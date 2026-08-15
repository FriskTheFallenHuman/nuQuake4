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
#include "rvPrimBatch.h"
#include "../cm/CollisionModel_local.h"

/*
===============================================================================

	Quake 4 MD5R primitive batches

	The class layout, signatures, and compilation-unit ownership come from
	rvPrimBatch.obj in quake4.pdb.  These bodies follow the address-matched
	retail executable.

===============================================================================
*/

static void RV_ClearGeoSpec( primBatchGeoSpec_s &geoSpec ) {
	geoSpec.m_vertexStart = 0;
	geoSpec.m_vertexCount = 0;
	geoSpec.m_indexStart = -1;
	geoSpec.m_primitiveCount = 0;
}

rvPrimBatch::rvPrimBatch() {
	m_transformPalette = NULL;
	m_numTransforms = 0;
	m_silEdgeStart = 0;
	m_silEdgeCount = 0;
	RV_ClearGeoSpec( m_silTraceGeoSpec );
	RV_ClearGeoSpec( m_drawGeoSpec );
	RV_ClearGeoSpec( m_shadowVolGeoSpec );
	m_numShadowPrimitivesNoCaps = 0;
	m_shadowCapPlaneBits = 0;
}

rvPrimBatch::~rvPrimBatch() {
}

void rvPrimBatch::Shutdown() {
	if ( m_transformPalette != NULL ) {
		Mem_Free( m_transformPalette );
	}
	m_transformPalette = NULL;
	m_numTransforms = 0;
	m_silEdgeStart = 0;
	m_silEdgeCount = 0;
	RV_ClearGeoSpec( m_silTraceGeoSpec );
	RV_ClearGeoSpec( m_drawGeoSpec );
	RV_ClearGeoSpec( m_shadowVolGeoSpec );
	m_numShadowPrimitivesNoCaps = 0;
	m_shadowCapPlaneBits = 0;
}

void rvPrimBatch::Init( int *transformPalette, int numTransforms ) {
	if ( m_numTransforms != 0 ) {
		Shutdown();
	}
	if ( numTransforms > 25 ) {
		common->FatalError( "Primitive batch initialization failed - too many transforms per batch" );
		return;
	}
	if ( transformPalette != NULL ) {
		m_transformPalette = static_cast<int *>( Mem_Alloc( sizeof( int ) * numTransforms, MA_RENDER ) );
		if ( m_transformPalette == NULL ) {
			common->FatalError( "Out of memory" );
			return;
		}
		for ( int i = 0; i < numTransforms; ++i ) {
			m_transformPalette[i] = transformPalette[i];
		}
	}
	m_numTransforms = numTransforms;
}

void rvPrimBatch::Init( Lexer &lexer ) {
	if ( m_numTransforms != 0 ) {
		Shutdown();
	}
	lexer.ExpectTokenString( "{" );
	idToken token;
	lexer.ReadToken( &token );
	if ( token.Icmp( "Transform" ) != 0 ) {
		m_numTransforms = 1;
	} else {
		lexer.ExpectTokenString( "[" );
		m_numTransforms = lexer.ParseInt();
		lexer.ExpectTokenString( "]" );
		lexer.ExpectTokenString( "{" );
		if ( m_numTransforms > 25 ) {
			lexer.Error( "Primitive batch initialization failed - too many transforms per batch" );
			return;
		}
		if ( m_numTransforms == 1 ) {
			const int transform = lexer.ParseInt();
			if ( transform != 0 ) {
				m_transformPalette = static_cast<int *>( Mem_Alloc( sizeof( int ), MA_RENDER ) );
				if ( m_transformPalette == NULL ) {
					lexer.Error( "Out of memory error" );
					return;
				}
				m_transformPalette[0] = transform;
			}
		} else if ( m_numTransforms > 0 ) {
			m_transformPalette = static_cast<int *>( Mem_Alloc(
				m_numTransforms * sizeof( int ), MA_RENDER ) );
			if ( m_transformPalette == NULL ) {
				lexer.Error( "Out of memory" );
				return;
			}
			for ( int i = 0; i < m_numTransforms; ++i ) {
				m_transformPalette[i] = lexer.ParseInt();
			}
		}
		lexer.ExpectTokenString( "}" );
		lexer.ReadToken( &token );
	}

	if ( token.Icmp( "SilTraceIndexedTriList" ) == 0 ) {
		m_silTraceGeoSpec.m_vertexStart = lexer.ParseInt();
		m_silTraceGeoSpec.m_vertexCount = lexer.ParseInt();
		m_silTraceGeoSpec.m_indexStart = lexer.ParseInt();
		m_silTraceGeoSpec.m_primitiveCount = lexer.ParseInt();
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "DrawIndexedTriList" ) == 0 ) {
		m_drawGeoSpec.m_vertexStart = lexer.ParseInt();
		m_drawGeoSpec.m_vertexCount = lexer.ParseInt();
		m_drawGeoSpec.m_indexStart = lexer.ParseInt();
		m_drawGeoSpec.m_primitiveCount = lexer.ParseInt();
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "ShadowVerts" ) == 0 ) {
		m_shadowVolGeoSpec.m_vertexStart = lexer.ParseInt();
		m_shadowVolGeoSpec.m_vertexCount = m_silTraceGeoSpec.m_vertexCount * 2;
		if ( m_silTraceGeoSpec.m_vertexCount == 0 ) {
			lexer.Error( "Primitive batch initialization failed - expected SilTraceIndexedTriList statement" );
		}
		lexer.ReadToken( &token );
	} else if ( token.Icmp( "ShadowIndexedTriList" ) == 0 ) {
		m_shadowVolGeoSpec.m_vertexStart = lexer.ParseInt();
		m_shadowVolGeoSpec.m_vertexCount = lexer.ParseInt();
		m_shadowVolGeoSpec.m_indexStart = lexer.ParseInt();
		m_shadowVolGeoSpec.m_primitiveCount = lexer.ParseInt();
		m_numShadowPrimitivesNoCaps = lexer.ParseInt();
		m_shadowCapPlaneBits = lexer.ParseInt();
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "SilhouetteEdge" ) == 0 ) {
		m_silEdgeStart = lexer.ParseInt();
		m_silEdgeCount = lexer.ParseInt();
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "}" ) != 0 ) {
		lexer.Error( "Expected }." );
	}
}

void rvPrimBatch::LoadMatrixPaletteIntoVPParams( const float *skinToModelTransforms ) {
	if ( m_transformPalette == NULL ) {
		return;
	}
	for ( int i = 0; i < m_numTransforms; ++i ) {
		const float *transform = skinToModelTransforms + i * 16;
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, i * 3 + 0, transform + 0 );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, i * 3 + 1, transform + 4 );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, i * 3 + 2, transform + 8 );
	}
}

int rvPrimBatch::FlipOutsideBackFaces( unsigned char *facing,
		const unsigned char *cullBits, rvIndexBuffer &indexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	indexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, indexMemory );

	int numRemaining = 0;
	if ( indexBuffer.Is16Bit() ) {
		const unsigned short *indices = static_cast<const unsigned short *>( indexMemory );
		for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
			if ( facing[triangle] == 0 ) {
				if ( ( cullBits[indices[0]] & cullBits[indices[1]] & cullBits[indices[2]] ) != 0 ) {
					facing[triangle] = 1;
				} else {
					++numRemaining;
				}
			}
			indices += 3;
		}
	} else {
		const unsigned int *indices = static_cast<const unsigned int *>( indexMemory );
		for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
			if ( facing[triangle] == 0 ) {
				if ( ( cullBits[indices[0]] & cullBits[indices[1]] & cullBits[indices[2]] ) != 0 ) {
					facing[triangle] = 1;
				} else {
					++numRemaining;
				}
			}
			indices += 3;
		}
	}

	indexBuffer.Unlock();
	return numRemaining;
}

