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
#include "rvRenderModelMD5R.h"
#include "rvMesh.h"
#include "../cm/CollisionModel_local.h"

/*
===============================================================================

	Quake 4 MD5R render model

	The class layout, signatures, and compilation-unit ownership come from
	rvRenderModelMD5R.obj in quake4.pdb. Bodies follow the address-matched
	retail executable.

===============================================================================
*/

static const float MD5R_DefaultLODRanges[3] = { 500.0f, 1000.0f, 2000.0f };
static const char *MD5R_SnapshotName = "_MD5R_Snapshot_";
rvRenderModelMD5R *rvRenderModelMD5R::ms_modelList = NULL;

static bool MD5R_FaceNegativePolarity( const srfTriangles_t &tri,
		int firstIndex ) {
	const idDrawVert &a = tri.verts[tri.indexes[firstIndex + 0]];
	const idDrawVert &b = tri.verts[tri.indexes[firstIndex + 1]];
	const idDrawVert &c = tri.verts[tri.indexes[firstIndex + 2]];
	const idVec2 d0 = b.st - a.st;
	const idVec2 d1 = c.st - a.st;
	return d0.x * d1.y - d0.y * d1.x < 0.0f;
}

static int *MD5R_CreateSilRemap( const srfTriangles_t &tri ) {
	int *remap = new int[tri.numVerts];
	if ( remap == NULL ) {
		common->FatalError( "rvRenderModelMD5R: out of memory building silhouette remap" );
	}
	if ( !r_useSilRemap.GetBool() ) {
		for ( int i = 0; i < tri.numVerts; ++i ) {
			remap[i] = i;
		}
		return remap;
	}

	idHashIndex hash( 1024, tri.numVerts );
	for ( int i = 0; i < tri.numVerts; ++i ) {
		const idDrawVert &vertex = tri.verts[i];
		const int hashKey = hash.GenerateKey( vertex.xyz );
		int previous;
		for ( previous = hash.First( hashKey ); previous >= 0;
				previous = hash.Next( previous ) ) {
			if ( tri.verts[previous].xyz == vertex.xyz ) {
				remap[i] = previous;
				break;
			}
		}
		if ( previous < 0 ) {
			remap[i] = i;
			hash.Add( hashKey, i );
		}
	}
	return remap;
}

rvRenderModelMD5R::rvRenderModelMD5R() {
	ResetValues();
	m_source = MD5R_SOURCE_NONE;
	m_next = ms_modelList;
	ms_modelList = this;
}

rvRenderModelMD5R::~rvRenderModelMD5R() {
	Shutdown();
	RemoveFromList( *this );
}

void rvRenderModelMD5R::ResetValues() {
	purged = true;
	m_joints = NULL;
	m_skinSpaceToLocalMats = NULL;
	m_defaultPose = NULL;
	m_numJoints = 0;
	m_vertexBuffers = NULL;
	m_allocVertexBuffers = NULL;
	m_numVertexBuffers = 0;
	m_indexBuffers = NULL;
	m_allocIndexBuffers = NULL;
	m_numIndexBuffers = 0;
	m_silEdges = NULL;
	m_allocSilEdges = NULL;
	m_numSilEdges = 0;
	m_numSilEdgesAdded = 0;
	m_meshes = NULL;
	m_numMeshes = 0;
	m_numLODs = 0;
	m_lods = NULL;
	m_allLODMeshes = NULL;
}

void rvRenderModelMD5R::ParseVertexBuffers( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numVertexBuffers = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_allocVertexBuffers = new rvVertexBuffer[m_numVertexBuffers];
	m_vertexBuffers = m_allocVertexBuffers;
	if ( m_vertexBuffers == NULL ) {
		lexer.Error( "Out of memory" );
	}
	for ( int i = 0; i < m_numVertexBuffers; ++i ) {
		lexer.ExpectTokenString( "VertexBuffer" );
		m_vertexBuffers[i].Init( lexer );
	}
	lexer.ExpectTokenString( "}" );
}

void rvRenderModelMD5R::ParseIndexBuffers( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numIndexBuffers = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_allocIndexBuffers = new rvIndexBuffer[m_numIndexBuffers];
	m_indexBuffers = m_allocIndexBuffers;
	if ( m_indexBuffers == NULL ) {
		lexer.Error( "Out of memory" );
	}
	for ( int i = 0; i < m_numIndexBuffers; ++i ) {
		lexer.ExpectTokenString( "IndexBuffer" );
		m_indexBuffers[i].Init( lexer );
	}
	lexer.ExpectTokenString( "}" );
}

void rvRenderModelMD5R::ParseSilhouetteEdges( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numSilEdges = m_numSilEdgesAdded = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_allocSilEdges = static_cast<silEdge_t *>( Mem_Alloc(
		m_numSilEdges * sizeof( silEdge_t ), MA_RENDER ) );
	m_silEdges = m_allocSilEdges;
	if ( m_silEdges == NULL && m_numSilEdges != 0 ) {
		lexer.Error( "Out of memory" );
	}
	for ( int i = 0; i < m_numSilEdges; ++i ) {
		m_silEdges[i].p1 = lexer.ParseInt();
		m_silEdges[i].p2 = lexer.ParseInt();
		m_silEdges[i].v1 = lexer.ParseInt();
		m_silEdges[i].v2 = lexer.ParseInt();
	}
	lexer.ExpectTokenString( "}" );
}

void rvRenderModelMD5R::ParseLevelOfDetail( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numLODs = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_lods = static_cast<levelOfDetailMD5R_s *>( Mem_Alloc(
		m_numLODs * sizeof( levelOfDetailMD5R_s ), MA_RENDER ) );
	if ( m_lods == NULL && m_numLODs != 0 ) {
		lexer.Error( "Out of memory" );
	}
	for ( int i = 0; i < m_numLODs; ++i ) {
		m_lods[i].m_rangeEnd = lexer.ParseFloat();
		m_lods[i].m_rangeEndSquared = m_lods[i].m_rangeEnd * m_lods[i].m_rangeEnd;
		m_lods[i].m_meshList = NULL;
	}
	lexer.ExpectTokenString( "}" );
}

void rvRenderModelMD5R::ParseMeshes( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numMeshes = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_meshes = new rvMesh[m_numMeshes];
	if ( m_meshes == NULL && m_numMeshes != 0 ) {
		lexer.Error( "Out of memory" );
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		lexer.ExpectTokenString( "Mesh" );
		m_meshes[i].Init( *this, lexer );
		m_meshes[i].m_meshIdentifier = i;
	}
	lexer.ExpectTokenString( "}" );
}

void rvRenderModelMD5R::BuildLevelsOfDetail() {
	int maximumLevel = -1;
	for ( int i = 0; i < m_numMeshes; ++i ) {
		maximumLevel = Max( maximumLevel, static_cast<int>( m_meshes[i].m_levelOfDetail ) );
	}
	if ( maximumLevel >= 0 && m_numLODs == 0 ) {
		m_numLODs = maximumLevel + 1;
		m_lods = static_cast<levelOfDetailMD5R_s *>( Mem_Alloc(
			m_numLODs * sizeof( levelOfDetailMD5R_s ), MA_RENDER ) );
		if ( m_lods == NULL ) {
			common->FatalError( "Out of memory" );
		}
		for ( int i = 0; i < m_numLODs; ++i ) {
			m_lods[i].m_rangeEnd = i < 3 ? MD5R_DefaultLODRanges[i]
				: m_lods[i - 1].m_rangeEnd * 2.0f;
			m_lods[i].m_rangeEndSquared = m_lods[i].m_rangeEnd * m_lods[i].m_rangeEnd;
			m_lods[i].m_meshList = NULL;
		}
	}
	m_allLODMeshes = NULL;
	for ( int i = 0; i < m_numLODs; ++i ) {
		m_lods[i].m_meshList = NULL;
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		rvMesh &mesh = m_meshes[i];
		if ( mesh.m_levelOfDetail < 0 || mesh.m_levelOfDetail >= m_numLODs ) {
			mesh.m_nextInLOD = m_allLODMeshes;
			m_allLODMeshes = &mesh;
		} else {
			mesh.m_nextInLOD = m_lods[mesh.m_levelOfDetail].m_meshList;
			m_lods[mesh.m_levelOfDetail].m_meshList = &mesh;
		}
	}
}

