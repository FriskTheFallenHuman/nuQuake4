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

#if defined( Q4_CM_LEGACY_SEED )
#include "collisionmodel_translate_legacy.inc"
#else

/*
===========================================================================

Quake 4 object-based translation helpers reconstructed in the exact
CollisionModel_translate.obj source owner identified by quake4.pdb.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

void idCollisionModelManagerLocal::CM_GetCollisionPointTexCoords( idVec2 &texCoord,
		cm_traceWork_t *traceWork, cm_polygon_t *polygon ) {
	texCoord.Set( 0.5f, 0.5f );
	const idVec3 size = polygon->bounds[1] - polygon->bounds[0];
	int dimension = size.y > size.x ? 1 : 0;
	if ( size.z > size[dimension] ) {
		dimension = 2;
	}

	idVec3 triangle[3];
	triangle[0] = polygon->bounds[0];
	triangle[1] = polygon->bounds[1];
	triangle[2] = polygon->bounds[0];
	triangle[2][dimension] = polygon->bounds[1][dimension];
	const float area = idMath::BarycentricTriangleArea( polygon->plane.Normal(),
		triangle[0], triangle[1], triangle[2] );
	if ( area != 0.0f ) {
		idMath::BarycentricEvaluate( texCoord, traceWork->trace.c.point,
			polygon->plane.Normal(), area, triangle, polygon->texBounds );
	}
}

void idCollisionModelManagerLocal::CM_GetMaterialType( cm_traceWork_t *traceWork, cm_polygon_t *polygon ) {
	const idMaterial *material = traceWork->trace.c.material;
	traceWork->trace.c.materialType = NULL;
	if ( material == NULL ) {
		return;
	}
	if ( polygon != NULL && material->GetMaterialTypeArray() != NULL ) {
		idVec2 texCoord;
		CM_GetCollisionPointTexCoords( texCoord, traceWork, polygon );
		traceWork->trace.c.materialType = material->GetMaterialType( texCoord );
	} else {
		traceWork->trace.c.materialType = material->GetMaterialType();
	}
}

#define Q4_CM_OBJECT_TRANSLATION
#define Q4_CM_TRANSLATE_HELPERS_ONLY
#include "collisionmodel_translate_legacy.inc"
#undef Q4_CM_TRANSLATE_HELPERS_ONLY
#undef Q4_CM_OBJECT_TRANSLATION

void idCollisionModelManagerLocal::Translation( trace_t *results, const idVec3 &start,
		const idVec3 &end, const idTraceModel *trm, const idMat3 &trmAxis,
		int contentMask, idCollisionModel *collisionModel, const idVec3 &modelOrigin,
		const idMat3 &modelAxis ) {
	memset( results, 0, sizeof( *results ) );
	results->fraction = 1.0f;
	results->endpos = end;
	results->endAxis = trmAxis;

	if ( collisionModel == NULL ) {
		return;
	}
	if ( start == end ) {
		ContentsTrm( results, start, trm, trmAxis, contentMask,
			collisionModel, modelOrigin, modelAxis );
		return;
	}

	const bool pointTrace = trm == NULL ||
		( trm->bounds[1].x - trm->bounds[0].x <= 0.0f &&
		  trm->bounds[1].y - trm->bounds[0].y <= 0.0f &&
		  trm->bounds[1].z - trm->bounds[0].z <= 0.0f );
	if ( !pointTrace && ( end - start ).LengthSqr() > Square( CM_MAX_TRACE_DIST ) ) {
		results->fraction = 0.0f;
		results->endpos = start;
		results->endAxis = trmAxis;
		results->c.normal.Zero();
		results->c.material = NULL;
		results->c.point = start;
		common->Printf( "idCollisionModelManagerLocal::Translation: huge translation\n" );
		return;
	}

	++checkCount;
	ALIGN16( cm_traceWork_t tw );
	memset( &tw, 0, sizeof( tw ) );
	tw.trace.fraction = 1.0f;
	tw.trace.c.contents = 0;
	tw.trace.c.type = CONTACT_NONE;
	tw.contents = contentMask;
	tw.model = static_cast<idCollisionModelLocal *>( collisionModel );
	tw.rotation = false;
	tw.positionTest = false;
	tw.quickExit = false;
	tw.getContacts = getContacts;
	tw.contacts = contacts;
	tw.maxContacts = maxContacts;
	tw.numContacts = 0;
	tw.start = start - modelOrigin;
	tw.end = end - modelOrigin;
	tw.dir = tw.end - tw.start;

	idMat3 inverseModelAxis = mat3_identity;
	const bool modelRotated = modelAxis.IsRotated();
	if ( modelRotated ) {
		inverseModelAxis = modelAxis.Transpose();
		tw.start *= inverseModelAxis;
		tw.end *= inverseModelAxis;
		tw.dir *= inverseModelAxis;
	}

	if ( pointTrace ) {
		tw.pointTrace = true;
		tw.isConvex = true;
		tw.trmBounds.Zero();
		for ( int i = 0; i < 3; ++i ) {
			tw.traceBounds[0][i] = Min( tw.start[i], tw.end[i] ) - CM_BOX_EPSILON;
			tw.traceBounds[1][i] = Max( tw.start[i], tw.end[i] ) + CM_BOX_EPSILON;
			tw.trmExtents[i] = CM_BOX_EPSILON;
		}
		SetupTranslationHeartPlanes( &tw );
		tw.maxDistFromHeartPlane1 = CM_BOX_EPSILON;
		tw.maxDistFromHeartPlane2 = CM_BOX_EPSILON;
		tw.numVerts = 1;
		tw.vertices[0].p = tw.start;
		tw.vertices[0].endp = tw.end;
		tw.vertices[0].pl.FromRay( tw.start, tw.dir );
		tw.vertices[0].used = true;
		tw.numEdges = 0;
		tw.numPolys = 0;
		TraceThroughModel( &tw );
	} else {
		tw.pointTrace = false;
		SetupTrm( &tw, trm );

		idMat3 trmTransform = trmAxis;
		if ( modelRotated ) {
			trmTransform *= inverseModelAxis;
		}

		// The trace origin follows the transformed trace-model center, while
		// vertices remain positioned relative to the caller's physics origin.
		const idVec3 traceOrigin = tw.start;
		const idVec3 traceEnd = tw.end;
		const idVec3 transformedOffset = trm->offset * trmTransform;
		tw.start = traceOrigin + transformedOffset;
		tw.end = traceEnd + transformedOffset;

		for ( int i = 0; i < tw.numPolys; ++i ) {
			tw.polys[i].plane.SetNormal( trm->polys[i].normal * trmTransform );
			const float facing = tw.polys[i].plane.Normal() * tw.dir;
			if ( facing > 0.0f || ( !trm->isConvex && facing == 0.0f ) ) {
				tw.polys[i].used = true;
				for ( int j = 0; j < tw.polys[i].numEdges; ++j ) {
					cm_trmEdge_t &edge = tw.edges[abs( tw.polys[i].edges[j] )];
					edge.used = true;
					tw.vertices[edge.vertexNum[0]].used = true;
					tw.vertices[edge.vertexNum[1]].used = true;
				}
			}
		}

		tw.trmBounds.Clear();
		for ( int i = 0; i < tw.numVerts; ++i ) {
			cm_trmVertex_t &vertex = tw.vertices[i];
			if ( !vertex.used ) {
				continue;
			}
			vertex.p = trm->verts[i] * trmTransform + traceOrigin;
			vertex.endp = vertex.p + tw.dir;
			vertex.pl.FromRay( vertex.p, tw.dir );
			tw.trmBounds.AddPoint( vertex.p - tw.start );
		}

		for ( int i = 1; i <= tw.numEdges; ++i ) {
			cm_trmEdge_t &edge = tw.edges[i];
			if ( !edge.used ) {
				continue;
			}
			const idVec3 &edgeStart = tw.vertices[edge.vertexNum[0]].p;
			const idVec3 &edgeEnd = tw.vertices[edge.vertexNum[1]].p;
			edge.pl.FromLine( edgeStart, edgeEnd );
			const idVec3 edgeDir = edgeStart - edgeEnd;
			edge.cross[0] = edgeDir[0] * tw.dir[1] - edgeDir[1] * tw.dir[0];
			edge.cross[1] = edgeDir[0] * tw.dir[2] - edgeDir[2] * tw.dir[0];
			edge.cross[2] = edgeDir[1] * tw.dir[2] - edgeDir[2] * tw.dir[1];
			edge.bitNum = static_cast<short>( i );
		}

		for ( int i = 0; i < tw.numPolys; ++i ) {
			cm_trmPolygon_t &polygon = tw.polys[i];
			if ( polygon.used ) {
				const cm_trmEdge_t &edge = tw.edges[abs( polygon.edges[0] )];
				polygon.plane.FitThroughPoint( tw.vertices[edge.vertexNum[0]].p );
			}
		}

		for ( int i = 0; i < 3; ++i ) {
			tw.traceBounds[0][i] = Min( tw.start[i], tw.end[i] ) + tw.trmBounds[0][i] - CM_BOX_EPSILON;
			tw.traceBounds[1][i] = Max( tw.start[i], tw.end[i] ) + tw.trmBounds[1][i] + CM_BOX_EPSILON;
			tw.trmExtents[i] = Max( idMath::Fabs( tw.trmBounds[0][i] ),
				idMath::Fabs( tw.trmBounds[1][i] ) ) + CM_BOX_EPSILON;
		}

		SetupTranslationHeartPlanes( &tw );
		tw.maxDistFromHeartPlane1 = 0.0f;
		tw.maxDistFromHeartPlane2 = 0.0f;
		for ( int i = 0; i < tw.numVerts; ++i ) {
			if ( !tw.vertices[i].used ) {
				continue;
			}
			tw.maxDistFromHeartPlane1 = Max( tw.maxDistFromHeartPlane1,
				idMath::Fabs( tw.heartPlane1.Distance( tw.vertices[i].p ) ) );
			tw.maxDistFromHeartPlane2 = Max( tw.maxDistFromHeartPlane2,
				idMath::Fabs( tw.heartPlane2.Distance( tw.vertices[i].p ) ) );
		}
		tw.maxDistFromHeartPlane1 += CM_BOX_EPSILON;
		tw.maxDistFromHeartPlane2 += CM_BOX_EPSILON;
		TraceThroughModel( &tw );
	}

	if ( tw.getContacts ) {
		if ( modelRotated ) {
			for ( int i = 0; i < tw.numContacts; ++i ) {
				tw.contacts[i].normal *= modelAxis;
				tw.contacts[i].point *= modelAxis;
			}
		}
		if ( modelOrigin != vec3_origin ) {
			for ( int i = 0; i < tw.numContacts; ++i ) {
				tw.contacts[i].point += modelOrigin;
				tw.contacts[i].dist += modelOrigin * tw.contacts[i].normal;
			}
		}
		numContacts = tw.numContacts;
		return;
	}

	*results = tw.trace;
	results->endpos = start + results->fraction * ( end - start );
	results->endAxis = pointTrace ? mat3_identity : trmAxis;
	if ( results->fraction < 1.0f ) {
		if ( results->fraction > 0.0f && results->endpos.Compare( start ) ) {
			results->fraction = 0.0f;
		}
		if ( modelRotated ) {
			results->c.normal *= modelAxis;
			results->c.point *= modelAxis;
		}
		results->c.point += modelOrigin;
		results->c.dist += modelOrigin * results->c.normal;
	}
}

#endif