int rvPrimBatch::GetNearestJoint( int silTraceIndex0, int, int,
		rvVertexBuffer &silTraceVertexBuffer, rvIndexBuffer &silTraceIndexBuffer ) const {
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart,
		m_silTraceGeoSpec.m_primitiveCount * 3, rvIndexBufferLockFlagRead, indexMemory );
	const int localIndex = silTraceIndex0 - m_silTraceGeoSpec.m_indexStart;
	const int vertexIndex = silTraceIndexBuffer.Is16Bit()
		? static_cast<const unsigned short *>( indexMemory )[localIndex]
		: static_cast<const unsigned int *>( indexMemory )[localIndex];

	unsigned char *blendIndices = NULL;
	int stride = 0;
	silTraceVertexBuffer.LockBlendIndex( vertexIndex + m_silTraceGeoSpec.m_vertexStart,
		1, rvVertexBufferLockFlagRead, blendIndices, stride );
	const int nearestJoint = blendIndices[0];
	silTraceVertexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
	return nearestJoint;
}

void rvPrimBatch::GetTextureBounds( float bounds[2][2],
		rvVertexBuffer &drawVertexBuffer ) {
	unsigned char *textureCoordinates = NULL;
	int stride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinates, stride );
	for ( int vertex = 0; vertex < m_drawGeoSpec.m_vertexCount; ++vertex ) {
		const float *st = reinterpret_cast<const float *>( textureCoordinates );
		if ( st[0] < bounds[0][0] ) {
			bounds[0][0] = st[0];
		}
		if ( st[0] > bounds[1][0] ) {
			bounds[1][0] = st[0];
		}
		if ( st[1] < bounds[0][1] ) {
			bounds[0][1] = st[1];
		}
		if ( st[1] > bounds[1][1] ) {
			bounds[1][1] = st[1];
		}
		textureCoordinates += stride;
	}
	drawVertexBuffer.Unlock();
}

void rvPrimBatch::CopyDrawVertices( idDrawVert *destDrawVerts,
		rvVertexBuffer &drawVertexBuffer ) {
	unsigned char *position = NULL;
	unsigned char *normal = NULL;
	unsigned char *tangent = NULL;
	unsigned char *binormal = NULL;
	unsigned char *textureCoordinate = NULL;
	unsigned char *diffuseColor = NULL;
	int positionStride = 0;
	int normalStride = 0;
	int tangentStride = 0;
	int binormalStride = 0;
	int textureCoordinateStride = 0;
	int diffuseColorStride = 0;

	drawVertexBuffer.LockPosition( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		position, positionStride );
	drawVertexBuffer.LockNormal( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		normal, normalStride );
	drawVertexBuffer.LockBinormal( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		binormal, binormalStride );
	drawVertexBuffer.LockTangent( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		tangent, tangentStride );
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinate, textureCoordinateStride );
	drawVertexBuffer.LockDiffuseColor( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		diffuseColor, diffuseColorStride );

	for ( int i = 0; i < m_drawGeoSpec.m_vertexCount; ++i ) {
		const float *positionValues = reinterpret_cast<const float *>( position );
		const float *normalValues = reinterpret_cast<const float *>( normal );
		const float *tangentValues = reinterpret_cast<const float *>( tangent );
		const float *binormalValues = reinterpret_cast<const float *>( binormal );
		const float *textureValues = reinterpret_cast<const float *>( textureCoordinate );
		idDrawVert &dest = destDrawVerts[i];
		dest.xyz.Set( positionValues[0], positionValues[1], positionValues[2] );
		dest.normal.Set( normalValues[0], normalValues[1], normalValues[2] );
		dest.tangents[0].Set( tangentValues[0], tangentValues[1], tangentValues[2] );
		dest.tangents[1].Set( binormalValues[0], binormalValues[1], binormalValues[2] );
		dest.st.Set( textureValues[0], textureValues[1] );
		dest.color[0] = diffuseColor[0];
		dest.color[1] = diffuseColor[1];
		dest.color[2] = diffuseColor[2];
		dest.color[3] = diffuseColor[3];
		position += positionStride;
		normal += normalStride;
		tangent += tangentStride;
		binormal += binormalStride;
		textureCoordinate += textureCoordinateStride;
		diffuseColor += diffuseColorStride;
	}
	drawVertexBuffer.Unlock();
}

void rvPrimBatch::CopyDrawIndices( int *destIndices,
		rvIndexBuffer &drawIndexBuffer, int destBase ) {
	const int indexAdjustment = destBase - m_drawGeoSpec.m_vertexStart;
	const int numIndices = m_drawGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, indexMemory );
	if ( drawIndexBuffer.Is16Bit() ) {
		const unsigned short *indices = static_cast<const unsigned short *>( indexMemory );
		for ( int i = 0; i < numIndices; ++i ) {
			destIndices[i] = indexAdjustment + indices[i];
		}
	} else {
		const unsigned int *indices = static_cast<const unsigned int *>( indexMemory );
		for ( int i = 0; i < numIndices; ++i ) {
			destIndices[i] = indexAdjustment + indices[i];
		}
	}
	drawIndexBuffer.Unlock();
}

void rvPrimBatch::CopySilTraceVertices( rvVertexBuffer &silTraceVertexBuffer,
		rvIndexBuffer &silTraceIndexBuffer, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, drawIndexMemory );

	unsigned int *copyMapping = static_cast<unsigned int *>( _alloca16(
		m_drawGeoSpec.m_vertexCount * sizeof( unsigned int ) ) );
	SIMDProcessor->Memset( copyMapping, 0,
		m_drawGeoSpec.m_vertexCount * sizeof( unsigned int ) );
	for ( int index = 0; index < numIndices; ++index ) {
		const unsigned int silTraceIndex = silTraceIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( silTraceIndexMemory )[index]
			: static_cast<const unsigned int *>( silTraceIndexMemory )[index];
		const unsigned int drawIndex = drawIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( drawIndexMemory )[index]
			: static_cast<const unsigned int *>( drawIndexMemory )[index];
		copyMapping[silTraceIndex] = drawIndex - m_drawGeoSpec.m_vertexStart;
	}
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();

	unsigned char *silTraceVertices = NULL;
	unsigned char *drawVertices = NULL;
	int silTraceStride = 0;
	int drawStride = 0;
	silTraceVertexBuffer.LockPosition( m_silTraceGeoSpec.m_vertexStart,
		m_silTraceGeoSpec.m_vertexCount, rvVertexBufferLockFlagWrite,
		silTraceVertices, silTraceStride );
	drawVertexBuffer.LockPosition( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		drawVertices, drawStride );

	const rvVertexFormat &silTraceFormat = silTraceVertexBuffer.GetFormat();
	const rvVertexFormat &drawFormat = drawVertexBuffer.GetFormat();
	float positionTail[4] = { 0.0f, 0.0f, 0.0f, 1.0f };
	rvVertexBuffer::ComponentCopy(
		silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		silTraceStride, silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ),
		silTraceFormat.GetPositionDimension(),
		drawVertices + drawFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		drawStride, drawFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ),
		drawFormat.GetPositionDimension(), m_silTraceGeoSpec.m_vertexCount,
		copyMapping, positionTail, false );

	if ( ( drawFormat.GetFlags() & rvVertexFormatFlagBlendIndex ) != 0 ) {
		rvVertexBuffer::ComponentCopy(
			silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_INDEX ),
			silTraceStride, silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_INDEX ), 1,
			drawVertices + drawFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_INDEX ),
			drawStride, drawFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_INDEX ), 1,
			m_silTraceGeoSpec.m_vertexCount, copyMapping, NULL, false );
	}
	if ( ( drawFormat.GetFlags() & rvVertexFormatFlagBlendWeight ) != 0 ) {
		rvVertexBuffer::ComponentCopy(
			silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
			silTraceStride, silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
			silTraceFormat.GetBlendWeightDimension(),
			drawVertices + drawFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
			drawStride, drawFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
			drawFormat.GetBlendWeightDimension(), m_silTraceGeoSpec.m_vertexCount,
			copyMapping, NULL, true );
	}
	drawVertexBuffer.Unlock();
	silTraceVertexBuffer.Unlock();
}