dynamicModel_t rvRenderModelMD5R::IsDynamicModel() const {
	return m_numJoints != 0 ? DM_CACHED : DM_STATIC;
}

idBounds rvRenderModelMD5R::Bounds( const renderEntity_t *entity ) const {
	return entity != NULL && m_numJoints != 0 ? entity->bounds : bounds;
}

srfTriangles_t *rvRenderModelMD5R::GenerateStaticTriSurface( int meshOffset ) {
	rvMesh &mesh = m_meshes[meshOffset];
	srfTriangles_t *triangles = R_AllocStaticTriSurf();
	triangles->numVerts = mesh.m_numDrawVertices;
	triangles->numIndexes = mesh.m_numDrawIndices;
	R_AllocStaticTriSurfVerts( triangles, triangles->numVerts );
	R_AllocStaticTriSurfIndexes( triangles, triangles->numIndexes );
	mesh.CopyTriangles( triangles->verts, triangles->indexes, 0 );
	return triangles;
}

int rvRenderModelMD5R::NumJoints() const {
	return m_numJoints;
}

const idMD5Joint *rvRenderModelMD5R::GetJoints() const {
	return m_joints;
}

const idJointQuat *rvRenderModelMD5R::GetDefaultPose() const {
	return m_defaultPose;
}

int rvRenderModelMD5R::NearestJoint( int surfaceNum, int a, int b, int c ) const {
	if ( surfaceNum > m_numMeshes ) {
		common->Error( "idRenderModelMD5R::NearestJoint: surfaceNum > m_numMeshes" );
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		if ( m_meshes[i].m_surfaceNum == surfaceNum ) {
			return m_meshes[i].GetNearestJoint( a, b, c );
		}
	}
	return 0;
}

int rvRenderModelMD5R::CalcMaxBonesPerVertex( const jointWeight_t *jointWeights,
		int numVerts, const srfTriangles_t &tri ) {
	int maxBonesPerVertex = 0;
	int currentWeight = 0;
	for ( int vertex = 0; vertex < numVerts; ++vertex ) {
		int bonesPerVertex = 0;
		do {
			++bonesPerVertex;
		} while ( jointWeights[currentWeight++].nextVertexOffset !=
				sizeof( jointWeight_t ) );
		maxBonesPerVertex = Max( maxBonesPerVertex, bonesPerVertex );
		if ( bonesPerVertex > 4 ) {
			common->Warning( "Vertex %d in %s is weighted to %d transforms",
				vertex, Name(), bonesPerVertex );
		}
	}
	return maxBonesPerVertex;
}

void rvRenderModelMD5R::FixBadTangentSpaces( srfTriangles_t &tri ) {
	for ( int i = 0; i < tri.numVerts; ++i ) {
		idDrawVert &vert = tri.verts[i];
		if ( !FLOAT_IS_NAN( vert.tangents[0].x ) &&
				!FLOAT_IS_NAN( vert.tangents[0].y ) &&
				!FLOAT_IS_NAN( vert.tangents[0].z ) &&
				!FLOAT_IS_NAN( vert.tangents[1].x ) &&
				!FLOAT_IS_NAN( vert.tangents[1].y ) &&
				!FLOAT_IS_NAN( vert.tangents[1].z ) ) {
			continue;
		}

		if ( idMath::Fabs( vert.normal.z ) <= 0.7f ) {
			const float length = idMath::Sqrt(
				vert.normal.x * vert.normal.x + vert.normal.y * vert.normal.y );
			const float inverseLength = length > 0.0f ? 1.0f / length : 0.0f;
			vert.tangents[0].Set( -vert.normal.y * inverseLength,
				vert.normal.x * inverseLength, 0.0f );
		} else {
			const float length = idMath::Sqrt(
				vert.normal.y * vert.normal.y + vert.normal.z * vert.normal.z );
			const float inverseLength = length > 0.0f ? 1.0f / length : 0.0f;
			vert.tangents[0].Set( length,
				-vert.normal.x * vert.normal.y * inverseLength,
				-vert.normal.x * vert.normal.z * inverseLength );
		}
		vert.tangents[1] = vert.normal.Cross( vert.tangents[0] );
	}
}

int rvRenderModelMD5R::BuildBlend4VertArray( idMD5Mesh &md5Mesh,
		modelSurface_t &surface, rvBlend4DrawVert *drawVertices ) {
	srfTriangles_t &tri = *surface.geometry;
	R_DeriveTangents( &tri, true );
	FixBadTangentSpaces( tri );

	int currentWeight = 0;
	int maxBonesPerVertex = 0;
	const int sourceVertexCount = md5Mesh.texCoords.Num();
	for ( int vertex = 0; vertex < sourceVertexCount; ++vertex ) {
		int blendIndices[4] = { 0, 0, 0, 0 };
		float blendWeights[4] = { 0.0f, 0.0f, 0.0f, 0.0f };
		int bonesPerVertex = 0;
		for ( ;; ) {
			const jointWeight_t &jointWeight = md5Mesh.weights[currentWeight++];
			if ( bonesPerVertex < 4 ) {
				blendIndices[bonesPerVertex] = jointWeight.jointMatOffset /
					sizeof( idJointMat );
				blendWeights[bonesPerVertex] = jointWeight.weight;
				if ( blendWeights[bonesPerVertex] > blendWeights[0] ) {
					const int oldIndex = blendIndices[0];
					blendIndices[0] = blendIndices[bonesPerVertex];
					blendIndices[bonesPerVertex] = oldIndex;
					const float oldWeight = blendWeights[0];
					blendWeights[0] = blendWeights[bonesPerVertex];
					blendWeights[bonesPerVertex] = oldWeight;
				}
			}
			++bonesPerVertex;
			if ( jointWeight.nextVertexOffset == sizeof( jointWeight_t ) ) {
				break;
			}
		}
		maxBonesPerVertex = Max( maxBonesPerVertex, bonesPerVertex );

		rvBlend4DrawVert &dest = drawVertices[vertex];
		for ( int i = 0; i < 4; ++i ) {
			dest.blendIndex[i] = blendIndices[i];
			dest.blendWeight[i] = blendWeights[i];
		}
		const idDrawVert &source = tri.verts[vertex];
		dest.xyz = source.xyz;
		dest.normal = source.normal;
		dest.tangent = source.tangents[0];
		dest.binormal = source.tangents[1];
		memcpy( dest.color, source.color, sizeof( dest.color ) );
		dest.st = source.st;
	}

	for ( int vertex = sourceVertexCount; vertex < tri.numVerts; ++vertex ) {
		const int mirroredVertex =
			tri.mirroredVerts[vertex - sourceVertexCount];
		rvBlend4DrawVert &dest = drawVertices[vertex];
		const rvBlend4DrawVert &blendSource = drawVertices[mirroredVertex];
		memcpy( dest.blendIndex, blendSource.blendIndex,
			sizeof( dest.blendIndex ) );
		memcpy( dest.blendWeight, blendSource.blendWeight,
			sizeof( dest.blendWeight ) );
		const idDrawVert &source = tri.verts[vertex];
		dest.xyz = source.xyz;
		dest.normal = source.normal;
		dest.tangent = source.tangents[0];
		dest.binormal = source.tangents[1];
		memcpy( dest.color, source.color, sizeof( dest.color ) );
		dest.st = source.st;
	}

	for ( int index = 0; index < tri.numIndexes; index += 3 ) {
		if ( !MD5R_FaceNegativePolarity( tri, index ) ) {
			continue;
		}
		for ( int corner = 0; corner < 3; ++corner ) {
			float &weight = drawVertices[tri.indexes[index + corner]].blendWeight[0];
			weight = -idMath::Fabs( weight );
		}
	}
	return maxBonesPerVertex;
}

