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
#include "rvVertexBuffer.h"

// Retail compilation unit: rvVertexBuffer.obj.

void rvVertexBuffer::ResetValues() {
	m_flags = 0;
	m_lockStatus = 0;
	m_numVertices = 0;
	m_vbID = 0;
	m_lockVertexOffset = 0;
	m_lockVertexCount = 0;
	m_lockedBase = NULL;
	m_numVerticesWritten = 0;
	m_interleavedStorage = NULL;
	m_positionArray = NULL;
	m_swizzledPositionArray = NULL;
	m_blendIndexArray = NULL;
	m_blendWeightArray = NULL;
	m_normalArray = NULL;
	m_tangentArray = NULL;
	m_binormalArray = NULL;
	m_diffuseColorArray = NULL;
	m_specularColorArray = NULL;
	m_pointSizeArray = NULL;
	memset( m_texCoordArrays, 0, sizeof( m_texCoordArrays ) );
}

rvVertexBuffer::rvVertexBuffer() {
	ResetValues();
}

rvVertexBuffer::~rvVertexBuffer() {
	Shutdown();
}

void rvVertexBuffer::CreateVertexStorage() {
	bool allocationFailed = false;
	if ( ( m_flags & rvVertexBufferFlagSystemMemory ) != 0 ) {
		if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
			if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 ) {
				m_positionArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * m_numVertices * m_format.GetPositionDimension(), MA_RENDER ) );
				allocationFailed |= m_positionArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagSwizzledPosition ) != 0 ) {
				m_swizzledPositionArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * 3 * ( ( m_numVertices + 3 ) & ~3 ), MA_RENDER ) );
				allocationFailed |= m_swizzledPositionArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagBlendIndex ) != 0 ) {
				m_blendIndexArray = static_cast<unsigned int *>( Mem_Alloc16( sizeof( unsigned int ) * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_blendIndexArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagBlendWeight ) != 0 ) {
				m_blendWeightArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * m_numVertices * m_format.GetBlendWeightDimension(), MA_RENDER ) );
				allocationFailed |= m_blendWeightArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagNormal ) != 0 ) {
				m_normalArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * 3 * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_normalArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagTangent ) != 0 ) {
				m_tangentArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * 3 * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_tangentArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagBinormal ) != 0 ) {
				m_binormalArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * 3 * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_binormalArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagDiffuseColor ) != 0 ) {
				m_diffuseColorArray = static_cast<unsigned int *>( Mem_Alloc16( sizeof( unsigned int ) * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_diffuseColorArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagSpecularColor ) != 0 ) {
				m_specularColorArray = static_cast<unsigned int *>( Mem_Alloc16( sizeof( unsigned int ) * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_specularColorArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagPointSize ) != 0 ) {
				m_pointSizeArray = static_cast<float *>( Mem_Alloc16( sizeof( float ) * m_numVertices, MA_RENDER ) );
				allocationFailed |= m_pointSizeArray == NULL;
			}
			if ( ( m_format.m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
				for ( int texture = 0; texture < 7; ++texture ) {
					const int dimension = m_format.GetTextureDimension( texture );
					if ( dimension != 0 ) {
						m_texCoordArrays[texture] = static_cast<float *>( Mem_Alloc16( sizeof( float ) * dimension * m_numVertices, MA_RENDER ) );
						allocationFailed |= m_texCoordArrays[texture] == NULL;
					}
				}
			}
		} else {
			m_interleavedStorage = static_cast<unsigned char *>( Mem_Alloc16( m_format.GetSize() * m_numVertices, MA_RENDER ) );
			allocationFailed = m_interleavedStorage == NULL;
		}
	}
	if ( allocationFailed ) {
		common->FatalError( "Ran out of memory trying to allocate system memory vertex storage" );
		return;
	}

	if ( ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) {
		qglGetError();
		qglGenBuffersARB( 1, &m_vbID );
		if ( m_vbID == 0 ) {
			common->FatalError( "rvVertexBuffer: Unable to gen buffer id" );
			return;
		}
		if ( ( m_flags & rvVertexBufferFlagDynamicStream ) == 0 ) {
			qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
			qglBufferDataARB( GL_ARRAY_BUFFER_ARB, m_format.GetSize() * m_numVertices, NULL, GL_STATIC_DRAW_ARB );
			const unsigned int error = qglGetError();
			if ( error != GL_NO_ERROR ) {
				common->FatalError( "Unable to allocate vertex storage - %d", error );
			}
			m_format.SetVertexDeclaration( 0 );
			qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
		}
	}
}

