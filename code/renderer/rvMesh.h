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

#ifndef __RENDERER_RVMESH_H__
#define __RENDERER_RVMESH_H__

#include "rvPrimBatch.h"
#include "rvRenderModelMD5R.h"

class rvMesh {
friend class rvRenderModelMD5R;
friend class rvModelParticle;
friend srfTriangles_t *R_CreateVertexBufferTurboShadowVolume(
	const idRenderEntityLocal *ent, const srfTriangles_t *tri,
	const idRenderLightLocal *light, srfCullInfo_t &cullInfo );
public:
	rvMesh();
	~rvMesh();
	void Init( rvRenderModelMD5R &renderModel, Lexer &lexer );
	void Init( rvRenderModelMD5R &renderModel, modelSurface_t &sourceSurface,
		int *silRemap, int silTraceVertexBuffer, int drawVertexBuffer,
		int shadowVertexBuffer, int silTraceIndexBuffer, int drawIndexBuffer,
		int shadowIndexBuffer );
	void Init( rvRenderModelMD5R &renderModel, const idMaterial *material,
		int numTransforms, rvBlend4DrawVert *drawVertices, int numDrawVertices,
		int *drawIndices, int numIndices, silEdge_t *silEdges, int numSilEdges,
		int *silRemap, int silTraceVertexBuffer, int drawVertexBuffer,
		int shadowVertexBuffer, int silTraceIndexBuffer, int drawIndexBuffer );
	void UpdateSurface( modelSurface_t &surface );

	int FlipOutsideBackFaces( srfCullInfo_t &cullInfo );
	void CalcGeometryProfile();
	void Draw( const float *skinToModelTransforms,
		const rvVertexFormat *vertexComponentsNeeded );
	void Draw( const float *skinToModelTransforms, int *indices, int numIndices,
		const rvVertexFormat *vertexComponentsNeeded );
	void DrawShadowVolume( const float *skinToModelTransforms, int *indices,
		bool drawCaps, const rvVertexFormat *vertexComponentsNeeded );
	void DeriveTriPlanes( idPlane *planes, const rvSilTraceVertT *silTraceVerts );
	bool PreciseCullSurface( idBounds &ndcBounds,
		const rvSilTraceVertT *silTraceVerts, const idVec3 &localView,
		const float *modelMatrix );
	int CreateSilShadowVolTris( int primBatch, int *shadowIndices,
		const unsigned char *facing );
	int CreateFrontBackShadowVolTris( int primBatch, int *shadowIndices,
		const unsigned char *facing );
	ID_INLINE int GetNumSilTracePrimitives( int primBatch ) const {
		return m_primBatches[primBatch].m_silTraceGeoSpec.m_primitiveCount;
	}
	int GetNearestJoint( int silTraceIndex0, int silTraceIndex1,
		int silTraceIndex2 ) const;
	void LocalTrace( localTrace_t &hit, int &testPlanes, int &testEdges,
		int &intersections, const idVec3 &start, const idVec3 &end,
		const unsigned char *cullBits, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts, float radius,
		const idMaterial *material );
	void CreateLightTris( srfTriangles_t &newTri, int &backFaced,
		int &distanceCulled, srfCullInfo_t &cullInfo,
		const rvSilTraceVertT *silTraceVerts, bool includeBackFaces );
	void CreateFrontFaceTris( srfTriangles_t &newTri, int &backFaced,
		srfCullInfo_t &cullInfo, const rvSilTraceVertT *silTraceVerts );
	void CreateOverlayTriangles( overlayVertex_t *overlayVerts, int &numVerts,
		int *overlayIndices, int &numIndices, const idPlane *planes,
		const rvSilTraceVertT *silTraceVerts );
	void CreateDecalTriangles( idRenderModelDecal &decalModel,
		const decalProjectionInfo_t &localInfo, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts );
	void GenerateCollisionPolys( idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel );
	void CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		const rvSilTraceVertT *silTraceVerts );
	void CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		int destBase );
	void TransformTriangles( idDrawVert *destDrawVerts, int *destIndices,
		const idMat4 &transform, int colorShift, unsigned char *colorAdd,
		int destBase );
	void TubeDeform( idDrawVert *destDrawVerts, int *destIndices,
		const idVec3 &localView, const rvSilTraceVertT *silTraceVerts );
	const rvVertexFormat *GetDrawVertexBufferFormat() const;
	const rvVertexFormat *GetShadowVolVertexBufferFormat() const;
	void PlaneForSurface( idPlane &destPlane,
		const rvSilTraceVertT *silTraceVerts );
	void SetupForDrawRender( const rvVertexFormat *vertexComponentsNeeded );
	void SetupForShadowVolRender( const rvVertexFormat *vertexComponentsNeeded );
	void ScreenRectFromDrawSurf( idScreenRect &destRect,
		const float *modelMatrix, float *viewMatrix, float *projectionMatrix,
		const idScreenRect &viewport, const rvSilTraceVertT *silTraceVerts ) const;
	void Write( idFile &outFile, const char *prepend );
	void SurfaceToTextureAxis( idVec3 &origin, idVec3 axis[3],
		const rvSilTraceVertT *silTraceVerts );

protected:
	void ResetValues();
	void UpdateSurface( modelSurface_t &surface, const renderEntity_t &entity,
		idJointMat *skinSpaceToLocalMats );

	idBounds			m_bounds;
	rvRenderModelMD5R *m_renderModel;
	const idMaterial *	m_material;
	rvMesh *			m_nextInLOD;
	rvPrimBatch *		m_primBatches;
	int					m_meshIdentifier;
	int					m_numSilTraceVertices;
	int					m_numSilTraceIndices;
	int					m_numSilTracePrimitives;
	int					m_numSilEdges;
public:
	int					m_numDrawVertices;
	int					m_numDrawIndices;
protected:
	int					m_numDrawPrimitives;
	short				m_silTraceVertexBuffer;
	short				m_silTraceIndexBuffer;
	short				m_drawVertexBuffer;
	short				m_drawIndexBuffer;
	short				m_shadowVolVertexBuffer;
	short				m_shadowVolIndexBuffer;
	short				m_levelOfDetail;
	short				m_numTransforms;
	short				m_numPrimBatches;
	short				m_surfaceNum;
public:
	bool				m_drawSetUp;
};

#endif
