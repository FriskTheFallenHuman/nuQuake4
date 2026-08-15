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

// Copyright (C) 2005 Raven Software

#ifndef __RENDERER_RVPRIMBATCH_H__
#define __RENDERER_RVPRIMBATCH_H__

#include "rvIndexBuffer.h"
#include "rvVertexBuffer.h"

class idCollisionModelLocal;
class idCollisionModelManagerLocal;

struct primBatchGeoSpec_s {
	int m_vertexStart;
	int m_vertexCount;
	int m_indexStart;
	int m_primitiveCount;
};

class rvPrimBatch {
friend class rvMesh;
public:
	rvPrimBatch();
	~rvPrimBatch();

	void Shutdown();
	void Init( int *transformPalette, int numTransforms );
	void Init( Lexer &lexer );
	void LoadMatrixPaletteIntoVPParams( const float *skinToModelTransforms );
	int FlipOutsideBackFaces( unsigned char *facing, const unsigned char *cullBits,
		rvIndexBuffer &indexBuffer );
	int GetNearestJoint( int silTraceIndex0, int silTraceIndex1, int silTraceIndex2,
		rvVertexBuffer &silTraceVertexBuffer, rvIndexBuffer &silTraceIndexBuffer ) const;
	void GetTextureBounds( float bounds[2][2], rvVertexBuffer &drawVertexBuffer );
	void Draw( rvVertexBuffer &vertexBuffer, rvIndexBuffer &indexBuffer,
		const rvVertexFormat *vertexComponentsNeeded );
	void Draw( rvVertexBuffer &vertexBuffer, int *indices, int numIndices,
		const rvVertexFormat *vertexComponentsNeeded );
	void DrawShadowVolume( rvVertexBuffer &vertexBuffer, int *indices, int numIndices,
		const rvVertexFormat *vertexComponentsNeeded );
	void DrawShadowVolume( rvVertexBuffer &vertexBuffer, rvIndexBuffer &indexBuffer,
		bool drawCaps, const rvVertexFormat *vertexComponentsNeeded );
	int CreateSilShadowVolTris( int *shadowIndices, const unsigned char *facing,
		silEdge_t *silEdges );
	int CreateFrontBackShadowVolTris( int *shadowIndices, const unsigned char *facing,
		rvIndexBuffer &silTraceIndexBuffer );
	void TransformVertsMinMax( rvSilTraceVertT *destSilTraceVerts,
		idVec3 &boundsMin, idVec3 &boundsMax, rvVertexBuffer &silTraceVertexBuffer,
		idJointMat *skinSpaceToLocalMats, idJointMat *localToModelMats,
		float *skinToModelTransforms );
	void DeriveTriPlanes( idPlane *planes, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer );
	void LocalTrace( localTrace_t &hit, int &testPlanes, int &testEdges,
		int &intersections, const idVec3 &start, const idVec3 &end,
		const unsigned char *cullBits, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts, float radius,
		rvIndexBuffer &silTraceIndexBuffer, rvIndexBuffer &drawIndexBuffer );
	void CreateLightTris( int *destDrawIndices, int &destIndexCount,
		idBounds &bounds, int &backFaced, int &distanceCulled,
		const unsigned char *facing, const unsigned char *cullBits,
		const idPlane *localClipPlanes, const rvSilTraceVertT *silTraceVerts,
		bool includeBackFaces, rvIndexBuffer &silTraceIndexBuffer,
		rvIndexBuffer &drawIndexBuffer );
	void CreateFrontFaceTris( int *destDrawIndices, int &destIndexCount,
		idBounds &bounds, int &backFaced, const unsigned char *facing,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer,
		rvIndexBuffer &drawIndexBuffer );
	const rvDeclMatType *GetMaterialType( const idMaterial *material,
		const localTrace_t &hit, rvVertexBuffer &drawVertexBuffer );
	void FindOverlayTriangles( overlayVertex_t *overlayVerts, int &numVerts,
		int *overlayIndices, int &numIndices, const unsigned char *cullBits,
		const idVec2 *textureCoordinates, int vertexBase,
		rvIndexBuffer &silTraceIndexBuffer );
	void FindDecalTriangles( idRenderModelDecal &decalModel,
		const decalProjectionInfo_t &localInfo, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer );
	void GenerateCollisionPolys( idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel, const idMaterial &material,
		rvVertexBuffer &drawVertexBuffer, rvIndexBuffer &drawIndexBuffer );
	void CopyDrawVertices( idDrawVert *destDrawVerts,
		rvVertexBuffer &drawVertexBuffer );
	void CopyDrawIndices( int *destIndices, rvIndexBuffer &drawIndexBuffer,
		int destBase );
	void CopySilTraceVertices( rvVertexBuffer &silTraceVertexBuffer,
		rvIndexBuffer &silTraceIndexBuffer, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer );
	void CopyShadowVertices( rvVertexBuffer &shadowVertexBuffer,
		rvVertexBuffer &silTraceVertexBuffer );
	void CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		rvVertexBuffer &drawVertexBuffer, rvIndexBuffer &drawIndexBuffer,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer,
		int destBase );
	void GetTriangle( idDrawVert &a, idDrawVert &b, idDrawVert &c,
		int triangleOffset, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer );
	void TransformDrawVertices( idDrawVert *destDrawVerts,
		rvVertexBuffer &drawVertexBuffer, const idMat4 &transform,
		int colorShift, unsigned char *colorAdd );
	void TubeDeform( idDrawVert *destDrawVerts, int *destIndices,
		const idVec3 &localView, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer );
	bool PreciseCullSurface( idBounds &ndcBounds,
		const rvSilTraceVertT *silTraceVerts, const idVec3 &localView,
		const float *modelMatrix, rvIndexBuffer &silTraceIndexBuffer );
	void PlaneForSurface( idPlane &destPlane, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer );
	void Write( idFile &outFile, const char *prepend );

protected:
	int *			m_transformPalette;
	int				m_numTransforms;
	int				m_silEdgeStart;
	int				m_silEdgeCount;
	primBatchGeoSpec_s	m_silTraceGeoSpec;
	primBatchGeoSpec_s	m_drawGeoSpec;
	primBatchGeoSpec_s	m_shadowVolGeoSpec;
	int				m_numShadowPrimitivesNoCaps;
	int				m_shadowCapPlaneBits;
};

#endif