void rvRenderModelMD5R::RemoveFromList( rvRenderModelMD5R &model ) {
	rvRenderModelMD5R *previous = NULL;
	for ( rvRenderModelMD5R *current = ms_modelList; current != NULL;
			previous = current, current = current->m_next ) {
		if ( current != &model ) {
			continue;
		}
		if ( previous != NULL ) {
			previous->m_next = model.m_next;
		} else {
			ms_modelList = model.m_next;
		}
		model.m_next = NULL;
		return;
	}
}

void rvRenderModelMD5R::CompressVertexFormat( rvVertexFormat &compressedFormat,
		const rvVertexFormat &format ) {
	compressedFormat.Init( format );
	const Rv_Vertex_Component_t components[3] = {
		RV_VERTEX_COMPONENT_NORMAL,
		RV_VERTEX_COMPONENT_TANGENT,
		RV_VERTEX_COMPONENT_BINORMAL
	};
	for ( int i = 0; i < 3; ++i ) {
		if ( ( compressedFormat.m_flags & BIT( components[i] ) ) != 0 ) {
			compressedFormat.m_dataTypes[components[i]] =
				RV_VERTEX_DATA_TYPE_DEC_10_10_10N;
			compressedFormat.CalcSize();
		}
	}
}

void rvRenderModelMD5R::WriteSilhouetteEdges( idFile &outFile,
		const char *prepend, const char *prependPlusTab ) {
	if ( m_numSilEdgesAdded == 0 ) {
		return;
	}
	outFile.WriteFloatString( "%sSilhouetteEdge[ %d ]\n%s{\n",
		prepend, m_numSilEdgesAdded, prepend );
	for ( int i = 0; i < m_numSilEdgesAdded; ++i ) {
		outFile.WriteFloatString( "%s%d %d %d %d\n", prependPlusTab,
			m_silEdges[i].p1, m_silEdges[i].p2,
			m_silEdges[i].v1, m_silEdges[i].v2 );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvRenderModelMD5R::WriteLevelOfDetail( idFile &outFile,
		const char *prepend, const char *prependPlusTab ) {
	bool isDefault = m_numLODs <= 3;
	for ( int i = 0; isDefault && i < m_numLODs; ++i ) {
		const float defaultRange = i < 3 ? MD5R_DefaultLODRanges[i]
			: m_lods[i - 1].m_rangeEnd * 2.0f;
		isDefault = m_lods[i].m_rangeEnd == defaultRange;
	}
	if ( m_numLODs == 0 || isDefault ) {
		return;
	}
	outFile.WriteFloatString( "%sLevelOfDetail[ %d ]\n%s{\n",
		prepend, m_numLODs, prepend );
	for ( int i = 0; i < m_numLODs; ++i ) {
		outFile.WriteFloatString( "%s%f\n", prependPlusTab, m_lods[i].m_rangeEnd );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvRenderModelMD5R::WriteMeshes( idFile &outFile, const char *prepend ) {
	if ( m_numMeshes == 0 ) {
		return;
	}
	idStr indent = prepend;
	indent += "\t";
	outFile.WriteFloatString( "%sMesh[ %d ]\n%s{\n", prepend, m_numMeshes, prepend );
	for ( int i = 0; i < m_numMeshes; ++i ) {
		m_meshes[i].Write( outFile, indent.c_str() );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvRenderModelMD5R::WriteJoints( idFile &outFile, const char *prepend,
		const char *prependPlusTab ) {
	if ( m_numJoints == 0 ) {
		return;
	}
	outFile.WriteFloatString( "%sJoint[ %d ]\n%s{\n",
		prepend, m_numJoints, prepend );
	for ( int i = 0; i < m_numJoints; ++i ) {
		const int parentOffset = m_joints[i].parent != NULL
			? static_cast<int>( m_joints[i].parent - m_joints ) : -1;
		idJointMat jointMat = m_skinSpaceToLocalMats[i];
		jointMat.Invert();
		const idJointQuat jointQuat = jointMat.ToJointQuat();
		const idCQuat compressedQuat = jointQuat.q.ToCQuat();
		const idVec3 translation = jointMat.ToVec3();
		outFile.WriteFloatString(
			"%s\"%s\" %d  %f %f %f  %f %f %f\n",
			prependPlusTab, m_joints[i].name.c_str(), parentOffset,
			translation.x, translation.y, translation.z,
			compressedQuat.x, compressedQuat.y, compressedQuat.z );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvRenderModelMD5R::Print() const {
	int totalVertices = 0;
	int totalTriangles = 0;
	common->Printf( "%s\nDynamic MD5R model.\n    verts  tris material\n", name.c_str() );
	for ( int i = 0; i < m_numMeshes; ++i ) {
		const rvMesh &mesh = m_meshes[i];
		totalVertices += mesh.m_numDrawVertices;
		totalTriangles += mesh.m_numDrawPrimitives;
		common->Printf( "%2i: %5i %5i %s\n", i, mesh.m_numDrawVertices,
			mesh.m_numDrawPrimitives, mesh.m_material->GetName() );
	}
	common->Printf( "-----\n%4i verts.\n%4i tris.\n%4i joints.\n",
		totalVertices, totalTriangles, m_numJoints );
}

void rvRenderModelMD5R::TouchData() {
	for ( int i = 0; i < m_numMeshes; ++i ) {
		declManager->FindMaterial( m_meshes[i].m_material->GetName() );
	}
}

jointHandle_t rvRenderModelMD5R::GetJointHandle( const char *jointName ) const {
	for ( int i = 0; i < m_numJoints; ++i ) {
		if ( m_joints[i].name.Icmp( jointName ) == 0 ) {
			return static_cast<jointHandle_t>( i );
		}
	}
	return INVALID_JOINT;
}

const char *rvRenderModelMD5R::GetJointName( jointHandle_t jointHandle ) const {
	if ( jointHandle < 0 || jointHandle >= m_numJoints ) {
		return "<invalid joint>";
	}
	return m_joints[jointHandle].name.c_str();
}

int rvRenderModelMD5R::GetSurfaceMask( const char *surfaceName ) const {
	int surfaceMask = 0;
	for ( int i = m_numMeshes - 1; i >= 0; --i ) {
		if ( idStr::Icmp( m_meshes[i].m_material->GetName(), surfaceName ) == 0 ) {
			surfaceMask |= 1 << m_meshes[i].m_meshIdentifier;
		}
	}
	return surfaceMask;
}

void rvRenderModelMD5R::DrawJoints( const renderEntity_t *entity,
		const viewDef_t *view ) const {
	if ( entity == NULL || entity->joints == NULL ) {
		return;
	}
	const int numJoints = Min( entity->numJoints, m_numJoints );
	for ( int i = 0; i < numJoints; ++i ) {
		const idJointMat &joint = entity->joints[i];
		const idVec3 position = entity->origin + joint.ToVec3() * entity->axis;
		if ( m_joints[i].parent != NULL ) {
			const int parent = static_cast<int>( m_joints[i].parent - m_joints );
			const idVec3 parentPosition = entity->origin +
				entity->joints[parent].ToVec3() * entity->axis;
			session->rw->DebugLine( colorWhite, parentPosition, position );
		}
		const idMat3 jointAxis = joint.ToMat3();
		session->rw->DebugLine( colorRed, position,
			position + jointAxis[0] * 2.0f * entity->axis );
		session->rw->DebugLine( colorGreen, position,
			position + jointAxis[1] * 2.0f * entity->axis );
		session->rw->DebugLine( colorBlue, position,
			position + jointAxis[2] * 2.0f * entity->axis );
	}

	idBounds worldBounds;
	worldBounds.FromTransformedBounds( entity->bounds, vec3_origin, entity->axis );
	session->rw->DebugBounds( colorMagenta, worldBounds, entity->origin );
	if ( view == NULL || r_jointNameScale.GetFloat() == 0.0f ||
			!worldBounds.Expand( 128.0f ).ContainsPoint(
				view->renderView.vieworg - entity->origin ) ) {
		return;
	}
	const idVec3 offset( 0.0f, 0.0f, r_jointNameOffset.GetFloat() );
	for ( int i = 0; i < numJoints; ++i ) {
		const idVec3 position = entity->origin +
			entity->joints[i].ToVec3() * entity->axis;
		session->rw->DrawText( m_joints[i].name.c_str(), position + offset,
			r_jointNameScale.GetFloat(), colorCyan,
			view->renderView.viewaxis, 1 );
	}
}

void rvRenderModelMD5R::GenerateCollisionModel(
		idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel ) {
	bool hasCollisionMesh = false;
	for ( int i = 0; i < m_numMeshes; ++i ) {
		if ( ( m_meshes[i].m_material->GetSurfaceFlags() & SURF_COLLISION ) != 0 ) {
			hasCollisionMesh = true;
			break;
		}
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		const idMaterial *material = m_meshes[i].m_material;
		if ( material->GetContentFlags() != 0 &&
				( !hasCollisionMesh ||
				  ( material->GetSurfaceFlags() & SURF_COLLISION ) != 0 ) ) {
			m_meshes[i].GenerateCollisionPolys( modelManager, collisionModel );
		}
	}
}

void rvRenderModelMD5R::WriteSansBuffers( idFile &outFile, const char *prepend ) {
	if ( m_numMeshes == 0 ) {
		return;
	}
	WriteMeshes( outFile, prepend );
	outFile.WriteFloatString( "%sBounds %f %f %f  %f %f %f\n", prepend,
		bounds[0].x, bounds[0].y, bounds[0].z,
		bounds[1].x, bounds[1].y, bounds[1].z );
	if ( GetHasSky() ) {
		outFile.WriteFloatString( "%sHasSky\n", prepend );
	}
}

void rvRenderModelMD5R::Shutdown() {
	idRenderModelStatic::PurgeModel();
	delete[] m_joints;
	if ( m_skinSpaceToLocalMats != NULL ) {
		Mem_Free16( m_skinSpaceToLocalMats );
	}
	if ( m_defaultPose != NULL ) {
		Mem_Free16( m_defaultPose );
	}
	delete[] m_allocVertexBuffers;
	delete[] m_allocIndexBuffers;
	if ( m_allocSilEdges != NULL ) {
		Mem_Free( m_allocSilEdges );
	}
	delete[] m_meshes;
	if ( m_lods != NULL ) {
		Mem_Free( m_lods );
	}
	ResetValues();
}

void rvRenderModelMD5R::PurgeModel() {
	Shutdown();
}

void rvRenderModelMD5R::ParseJoints( Lexer &lexer ) {
	lexer.ExpectTokenString( "[" );
	m_numJoints = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );

	m_joints = new idMD5Joint[m_numJoints];
	m_skinSpaceToLocalMats = static_cast<idJointMat *>(
		Mem_Alloc16( m_numJoints * sizeof( idJointMat ), MA_RENDER ) );
	m_defaultPose = static_cast<idJointQuat *>(
		Mem_Alloc16( m_numJoints * sizeof( idJointQuat ), MA_RENDER ) );
	if ( ( m_joints == NULL || m_skinSpaceToLocalMats == NULL ||
			m_defaultPose == NULL ) && m_numJoints != 0 ) {
		lexer.Error( "Out of memory" );
	}

	for ( int i = 0; i < m_numJoints; ++i ) {
		idToken token;
		lexer.ReadToken( &token );
		m_joints[i].name = token;
		const int parentOffset = lexer.ParseInt();

		idVec3 translation;
		translation.x = lexer.ParseFloat();
		translation.y = lexer.ParseFloat();
		translation.z = lexer.ParseFloat();
		idQuat rotation;
		rotation.x = lexer.ParseFloat();
		rotation.y = lexer.ParseFloat();
		rotation.z = lexer.ParseFloat();
		rotation.w = rotation.CalcW();

		m_skinSpaceToLocalMats[i].SetRotation( rotation.ToMat3() );
		m_skinSpaceToLocalMats[i].SetTranslation( translation );
		if ( parentOffset >= 0 ) {
			if ( parentOffset >= m_numJoints - 1 ) {
				lexer.Error( "Invalid parent for joint '%s'",
					m_joints[i].name.c_str() );
			}
			m_joints[i].parent = &m_joints[parentOffset];
			const idMat3 parentRotation =
				m_skinSpaceToLocalMats[parentOffset].ToMat3();
			m_defaultPose[i].q = ( m_skinSpaceToLocalMats[i].ToMat3() *
				parentRotation.Transpose() ).ToQuat();
			m_defaultPose[i].t = ( translation -
				m_skinSpaceToLocalMats[parentOffset].ToVec3() ) *
				parentRotation.Transpose();
		} else {
			m_joints[i].parent = NULL;
			m_defaultPose[i].q = rotation;
			m_defaultPose[i].t = translation;
		}
		m_defaultPose[i].w = 0.0f;
	}

	for ( int i = 0; i < m_numJoints; ++i ) {
		m_skinSpaceToLocalMats[i].Invert();
	}
	lexer.ExpectTokenString( "}" );
}

bool rvRenderModelMD5R::HasCollisionSurface( const renderEntity_t *entity ) const {
	if ( entity == NULL ) {
		return false;
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		const idMaterial *material = R_RemapShaderBySkin( m_meshes[i].m_material,
			entity->customSkin, entity->customShader );
		if ( ( material->GetSurfaceFlags() & SURF_COLLISION ) != 0 &&
				!material->IsDrawn() && !material->SurfaceCastsShadow() ) {
			return true;
		}
	}
	return false;
}

void rvRenderModelMD5R::Write( idFile &outFile, const char *prepend,
		bool writeBuffers ) {
	if ( IsDefaultModel() ) {
		return;
	}
	idStr indent = prepend;
	indent += "\t";
	WriteJoints( outFile, prepend, indent.c_str() );

	if ( m_numVertexBuffers != 0 ) {
		outFile.WriteFloatString( "%sVertexBuffer[ %d ]\n%s{\n",
			prepend, m_numVertexBuffers, prepend );
		for ( int i = 0; i < m_numVertexBuffers; ++i ) {
			if ( writeBuffers ) {
				if ( ( m_vertexBuffers[i].m_flags &
						( rvVertexBufferFlagUsageShadow |
						  rvVertexBufferFlagUsageExplicitShadow ) ) != 0 ) {
					rvVertexFormat compressedFormat;
					CompressVertexFormat( compressedFormat, m_vertexBuffers[i].m_format );
					m_vertexBuffers[i].SetLoadFormat( compressedFormat );
					m_vertexBuffers[i].m_flags |=
						rvVertexBufferFlagWriteLoadFormatAsPrimary;
				} else {
					m_vertexBuffers[i].m_flags |=
						rvVertexBufferFlagInitiallyEmpty;
				}
			} else {
				m_vertexBuffers[i].m_flags &=
					~rvVertexBufferFlagInitiallyEmpty;
				m_vertexBuffers[i].m_flags &=
					~rvVertexBufferFlagWriteLoadFormatAsPrimary;
			}
			m_vertexBuffers[i].Write( outFile, indent.c_str() );
		}
		outFile.WriteFloatString( "%s}\n", prepend );
	}

	if ( m_numIndexBuffers != 0 ) {
		outFile.WriteFloatString( "%sIndexBuffer[ %d ]\n%s{\n",
			prepend, m_numIndexBuffers, prepend );
		for ( int i = 0; i < m_numIndexBuffers; ++i ) {
			m_indexBuffers[i].Write( outFile, indent.c_str() );
		}
		outFile.WriteFloatString( "%s}\n", prepend );
	}
	WriteSilhouetteEdges( outFile, prepend, indent.c_str() );
	WriteLevelOfDetail( outFile, prepend, indent.c_str() );
	WriteSansBuffers( outFile, prepend );
}

bool rvRenderModelMD5R::Init( idRenderModelMD5 &sourceModel ) {
	if ( m_meshes != NULL ) {
		Shutdown();
	}
	name = sourceModel.Name();
	m_source = MD5R_SOURCE_MD5;
	purged = false;
	reloadable = true;
	m_numJoints = sourceModel.NumJoints();
	m_joints = new idMD5Joint[m_numJoints];
	m_skinSpaceToLocalMats = static_cast<idJointMat *>(
		Mem_Alloc16( m_numJoints * sizeof( idJointMat ), MA_RENDER ) );
	m_defaultPose = static_cast<idJointQuat *>(
		Mem_Alloc16( m_numJoints * sizeof( idJointQuat ), MA_RENDER ) );
	if ( ( m_joints == NULL || m_skinSpaceToLocalMats == NULL ||
			m_defaultPose == NULL ) && m_numJoints != 0 ) {
		common->FatalError( "Out of memory" );
	}

	const idMD5Joint *sourceJoints = sourceModel.GetJoints();
	const idJointQuat *sourcePose = sourceModel.GetDefaultPose();
	const idJointMat *sourceSkinMats = sourceModel.GetSkinSpaceToLocalMats();
	idJointMat *jointMats = static_cast<idJointMat *>(
		_alloca16( m_numJoints * sizeof( idJointMat ) ) );
	for ( int i = 0; i < m_numJoints; ++i ) {
		m_joints[i].name = sourceJoints[i].name;
		m_joints[i].parent = sourceJoints[i].parent != NULL
			? &m_joints[sourceJoints[i].parent - sourceJoints] : NULL;
		m_defaultPose[i] = sourcePose[i];
		m_skinSpaceToLocalMats[i] = sourceSkinMats[i];
		jointMats[i].SetRotation( sourcePose[i].q.ToMat3() );
		jointMats[i].SetTranslation( sourcePose[i].t );
		if ( m_joints[i].parent != NULL ) {
			jointMats[i] *= jointMats[m_joints[i].parent - m_joints];
		}
	}

	idRenderModelStatic staticModel;
	staticModel.InitEmpty( MD5R_SnapshotName );
	renderEntity_t renderEntity;
	memset( &renderEntity, 0, sizeof( renderEntity ) );
	renderEntity.axis = mat3_identity;
	renderEntity.bounds.Clear();
	renderEntity.numJoints = m_numJoints;
	renderEntity.joints = jointMats;
	renderEntity.hModel = &sourceModel;
	for ( int i = 0; i < sourceModel.meshes.Num(); ++i ) {
		modelSurface_t &surface = staticModel.surfaces.Alloc();
		surface.id = i;
		surface.shader = NULL;
		surface.geometry = NULL;
		surface.mOriginalSurfaceName = NULL;
		sourceModel.meshes[i].UpdateSurface(
			&renderEntity, jointMats, &surface, true );
		staticModel.bounds.AddBounds( surface.geometry->bounds );
	}

	int oneBoneVertices = 0;
	int fourBoneVertices = 0;
	int numIndices = 0;
	int numSilEdges = 0;
	for ( int i = 0; i < staticModel.surfaces.Num(); ++i ) {
		modelSurface_t &surface = staticModel.surfaces[i];
		idMD5Mesh &md5Mesh = sourceModel.meshes[surface.id];
		const int bonesPerVertex = CalcMaxBonesPerVertex(
			md5Mesh.weights, md5Mesh.texCoords.Num(), *surface.geometry );
		if ( bonesPerVertex > 4 ) {
			Shutdown();
			common->Warning(
				"Unable to convert MD5 mesh %s - too many bones per vertex: %d",
				sourceModel.Name(), bonesPerVertex );
			return false;
		}
		if ( bonesPerVertex <= 1 ) {
			oneBoneVertices += surface.geometry->numVerts;
		} else {
			fourBoneVertices += surface.geometry->numVerts;
		}
		numIndices += surface.geometry->numIndexes;
		numSilEdges += surface.geometry->numSilEdges;
	}
	if ( m_numJoints >= 25 ) {
		oneBoneVertices *= 2;
		fourBoneVertices *= 2;
		numIndices *= 2;
		numSilEdges *= 2;
	}

	m_numVertexBuffers = oneBoneVertices != 0 && fourBoneVertices != 0 ? 6 : 3;
	m_allocVertexBuffers = new rvVertexBuffer[m_numVertexBuffers];
	m_vertexBuffers = m_allocVertexBuffers;
	if ( m_vertexBuffers == NULL ) {
		common->FatalError( "Out of memory" );
	}
	int textureDimensions[7] = { 2, 0, 0, 0, 0, 0, 0 };
	rvVertexFormat vertexFormat;
	int fourBoneBufferStart = 0;
	if ( oneBoneVertices != 0 ) {
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex, 3, 0, 1, NULL );
		m_vertexBuffers[0].Init( vertexFormat, oneBoneVertices,
			rvVertexBufferFlagSystemMemory | rvVertexBufferFlagUsageDraw );
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex | rvVertexFormatFlagNormal |
			rvVertexFormatFlagTangent | rvVertexFormatFlagBinormal |
			rvVertexFormatFlagDiffuseColor |
			rvVertexFormatFlagTextureCoordinate,
			3, 0, 1, textureDimensions );
		m_vertexBuffers[1].Init( vertexFormat, oneBoneVertices,
			rvVertexBufferFlagSystemMemory | rvVertexBufferFlagVideoMemory |
			rvVertexBufferFlagUsageShadow );
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex, 3, 0, 1, NULL );
		m_vertexBuffers[2].Init( vertexFormat, oneBoneVertices * 2,
			rvVertexBufferFlagVideoMemory | rvVertexBufferFlagUsageSilTrace );
		fourBoneBufferStart = 3;
	}
	if ( fourBoneVertices != 0 ) {
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex | rvVertexFormatFlagBlendWeight,
			3, 4, 4, NULL );
		m_vertexBuffers[fourBoneBufferStart].Init( vertexFormat,
			fourBoneVertices,
			rvVertexBufferFlagSystemMemory | rvVertexBufferFlagUsageDraw );
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex | rvVertexFormatFlagBlendWeight |
			rvVertexFormatFlagNormal | rvVertexFormatFlagTangent |
			rvVertexFormatFlagDiffuseColor |
			rvVertexFormatFlagTextureCoordinate,
			3, 3, 4, textureDimensions );
		m_vertexBuffers[fourBoneBufferStart + 1].Init( vertexFormat,
			fourBoneVertices,
			rvVertexBufferFlagSystemMemory | rvVertexBufferFlagVideoMemory |
			rvVertexBufferFlagUsageShadow );
		vertexFormat.Init( rvVertexFormatFlagPosition |
			rvVertexFormatFlagBlendIndex | rvVertexFormatFlagBlendWeight,
			4, 3, 4, NULL );
		m_vertexBuffers[fourBoneBufferStart + 2].Init( vertexFormat,
			fourBoneVertices * 2,
			rvVertexBufferFlagVideoMemory | rvVertexBufferFlagUsageSilTrace );
	}

	m_numIndexBuffers = 2;
	m_allocIndexBuffers = new rvIndexBuffer[m_numIndexBuffers];
	m_indexBuffers = m_allocIndexBuffers;
	if ( m_indexBuffers == NULL ) {
		common->FatalError( "Out of memory" );
	}
	m_indexBuffers[0].Init( numIndices, rvIndexBufferFlagSystemMemory );
	m_indexBuffers[1].Init( numIndices,
		rvIndexBufferFlagSystemMemory | rvIndexBufferFlagVideoMemory );
	m_numSilEdges = numSilEdges;
	m_numSilEdgesAdded = 0;
	m_allocSilEdges = static_cast<silEdge_t *>(
		Mem_Alloc( numSilEdges * sizeof( silEdge_t ), MA_RENDER ) );
	m_silEdges = m_allocSilEdges;
	if ( m_silEdges == NULL && numSilEdges != 0 ) {
		common->FatalError( "Out of memory" );
	}
	m_numMeshes = sourceModel.meshes.Num();
	m_meshes = new rvMesh[m_numMeshes];
	if ( m_meshes == NULL ) {
		common->FatalError( "Out of memory" );
	}

	for ( int i = 0; i < m_numMeshes; ++i ) {
		int surfaceNum;
		if ( !staticModel.FindSurfaceWithId( i, surfaceNum ) ) {
			continue;
		}
		modelSurface_t &surface = staticModel.surfaces[surfaceNum];
		rvBlend4DrawVert *drawVertices = static_cast<rvBlend4DrawVert *>(
			Mem_Alloc( surface.geometry->numVerts *
				sizeof( rvBlend4DrawVert ), MA_RENDER ) );
		const int bonesPerVertex = BuildBlend4VertArray(
			sourceModel.meshes[i], surface, drawVertices );
		int *silRemap = MD5R_CreateSilRemap( *surface.geometry );
		const int vertexBufferStart =
			bonesPerVertex <= 1 ? 0 : fourBoneBufferStart;
		m_meshes[i].Init( *this, surface.shader, m_numJoints,
			drawVertices, surface.geometry->numVerts,
			surface.geometry->indexes, surface.geometry->numIndexes,
			surface.geometry->silEdges, surface.geometry->numSilEdges,
			silRemap, vertexBufferStart, vertexBufferStart + 1,
			vertexBufferStart + 2, 0, 1 );
		m_meshes[i].m_meshIdentifier = i;
		delete[] silRemap;
		Mem_Free( drawVertices );
	}
	BuildLevelsOfDetail();
	bounds = sourceModel.bounds;
	for ( int i = 0; i < m_numVertexBuffers; ++i ) {
		m_vertexBuffers[i].Resize( m_vertexBuffers[i].GetNumVerticesWritten() );
	}
	for ( int i = 0; i < m_numIndexBuffers; ++i ) {
		m_indexBuffers[i].Resize( m_indexBuffers[i].GetNumIndicesWritten() );
	}
	SetHasSky( false );
	return true;
}

bool rvRenderModelMD5R::Init( idRenderModelStatic &sourceModel,
		rvVertexBuffer *vertexBuffers, int vertexBufferStart,
		int numVertexBuffers, rvIndexBuffer *indexBuffers,
		int indexBufferStart, int numIndexBuffers, silEdge_t *silEdges,
		int silEdgeStart, int maxNumSilEdges, rvMD5RSource_t source ) {
	if ( m_meshes != NULL ) {
		Shutdown();
	}
	name = sourceModel.Name();
	m_source = source;
	purged = false;

	int numMeshes = 0;
	for ( int i = 0; i < sourceModel.surfaces.Num(); ++i ) {
		if ( sourceModel.surfaces[i].geometry != NULL ) {
			++numMeshes;
		}
	}
	if ( numMeshes == 0 ) {
		if ( source != MD5R_SOURCE_MANUAL ) {
			MakeDefaultModel();
		}
		return false;
	}

	m_vertexBuffers = vertexBuffers;
	m_numVertexBuffers = vertexBufferStart + numVertexBuffers;
	m_indexBuffers = indexBuffers;
	m_numIndexBuffers = indexBufferStart + numIndexBuffers;
	m_silEdges = silEdges;
	m_numSilEdges = maxNumSilEdges;
	m_numSilEdgesAdded = silEdgeStart;

	int silTraceVertexBuffer = -1;
	int drawVertexBuffer = -1;
	int shadowVertexBuffer = -1;
	if ( numVertexBuffers == 3 ) {
		silTraceVertexBuffer = vertexBufferStart;
		drawVertexBuffer = vertexBufferStart + 1;
		shadowVertexBuffer = vertexBufferStart + 2;
	}
	int silTraceIndexBuffer = -1;
	int drawIndexBuffer = -1;
	int shadowIndexBuffer = -1;
	if ( numIndexBuffers == 3 ) {
		silTraceIndexBuffer = indexBufferStart;
		drawIndexBuffer = indexBufferStart + 1;
		shadowIndexBuffer = indexBufferStart + 2;
	} else if ( numIndexBuffers == 2 ) {
		silTraceIndexBuffer = indexBufferStart;
		drawIndexBuffer = indexBufferStart + 1;
	}

	m_numMeshes = numMeshes;
	m_meshes = new rvMesh[m_numMeshes];
	if ( m_meshes == NULL ) {
		common->FatalError( "Out of memory" );
	}
	int meshIndex = 0;
	for ( int i = 0; i < sourceModel.surfaces.Num(); ++i ) {
		modelSurface_t &surface = sourceModel.surfaces[i];
		if ( surface.geometry == NULL ) {
			continue;
		}
		int *silRemap = NULL;
		if ( surface.geometry->verts != NULL ) {
			FixBadTangentSpaces( *surface.geometry );
			silRemap = MD5R_CreateSilRemap( *surface.geometry );
		}
		m_meshes[meshIndex].Init( *this, surface, silRemap,
			silTraceVertexBuffer, drawVertexBuffer, shadowVertexBuffer,
			silTraceIndexBuffer, drawIndexBuffer, shadowIndexBuffer );
		m_meshes[meshIndex].m_meshIdentifier = meshIndex;
		delete[] silRemap;
		++meshIndex;
	}
	BuildLevelsOfDetail();
	bounds = sourceModel.bounds;
	SetHasSky( sourceModel.GetHasSky() );
	return true;
}

bool rvRenderModelMD5R::Init( idRenderModelStatic &sourceModel,
		rvMD5RSource_t source ) {
	if ( m_meshes != NULL ) {
		Shutdown();
	}
	name = sourceModel.Name();
	m_source = source;
	purged = false;
	reloadable = true;

	int numDrawSurfaces = 0;
	for ( int i = 0; i < sourceModel.surfaces.Num(); ++i ) {
		const modelSurface_t &surface = sourceModel.surfaces[i];
		if ( surface.geometry != NULL &&
				( surface.shader->GetSurfaceFlags() & SURF_COLLISION ) == 0 ) {
			++numDrawSurfaces;
		}
	}

	int numVertices = 0;
	int numIndices = 0;
	int numSilEdges = 0;
	int numMeshes = 0;
	for ( int i = 0; i < sourceModel.surfaces.Num(); ++i ) {
		const modelSurface_t &surface = sourceModel.surfaces[i];
		if ( surface.geometry == NULL ||
				( numDrawSurfaces > 0 &&
				  ( surface.shader->GetSurfaceFlags() & SURF_COLLISION ) != 0 ) ) {
			continue;
		}
		numVertices += surface.geometry->numVerts;
		numIndices += surface.geometry->numIndexes;
		numSilEdges += surface.geometry->numSilEdges;
		++numMeshes;
	}
	if ( numMeshes == 0 ) {
		if ( source != MD5R_SOURCE_MANUAL ) {
			MakeDefaultModel();
		}
		return false;
	}

	int textureDimensions[7] = { 2, 0, 0, 0, 0, 0, 0 };
	rvVertexFormat vertexFormat;
	m_numVertexBuffers = 3;
	m_allocVertexBuffers = new rvVertexBuffer[m_numVertexBuffers];
	m_vertexBuffers = m_allocVertexBuffers;
	if ( m_vertexBuffers == NULL ) {
		common->FatalError( "Out of memory" );
	}
	vertexFormat.Init( rvVertexFormatFlagPosition, 4, 0, 1, NULL );
	m_vertexBuffers[0].Init( vertexFormat, numVertices,
		rvVertexBufferFlagSystemMemory | rvVertexBufferFlagUsageDraw );
	vertexFormat.Init( rvVertexFormatFlagPosition | rvVertexFormatFlagNormal |
		rvVertexFormatFlagTangent | rvVertexFormatFlagBinormal |
		rvVertexFormatFlagDiffuseColor | rvVertexFormatFlagTextureCoordinate,
		4, 0, 1, textureDimensions );
	m_vertexBuffers[1].Init( vertexFormat, numVertices,
		rvVertexBufferFlagSystemMemory | rvVertexBufferFlagVideoMemory |
		rvVertexBufferFlagUsageShadow );
	vertexFormat.Init( rvVertexFormatFlagPosition, 4, 0, 1, NULL );
	m_vertexBuffers[2].Init( vertexFormat, numVertices * 2,
		rvVertexBufferFlagVideoMemory | rvVertexBufferFlagUsageSilTrace );

	m_numIndexBuffers = 2;
	m_allocIndexBuffers = new rvIndexBuffer[m_numIndexBuffers];
	m_indexBuffers = m_allocIndexBuffers;
	if ( m_indexBuffers == NULL ) {
		common->FatalError( "Out of memory" );
	}
	m_indexBuffers[0].Init( numIndices, rvIndexBufferFlagSystemMemory );
	m_indexBuffers[1].Init( numIndices,
		rvIndexBufferFlagSystemMemory | rvIndexBufferFlagVideoMemory );

	m_numSilEdges = numSilEdges;
	m_numSilEdgesAdded = 0;
	m_allocSilEdges = static_cast<silEdge_t *>(
		Mem_Alloc( numSilEdges * sizeof( silEdge_t ), MA_RENDER ) );
	m_silEdges = m_allocSilEdges;
	if ( m_silEdges == NULL && numSilEdges != 0 ) {
		common->FatalError( "Out of memory" );
	}
	m_numMeshes = numMeshes;
	m_meshes = new rvMesh[m_numMeshes];
	if ( m_meshes == NULL ) {
		common->FatalError( "Out of memory" );
	}

	int meshIndex = 0;
	for ( int i = 0; i < sourceModel.surfaces.Num(); ++i ) {
		modelSurface_t &surface = sourceModel.surfaces[i];
		if ( surface.geometry == NULL ||
				( numDrawSurfaces > 0 &&
				  ( surface.shader->GetSurfaceFlags() & SURF_COLLISION ) != 0 ) ) {
			continue;
		}
		FixBadTangentSpaces( *surface.geometry );
		int *silRemap = MD5R_CreateSilRemap( *surface.geometry );
		m_meshes[meshIndex].Init( *this, surface, silRemap,
			0, 1, 2, 0, 1, -1 );
		m_meshes[meshIndex].m_meshIdentifier = meshIndex;
		delete[] silRemap;
		++meshIndex;
	}
	BuildLevelsOfDetail();
	bounds = sourceModel.bounds;
	for ( int i = 0; i < m_numVertexBuffers; ++i ) {
		m_vertexBuffers[i].Resize( m_vertexBuffers[i].GetNumVerticesWritten() );
	}
	for ( int i = 0; i < m_numIndexBuffers; ++i ) {
		m_indexBuffers[i].Resize( m_indexBuffers[i].GetNumIndicesWritten() );
	}
	GenerateStaticSurfaces();
	SetHasSky( source == MD5R_SOURCE_MANUAL ? sourceModel.GetHasSky() : false );
	return true;
}

bool rvRenderModelMD5R::Init( Lexer &lexer, rvVertexBuffer *vertexBuffers,
		int numVertexBuffers, rvIndexBuffer *indexBuffers, int numIndexBuffers,
		silEdge_t *silEdges, int maxNumSilEdges, rvMD5RSource_t source ) {
	if ( m_meshes != NULL ) {
		Shutdown();
	}
	m_source = source;
	m_vertexBuffers = vertexBuffers;
	m_numVertexBuffers = numVertexBuffers;
	m_indexBuffers = indexBuffers;
	m_numIndexBuffers = numIndexBuffers;
	m_silEdges = silEdges;
	m_numSilEdges = maxNumSilEdges;
	m_numSilEdgesAdded = maxNumSilEdges;
	purged = false;

	bool result = true;
	idToken token;
	lexer.ReadToken( &token );
	if ( token.Icmp( "Mesh" ) != 0 ) {
		result = false;
	} else {
		ParseMeshes( lexer );
		BuildLevelsOfDetail();
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "Bounds" ) == 0 ) {
		bounds[0].x = lexer.ParseFloat();
		bounds[0].y = lexer.ParseFloat();
		bounds[0].z = lexer.ParseFloat();
		bounds[1].x = lexer.ParseFloat();
		bounds[1].y = lexer.ParseFloat();
		bounds[1].z = lexer.ParseFloat();
		lexer.ReadToken( &token );
	}
	if ( result ) {
		if ( token.Icmp( "HasSky" ) == 0 ) {
			SetHasSky( true );
		} else {
			lexer.UnreadToken( &token );
		}
		if ( m_numJoints == 0 ) {
			GenerateStaticSurfaces();
		}
	} else {
		lexer.UnreadToken( &token );
	}
	return result;
}

void rvRenderModelMD5R::InitFromFile( const char *fileName ) {
	if ( m_meshes != NULL ) {
		Shutdown();
	}
	name = fileName;
	m_source = MD5R_SOURCE_FILE;
	LoadModel();
	reloadable = true;
}

void rvRenderModelMD5R::LoadModel() {
	idAutoPtr<Lexer> lexer( LexerFactory::MakeLexer(
		LEXFL_NOSTRINGESCAPECHARS | LEXFL_ALLOWPATHNAMES ) );

	if ( m_source == MD5R_SOURCE_MD5 ) {
		idAutoPtr<idRenderModelMD5> md5Model( new idRenderModelMD5 );
		if ( md5Model.get() == NULL ) {
			common->FatalError( "rvRenderModelMD5R: load failed, out of memory" );
			return;
		}
		md5Model->InitFromFile( name.c_str() );
		if ( md5Model->IsDefaultModel() ) {
			MakeDefaultModel();
		} else {
			Init( *md5Model );
		}
		return;
	}

	if ( m_source == MD5R_SOURCE_LWO_ASE_FLT ) {
		idAutoPtr<idRenderModelStatic> staticModel( new idRenderModelStatic );
		if ( staticModel.get() == NULL ) {
			common->FatalError( "rvRenderModelMD5R: load failed, out of memory" );
			return;
		}
		staticModel->InitFromFile( name.c_str() );
		if ( staticModel->IsDefaultModel() ) {
			MakeDefaultModel();
		} else {
			Init( *staticModel, MD5R_SOURCE_LWO_ASE_FLT );
		}
		return;
	}

	if ( m_meshes != NULL ) {
		Shutdown();
	}
	purged = false;
	if ( !lexer->LoadFile( name.c_str() ) ) {
		MakeDefaultModel();
		return;
	}

	lexer->ExpectTokenString( "MD5RVersion" );
	const int version = lexer->ParseInt();
	if ( version != 1 ) {
		lexer->Error( "Invalid version %d.  Should be version %d\n", version, 1 );
	}

	idToken token;
	lexer->ReadToken( &token );
	if ( token.Icmp( "CommandLine" ) == 0 ) {
		lexer->ReadToken( &token );
	}
	if ( token.Icmp( "Joint" ) == 0 ) {
		ParseJoints( *lexer );
		lexer->ReadToken( &token );
	}
	if ( token.Icmp( "VertexBuffer" ) != 0 ) {
		lexer->Error( "Expected VertexBuffer keyword" );
	}
	ParseVertexBuffers( *lexer );
	lexer->ReadToken( &token );
	if ( token.Icmp( "IndexBuffer" ) == 0 ) {
		ParseIndexBuffers( *lexer );
		lexer->ReadToken( &token );
	}
	if ( token.Icmp( "SilhouetteEdge" ) == 0 ) {
		ParseSilhouetteEdges( *lexer );
		lexer->ReadToken( &token );
	}
	if ( token.Icmp( "LevelOfDetail" ) == 0 ) {
		ParseLevelOfDetail( *lexer );
		lexer->ReadToken( &token );
	}
	if ( token.Icmp( "Mesh" ) != 0 ) {
		lexer->Error( "Expected Mesh keyword" );
	}
	ParseMeshes( *lexer );
	BuildLevelsOfDetail();

	lexer->ExpectTokenString( "Bounds" );
	bounds[0].x = lexer->ParseFloat();
	bounds[0].y = lexer->ParseFloat();
	bounds[0].z = lexer->ParseFloat();
	bounds[1].x = lexer->ParseFloat();
	bounds[1].y = lexer->ParseFloat();
	bounds[1].z = lexer->ParseFloat();
	if ( lexer->ReadToken( &token ) && token.Icmp( "HasSky" ) == 0 ) {
		SetHasSky( true );
	}
	fileSystem->ReadFile( name.c_str(), NULL, &timeStamp );
	if ( m_numJoints == 0 ) {
		GenerateStaticSurfaces();
	}
}

modelSurface_t *rvRenderModelMD5R::GenerateSurface(
		idRenderModelStatic &staticModel, rvMesh &mesh,
		const renderEntity_t &entity, unsigned int surfaceMask ) {
	const idMaterial *material = R_RemapShaderBySkin( mesh.m_material,
		entity.customSkin, entity.customShader );
	if ( ( surfaceMask & SURF_COLLISION ) != 0 ) {
		if ( material == NULL ||
				( material->GetSurfaceFlags() & SURF_COLLISION ) == 0 ) {
			staticModel.DeleteSurfaceWithId( mesh.m_meshIdentifier );
			mesh.m_surfaceNum = -1;
			return NULL;
		}
	} else if ( material == NULL ||
			( !material->IsDrawn() && !material->SurfaceCastsShadow() ) ) {
		staticModel.DeleteSurfaceWithId( mesh.m_meshIdentifier );
		mesh.m_surfaceNum = -1;
		return NULL;
	}

	int surfaceNum = -1;
	modelSurface_t *surface = NULL;
	if ( staticModel.FindSurfaceWithId( mesh.m_meshIdentifier, surfaceNum ) ) {
		mesh.m_surfaceNum = surfaceNum;
		surface = &staticModel.surfaces[surfaceNum];
	} else {
		mesh.m_surfaceNum = staticModel.NumSurfaces();
		surface = &staticModel.surfaces.Alloc();
		surface->geometry = NULL;
		surface->shader = NULL;
		surface->id = mesh.m_meshIdentifier;
		surface->mOriginalSurfaceName = NULL;
	}
	mesh.UpdateSurface( *surface, entity, m_skinSpaceToLocalMats );
	staticModel.bounds.AddBounds( surface->geometry->bounds );
	return surface;
}

void rvRenderModelMD5R::GenerateSurface( rvMesh &mesh ) {
	mesh.m_surfaceNum = NumSurfaces();
	modelSurface_t &surface = surfaces.Alloc();
	surface.geometry = NULL;
	surface.shader = NULL;
	surface.id = mesh.m_meshIdentifier;
	surface.mOriginalSurfaceName = NULL;
	mesh.UpdateSurface( surface );
}

idRenderModel *rvRenderModelMD5R::InstantiateDynamicModel(
		const renderEntity_t *entity, const viewDef_t *view,
		idRenderModel *cachedModel, dword surfaceMask ) {
	if ( m_numJoints == 0 || entity == NULL ) {
		return NULL;
	}
	if ( cachedModel != NULL && !r_useCachedDynamicModels.GetBool() ) {
		delete cachedModel;
		cachedModel = NULL;
	}
	if ( purged ) {
		common->DWarning( "model %s instantiated while purged", Name() );
		LoadModel();
	}
	if ( entity->joints == NULL ) {
		common->Printf( "rvRenderModelMD5R::InstantiateDynamicModel: NULL joints on renderEntity for '%s'\n", Name() );
		delete cachedModel;
		return NULL;
	}
	if ( entity->numJoints != m_numJoints ) {
		common->Printf( "rvRenderModelMD5R::InstantiateDynamicModel: renderEntity has different number of joints than model for '%s'\n", Name() );
		delete cachedModel;
		return NULL;
	}

	idRenderModelStatic *staticModel;
	if ( cachedModel != NULL ) {
		staticModel = static_cast<idRenderModelStatic *>( cachedModel );
	} else {
		staticModel = new idRenderModelStatic;
		staticModel->InitEmpty( MD5R_SnapshotName );
	}
	staticModel->bounds.Clear();
	if ( r_showSkel.GetInteger() != 0 && view != NULL &&
			( !r_skipSuppress.GetBool() || entity->suppressSurfaceInViewID == 0 ||
			  entity->suppressSurfaceInViewID != view->renderView.viewID ) ) {
		DrawJoints( entity, view );
		if ( r_showSkel.GetInteger() > 1 ) {
			staticModel->InitEmpty( MD5R_SnapshotName );
			return staticModel;
		}
	}

	int level = 0;
	if ( view != NULL ) {
		const float distanceSquared = view->renderView.vieworg.Dist2( entity->origin );
		while ( level < m_numLODs &&
				distanceSquared >= m_lods[level].m_rangeEndSquared ) {
			++level;
		}
	}
	if ( level != staticModel->levelOfDetail ) {
		staticModel->InitEmpty( MD5R_SnapshotName );
		staticModel->levelOfDetail = level;
	}
	if ( level < m_numLODs ) {
		for ( rvMesh *mesh = m_lods[level].m_meshList; mesh != NULL;
				mesh = mesh->m_nextInLOD ) {
			GenerateSurface( *staticModel, *mesh, *entity, surfaceMask );
		}
	}
	for ( rvMesh *mesh = m_allLODMeshes; mesh != NULL; mesh = mesh->m_nextInLOD ) {
		GenerateSurface( *staticModel, *mesh, *entity, surfaceMask );
	}
	return staticModel;
}

void rvRenderModelMD5R::GenerateStaticSurfaces() {
	if ( purged ) {
		common->DWarning( "model %s instantiated while purged", Name() );
		LoadModel();
	}
	for ( int i = 0; i < m_numMeshes; ++i ) {
		GenerateSurface( m_meshes[i] );
	}
}

void rvRenderModelMD5R::WriteAll( bool writeBuffers ) {
	const bool oldFileLoadingAllowed = fileSystem->GetIsFileLoadingAllowed();
	fileSystem->SetIsFileLoadingAllowed( true );
	for ( rvRenderModelMD5R *model = ms_modelList; model != NULL;
			model = model->m_next ) {
		if ( model->m_meshes == NULL || model->purged ||
				( model->m_source != MD5R_SOURCE_MD5 &&
				  model->m_source != MD5R_SOURCE_LWO_ASE_FLT ) ) {
			continue;
		}

		idStr md5rName = model->name;
		md5rName.StripAbsoluteFileExtension();
		if ( model->m_source == MD5R_SOURCE_LWO_ASE_FLT ) {
			md5rName += "_static";
		}
		md5rName += ".md5r";

		unsigned int md5rTimestamp = 0;
		idFile *input = fileSystem->OpenFileRead( md5rName.c_str() );
		if ( input != NULL ) {
			md5rTimestamp = input->Timestamp();
			fileSystem->CloseFile( input );
		}

		unsigned int sourceTimestamp = 0;
		idStr sourceName = model->name;
		sourceName.StripAbsoluteFileExtension();
		if ( model->m_source == MD5R_SOURCE_MD5 ) {
			sourceName += ".md5mesh";
			input = fileSystem->OpenFileRead( sourceName.c_str() );
		} else {
			const char *extensions[3] = { ".lwo", ".ase", ".flt" };
			input = NULL;
			for ( int i = 0; i < 3 && input == NULL; ++i ) {
				sourceName = model->name;
				sourceName.StripAbsoluteFileExtension();
				sourceName += extensions[i];
				input = fileSystem->OpenFileRead( sourceName.c_str() );
			}
		}
		if ( input != NULL ) {
			sourceTimestamp = input->Timestamp();
			fileSystem->CloseFile( input );
		}
		if ( md5rTimestamp != 0 && md5rTimestamp > sourceTimestamp ) {
			continue;
		}

		idFile *output = fileSystem->OpenFileWrite(
			md5rName.c_str(), "fs_savepath", false );
		if ( output == NULL ) {
			continue;
		}
		common->Printf( "writing %s\n", md5rName.c_str() );
		output->WriteFloatString( "MD5RVersion %d\n", 1 );
		model->Write( *output, "", writeBuffers );
		fileSystem->CloseFile( output );
		idLexer::WriteBinaryFile( md5rName.c_str() );
	}
	fileSystem->SetIsFileLoadingAllowed( oldFileLoadingAllowed );
}

int rvRenderModelMD5R::Memory() const {
	return 0;
}

bool rvRenderModelMD5R::HasSeparateSilTraceMeshes() const {
	return true;
}