void rvPrimBatch::GetTriangle( idDrawVert &a, idDrawVert &b, idDrawVert &c,
		int triangleOffset, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer ) {
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart + triangleOffset * 3,
		3, rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart + triangleOffset * 3,
		3, rvIndexBufferLockFlagRead, drawIndexMemory );
	unsigned char *textureCoordinates = NULL;
	int textureCoordinateStride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinates, textureCoordinateStride );

	int silTraceIndices[3];
	int drawIndices[3];
	for ( int corner = 0; corner < 3; ++corner ) {
		silTraceIndices[corner] = silTraceIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( silTraceIndexMemory )[corner]
			: static_cast<const unsigned int *>( silTraceIndexMemory )[corner];
		drawIndices[corner] = drawIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( drawIndexMemory )[corner]
			: static_cast<const unsigned int *>( drawIndexMemory )[corner];
	}

	idDrawVert *vertices[3] = { &a, &b, &c };
	for ( int corner = 0; corner < 3; ++corner ) {
		vertices[corner]->xyz = silTraceVerts[silTraceIndices[corner]].xyzw.ToVec3();
		const float *st = reinterpret_cast<const float *>( textureCoordinates +
			( drawIndices[corner] - m_drawGeoSpec.m_vertexStart ) * textureCoordinateStride );
		vertices[corner]->st.Set( st[0], st[1] );
	}

	drawVertexBuffer.Unlock();
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
}

void rvPrimBatch::CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		rvVertexBuffer &drawVertexBuffer, rvIndexBuffer &drawIndexBuffer,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer,
		int destBase ) {
	const int numIndices = m_drawGeoSpec.m_primitiveCount * 3;
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, drawIndexMemory );
	unsigned char *textureCoordinates = NULL;
	unsigned char *diffuseColors = NULL;
	int textureCoordinateStride = 0;
	int diffuseColorStride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinates, textureCoordinateStride );
	drawVertexBuffer.LockDiffuseColor( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		diffuseColors, diffuseColorStride );

	for ( int i = 0; i < numIndices; ++i ) {
		const int silTraceIndex = silTraceIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( silTraceIndexMemory )[i]
			: static_cast<const unsigned int *>( silTraceIndexMemory )[i];
		const int drawIndex = drawIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( drawIndexMemory )[i]
			: static_cast<const unsigned int *>( drawIndexMemory )[i];
		const int localDrawIndex = drawIndex - m_drawGeoSpec.m_vertexStart;
		destIndices[i] = destBase + localDrawIndex;
		idDrawVert &dest = destDrawVerts[localDrawIndex];
		dest.xyz = silTraceVerts[silTraceIndex].xyzw.ToVec3();
		const float *st = reinterpret_cast<const float *>( textureCoordinates +
			localDrawIndex * textureCoordinateStride );
		dest.st.Set( st[0], st[1] );
		const unsigned char *color = diffuseColors + localDrawIndex * diffuseColorStride;
		dest.color[0] = color[0];
		dest.color[1] = color[1];
		dest.color[2] = color[2];
		dest.color[3] = color[3];
	}

	drawVertexBuffer.Unlock();
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
}

void rvPrimBatch::TransformDrawVertices( idDrawVert *destDrawVerts,
		rvVertexBuffer &drawVertexBuffer, const idMat4 &transform,
		int colorShift, unsigned char *colorAdd ) {
	unsigned char *position = NULL;
	unsigned char *normal = NULL;
	unsigned char *tangent = NULL;
	unsigned char *binormal = NULL;
	unsigned char *textureCoordinate = NULL;
	unsigned char *diffuseColor = NULL;
	int positionStride = 0;
	int normalStride = 0;
	int tangentStride = 0;
	int binormalStride = 0;
	int textureCoordinateStride = 0;
	int diffuseColorStride = 0;
	drawVertexBuffer.LockPosition( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead, position, positionStride );
	drawVertexBuffer.LockNormal( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead, normal, normalStride );
	drawVertexBuffer.LockBinormal( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead, binormal, binormalStride );
	drawVertexBuffer.LockTangent( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead, tangent, tangentStride );
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinate, textureCoordinateStride );
	drawVertexBuffer.LockDiffuseColor( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		diffuseColor, diffuseColorStride );

	for ( int i = 0; i < m_drawGeoSpec.m_vertexCount; ++i ) {
		const float *positionValues = reinterpret_cast<const float *>( position );
		const float *normalValues = reinterpret_cast<const float *>( normal );
		const float *tangentValues = reinterpret_cast<const float *>( tangent );
		const float *binormalValues = reinterpret_cast<const float *>( binormal );
		const float *textureValues = reinterpret_cast<const float *>( textureCoordinate );
		idDrawVert &dest = destDrawVerts[i];
		dest.xyz = transform * idVec3( positionValues[0], positionValues[1], positionValues[2] );
		dest.normal.Set( normalValues[0], normalValues[1], normalValues[2] );
		dest.tangents[0].Set( tangentValues[0], tangentValues[1], tangentValues[2] );
		dest.tangents[1].Set( binormalValues[0], binormalValues[1], binormalValues[2] );
		dest.st.Set( textureValues[0], textureValues[1] );
		for ( int component = 0; component < 4; ++component ) {
			dest.color[component] = static_cast<unsigned char>(
				colorAdd[component] + ( diffuseColor[component] >> colorShift ) );
		}
		position += positionStride;
		normal += normalStride;
		tangent += tangentStride;
		binormal += binormalStride;
		textureCoordinate += textureCoordinateStride;
		diffuseColor += diffuseColorStride;
	}
	drawVertexBuffer.Unlock();
}

