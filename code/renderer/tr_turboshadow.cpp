/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

This file is part of the Quake 4 Reconstructed GPL Source Code (?Quake 4 Reconstructed Source Code?).

Quake 4 Reconstructed Source Code is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Quake 4 Reconstructed Source Code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Quake 4 Reconstructed Source Code.  If not, see <http://www.gnu.org/licenses/>.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "tr_local.h"
#include "rvMesh.h"

int	c_turboUsedVerts;
int c_turboUnusedVerts;


/*
=====================
R_CreateVertexBufferTurboShadowVolume

Creates the CPU index stream used with an MD5R mesh's resident shadow-volume
vertex buffer.  Each primitive batch is preceded by a pair containing the
silhouette-only and silhouette-plus-cap index counts.
=====================
*/
srfTriangles_t *R_CreateVertexBufferTurboShadowVolume( const idRenderEntityLocal *ent,
		const srfTriangles_t *tri, const idRenderLightLocal *light,
		srfCullInfo_t &cullInfo ) {
	rvMesh *mesh = tri->primBatchMesh;
	const int numFaces = mesh->m_numSilTracePrimitives;

	R_CalcInteractionFacing( ent, tri, light, cullInfo );
	if ( r_useShadowProjectedCull.GetBool() ) {
		R_CalcInteractionCullBits( ent, tri, light, cullInfo );
	}

	int numShadowingFaces;
	if ( cullInfo.cullBits != LIGHT_CULL_ALL_FRONT &&
			r_useShadowProjectedCull.GetBool() ) {
		numShadowingFaces = mesh->FlipOutsideBackFaces( cullInfo );
	} else {
		int numFacing = 0;
		for ( int i = 0; i < numFaces; ++i ) {
			numFacing += cullInfo.facing[i];
		}
		numShadowingFaces = numFaces - numFacing;
	}

	if ( numShadowingFaces == 0 ) {
		return NULL;
	}

	srfTriangles_t *newTri = R_AllocStaticTriSurf();
	newTri->numVerts = mesh->m_numSilTraceVertices * 2;
	newTri->primBatchMesh = tri->primBatchMesh;
	newTri->skinToModelTransforms = tri->skinToModelTransforms;
	newTri->skinToModelTransformsAlloc = NULL;
	newTri->numSkinToModelTransforms = tri->numSkinToModelTransforms;

	const int batchHeaderIndexes = mesh->m_numPrimBatches * 2;
	R_AllocStaticTriSurfIndexes( newTri, batchHeaderIndexes +
		6 * ( numShadowingFaces + mesh->m_numSilEdges ) );

	int *batchCounts = newTri->indexes;
	int *shadowIndexes = newTri->indexes + batchHeaderIndexes;
	const byte *batchFacing = cullInfo.facing;
	newTri->numIndexes = 0;
	newTri->numShadowIndexesNoCaps = 0;

	for ( int batch = 0; batch < mesh->m_numPrimBatches; ++batch ) {
		const int numSilIndexes = mesh->CreateSilShadowVolTris(
			batch, shadowIndexes, batchFacing );
		shadowIndexes += numSilIndexes;
		const int numCapIndexes = mesh->CreateFrontBackShadowVolTris(
			batch, shadowIndexes, batchFacing );
		shadowIndexes += numCapIndexes;

		batchCounts[batch * 2] = numSilIndexes;
		batchCounts[batch * 2 + 1] = numSilIndexes + numCapIndexes;
		newTri->numShadowIndexesNoCaps += numSilIndexes;
		newTri->numIndexes += numSilIndexes + numCapIndexes;
		batchFacing += mesh->GetNumSilTracePrimitives( batch );
	}

	newTri->numShadowIndexesNoFrontCaps = newTri->numIndexes;
	newTri->shadowCapPlaneBits = SHADOW_CAP_INFINITE;
	R_ResizeStaticTriSurfIndexes( newTri, newTri->numIndexes + batchHeaderIndexes );
	newTri->bounds.Clear();
	return newTri;
}