bool rvVertexBuffer::LockInterleaved( int vertexOffset, int numVerticesToLock,
		unsigned int lockFlags, void *&startPtr, int &stride ) {
	m_lockVertexOffset = vertexOffset;
	m_lockVertexCount = numVerticesToLock;
	if ( m_lockVertexCount == 0 ) {
		m_lockVertexCount = m_numVertices - vertexOffset;
	}

	if ( ( m_flags & rvVertexBufferFlagSystemMemory ) != 0 ) {
		m_lockedBase = m_interleavedStorage;
	} else if ( m_lockStatus == 0 ) {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
		unsigned int access = GL_READ_WRITE_ARB;
		if ( ( lockFlags & rvVertexBufferLockFlagRead ) != 0 ) {
			access = ( lockFlags & rvVertexBufferLockFlagWrite ) != 0 ? GL_READ_WRITE_ARB : GL_READ_ONLY_ARB;
		} else if ( ( lockFlags & rvVertexBufferLockFlagWrite ) != 0 ) {
			access = GL_WRITE_ONLY_ARB;
			const unsigned int usage = ( m_flags & rvVertexBufferFlagDynamicStream ) != 0 ? GL_STREAM_DRAW_ARB : GL_STATIC_DRAW_ARB;
			if ( ( m_flags & rvVertexBufferFlagDynamicStream ) != 0 ) {
				lockFlags |= rvVertexBufferLockFlagEmpty;
			}
			if ( ( lockFlags & rvVertexBufferLockFlagEmpty ) != 0 ) {
				m_lockVertexOffset = 0;
				qglBufferDataARB( GL_ARRAY_BUFFER_ARB, m_format.GetSize() * m_lockVertexCount, NULL, usage );
			}
		}
		m_lockedBase = static_cast<unsigned char *>( qglMapBufferARB( GL_ARRAY_BUFFER_ARB, access ) );
		if ( m_lockedBase == NULL ) {
			return false;
		}
	}

	m_lockStatus = lockFlags;
	startPtr = m_lockedBase + m_lockVertexOffset * m_format.GetSize();
	stride = m_format.GetSize();
	return true;
}

void rvVertexBuffer::TransferSoAToAoS( unsigned char *vertexDest ) {
	const int stride = m_format.GetSize();
	for ( int vertex = 0; vertex < m_numVertices; ++vertex ) {
		unsigned char *dest = vertexDest + vertex * stride;
		if ( ( m_format.m_flags & rvVertexFormatFlagSwizzledPosition ) != 0 ) {
			const int block = vertex & ~3;
			const int lane = vertex & 3;
			float *out = reinterpret_cast<float *>( dest );
			out[0] = m_swizzledPositionArray[block * 3 + lane];
			out[1] = m_swizzledPositionArray[block * 3 + 4 + lane];
			out[2] = m_swizzledPositionArray[block * 3 + 8 + lane];
		} else if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 ) {
			memcpy( dest + m_format.m_byteOffset[0], m_positionArray + vertex * m_format.GetPositionDimension(),
				sizeof( float ) * m_format.GetPositionDimension() );
		}
		if ( ( m_format.m_flags & rvVertexFormatFlagBlendIndex ) != 0 ) {
			memcpy( dest + m_format.m_byteOffset[2], m_blendIndexArray + vertex, 4 );
		}
		if ( ( m_format.m_flags & rvVertexFormatFlagBlendWeight ) != 0 ) {
			memcpy( dest + m_format.m_byteOffset[3], m_blendWeightArray + vertex * m_format.GetBlendWeightDimension(),
				sizeof( float ) * m_format.GetBlendWeightDimension() );
		}
		if ( ( m_format.m_flags & rvVertexFormatFlagNormal ) != 0 ) { memcpy( dest + m_format.m_byteOffset[4], m_normalArray + vertex * 3, 12 ); }
		if ( ( m_format.m_flags & rvVertexFormatFlagTangent ) != 0 ) { memcpy( dest + m_format.m_byteOffset[5], m_tangentArray + vertex * 3, 12 ); }
		if ( ( m_format.m_flags & rvVertexFormatFlagBinormal ) != 0 ) { memcpy( dest + m_format.m_byteOffset[6], m_binormalArray + vertex * 3, 12 ); }
		if ( ( m_format.m_flags & rvVertexFormatFlagDiffuseColor ) != 0 ) { memcpy( dest + m_format.m_byteOffset[7], m_diffuseColorArray + vertex, 4 ); }
		if ( ( m_format.m_flags & rvVertexFormatFlagSpecularColor ) != 0 ) { memcpy( dest + m_format.m_byteOffset[8], m_specularColorArray + vertex, 4 ); }
		if ( ( m_format.m_flags & rvVertexFormatFlagPointSize ) != 0 ) { memcpy( dest + m_format.m_byteOffset[9], m_pointSizeArray + vertex, 4 ); }
		for ( int texture = 0; texture < 7; ++texture ) {
			const int dimension = m_format.GetTextureDimension( texture );
			if ( dimension != 0 ) {
				memcpy( dest + m_format.m_byteOffset[10 + texture], m_texCoordArrays[texture] + vertex * dimension,
					sizeof( float ) * dimension );
			}
		}
	}
}

void rvVertexBuffer::SetupForRender( int vertexStartOffset, const rvVertexFormat &formatNeeded ) {
	if ( ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
		m_format.SetVertexDeclaration( vertexStartOffset );
		formatNeeded.EnableVertexDeclaration();
	}
}

rvSilTraceVertT *rvVertexBuffer::GetSilTraceVertexArray( int vertexOffset ) {
	return reinterpret_cast<rvSilTraceVertT *>( m_interleavedStorage + sizeof( rvSilTraceVertT ) * vertexOffset );
}

void rvVertexBuffer::SetLoadFormat( const rvVertexFormat &loadFormat ) {
	m_loadFormat.Init( loadFormat );
}