void rvPrimBatch::TubeDeform( idDrawVert *destDrawVerts, int *destIndices,
		const idVec3 &localView, rvVertexBuffer &drawVertexBuffer,
		rvIndexBuffer &drawIndexBuffer, const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer ) {
	static const int edgeVertices[6][2] = {
		{ 0, 1 }, { 1, 2 }, { 2, 0 },
		{ 3, 4 }, { 4, 5 }, { 5, 3 }
	};

	const int drawIndexCount = m_drawGeoSpec.m_primitiveCount * 3;
	const int silTraceIndexCount = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *drawIndexMemory = NULL;
	void *silTraceIndexMemory = NULL;
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, drawIndexCount,
		rvIndexBufferLockFlagRead, drawIndexMemory );
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, silTraceIndexCount,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );

	unsigned char *textureCoordinateMemory = NULL;
	unsigned char *diffuseColorMemory = NULL;
	int textureCoordinateStride = 0;
	int diffuseColorStride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinateMemory, textureCoordinateStride );
	drawVertexBuffer.LockDiffuseColor( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		diffuseColorMemory, diffuseColorStride );

	for ( int index = 0; index < drawIndexCount; ++index ) {
		const int sourceIndex = drawIndexBuffer.Is16Bit()
			? static_cast<const unsigned short *>( drawIndexMemory )[index]
			: static_cast<const unsigned int *>( drawIndexMemory )[index];
		destIndices[index] = sourceIndex - m_drawGeoSpec.m_vertexStart;
	}

	for ( int vertex = 0; vertex < m_drawGeoSpec.m_vertexCount; vertex += 4 ) {
		float lengths[2] = { 999999.0f, 999999.0f };
		int shortestEdges[2] = { 0, 0 };
		for ( int edge = 0; edge < 6; ++edge ) {
			const int index0 = vertex + edgeVertices[edge][0];
			const int index1 = vertex + edgeVertices[edge][1];
			const int silVertex0 = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index0]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index0];
			const int silVertex1 = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index1]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index1];
			const float length = ( silTraceVerts[silVertex0].xyzw.ToVec3() -
				silTraceVerts[silVertex1].xyzw.ToVec3() ).Length();
			if ( length < lengths[0] ) {
				shortestEdges[1] = shortestEdges[0];
				lengths[1] = lengths[0];
				shortestEdges[0] = edge;
				lengths[0] = length;
			} else if ( length < lengths[1] ) {
				shortestEdges[1] = edge;
				lengths[1] = length;
			}
		}

		idVec3 midpoints[2];
		for ( int side = 0; side < 2; ++side ) {
			const int edge = shortestEdges[side];
			const int index0 = vertex + edgeVertices[edge][0];
			const int index1 = vertex + edgeVertices[edge][1];
			const int silVertex0 = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index0]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index0];
			const int silVertex1 = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index1]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index1];
			midpoints[side] = 0.5f * ( silTraceVerts[silVertex0].xyzw.ToVec3() +
				silTraceVerts[silVertex1].xyzw.ToVec3() );
		}

		const idVec3 major = midpoints[1] - midpoints[0];
		for ( int side = 0; side < 2; ++side ) {
			const int edge = shortestEdges[side];
			const int drawVertex0 = destIndices[vertex + edgeVertices[edge][0]];
			const int drawVertex1 = destIndices[vertex + edgeVertices[edge][1]];
			idDrawVert &out0 = destDrawVerts[drawVertex0];
			idDrawVert &out1 = destDrawVerts[drawVertex1];

			const unsigned char *color0 = diffuseColorMemory +
				drawVertex0 * diffuseColorStride;
			const unsigned char *color1 = diffuseColorMemory +
				drawVertex1 * diffuseColorStride;
			memcpy( out0.color, color0, sizeof( out0.color ) );
			memcpy( out1.color, color1, sizeof( out1.color ) );
			const float *st0 = reinterpret_cast<const float *>(
				textureCoordinateMemory + drawVertex0 * textureCoordinateStride );
			const float *st1 = reinterpret_cast<const float *>(
				textureCoordinateMemory + drawVertex1 * textureCoordinateStride );
			out0.st.Set( st0[0], st0[1] );
			out1.st.Set( st1[0], st1[1] );

			idVec3 minor;
			minor.Cross( major, midpoints[side] - localView );
			minor.Normalize();
			const float halfLength = 0.5f * lengths[side];
			if ( side != 0 ) {
				out0.xyz = midpoints[side] - halfLength * minor;
				out1.xyz = midpoints[side] + halfLength * minor;
			} else {
				out0.xyz = midpoints[side] + halfLength * minor;
				out1.xyz = midpoints[side] - halfLength * minor;
			}
		}
	}

	drawVertexBuffer.Unlock();
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
}

void rvPrimBatch::CopyShadowVertices( rvVertexBuffer &shadowVertexBuffer,
		rvVertexBuffer &silTraceVertexBuffer ) {
	unsigned char *shadowVertices = NULL;
	unsigned char *silTraceVertices = NULL;
	int shadowStride = 0;
	int silTraceStride = 0;
	shadowVertexBuffer.LockPosition( m_shadowVolGeoSpec.m_vertexStart,
		m_shadowVolGeoSpec.m_vertexCount, rvVertexBufferLockFlagWrite,
		shadowVertices, shadowStride );
	silTraceVertexBuffer.LockPosition( m_silTraceGeoSpec.m_vertexStart,
		m_silTraceGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		silTraceVertices, silTraceStride );

	const rvVertexFormat &shadowFormat = shadowVertexBuffer.GetFormat();
	const rvVertexFormat &silTraceFormat = silTraceVertexBuffer.GetFormat();
	float infiniteTail[4] = { 0.0f, 0.0f, 0.0f, 0.0f };
	float finiteTail[4] = { 0.0f, 0.0f, 0.0f, 1.0f };
	rvVertexBuffer::ComponentCopy(
		shadowVertices + shadowFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		shadowStride * 2, shadowFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ),
		shadowFormat.GetPositionDimension(),
		silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		silTraceStride, silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ), 3,
		m_silTraceGeoSpec.m_vertexCount, NULL, finiteTail, false );
	rvVertexBuffer::ComponentCopy(
		shadowVertices + shadowStride + shadowFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		shadowStride * 2, shadowFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ),
		shadowFormat.GetPositionDimension(),
		silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_POSITION ),
		silTraceStride, silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_POSITION ), 3,
		m_silTraceGeoSpec.m_vertexCount, NULL, infiniteTail, false );

	if ( ( silTraceFormat.GetFlags() & rvVertexFormatFlagBlendIndex ) != 0 ) {
		for ( int pair = 0; pair < 2; ++pair ) {
			rvVertexBuffer::ComponentCopy(
				shadowVertices + pair * shadowStride +
					shadowFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_INDEX ),
				shadowStride * 2,
				shadowFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_INDEX ), 1,
				silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_INDEX ),
				silTraceStride,
				silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_INDEX ), 1,
				m_silTraceGeoSpec.m_vertexCount, NULL, NULL, false );
		}
	}
	if ( ( silTraceFormat.GetFlags() & rvVertexFormatFlagBlendWeight ) != 0 ) {
		for ( int pair = 0; pair < 2; ++pair ) {
			rvVertexBuffer::ComponentCopy(
				shadowVertices + pair * shadowStride +
					shadowFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
				shadowStride * 2,
				shadowFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
				shadowFormat.GetBlendWeightDimension(),
				silTraceVertices + silTraceFormat.GetByteOffset( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
				silTraceStride,
				silTraceFormat.GetDataType( RV_VERTEX_COMPONENT_BLEND_WEIGHT ),
				silTraceFormat.GetBlendWeightDimension(),
				m_silTraceGeoSpec.m_vertexCount, NULL, NULL, true );
		}
	}
	silTraceVertexBuffer.Unlock();
	shadowVertexBuffer.Unlock();
}

