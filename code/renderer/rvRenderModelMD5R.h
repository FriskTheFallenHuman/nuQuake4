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

#ifndef __RENDERER_RVRENDERMODELMD5R_H__
#define __RENDERER_RVRENDERMODELMD5R_H__

#include "Model_local.h"
#include "rvIndexBuffer.h"
#include "rvVertexBuffer.h"

class rvMesh;
class idCollisionModelLocal;
class idCollisionModelManagerLocal;

struct levelOfDetailMD5R_s {
	float	m_rangeEnd;
	float	m_rangeEndSquared;
	rvMesh *m_meshList;
};

enum rvMD5RSource_t {
	MD5R_SOURCE_NONE = 0,
	MD5R_SOURCE_FILE,
	MD5R_SOURCE_PROC,
	MD5R_SOURCE_MD5,
	MD5R_SOURCE_LWO_ASE_FLT,
	MD5R_SOURCE_MANUAL
};

class rvRenderModelMD5R : public idRenderModelStatic {
friend class rvMesh;
public:
	rvRenderModelMD5R();
	virtual ~rvRenderModelMD5R();

	virtual void InitFromFile( const char *fileName );
	virtual void PurgeModel();
	virtual void LoadModel();
	virtual void TouchData();
	virtual void Print() const;
	virtual void List() const {}
	virtual int Memory() const;
	virtual dynamicModel_t IsDynamicModel() const;
	virtual idBounds Bounds( const renderEntity_t *entity ) const;
	virtual bool HasCollisionSurface( const renderEntity_t *entity ) const;
	virtual idRenderModel *InstantiateDynamicModel( const renderEntity_t *entity,
		const viewDef_t *view, idRenderModel *cachedModel, dword surfaceMask );
	virtual int NumJoints() const;
	virtual const idMD5Joint *GetJoints() const;
	virtual jointHandle_t GetJointHandle( const char *jointName ) const;
	virtual const char *GetJointName( jointHandle_t jointHandle ) const;
	virtual const idJointQuat *GetDefaultPose() const;
	virtual int NearestJoint( int surfaceNum, int a, int b, int c ) const;
	virtual int GetSurfaceMask( const char *surfaceName ) const;
	virtual bool HasSeparateSilTraceMeshes() const;
	virtual srfTriangles_t *GenerateStaticTriSurface( int meshOffset );

	bool Init( idRenderModelMD5 &model );
	bool Init( idRenderModelStatic &model, rvVertexBuffer *vertexBuffers,
		int vertexBufferStart, int numVertexBuffers, rvIndexBuffer *indexBuffers,
		int indexBufferStart, int numIndexBuffers, silEdge_t *silEdges,
		int silEdgeStart, int maxNumSilEdges, rvMD5RSource_t source );
	bool Init( idRenderModelStatic &model, rvMD5RSource_t source );
	bool Init( Lexer &lexer, rvVertexBuffer *vertexBuffers, int numVertexBuffers,
		rvIndexBuffer *indexBuffers, int numIndexBuffers, silEdge_t *silEdges,
		int maxNumSilEdges, rvMD5RSource_t source );
	void Shutdown();
	void GenerateCollisionModel( idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel );
	void GenerateStaticSurfaces();
	void Write( idFile &outFile, const char *prepend, bool writeBuffers );
	void WriteSansBuffers( idFile &outFile, const char *prepend );
	static void WriteAll( bool writeBuffers );
	static void CompressVertexFormat( rvVertexFormat &compressedFormat,
		const rvVertexFormat &format );

protected:
	void ResetValues();
	void ParseVertexBuffers( Lexer &lexer );
	void ParseIndexBuffers( Lexer &lexer );
	void ParseSilhouetteEdges( Lexer &lexer );
	void ParseLevelOfDetail( Lexer &lexer );
	void ParseMeshes( Lexer &lexer );
	void ParseJoints( Lexer &lexer );
	void BuildLevelsOfDetail();
	int CalcMaxBonesPerVertex( const jointWeight_t *jointWeights, int numVerts,
		const srfTriangles_t &tri );
	void FixBadTangentSpaces( srfTriangles_t &tri );
	void DrawJoints( const renderEntity_t *entity, const viewDef_t *view ) const;
	int BuildBlend4VertArray( idMD5Mesh &md5Mesh, modelSurface_t &surface,
		rvBlend4DrawVert *drawVertices );
	modelSurface_t *GenerateSurface( idRenderModelStatic &staticModel,
		rvMesh &mesh, const renderEntity_t &entity, unsigned int surfaceMask );
	void GenerateSurface( rvMesh &mesh );
	void WriteSilhouetteEdges( idFile &outFile, const char *prepend,
		const char *prependPlusTab );
	void WriteLevelOfDetail( idFile &outFile, const char *prepend,
		const char *prependPlusTab );
	void WriteMeshes( idFile &outFile, const char *prepend );
	void WriteJoints( idFile &outFile, const char *prepend,
		const char *prependPlusTab );
	static void RemoveFromList( rvRenderModelMD5R &model );
	static rvRenderModelMD5R *ms_modelList;

	idMD5Joint *			m_joints;
	idJointMat *			m_skinSpaceToLocalMats;
	idJointQuat *			m_defaultPose;
	int					m_numJoints;
	rvVertexBuffer *		m_vertexBuffers;
	rvVertexBuffer *		m_allocVertexBuffers;
	int					m_numVertexBuffers;
	rvIndexBuffer *		m_indexBuffers;
	rvIndexBuffer *		m_allocIndexBuffers;
	int					m_numIndexBuffers;
	silEdge_t *			m_silEdges;
	silEdge_t *			m_allocSilEdges;
	int					m_numSilEdges;
	int					m_numSilEdgesAdded;
	rvMesh *				m_meshes;
	int					m_numMeshes;
	int					m_numLODs;
	levelOfDetailMD5R_s *	m_lods;
	rvMesh *				m_allLODMeshes;
	rvMD5RSource_t		m_source;
	rvRenderModelMD5R *	m_next;
};

#endif