void rvVertexBuffer::Unlock() {
	const bool wrote = ( m_lockStatus & rvVertexBufferLockFlagWrite ) != 0;
	if ( wrote ) {
		if ( ( m_lockStatus & rvVertexBufferLockFlagEmpty ) != 0 ) { m_numVerticesWritten = m_lockVertexCount; }
		else { m_numVerticesWritten += m_lockVertexCount; }
	}

	if ( ( m_flags & rvVertexBufferFlagSystemMemory ) != 0 ) {
		if ( wrote && ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) {
			const int byteOffset = m_format.GetSize() * m_lockVertexOffset;
			qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
			if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
				unsigned char *videoMemory = static_cast<unsigned char *>( qglMapBufferARB( GL_ARRAY_BUFFER_ARB, GL_WRITE_ONLY_ARB ) );
				if ( videoMemory != NULL ) {
					TransferSoAToAoS( videoMemory + byteOffset );
					qglUnmapBufferARB( GL_ARRAY_BUFFER_ARB );
				}
			} else {
				qglBufferSubDataARB( GL_ARRAY_BUFFER_ARB, byteOffset, m_format.GetSize() * m_lockVertexCount,
					m_interleavedStorage + byteOffset );
			}
			qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
		}
	} else if ( ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
		qglUnmapBufferARB( GL_ARRAY_BUFFER_ARB );
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	}
	m_lockStatus = 0;
	m_lockVertexOffset = 0;
	m_lockVertexCount = 0;
	m_lockedBase = NULL;
}

void rvVertexBuffer::CopyData( int destVertexOffset, int numVertices, const unsigned char *srcPtr,
		int srcStride, const rvVertexFormat &srcFormat, const unsigned int *copyMapping ) {
	unsigned char *destPtr = NULL;
	int destStride = 0;
	if ( !LockInterleaved( destVertexOffset, numVertices, rvVertexBufferLockFlagWrite,
			reinterpret_cast<void *&>( destPtr ), destStride ) ) {
		common->FatalError( "Vertex buffer cannot be mapped for access" );
		return;
	}
	auto copy = [&]( int component, int destDimension, int sourceDimension ) {
		if ( ( m_format.m_flags & BIT( component < 10 ? component : 10 ) ) != 0 &&
			 ( srcFormat.m_flags & BIT( component < 10 ? component : 10 ) ) != 0 ) {
			ComponentCopy( destPtr + m_format.m_byteOffset[component], destStride,
				static_cast<Rv_Vertex_Data_Type_t>( m_format.m_dataTypes[component] ), destDimension,
				srcPtr + srcFormat.m_byteOffset[component], srcStride,
				static_cast<Rv_Vertex_Data_Type_t>( srcFormat.m_dataTypes[component] ), sourceDimension,
				numVertices, copyMapping, NULL, false );
		}
	};
	copy( 0, m_format.GetPositionDimension(), srcFormat.GetPositionDimension() );
	copy( 2, 1, 1 );
	copy( 3, m_format.GetBlendWeightDimension(), srcFormat.GetBlendWeightDimension() );
	for ( int component = 4; component <= 6; ++component ) { copy( component, 3, 3 ); }
	for ( int component = 7; component <= 9; ++component ) { copy( component, 1, 1 ); }
	for ( int texture = 0; texture < 7; ++texture ) {
		copy( 10 + texture, m_format.GetTextureDimension( texture ), srcFormat.GetTextureDimension( texture ) );
	}
	Unlock();
}

void rvVertexBuffer::CopyData( unsigned char *destPtr, int destStride, const rvVertexFormat &destFormat,
		int srcVertexOffset, int numVertices, const unsigned int *copyMapping ) {
	const unsigned char *srcPtr = NULL;
	int srcStride = 0;
	if ( !LockInterleaved( srcVertexOffset, numVertices, rvVertexBufferLockFlagRead,
			reinterpret_cast<void *&>( const_cast<unsigned char *&>( srcPtr ) ), srcStride ) ) {
		common->FatalError( "Vertex buffer cannot be mapped for access" );
		return;
	}
	auto copy = [&]( int component, int destDimension, int sourceDimension ) {
		if ( ( destFormat.m_flags & BIT( component < 10 ? component : 10 ) ) != 0 &&
			 ( m_format.m_flags & BIT( component < 10 ? component : 10 ) ) != 0 ) {
			ComponentCopy( destPtr + destFormat.m_byteOffset[component], destStride,
				static_cast<Rv_Vertex_Data_Type_t>( destFormat.m_dataTypes[component] ), destDimension,
				srcPtr + m_format.m_byteOffset[component], srcStride,
				static_cast<Rv_Vertex_Data_Type_t>( m_format.m_dataTypes[component] ), sourceDimension,
				numVertices, copyMapping, NULL, false );
		}
	};
	copy( 0, destFormat.GetPositionDimension(), m_format.GetPositionDimension() );
	copy( 2, 1, 1 );
	copy( 3, destFormat.GetBlendWeightDimension(), m_format.GetBlendWeightDimension() );
	for ( int component = 4; component <= 6; ++component ) { copy( component, 3, 3 ); }
	for ( int component = 7; component <= 9; ++component ) { copy( component, 1, 1 ); }
	for ( int texture = 0; texture < 7; ++texture ) {
		copy( 10 + texture, destFormat.GetTextureDimension( texture ), m_format.GetTextureDimension( texture ) );
	}
	Unlock();
}