void rvPrimBatch::Write( idFile &outFile, const char *prepend ) {
	idStr indent = prepend;
	indent += "\t";
	outFile.WriteFloatString( "%sPrimBatch\n%s{\n", prepend, prepend );
	if ( m_transformPalette != NULL ) {
		outFile.WriteFloatString( "%sTransform[ %d ]\n%s{\n",
			indent.c_str(), m_numTransforms, indent.c_str() );
		for ( int i = 0; i < m_numTransforms; ++i ) {
			outFile.WriteFloatString( "%s\t%d\n", indent.c_str(), m_transformPalette[i] );
		}
		outFile.WriteFloatString( "%s}\n", indent.c_str() );
	}
	if ( m_silTraceGeoSpec.m_primitiveCount > 0 ) {
		outFile.WriteFloatString( "%sSilTraceIndexedTriList %d %d %d %d\n",
			indent.c_str(), m_silTraceGeoSpec.m_vertexStart,
			m_silTraceGeoSpec.m_vertexCount, m_silTraceGeoSpec.m_indexStart,
			m_silTraceGeoSpec.m_primitiveCount );
	}
	if ( m_drawGeoSpec.m_primitiveCount > 0 ) {
		outFile.WriteFloatString( "%sDrawIndexedTriList %d %d %d %d\n",
			indent.c_str(), m_drawGeoSpec.m_vertexStart, m_drawGeoSpec.m_vertexCount,
			m_drawGeoSpec.m_indexStart, m_drawGeoSpec.m_primitiveCount );
	}
	if ( m_shadowVolGeoSpec.m_primitiveCount > 0 ) {
		outFile.WriteFloatString( "%sShadowIndexedTriList %d %d %d %d %d %d\n",
			indent.c_str(), m_shadowVolGeoSpec.m_vertexStart,
			m_shadowVolGeoSpec.m_vertexCount, m_shadowVolGeoSpec.m_indexStart,
			m_shadowVolGeoSpec.m_primitiveCount, m_numShadowPrimitivesNoCaps,
			m_shadowCapPlaneBits );
	} else if ( m_shadowVolGeoSpec.m_vertexCount > 0 ) {
		outFile.WriteFloatString( "%sShadowVerts %d\n", indent.c_str(),
			m_shadowVolGeoSpec.m_vertexStart );
	}
	if ( m_silEdgeCount > 0 ) {
		outFile.WriteFloatString( "%sSilhouetteEdge %d %d\n", indent.c_str(),
			m_silEdgeStart, m_silEdgeCount );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvPrimBatch::Draw( rvVertexBuffer &, rvIndexBuffer &indexBuffer,
		const rvVertexFormat * ) {
	const int numIndices = m_drawGeoSpec.m_primitiveCount * 3;
	backEnd.pc.c_drawElements++;
	backEnd.pc.c_drawIndexes += numIndices;
	backEnd.pc.c_drawVertexes += m_drawGeoSpec.m_vertexCount;

	const GLenum indexType = indexBuffer.Is16Bit() ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT;
	const int indexSize = indexBuffer.Is16Bit() ? sizeof( unsigned short ) : sizeof( unsigned int );
	qglDrawElements( GL_TRIANGLES, r_singleTriangle.GetBool() ? 3 : numIndices,
		indexType, reinterpret_cast<const void *>( m_drawGeoSpec.m_indexStart * indexSize ) );
	backEnd.pc.c_drawRefIndexes += numIndices;
}

void rvPrimBatch::Draw( rvVertexBuffer &, int *indices, int numIndices,
		const rvVertexFormat * ) {
	if ( numIndices == 0 ) {
		return;
	}
	backEnd.pc.c_drawElements++;
	backEnd.pc.c_drawIndexes += numIndices;
	backEnd.pc.c_drawVertexes += m_drawGeoSpec.m_vertexCount;
	qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	qglDrawElements( GL_TRIANGLES, r_singleTriangle.GetBool() ? 3 : numIndices,
		GL_UNSIGNED_INT, indices );
	backEnd.pc.c_drawRefIndexes += numIndices;
}

void rvPrimBatch::DrawShadowVolume( rvVertexBuffer &, int *indices, int numIndices,
		const rvVertexFormat * ) {
	if ( numIndices == 0 ) {
		return;
	}
	backEnd.pc.c_shadowElements++;
	backEnd.pc.c_shadowIndexes += numIndices;
	backEnd.pc.c_shadowVertexes += m_shadowVolGeoSpec.m_vertexCount;
	qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	qglDrawElements( GL_TRIANGLES, r_singleTriangle.GetBool() ? 3 : numIndices,
		GL_UNSIGNED_INT, indices );
}

void rvPrimBatch::DrawShadowVolume( rvVertexBuffer &, rvIndexBuffer &indexBuffer,
		bool drawCaps, const rvVertexFormat * ) {
	const int primitiveCount = drawCaps ? m_shadowVolGeoSpec.m_primitiveCount
		: m_numShadowPrimitivesNoCaps;
	const int numIndices = primitiveCount * 3;
	if ( numIndices <= 0 ) {
		return;
	}
	backEnd.pc.c_shadowElements++;
	backEnd.pc.c_shadowIndexes += numIndices;
	backEnd.pc.c_shadowVertexes += m_shadowVolGeoSpec.m_vertexCount;

	const GLenum indexType = indexBuffer.Is16Bit() ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT;
	const int indexSize = indexBuffer.Is16Bit() ? sizeof( unsigned short ) : sizeof( unsigned int );
	qglDrawElements( GL_TRIANGLES, r_singleTriangle.GetBool() ? 3 : numIndices,
		indexType, reinterpret_cast<const void *>( m_shadowVolGeoSpec.m_indexStart * indexSize ) );
}

int rvPrimBatch::CreateSilShadowVolTris( int *shadowIndices,
		const unsigned char *facing, silEdge_t *silEdges ) {
	int *out = shadowIndices;
	const int vertexStart = m_shadowVolGeoSpec.m_vertexStart;
	const silEdge_t *edge = silEdges + m_silEdgeStart;
	const silEdge_t *end = edge + m_silEdgeCount;

	for ( ; edge < end; ++edge ) {
		const int f1 = facing[edge->p1];
		const int f2 = facing[edge->p2];
		if ( ( f1 ^ f2 ) == 0 ) {
			continue;
		}

		const int v1 = edge->v1 * 2;
		const int v2 = edge->v2 * 2;
		out[0] = vertexStart + v1;
		out[1] = vertexStart + ( f1 ^ v2 );
		out[2] = vertexStart + ( f2 ^ v2 );
		out[3] = vertexStart + ( f2 ^ v1 );
		out[4] = vertexStart + ( f1 ^ v1 );
		out[5] = vertexStart + ( v2 ^ 1 );
		out += 6;
	}

	return static_cast<int>( out - shadowIndices );
}

int rvPrimBatch::CreateFrontBackShadowVolTris( int *shadowIndices,
		const unsigned char *facing, rvIndexBuffer &silTraceIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, indexMemory );

	int *out = shadowIndices;
	const int vertexStart = m_shadowVolGeoSpec.m_vertexStart;
	if ( silTraceIndexBuffer.Is16Bit() ) {
		const unsigned short *indices = static_cast<const unsigned short *>( indexMemory );
		for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
			if ( facing[triangle] != 0 ) {
				indices += 3;
				continue;
			}
			const int v0 = indices[0] * 2;
			const int v1 = indices[1] * 2;
			const int v2 = indices[2] * 2;
			out[0] = vertexStart + v2;
			out[1] = vertexStart + v1;
			out[2] = vertexStart + v0;
			out[3] = vertexStart + ( v0 ^ 1 );
			out[4] = vertexStart + ( v1 ^ 1 );
			out[5] = vertexStart + ( v2 ^ 1 );
			out += 6;
			indices += 3;
		}
	} else {
		const unsigned int *indices = static_cast<const unsigned int *>( indexMemory );
		for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
			if ( facing[triangle] != 0 ) {
				indices += 3;
				continue;
			}
			const int v0 = indices[0] * 2;
			const int v1 = indices[1] * 2;
			const int v2 = indices[2] * 2;
			out[0] = vertexStart + v2;
			out[1] = vertexStart + v1;
			out[2] = vertexStart + v0;
			out[3] = vertexStart + ( v0 ^ 1 );
			out[4] = vertexStart + ( v1 ^ 1 );
			out[5] = vertexStart + ( v2 ^ 1 );
			out += 6;
			indices += 3;
		}
	}

	silTraceIndexBuffer.Unlock();
	return static_cast<int>( out - shadowIndices );
}