/*
=====================
R_CreateVertexProgramTurboShadowVolume

are dangling edges that are outside the light frustum still making planes?
=====================
*/
srfTriangles_t *R_CreateVertexProgramTurboShadowVolume( const idRenderEntityLocal *ent, 
														const srfTriangles_t *tri, const idRenderLightLocal *light,
														srfCullInfo_t &cullInfo ) {
	R_CalcInteractionFacing( ent, tri, light, cullInfo );
	if ( r_useShadowProjectedCull.GetBool() ) {
		R_CalcInteractionCullBits( ent, tri, light, cullInfo );
	}

	const int numFaces = tri->numIndexes / 3;
	int numFacing;
	if ( cullInfo.cullBits != LIGHT_CULL_ALL_FRONT &&
			r_useShadowProjectedCull.GetBool() ) {
		numFacing = SIMDProcessor->ShadowVolume_CountFacingCull(
			cullInfo.facing, numFaces, tri->indexes, cullInfo.cullBits );
	} else {
		numFacing = SIMDProcessor->ShadowVolume_CountFacing(
			cullInfo.facing, numFaces );
	}

	const int numShadowingFaces = numFaces - numFacing;
	if ( numShadowingFaces == 0 ) {
		return NULL;
	}

	srfTriangles_t *newTri = R_AllocStaticTriSurf();
	newTri->numVerts = tri->numVerts * 2;
	R_AllocStaticTriSurfIndexes( newTri,
		( tri->numSilEdges + numShadowingFaces + 1 ) * 6 );

	const int numShadowIndexes = SIMDProcessor->ShadowVolume_CreateSilTriangles(
		newTri->indexes, cullInfo.facing,
		reinterpret_cast<const silEdge_s *>( tri->silEdges ), tri->numSilEdges );
	newTri->numIndexes = newTri->numShadowIndexesNoFrontCaps = numShadowIndexes + numShadowingFaces * 6;
	newTri->numShadowIndexesNoCaps = numShadowIndexes;
	newTri->shadowCapPlaneBits = SHADOW_CAP_INFINITE;
	R_ResizeStaticTriSurfIndexes( newTri, newTri->numIndexes + 6 );
	newTri->bounds.Clear();
	SIMDProcessor->ShadowVolume_CreateCapTriangles( newTri->indexes + numShadowIndexes,
		cullInfo.facing, tri->indexes, tri->numIndexes );

	return newTri;
}