void rvVertexBuffer::Write( idFile &outFile, const char *prepend ) {
	idStr indent = prepend;
	indent += "\t";
	outFile.WriteFloatString( "%sVertexBuffer\n%s{\n", prepend, prepend );
	outFile.WriteFloatString( "%sVertexFormat ", indent.c_str() );
	m_format.Write( outFile, indent.c_str() );
	if ( !m_loadFormat.HasSameComponents( m_format ) || !m_loadFormat.HasSameDataTypes( m_format ) ) {
		outFile.WriteFloatString( "%sLoadVertexFormat ", indent.c_str() );
		m_loadFormat.Write( outFile, indent.c_str() );
	}
	if ( ( m_flags & rvVertexBufferFlagSystemMemory ) != 0 ) { outFile.WriteFloatString( "%sSystemMemory\n", indent.c_str() ); }
	if ( ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) { outFile.WriteFloatString( "%sVideoMemory\n", indent.c_str() ); }
	if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) { outFile.WriteFloatString( "%sSoA\n", indent.c_str() ); }
	outFile.WriteFloatString( "%sVertex[ %d ]\n%s{\n", indent.c_str(), m_numVerticesWritten, indent.c_str() );

	unsigned char *storage = NULL;
	bool allocatedStorage = false;
	if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
		storage = static_cast<unsigned char *>( Mem_Alloc16( m_format.GetSize() * m_numVertices, MA_RENDER ) );
		if ( storage != NULL ) { TransferSoAToAoS( storage ); allocatedStorage = true; }
	} else if ( ( m_flags & rvVertexBufferFlagSystemMemory ) != 0 ) {
		storage = m_interleavedStorage;
	} else {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
		storage = static_cast<unsigned char *>( qglMapBufferARB( GL_ARRAY_BUFFER_ARB, GL_READ_ONLY_ARB ) );
	}
	if ( storage == NULL ) {
		common->FatalError( "Vertex buffer cannot be mapped for access" );
		return;
	}
	int tokenSubTypes[72];
	for ( int i = 0; i < m_format.m_numValues; ++i ) { tokenSubTypes[i] = m_format.m_tokenSubTypes[i]; }
	idStr dataIndent = indent;
	dataIndent += "\t";
	outFile.WriteNumericStructArray( m_format.m_numValues, tokenSubTypes, m_numVerticesWritten, storage, dataIndent.c_str() );
	if ( allocatedStorage ) { Mem_Free16( storage ); }
	else if ( ( m_flags & rvVertexBufferFlagSystemMemory ) == 0 ) {
		qglUnmapBufferARB( GL_ARRAY_BUFFER_ARB );
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	}
	outFile.WriteFloatString( "%s}\n%s}\n", indent.c_str(), prepend );
}

void rvVertexBuffer::Shutdown() {
	if ( m_lockStatus != 0 ) { Unlock(); }
	if ( m_interleavedStorage != NULL ) { Mem_Free16( m_interleavedStorage ); }
	if ( m_positionArray != NULL ) { Mem_Free16( m_positionArray ); }
	if ( m_swizzledPositionArray != NULL ) { Mem_Free16( m_swizzledPositionArray ); }
	if ( m_blendIndexArray != NULL ) { Mem_Free16( m_blendIndexArray ); }
	if ( m_blendWeightArray != NULL ) { Mem_Free16( m_blendWeightArray ); }
	if ( m_normalArray != NULL ) { Mem_Free16( m_normalArray ); }
	if ( m_tangentArray != NULL ) { Mem_Free16( m_tangentArray ); }
	if ( m_binormalArray != NULL ) { Mem_Free16( m_binormalArray ); }
	if ( m_diffuseColorArray != NULL ) { Mem_Free16( m_diffuseColorArray ); }
	if ( m_specularColorArray != NULL ) { Mem_Free16( m_specularColorArray ); }
	if ( m_pointSizeArray != NULL ) { Mem_Free16( m_pointSizeArray ); }
	for ( int texture = 0; texture < 7; ++texture ) { if ( m_texCoordArrays[texture] != NULL ) { Mem_Free16( m_texCoordArrays[texture] ); } }
	if ( m_vbID != 0 ) { qglDeleteBuffersARB( 1, &m_vbID ); }
	m_format.Shutdown();
	m_loadFormat.Shutdown();
	ResetValues();
}