void rvPrimBatch::TransformVertsMinMax( rvSilTraceVertT *destSilTraceVerts,
		idVec3 &boundsMin, idVec3 &boundsMax, rvVertexBuffer &silTraceVertexBuffer,
		idJointMat *skinSpaceToLocalMats, idJointMat *localToModelMats,
		float *skinToModelTransforms ) {
	SIMDProcessor->JointMat_MultiplyMats( skinToModelTransforms,
		skinSpaceToLocalMats, localToModelMats, m_transformPalette, m_numTransforms );

	unsigned char *positions = NULL;
	int stride = 0;
	silTraceVertexBuffer.LockPosition( m_silTraceGeoSpec.m_vertexStart,
		m_silTraceGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		positions, stride );
	if ( ( silTraceVertexBuffer.GetFormat().GetFlags() & rvVertexFormatFlagBlendWeight ) != 0 &&
			silTraceVertexBuffer.GetFormat().GetBlendWeightDimension() == 4 ) {
		SIMDProcessor->TransformVertsMinMax4Bone( destSilTraceVerts, boundsMin, boundsMax,
			positions, stride, m_silTraceGeoSpec.m_vertexCount, skinToModelTransforms );
	} else {
		SIMDProcessor->TransformVertsMinMax1Bone( destSilTraceVerts, boundsMin, boundsMax,
			positions, stride, m_silTraceGeoSpec.m_vertexCount, skinToModelTransforms );
	}
	silTraceVertexBuffer.Unlock();
}

void rvPrimBatch::DeriveTriPlanes( idPlane *planes,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indices = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, indices );
	if ( silTraceIndexBuffer.Is16Bit() ) {
		SIMDProcessor->DeriveTriPlanes( planes, silTraceVerts,
			m_silTraceGeoSpec.m_vertexCount,
			static_cast<const unsigned short *>( indices ), numIndices );
	} else {
		SIMDProcessor->DeriveTriPlanes( planes, silTraceVerts,
			m_silTraceGeoSpec.m_vertexCount,
			static_cast<const int *>( indices ), numIndices );
	}
	silTraceIndexBuffer.Unlock();
}

static bool RV_TraceEdgeAcceptsPoint( const idVec3 &a, const idVec3 &b,
		const idVec3 &opposite, const idVec3 &point, const idVec3 &normal,
		float radiusSqr ) {
	const idVec3 dirA = a - point;
	const idVec3 dirB = b - point;
	const idVec3 cross = dirA.Cross( dirB );
	if ( normal * cross <= 0.0f ) {
		return true;
	}
	if ( radiusSqr <= 0.0f ) {
		return false;
	}
	const idVec3 edge = a - b;
	const float edgeLengthSqr = edge.LengthSqr();
	if ( cross.LengthSqr() > edgeLengthSqr * radiusSqr ) {
		return false;
	}
	const float along = edge * dirA;
	if ( along < 0.0f ) {
		if ( ( a - opposite ) * dirA < 0.0f && dirA.LengthSqr() > radiusSqr ) {
			return false;
		}
	} else if ( along > edgeLengthSqr ) {
		if ( ( b - opposite ) * dirB < 0.0f && dirB.LengthSqr() > radiusSqr ) {
			return false;
		}
	}
	return true;
}

void rvPrimBatch::LocalTrace( localTrace_t &hit, int &testPlanes, int &testEdges,
		int &intersections, const idVec3 &start, const idVec3 &end,
		const unsigned char *cullBits, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts, float radius,
		rvIndexBuffer &silTraceIndexBuffer, rvIndexBuffer &drawIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, drawIndexMemory );
	const idVec3 traceDirection = end - start;
	const float radiusSqr = radius * radius;

	for ( int index = 0, triangle = 0; index < numIndices; index += 3, ++triangle ) {
		int vertexIndices[3];
		for ( int corner = 0; corner < 3; ++corner ) {
			vertexIndices[corner] = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index + corner]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index + corner];
		}
		const unsigned char triangleOr = cullBits[vertexIndices[0]] |
			cullBits[vertexIndices[1]] | cullBits[vertexIndices[2]];
		if ( ( ( triangleOr ^ ( triangleOr >> 4 ) ) & 3 ) != 0 ||
				( ( triangleOr ^ ( triangleOr >> 1 ) ) & 4 ) != 0 ) {
			continue;
		}
		++testPlanes;
		const idPlane &plane = facePlanes[triangle];
		const float d1 = plane.Distance( start );
		const float d2 = plane.Distance( end );
		if ( d1 <= d2 || d1 < 0.0f || d2 > 0.0f ) {
			continue;
		}
		const float fraction = d1 / ( d1 - d2 );
		if ( fraction < 0.0f || fraction >= hit.fraction ) {
			continue;
		}
		++testEdges;
		const idVec3 point = start + fraction * traceDirection;
		const idVec3 vertices[3] = {
			silTraceVerts[vertexIndices[0]].xyzw.ToVec3(),
			silTraceVerts[vertexIndices[1]].xyzw.ToVec3(),
			silTraceVerts[vertexIndices[2]].xyzw.ToVec3()
		};
		if ( !RV_TraceEdgeAcceptsPoint( vertices[0], vertices[1], vertices[2],
				point, plane.Normal(), radiusSqr ) ||
			 !RV_TraceEdgeAcceptsPoint( vertices[1], vertices[2], vertices[0],
				point, plane.Normal(), radiusSqr ) ||
			 !RV_TraceEdgeAcceptsPoint( vertices[2], vertices[0], vertices[1],
				point, plane.Normal(), radiusSqr ) ) {
			continue;
		}

		++intersections;
		hit.fraction = fraction;
		hit.normal = plane.Normal();
		hit.point = point;
		for ( int corner = 0; corner < 3; ++corner ) {
			hit.indexes[corner] = m_silTraceGeoSpec.m_indexStart + index + corner;
			hit.vertices[corner] = vertices[corner];
			const int drawIndex = drawIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( drawIndexMemory )[index + corner]
				: static_cast<const unsigned int *>( drawIndexMemory )[index + corner];
			hit.drawIndices[corner] = drawIndex - m_drawGeoSpec.m_vertexStart;
		}
	}
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
}