/*
=====================
R_CreateTurboShadowVolume
=====================
*/
srfTriangles_t *R_CreateTurboShadowVolume( const idRenderEntityLocal *ent,
											const srfTriangles_t *tri, const idRenderLightLocal *light,
											srfCullInfo_t &cullInfo ) {
	int		i, j;
	idVec3	localLightOrigin;
	srfTriangles_t	*newTri;
	silEdge_t	*sil;
	const glIndex_t *indexes;
	const byte *facing;

	R_CalcInteractionFacing( ent, tri, light, cullInfo );
	if ( r_useShadowProjectedCull.GetBool() ) {
		R_CalcInteractionCullBits( ent, tri, light, cullInfo );
	}

	int numFaces = tri->numIndexes / 3;
	int	numShadowingFaces = 0;
	facing = cullInfo.facing;

	// if all the triangles are inside the light frustum
	if ( cullInfo.cullBits == LIGHT_CULL_ALL_FRONT || !r_useShadowProjectedCull.GetBool() ) {

		// count the number of shadowing faces
		for ( i = 0; i < numFaces; i++ ) {
			numShadowingFaces += facing[i];
		}
		numShadowingFaces = numFaces - numShadowingFaces;

	} else {

		// make all triangles that are outside the light frustum "facing", so they won't cast shadows
		indexes = tri->indexes;
		byte *modifyFacing = cullInfo.facing;
		const byte *cullBits = cullInfo.cullBits;
		for ( j = i = 0; i < tri->numIndexes; i += 3, j++ ) {
			if ( !modifyFacing[j] ) {
				int	i1 = indexes[i+0];
				int	i2 = indexes[i+1];
				int	i3 = indexes[i+2];
				if ( cullBits[i1] & cullBits[i2] & cullBits[i3] ) {
					modifyFacing[j] = 1;
				} else {
					numShadowingFaces++;
				}
			}
		}
	}

	if ( !numShadowingFaces ) {
		// no faces are inside the light frustum and still facing the right way
		return NULL;
	}

	newTri = R_AllocStaticTriSurf();

#ifdef USE_TRI_DATA_ALLOCATOR
	R_AllocStaticTriSurfShadowVerts( newTri, tri->numVerts * 2 );
	shadowCache_t *shadowVerts = newTri->shadowVertexes;
#else
	shadowCache_t *shadowVerts = (shadowCache_t *)_alloca16( tri->numVerts * 2 * sizeof( shadowVerts[0] ) );
#endif

	R_GlobalPointToLocal( ent->modelMatrix, light->globalLightOrigin, localLightOrigin );

	int	*vertRemap = (int *)_alloca16( tri->numVerts * sizeof( vertRemap[0] ) );

	SIMDProcessor->Memset( vertRemap, -1, tri->numVerts * sizeof( vertRemap[0] ) );

	for ( i = 0, j = 0; i < tri->numIndexes; i += 3, j++ ) {
		if ( facing[j] ) {
			continue;
		}
		// this may pull in some vertexes that are outside
		// the frustum, because they connect to vertexes inside
		vertRemap[tri->silIndexes[i+0]] = 0;
		vertRemap[tri->silIndexes[i+1]] = 0;
		vertRemap[tri->silIndexes[i+2]] = 0;
	}

	newTri->numVerts = SIMDProcessor->CreateShadowCache( &shadowVerts->xyz, vertRemap, localLightOrigin, tri->verts, tri->numVerts );

	c_turboUsedVerts += newTri->numVerts;
	c_turboUnusedVerts += tri->numVerts * 2 - newTri->numVerts;

#ifdef USE_TRI_DATA_ALLOCATOR
	R_ResizeStaticTriSurfShadowVerts( newTri, newTri->numVerts );
#else
	R_AllocStaticTriSurfShadowVerts( newTri, newTri->numVerts );
	SIMDProcessor->Memcpy( newTri->shadowVertexes, shadowVerts, newTri->numVerts * sizeof( shadowVerts[0] ) );
#endif

	// alloc the max possible size
#ifdef USE_TRI_DATA_ALLOCATOR
	R_AllocStaticTriSurfIndexes( newTri, ( numShadowingFaces + tri->numSilEdges ) * 6 );
	glIndex_t *tempIndexes = newTri->indexes;
	glIndex_t *shadowIndexes = newTri->indexes;
#else
	glIndex_t *tempIndexes = (glIndex_t *)_alloca16( tri->numSilEdges * 6 * sizeof( tempIndexes[0] ) );
	glIndex_t *shadowIndexes = tempIndexes;
#endif

	// create new triangles along sil planes
	for ( sil = tri->silEdges, i = tri->numSilEdges; i > 0; i--, sil++ ) {

		int f1 = facing[sil->p1];
		int f2 = facing[sil->p2];

		if ( !( f1 ^ f2 ) ) {
			continue;
		}

		int v1 = vertRemap[sil->v1];
		int v2 = vertRemap[sil->v2];

		// set the two triangle winding orders based on facing
		// without using a poorly-predictable branch

		shadowIndexes[0] = v1;
		shadowIndexes[1] = v2 ^ f1;
		shadowIndexes[2] = v2 ^ f2;
		shadowIndexes[3] = v1 ^ f2;
		shadowIndexes[4] = v1 ^ f1;
		shadowIndexes[5] = v2 ^ 1;

		shadowIndexes += 6;
	}

	int numShadowIndexes = shadowIndexes - tempIndexes;

	// we aren't bothering to separate front and back caps on these
	newTri->numIndexes = newTri->numShadowIndexesNoFrontCaps = numShadowIndexes + numShadowingFaces * 6;
	newTri->numShadowIndexesNoCaps = numShadowIndexes;
	newTri->shadowCapPlaneBits = SHADOW_CAP_INFINITE;

#ifdef USE_TRI_DATA_ALLOCATOR
	// decrease the size of the memory block to only store the used indexes
	R_ResizeStaticTriSurfIndexes( newTri, newTri->numIndexes );
#else
	// allocate memory for the indexes
	R_AllocStaticTriSurfIndexes( newTri, newTri->numIndexes );
	// copy the indexes we created for the sil planes
	SIMDProcessor->Memcpy( newTri->indexes, tempIndexes, numShadowIndexes * sizeof( tempIndexes[0] ) );
#endif

	// these have no effect, because they extend to infinity
	newTri->bounds.Clear();

	// put some faces on the model and some on the distant projection
	indexes = tri->silIndexes;
	shadowIndexes = newTri->indexes + numShadowIndexes;
	for ( i = 0, j = 0; i < tri->numIndexes; i += 3, j++ ) {
		if ( facing[j] ) {
			continue;
		}

		int i0 = vertRemap[indexes[i+0]];
		shadowIndexes[2] = i0;
		shadowIndexes[3] = i0 ^ 1;
		int i1 = vertRemap[indexes[i+1]];
		shadowIndexes[1] = i1;
		shadowIndexes[4] = i1 ^ 1;
		int i2 = vertRemap[indexes[i+2]];
		shadowIndexes[0] = i2;
		shadowIndexes[5] = i2 ^ 1;

		shadowIndexes += 6;
	}

	return newTri;
}