void rvVertexBuffer::Resize( int numVertices ) {
	if ( numVertices == m_numVertices || ( m_flags & rvVertexBufferFlagSystemMemory ) == 0 ) { return; }
	const int oldNumVertices = m_numVertices;
	const int copyVertices = Min( oldNumVertices, numVertices );
	if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
		auto resizeArray = [&]( void *&array, int valuesPerVertex, int oldStorageVertices, int newStorageVertices ) -> bool {
			if ( array == NULL ) { return true; }
			void *replacement = Mem_Alloc16( sizeof( float ) * valuesPerVertex * newStorageVertices, MA_RENDER );
			if ( replacement == NULL ) { return false; }
			SIMDProcessor->Memcpy( replacement, array, sizeof( float ) * valuesPerVertex * Min( oldStorageVertices, newStorageVertices ) );
			Mem_Free16( array ); array = replacement; return true;
		};
		bool ok = true;
		ok &= resizeArray( reinterpret_cast<void *&>( m_positionArray ), m_format.GetPositionDimension(), oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_swizzledPositionArray ), 3, ( oldNumVertices + 3 ) & ~3, ( numVertices + 3 ) & ~3 );
		ok &= resizeArray( reinterpret_cast<void *&>( m_blendIndexArray ), 1, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_blendWeightArray ), m_format.GetBlendWeightDimension(), oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_normalArray ), 3, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_tangentArray ), 3, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_binormalArray ), 3, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_diffuseColorArray ), 1, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_specularColorArray ), 1, oldNumVertices, numVertices );
		ok &= resizeArray( reinterpret_cast<void *&>( m_pointSizeArray ), 1, oldNumVertices, numVertices );
		for ( int texture = 0; texture < 7; ++texture ) {
			ok &= resizeArray( reinterpret_cast<void *&>( m_texCoordArrays[texture] ), m_format.GetTextureDimension( texture ), oldNumVertices, numVertices );
		}
		if ( !ok ) { common->FatalError( "Ran out of memory trying to allocate system memory vertex storage" ); Shutdown(); return; }
	} else {
		unsigned char *replacement = static_cast<unsigned char *>( Mem_Alloc16( numVertices * m_format.GetSize(), MA_RENDER ) );
		if ( replacement == NULL ) { common->FatalError( "Ran out of memory trying to allocate system memory vertex storage" ); Shutdown(); return; }
		SIMDProcessor->Memcpy( replacement, m_interleavedStorage, copyVertices * m_format.GetSize() );
		Mem_Free16( m_interleavedStorage );
		m_interleavedStorage = replacement;
	}
	m_numVertices = numVertices;
	if ( ( m_flags & rvVertexBufferFlagVideoMemory ) != 0 ) {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, m_vbID );
		if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
			qglBufferDataARB( GL_ARRAY_BUFFER_ARB, numVertices * m_format.GetSize(), NULL, GL_STATIC_DRAW_ARB );
			unsigned char *mapped = static_cast<unsigned char *>( qglMapBufferARB( GL_ARRAY_BUFFER_ARB, GL_WRITE_ONLY_ARB ) );
			if ( mapped != NULL ) { TransferSoAToAoS( mapped ); qglUnmapBufferARB( GL_ARRAY_BUFFER_ARB ); }
		} else {
			qglBufferDataARB( GL_ARRAY_BUFFER_ARB, numVertices * m_format.GetSize(), m_interleavedStorage, GL_STATIC_DRAW_ARB );
		}
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	}
}

#define RV_COMPONENT_LOCK_IMPL( name, member, component, componentStride ) \
	bool rvVertexBuffer::name( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags, \
		unsigned char *&ptr, int &stride ) { \
		m_lockVertexOffset = vertexBufferOffset; m_lockVertexCount = numVerticesToLock; \
		if ( ( m_flags & rvVertexBufferFlagSoA ) == 0 ) { \
			if ( !LockInterleaved( vertexBufferOffset, numVerticesToLock, lockFlags, reinterpret_cast<void *&>( ptr ), stride ) ) { return false; } \
			ptr += m_format.m_byteOffset[component]; return true; \
		} \
		m_lockStatus = lockFlags; ptr = reinterpret_cast<unsigned char *>( member ); stride = componentStride; return true; \
	}

RV_COMPONENT_LOCK_IMPL( LockPosition, m_positionArray, 0, sizeof( float ) * m_format.GetPositionDimension() )
RV_COMPONENT_LOCK_IMPL( LockBlendIndex, m_blendIndexArray, 2, sizeof( unsigned int ) )
RV_COMPONENT_LOCK_IMPL( LockBlendWeight, m_blendWeightArray, 3, sizeof( float ) * m_format.GetBlendWeightDimension() )
RV_COMPONENT_LOCK_IMPL( LockNormal, m_normalArray, 4, sizeof( float ) * 3 )
RV_COMPONENT_LOCK_IMPL( LockTangent, m_tangentArray, 5, sizeof( float ) * 3 )
RV_COMPONENT_LOCK_IMPL( LockBinormal, m_binormalArray, 6, sizeof( float ) * 3 )
RV_COMPONENT_LOCK_IMPL( LockDiffuseColor, m_diffuseColorArray, 7, sizeof( unsigned int ) )

#undef RV_COMPONENT_LOCK_IMPL

bool rvVertexBuffer::LockTextureCoordinate( int textureCoordinate, int vertexBufferOffset,
		int numVerticesToLock, unsigned int lockFlags, unsigned char *&textureCoordinatePtr, int &stride ) {
	m_lockVertexOffset = vertexBufferOffset;
	m_lockVertexCount = numVerticesToLock;
	if ( ( m_flags & rvVertexBufferFlagSoA ) == 0 ) {
		if ( !LockInterleaved( vertexBufferOffset, numVerticesToLock, lockFlags,
				reinterpret_cast<void *&>( textureCoordinatePtr ), stride ) ) { return false; }
		textureCoordinatePtr += m_format.m_byteOffset[10 + textureCoordinate];
		return true;
	}
	m_lockStatus = lockFlags;
	textureCoordinatePtr = reinterpret_cast<unsigned char *>( m_texCoordArrays[textureCoordinate] );
	stride = sizeof( float ) * m_format.GetTextureDimension( textureCoordinate );
	return true;
}