const rvDeclMatType *rvPrimBatch::GetMaterialType( const idMaterial *material,
		const localTrace_t &hit, rvVertexBuffer &drawVertexBuffer ) {
	if ( material->GetMaterialTypeArray() == NULL ||
			!drawVertexBuffer.IsSystemMemory() ||
			( drawVertexBuffer.GetFormat().GetFlags() &
			  rvVertexFormatFlagTextureCoordinate ) == 0 ) {
		return material->GetMaterialType();
	}

	unsigned char *textureCoordinateMemory = NULL;
	int textureCoordinateStride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinateMemory, textureCoordinateStride );
	idVec2 textureCoordinates[3];
	for ( int corner = 0; corner < 3; ++corner ) {
		const float *st = reinterpret_cast<const float *>( textureCoordinateMemory +
			hit.drawIndices[corner] * textureCoordinateStride );
		textureCoordinates[corner].Set( st[0], st[1] );
	}
	const float area = idMath::BarycentricTriangleArea( hit.normal,
		hit.vertices[0], hit.vertices[1], hit.vertices[2] );
	if ( area == 0.0f ) {
		drawVertexBuffer.Unlock();
		return material->GetMaterialType();
	}
	idVec2 textureCoordinate;
	idMath::BarycentricEvaluate( textureCoordinate, hit.point, hit.normal,
		area, hit.vertices, textureCoordinates );
	drawVertexBuffer.Unlock();
	return material->GetMaterialType( textureCoordinate );
}

void rvPrimBatch::CreateLightTris( int *destDrawIndices, int &destIndexCount,
		idBounds &bounds, int &backFaced, int &distanceCulled,
		const unsigned char *facing, const unsigned char *cullBits,
		const idPlane *, const rvSilTraceVertT *silTraceVerts,
		bool includeBackFaces, rvIndexBuffer &silTraceIndexBuffer,
		rvIndexBuffer &drawIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, drawIndexMemory );

	int *selectedSilTraceIndices = static_cast<int *>( _alloca16( numIndices * sizeof( int ) ) );
	destIndexCount = 0;
	for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
		if ( !includeBackFaces && facing[triangle] == 0 ) {
			++backFaced;
			continue;
		}
		int silIndices[3];
		int drawIndices[3];
		for ( int corner = 0; corner < 3; ++corner ) {
			const int index = triangle * 3 + corner;
			silIndices[corner] = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index];
			drawIndices[corner] = drawIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( drawIndexMemory )[index]
				: static_cast<const unsigned int *>( drawIndexMemory )[index];
		}
		if ( ( cullBits[silIndices[0]] & cullBits[silIndices[1]] &
				cullBits[silIndices[2]] ) != 0 ) {
			++distanceCulled;
			continue;
		}
		for ( int corner = 0; corner < 3; ++corner ) {
			selectedSilTraceIndices[destIndexCount] = silIndices[corner];
			destDrawIndices[destIndexCount++] = drawIndices[corner];
		}
	}
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
	SIMDProcessor->MinMax( bounds[0], bounds[1], silTraceVerts,
		selectedSilTraceIndices, destIndexCount );
}

void rvPrimBatch::CreateFrontFaceTris( int *destDrawIndices, int &destIndexCount,
		idBounds &bounds, int &backFaced, const unsigned char *facing,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer,
		rvIndexBuffer &drawIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *silTraceIndexMemory = NULL;
	void *drawIndexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, silTraceIndexMemory );
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, drawIndexMemory );

	int *selectedSilTraceIndices = static_cast<int *>( _alloca16( numIndices * sizeof( int ) ) );
	destIndexCount = 0;
	for ( int triangle = 0; triangle < m_silTraceGeoSpec.m_primitiveCount; ++triangle ) {
		if ( facing[triangle] == 0 ) {
			++backFaced;
			continue;
		}
		for ( int corner = 0; corner < 3; ++corner ) {
			const int index = triangle * 3 + corner;
			selectedSilTraceIndices[destIndexCount] = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( silTraceIndexMemory )[index]
				: static_cast<const unsigned int *>( silTraceIndexMemory )[index];
			destDrawIndices[destIndexCount++] = drawIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( drawIndexMemory )[index]
				: static_cast<const unsigned int *>( drawIndexMemory )[index];
		}
	}
	drawIndexBuffer.Unlock();
	silTraceIndexBuffer.Unlock();
	SIMDProcessor->MinMax( bounds[0], bounds[1], silTraceVerts,
		selectedSilTraceIndices, destIndexCount );
}

void rvPrimBatch::FindOverlayTriangles( overlayVertex_t *overlayVerts,
		int &numVerts, int *overlayIndices, int &numIndices,
		const unsigned char *cullBits, const idVec2 *textureCoordinates,
		int vertexBase, rvIndexBuffer &silTraceIndexBuffer ) {
	int *vertexRemap = static_cast<int *>( _alloca16(
		m_silTraceGeoSpec.m_vertexCount * sizeof( int ) ) );
	SIMDProcessor->Memset( vertexRemap, -1,
		m_silTraceGeoSpec.m_vertexCount * sizeof( int ) );

	const int indexCount = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, indexCount,
		rvIndexBufferLockFlagRead, indexMemory );
	for ( int index = 0; index < indexCount; index += 3 ) {
		int triangle[3];
		if ( silTraceIndexBuffer.Is16Bit() ) {
			const unsigned short *indices = static_cast<const unsigned short *>( indexMemory ) + index;
			triangle[0] = indices[0];
			triangle[1] = indices[1];
			triangle[2] = indices[2];
		} else {
			const unsigned int *indices = static_cast<const unsigned int *>( indexMemory ) + index;
			triangle[0] = indices[0];
			triangle[1] = indices[1];
			triangle[2] = indices[2];
		}
		if ( ( cullBits[triangle[0]] & cullBits[triangle[1]] & cullBits[triangle[2]] ) != 0 ) {
			continue;
		}
		for ( int corner = 0; corner < 3; ++corner ) {
			const int vertex = triangle[corner];
			if ( vertexRemap[vertex] == -1 ) {
				vertexRemap[vertex] = numVerts;
			overlayVerts[numVerts].vertexNum = vertex + vertexBase;
			overlayVerts[numVerts].st[0] = textureCoordinates[vertex].x;
			overlayVerts[numVerts].st[1] = textureCoordinates[vertex].y;
				++numVerts;
			}
			overlayIndices[numIndices++] = vertexRemap[vertex];
		}
	}
	silTraceIndexBuffer.Unlock();
}

void rvPrimBatch::FindDecalTriangles( idRenderModelDecal &decalModel,
		const decalProjectionInfo_t &localInfo, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts,
		rvIndexBuffer &silTraceIndexBuffer ) {
	byte *cullBits = static_cast<byte *>( _alloca16(
		m_silTraceGeoSpec.m_vertexCount * sizeof( byte ) ) );
	SIMDProcessor->DecalPointCull( cullBits, localInfo.boundingPlanes,
		silTraceVerts, m_silTraceGeoSpec.m_vertexCount );

	const int indexCount = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, indexCount,
		rvIndexBufferLockFlagRead, indexMemory );
	for ( int index = 0, triangle = 0; index < indexCount;
			index += 3, ++triangle ) {
		int vertexIndices[3];
		for ( int corner = 0; corner < 3; ++corner ) {
			vertexIndices[corner] = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( indexMemory )[index + corner]
				: static_cast<const unsigned int *>( indexMemory )[index + corner];
		}
		if ( ( cullBits[vertexIndices[0]] & cullBits[vertexIndices[1]] &
				cullBits[vertexIndices[2]] ) != 0 ) {
			continue;
		}
		if ( facePlanes != NULL && facePlanes[triangle].Normal() *
				localInfo.boundingPlanes[NUM_DECAL_BOUNDING_PLANES - 2].Normal() < -0.1f ) {
			continue;
		}

		idFixedWinding winding;
		winding.SetNumPoints( 3 );
		for ( int corner = 0; corner < 3; ++corner ) {
			winding[corner] = silTraceVerts[vertexIndices[corner]].xyzw.ToVec3();
			idVec3 texturePosition = winding[corner].ToVec3();
			if ( !localInfo.parallel ) {
				const idVec3 direction = texturePosition - localInfo.projectionOrigin;
				float scale = 0.0f;
				localInfo.boundingPlanes[NUM_DECAL_BOUNDING_PLANES - 1].RayIntersection(
					texturePosition, direction, scale );
				texturePosition += scale * direction;
			}
			winding[corner].s = localInfo.textureAxis[0].Distance( texturePosition );
			winding[corner].t = localInfo.textureAxis[1].Distance( texturePosition );
		}

		const int orBits = cullBits[vertexIndices[0]] |
			cullBits[vertexIndices[1]] | cullBits[vertexIndices[2]];
		for ( int plane = 0; plane < NUM_DECAL_BOUNDING_PLANES; ++plane ) {
			if ( ( orBits & ( 1 << plane ) ) != 0 &&
					!winding.ClipInPlace( -localInfo.boundingPlanes[plane], 0.1f ) ) {
				break;
			}
		}
		if ( winding.GetNumPoints() != 0 ) {
			decalModel.AddDepthFadedWinding( winding, localInfo.material,
				localInfo.fadePlanes, localInfo.fadeDepth, localInfo.startTime );
		}
	}
	silTraceIndexBuffer.Unlock();
}

void rvPrimBatch::GenerateCollisionPolys(
		idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel, const idMaterial &material,
		rvVertexBuffer &drawVertexBuffer, rvIndexBuffer &drawIndexBuffer ) {
	const int indexCount = m_drawGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	drawIndexBuffer.Lock( m_drawGeoSpec.m_indexStart, indexCount,
		rvIndexBufferLockFlagRead, indexMemory );

	unsigned char *positionMemory = NULL;
	unsigned char *textureCoordinateMemory = NULL;
	int positionStride = 0;
	int textureCoordinateStride = 0;
	drawVertexBuffer.LockTextureCoordinate( 0, m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		textureCoordinateMemory, textureCoordinateStride );
	drawVertexBuffer.LockPosition( m_drawGeoSpec.m_vertexStart,
		m_drawGeoSpec.m_vertexCount, rvVertexBufferLockFlagRead,
		positionMemory, positionStride );

	idFixedWinding winding;
	for ( int index = 0; index < indexCount; index += 3 ) {
		int sourceIndices[3];
		for ( int corner = 0; corner < 3; ++corner ) {
			const int sourceIndex = drawIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( indexMemory )[index + corner]
				: static_cast<const unsigned int *>( indexMemory )[index + corner];
			sourceIndices[corner] = sourceIndex - m_drawGeoSpec.m_vertexStart;
		}

		winding.SetNumPoints( 3 );
		for ( int corner = 0; corner < 3; ++corner ) {
			const int sourceIndex = sourceIndices[2 - corner];
			const float *position = reinterpret_cast<const float *>(
				positionMemory + sourceIndex * positionStride );
			const float *textureCoordinate = reinterpret_cast<const float *>(
				textureCoordinateMemory + sourceIndex * textureCoordinateStride );
			winding[corner].x = position[0];
			winding[corner].y = position[1];
			winding[corner].z = position[2];
			winding[corner].s = textureCoordinate[0];
			winding[corner].t = textureCoordinate[1];
		}

		idPlane plane;
		winding.GetPlane( plane );
		plane = -plane;
		modelManager.PolygonFromWinding( &collisionModel, &winding, plane,
			&material, 1 );
	}

	drawVertexBuffer.Unlock();
	drawIndexBuffer.Unlock();
}

bool rvPrimBatch::PreciseCullSurface( idBounds &ndcBounds,
		const rvSilTraceVertT *silTraceVerts, const idVec3 &localView,
		const float *modelMatrix, rvIndexBuffer &silTraceIndexBuffer ) {
	const int numIndices = m_silTraceGeoSpec.m_primitiveCount * 3;
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, numIndices,
		rvIndexBufferLockFlagRead, indexMemory );
	idFixedWinding winding;
	for ( int index = 0; index < numIndices; index += 3 ) {
		int vertexIndices[3];
		for ( int corner = 0; corner < 3; ++corner ) {
			vertexIndices[corner] = silTraceIndexBuffer.Is16Bit()
				? static_cast<const unsigned short *>( indexMemory )[index + corner]
				: static_cast<const unsigned int *>( indexMemory )[index + corner];
		}
		const idVec3 &v1 = silTraceVerts[vertexIndices[0]].xyzw.ToVec3();
		const idVec3 &v2 = silTraceVerts[vertexIndices[1]].xyzw.ToVec3();
		const idVec3 &v3 = silTraceVerts[vertexIndices[2]].xyzw.ToVec3();
		if ( tr.guiRecursionLevel == 0 ) {
			const idVec3 normal = ( v3 - v1 ).Cross( v2 - v1 );
			if ( normal * ( v1 - localView ) >= 0.0f ) {
				silTraceIndexBuffer.Unlock();
				return true;
			}
		}

		winding.SetNumPoints( 3 );
		R_LocalPointToGlobal( modelMatrix, v1, winding[0].ToVec3() );
		R_LocalPointToGlobal( modelMatrix, v2, winding[1].ToVec3() );
		R_LocalPointToGlobal( modelMatrix, v3, winding[2].ToVec3() );
		winding[0].s = winding[0].t = 0.0f;
		winding[1].s = winding[1].t = 0.0f;
		winding[2].s = winding[2].t = 0.0f;
		for ( int plane = 0; plane < 4; ++plane ) {
			if ( !winding.ClipInPlace( -tr.viewDef->frustum[plane], 0.1f ) ) {
				break;
			}
		}
		for ( int point = 0; point < winding.GetNumPoints(); ++point ) {
			idVec3 screen;
			R_GlobalToNormalizedDeviceCoordinates( tr.viewDef->worldSpace.modelViewMatrix, tr.viewDef->projectionMatrix, winding[point].ToVec3(), screen );
			ndcBounds.AddPoint( screen );
		}
	}
	silTraceIndexBuffer.Unlock();
	return false;
}

void rvPrimBatch::PlaneForSurface( idPlane &destPlane,
		const rvSilTraceVertT *silTraceVerts, rvIndexBuffer &silTraceIndexBuffer ) {
	void *indexMemory = NULL;
	silTraceIndexBuffer.Lock( m_silTraceGeoSpec.m_indexStart, 3,
		rvIndexBufferLockFlagRead, indexMemory );

	int i0;
	int i1;
	int i2;
	if ( silTraceIndexBuffer.Is16Bit() ) {
		const unsigned short *indices = static_cast<const unsigned short *>( indexMemory );
		i0 = indices[0];
		i1 = indices[1];
		i2 = indices[2];
	} else {
		const unsigned int *indices = static_cast<const unsigned int *>( indexMemory );
		i0 = indices[0];
		i1 = indices[1];
		i2 = indices[2];
	}

	destPlane.FromPoints( silTraceVerts[i0].xyzw.ToVec3(),
		silTraceVerts[i1].xyzw.ToVec3(), silTraceVerts[i2].xyzw.ToVec3() );
	silTraceIndexBuffer.Unlock();
}