void rvVertexBuffer::CopyRemappedData( int vertexBufferOffset, int numVertices,
		unsigned int *copyMapping, unsigned int *transformMapOldToNew,
		rvBlend4DrawVert *srcVertData, bool absBlendWeights ) {
	if ( vertexBufferOffset + numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy vertex data out-of-bounds" ); return; }
	unsigned char *ptr = NULL; int stride = 0;
	if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 && m_format.GetPositionDimension() >= 3 &&
		 LockPosition( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, &srcVertData[copyMapping[i]].xyz, 12 ); }
	}
	if ( ( m_format.m_flags & rvVertexFormatFlagBlendIndex ) != 0 &&
		 LockBlendIndex( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { unsigned char *out = ptr + i * stride; const rvBlend4DrawVert &src = srcVertData[copyMapping[i]]; for ( int j = 0; j < 4; ++j ) { out[j] = static_cast<unsigned char>( transformMapOldToNew[src.blendIndex[j]] ); } }
	}
	if ( ( m_format.m_flags & rvVertexFormatFlagBlendWeight ) != 0 &&
		 LockBlendWeight( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		const int dimension = m_format.GetBlendWeightDimension();
		for ( int i = 0; i < numVertices; ++i ) { float *out = reinterpret_cast<float *>( ptr + i * stride ); const float *src = srcVertData[copyMapping[i]].blendWeight; for ( int j = 0; j < dimension; ++j ) { out[j] = absBlendWeights ? idMath::Fabs( src[j] ) : src[j]; } }
	}
	auto copyVec3 = [&]( unsigned int flag, bool ( rvVertexBuffer::*lock )( int, int, unsigned int, unsigned char *&, int & ), idVec3 rvBlend4DrawVert::*member ) {
		if ( ( m_format.m_flags & flag ) != 0 && ( this->*lock )( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
			for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, &( srcVertData[copyMapping[i]].*member ), 12 ); }
		}
	};
	copyVec3( rvVertexFormatFlagNormal, &rvVertexBuffer::LockNormal, &rvBlend4DrawVert::normal );
	copyVec3( rvVertexFormatFlagTangent, &rvVertexBuffer::LockTangent, &rvBlend4DrawVert::tangent );
	copyVec3( rvVertexFormatFlagBinormal, &rvVertexBuffer::LockBinormal, &rvBlend4DrawVert::binormal );
	if ( ( m_format.m_flags & rvVertexFormatFlagDiffuseColor ) != 0 && LockDiffuseColor( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, srcVertData[copyMapping[i]].color, 4 ); }
	}
	if ( m_format.GetTextureDimension( 0 ) >= 2 && LockTextureCoordinate( 0, vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, &srcVertData[copyMapping[i]].st, 8 ); }
	}
	if ( m_lockStatus != 0 ) { Unlock(); }
}

void rvVertexBuffer::CopyRemappedShadowVolData( int vertexBufferOffset, int numVertices,
		unsigned int *copyMapping, unsigned int *transformMapOldToNew, rvBlend4DrawVert *srcVertData ) {
	if ( vertexBufferOffset + 2 * numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy shadow volume vertex data out-of-bounds" ); return; }
	unsigned char *ptr = NULL; int stride = 0;
	if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 && LockPosition( vertexBufferOffset, 2 * numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { const idVec3 &xyz = srcVertData[copyMapping[i]].xyz; memcpy( ptr + ( 2 * i ) * stride, &xyz, 12 ); memcpy( ptr + ( 2 * i + 1 ) * stride, &xyz, 12 ); if ( m_format.GetPositionDimension() == 4 ) { reinterpret_cast<float *>( ptr + ( 2 * i ) * stride )[3] = 1.0f; reinterpret_cast<float *>( ptr + ( 2 * i + 1 ) * stride )[3] = 0.0f; } }
	}
	if ( ( m_format.m_flags & rvVertexFormatFlagBlendIndex ) != 0 && LockBlendIndex( vertexBufferOffset, 2 * numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { const rvBlend4DrawVert &src = srcVertData[copyMapping[i]]; for ( int duplicate = 0; duplicate < 2; ++duplicate ) { unsigned char *out = ptr + ( 2 * i + duplicate ) * stride; for ( int j = 0; j < 4; ++j ) { out[j] = static_cast<unsigned char>( abs( static_cast<int>( transformMapOldToNew[src.blendIndex[j]] ) ) ); } if ( m_format.GetPositionDimension() == 3 ) { out[3] = duplicate ? 0 : 0xFF; } } }
	}
	if ( ( m_format.m_flags & rvVertexFormatFlagBlendWeight ) != 0 && LockBlendWeight( vertexBufferOffset, 2 * numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		const int dimension = m_format.GetBlendWeightDimension();
		for ( int i = 0; i < numVertices; ++i ) { for ( int duplicate = 0; duplicate < 2; ++duplicate ) { float *out = reinterpret_cast<float *>( ptr + ( 2 * i + duplicate ) * stride ); for ( int j = 0; j < dimension; ++j ) { out[j] = idMath::Fabs( srcVertData[copyMapping[i]].blendWeight[j] ); } } }
	}
	if ( m_lockStatus != 0 ) { Unlock(); }
}

int rvVertexBuffer::CopySilTraceData( unsigned int *indexMapping, int vertexBufferOffset,
		int numVertices, int *copyMapping, const idDrawVert *srcVertData ) {
	if ( vertexBufferOffset + numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy vertex data out-of-bounds" ); return 0; }
	unsigned char *ptr = NULL; int stride = 0; int written = 0;
	if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 && m_format.GetPositionDimension() >= 3 && LockPosition( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) {
			if ( copyMapping[i] == i ) { memcpy( ptr + written * stride, &srcVertData[i].xyz, 12 ); if ( m_format.GetPositionDimension() == 4 ) { reinterpret_cast<float *>( ptr + written * stride )[3] = 1.0f; } indexMapping[i] = written++; }
			else { indexMapping[i] = indexMapping[copyMapping[i]]; }
		}
	}
	if ( m_lockStatus != 0 ) { Unlock(); }
	m_numVerticesWritten = written;
	return written;
}

void rvVertexBuffer::CopyData( int vertexBufferOffset, int numVertices, const idDrawVert *srcVertData ) {
	if ( vertexBufferOffset + numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy vertex data out-of-bounds" ); return; }
	unsigned char *ptr = NULL; int stride = 0;
	auto copyField = [&]( unsigned int flag, bool ( rvVertexBuffer::*lock )( int, int, unsigned int, unsigned char *&, int & ), const unsigned char *field, int sourceStride, int bytes ) {
		if ( ( m_format.m_flags & flag ) != 0 && ( this->*lock )( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) { for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, field + i * sourceStride, bytes ); } }
	};
	copyField( rvVertexFormatFlagPosition, &rvVertexBuffer::LockPosition, reinterpret_cast<const unsigned char *>( &srcVertData[0].xyz ), sizeof( idDrawVert ), 12 );
	copyField( rvVertexFormatFlagNormal, &rvVertexBuffer::LockNormal, reinterpret_cast<const unsigned char *>( &srcVertData[0].normal ), sizeof( idDrawVert ), 12 );
	copyField( rvVertexFormatFlagTangent, &rvVertexBuffer::LockTangent, reinterpret_cast<const unsigned char *>( &srcVertData[0].tangents[0] ), sizeof( idDrawVert ), 12 );
	copyField( rvVertexFormatFlagBinormal, &rvVertexBuffer::LockBinormal, reinterpret_cast<const unsigned char *>( &srcVertData[0].tangents[1] ), sizeof( idDrawVert ), 12 );
	copyField( rvVertexFormatFlagDiffuseColor, &rvVertexBuffer::LockDiffuseColor, srcVertData[0].color, sizeof( idDrawVert ), 4 );
	if ( m_format.GetTextureDimension( 0 ) >= 2 && LockTextureCoordinate( 0, vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) { for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, &srcVertData[i].st, 8 ); } }
	if ( m_lockStatus != 0 ) { Unlock(); }
}

void rvVertexBuffer::CopyRemappedShadowVolData( int vertexBufferOffset, int numVertices,
		int *copyMapping, const idDrawVert *srcVertData ) {
	if ( vertexBufferOffset + 2 * numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy shadow volume vertex data out-of-bounds" ); return; }
	unsigned char *ptr = NULL; int stride = 0;
	if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 && LockPosition( vertexBufferOffset, 2 * numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		for ( int i = 0; i < numVertices; ++i ) { const idVec3 &xyz = srcVertData[copyMapping[i]].xyz; memcpy( ptr + ( 2 * i ) * stride, &xyz, 12 ); memcpy( ptr + ( 2 * i + 1 ) * stride, &xyz, 12 ); if ( m_format.GetPositionDimension() == 4 ) { reinterpret_cast<float *>( ptr + ( 2 * i ) * stride )[3] = 1.0f; reinterpret_cast<float *>( ptr + ( 2 * i + 1 ) * stride )[3] = 0.0f; } }
	}
	if ( m_lockStatus != 0 ) { Unlock(); }
}

void rvVertexBuffer::CopyShadowVolData( int vertexBufferOffset, int numVertices, shadowCache_t *srcVertData ) {
	if ( vertexBufferOffset + numVertices > m_numVertices ) { common->FatalError( "rvVertexBuffer: attempt to copy shadow volume vertex data out-of-bounds" ); return; }
	unsigned char *ptr = NULL; int stride = 0;
	if ( ( m_format.m_flags & rvVertexFormatFlagPosition ) != 0 && LockPosition( vertexBufferOffset, numVertices, rvVertexBufferLockFlagWrite, ptr, stride ) ) {
		const int bytes = Min( 4, m_format.GetPositionDimension() ) * sizeof( float );
		for ( int i = 0; i < numVertices; ++i ) { memcpy( ptr + i * stride, &srcVertData[i].xyz, bytes ); }
	}
	if ( m_lockStatus != 0 ) { Unlock(); }
}

void rvVertexBuffer::Init( const rvVertexFormat &vertexFormat, int numVertices, unsigned int flagMask ) {
	if ( m_format.m_flags != 0 ) { Shutdown(); }
	m_format.Init( vertexFormat );
	m_loadFormat.Init( vertexFormat );
	m_numVertices = numVertices;
	m_flags = flagMask;
	CreateVertexStorage();
}

void rvVertexBuffer::Init( Lexer &lexer ) {
	if ( m_format.m_flags != 0 ) { Shutdown(); }
	lexer.ExpectTokenString( "{" );
	lexer.ExpectTokenString( "VertexFormat" );
	m_format.Init( lexer );
	m_loadFormat.Init( m_format );
	m_flags = 0;
	idToken token;
	while ( lexer.ReadToken( &token ) ) {
		if ( !token.Icmp( "LoadVertexFormat" ) ) { m_loadFormat.Init( lexer ); }
		else if ( !token.Icmp( "SystemMemory" ) ) { m_flags |= rvVertexBufferFlagSystemMemory; }
		else if ( !token.Icmp( "VideoMemory" ) ) { m_flags |= rvVertexBufferFlagVideoMemory; }
		else { break; }
	}
	if ( m_flags == 0 ) { m_flags = rvVertexBufferFlagVideoMemory; }
	if ( !token.Icmp( "SoA" ) ) { m_flags |= rvVertexBufferFlagSoA; lexer.ReadToken( &token ); }
	if ( token.Icmp( "Vertex" ) ) { lexer.Error( "Expected vertex header" ); }
	lexer.ExpectTokenString( "[" );
	m_numVertices = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	if ( m_numVertices <= 0 ) { lexer.Error( "Invalid vertex count" ); return; }
	CreateVertexStorage();
	lexer.ExpectTokenString( "{" );
	if ( !lexer.ReadToken( &token ) ) { return; }
	if ( token.Icmp( "}" ) ) {
		lexer.UnreadToken( &token );
		m_lockStatus = rvVertexBufferLockFlagWrite | rvVertexBufferLockFlagEmpty;
		m_lockVertexOffset = 0;
		m_lockVertexCount = m_numVertices;
		int tokenSubTypes[72];
		if ( ( m_flags & rvVertexBufferFlagSoA ) != 0 ) {
			auto parse = [&]( int component, int dimension, unsigned char *storage, int count ) { if ( storage != NULL ) { m_format.GetTokenSubTypes( static_cast<Rv_Vertex_Component_t>( component ), tokenSubTypes ); lexer.ParseNumericStructArray( dimension, tokenSubTypes, count, storage ); } };
			if ( ( m_format.m_flags & rvVertexFormatFlagSwizzledPosition ) != 0 ) { parse( 1, 3, reinterpret_cast<unsigned char *>( m_swizzledPositionArray ), ( m_numVertices + 3 ) & ~3 ); }
			else { parse( 0, m_format.GetPositionDimension(), reinterpret_cast<unsigned char *>( m_positionArray ), m_numVertices ); }
			parse( 2, 1, reinterpret_cast<unsigned char *>( m_blendIndexArray ), m_numVertices );
			parse( 3, m_format.GetBlendWeightDimension(), reinterpret_cast<unsigned char *>( m_blendWeightArray ), m_numVertices );
			parse( 4, 3, reinterpret_cast<unsigned char *>( m_normalArray ), m_numVertices );
			parse( 5, 3, reinterpret_cast<unsigned char *>( m_tangentArray ), m_numVertices );
			parse( 6, 3, reinterpret_cast<unsigned char *>( m_binormalArray ), m_numVertices );
			parse( 7, 1, reinterpret_cast<unsigned char *>( m_diffuseColorArray ), m_numVertices );
			parse( 8, 1, reinterpret_cast<unsigned char *>( m_specularColorArray ), m_numVertices );
			parse( 9, 1, reinterpret_cast<unsigned char *>( m_pointSizeArray ), m_numVertices );
			for ( int texture = 0; texture < 7; ++texture ) { parse( 10 + texture, m_format.GetTextureDimension( texture ), reinterpret_cast<unsigned char *>( m_texCoordArrays[texture] ), m_numVertices ); }
		} else {
			unsigned char *storage = NULL; int stride = 0;
			if ( !LockInterleaved( 0, m_numVertices, rvVertexBufferLockFlagWrite | rvVertexBufferLockFlagEmpty, reinterpret_cast<void *&>( storage ), stride ) ) { lexer.Error( "Vertex buffer cannot be mapped for access" ); Shutdown(); return; }
			for ( int i = 0; i < m_format.m_numValues; ++i ) { tokenSubTypes[i] = m_format.m_tokenSubTypes[i]; }
			lexer.ParseNumericStructArray( m_format.m_numValues, tokenSubTypes, m_numVertices, storage );
		}
		Unlock();
		lexer.ExpectTokenString( "}" );
	} else {
		m_flags |= rvVertexBufferFlagInitiallyEmpty;
	}
	lexer.ExpectTokenString( "}" );
}
