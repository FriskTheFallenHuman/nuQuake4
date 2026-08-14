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
#include "rvIndexBuffer.h"

void rvIndexBuffer::CreateIndexStorage() {
	const int indexSize = ( m_flags & rvIndexBufferFlag16Bit ) != 0 ? 2 : 4;
	if ( ( m_flags & rvIndexBufferFlagSystemMemory ) != 0 ) {
		m_systemMemStorage = static_cast<unsigned char *>( Mem_Alloc16( indexSize * m_numIndices, MA_RENDER ) );
		if ( m_systemMemStorage == NULL ) {
			common->FatalError( "Ran out of memory trying to allocate system memory index storage" );
			return;
		}
	}

	if ( ( m_flags & rvIndexBufferFlagVideoMemory ) != 0 ) {
		qglGenBuffersARB( 1, &m_ibID );
		if ( m_ibID == 0 ) {
			common->FatalError( "rvIndexBuffer: Unable to gen index buffer id" );
			return;
		}
		if ( ( m_flags & rvIndexBufferFlagDynamicStream ) == 0 ) {
			qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, m_ibID );
			qglBufferDataARB( GL_ELEMENT_ARRAY_BUFFER_ARB, indexSize * m_numIndices, NULL, GL_STATIC_DRAW_ARB );
			if ( qglGetError() != GL_NO_ERROR ) {
				common->FatalError( "Unable to allocate index storage" );
			}
			qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
		}
	}
}

rvIndexBuffer::rvIndexBuffer() {
	m_flags = 0;
	m_lockStatus = 0;
	m_numIndices = 0;
	m_ibID = 0;
	m_lockIndexOffset = 0;
	m_lockIndexCount = 0;
	m_lockedBase = NULL;
	m_systemMemStorage = NULL;
	m_numIndicesWritten = 0;
}

bool rvIndexBuffer::Lock( int indexOffset, int numIndicesToLock, unsigned int lockFlags, void *&indexPtr ) {
	m_lockIndexOffset = indexOffset;
	m_lockIndexCount = numIndicesToLock != 0 ? numIndicesToLock : m_numIndices - indexOffset;
	const int indexSize = ( m_flags & rvIndexBufferFlag16Bit ) != 0 ? 2 : 4;

	if ( ( m_flags & rvIndexBufferFlagSystemMemory ) != 0 ) {
		m_lockedBase = m_systemMemStorage;
	} else {
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, m_ibID );
		unsigned int access = GL_READ_WRITE_ARB;
		if ( ( lockFlags & rvIndexBufferLockFlagRead ) != 0 ) {
			access = ( lockFlags & rvIndexBufferLockFlagWrite ) != 0 ? GL_READ_WRITE_ARB : GL_READ_ONLY_ARB;
		} else if ( ( lockFlags & rvIndexBufferLockFlagWrite ) != 0 ) {
			access = GL_WRITE_ONLY_ARB;
			const unsigned int usage = ( m_flags & rvIndexBufferFlagDynamicStream ) != 0 ? GL_STREAM_DRAW_ARB : GL_STATIC_DRAW_ARB;
			if ( ( m_flags & rvIndexBufferFlagDynamicStream ) != 0 ) {
				lockFlags |= rvIndexBufferLockFlagEmpty;
			}
			if ( ( lockFlags & rvIndexBufferLockFlagEmpty ) != 0 ) {
				m_lockIndexOffset = 0;
				qglBufferDataARB( GL_ELEMENT_ARRAY_BUFFER_ARB, indexSize * m_lockIndexCount, NULL, usage );
			}
		}
		m_lockedBase = static_cast<unsigned char *>( qglMapBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, access ) );
		if ( m_lockedBase == NULL ) {
			return false;
		}
	}

	m_lockStatus = lockFlags;
	indexPtr = m_lockedBase + indexSize * m_lockIndexOffset;
	return true;
}

void rvIndexBuffer::Unlock() {
	const bool wrote = ( m_lockStatus & rvIndexBufferLockFlagWrite ) != 0;
	if ( wrote ) {
		if ( ( m_lockStatus & rvIndexBufferLockFlagEmpty ) != 0 ) {
			m_numIndicesWritten = m_lockIndexCount;
		} else {
			m_numIndicesWritten += m_lockIndexCount;
		}
	}

	const int indexSize = ( m_flags & rvIndexBufferFlag16Bit ) != 0 ? 2 : 4;
	if ( ( m_flags & rvIndexBufferFlagSystemMemory ) != 0 ) {
		if ( wrote && ( m_flags & rvIndexBufferFlagVideoMemory ) != 0 ) {
			const int byteOffset = indexSize * m_lockIndexOffset;
			qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, m_ibID );
			qglBufferSubDataARB( GL_ELEMENT_ARRAY_BUFFER_ARB, byteOffset,
				indexSize * m_lockIndexCount, m_systemMemStorage + byteOffset );
			qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
		}
	} else if ( ( m_flags & rvIndexBufferFlagVideoMemory ) != 0 ) {
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, m_ibID );
		qglUnmapBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB );
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	}

	m_lockStatus = 0;
	m_lockIndexOffset = 0;
	m_lockIndexCount = 0;
	m_lockedBase = NULL;
}

void rvIndexBuffer::CopyRemappedData( int indexBufferOffset, int numIndices, unsigned int *indexMapping,
	int *indices, unsigned int indexBase ) {
	if ( indexBufferOffset + numIndices > m_numIndices ) {
		common->Warning( "rvIndexBuffer: attempt to copy index data out-of-bounds" );
		return;
	}
	void *destination = NULL;
	if ( !Lock( indexBufferOffset, numIndices, rvIndexBufferLockFlagWrite, destination ) ) {
		return;
	}
	if ( ( m_flags & rvIndexBufferFlag16Bit ) != 0 ) {
		unsigned short *out = static_cast<unsigned short *>( destination );
		for ( int i = 0; i < numIndices; ++i ) { out[i] = static_cast<unsigned short>( indexBase + indexMapping[indices[i]] ); }
	} else {
		unsigned int *out = static_cast<unsigned int *>( destination );
		for ( int i = 0; i < numIndices; ++i ) { out[i] = indexBase + indexMapping[indices[i]]; }
	}
	Unlock();
}

void rvIndexBuffer::CopyData( int indexBufferOffset, int numIndices, int *indices, unsigned int indexBase ) {
	if ( indexBufferOffset + numIndices > m_numIndices ) {
		common->Warning( "rvIndexBuffer: attempt to copy index data out-of-bounds" );
		return;
	}
	void *destination = NULL;
	if ( !Lock( indexBufferOffset, numIndices, rvIndexBufferLockFlagWrite, destination ) ) {
		return;
	}
	if ( ( m_flags & rvIndexBufferFlag16Bit ) != 0 ) {
		unsigned short *out = static_cast<unsigned short *>( destination );
		for ( int i = 0; i < numIndices; ++i ) { out[i] = static_cast<unsigned short>( indexBase + indices[i] ); }
	} else {
		unsigned int *out = static_cast<unsigned int *>( destination );
		for ( int i = 0; i < numIndices; ++i ) { out[i] = indexBase + indices[i]; }
	}
	Unlock();
}

void rvIndexBuffer::Write( idFile &outFile, const char *prepend ) {
	idStr indent = prepend;
	outFile.WriteFloatString( "%sIndexBuffer\n%s{\n", prepend, prepend );
	indent += "\t";
	if ( ( m_flags & rvIndexBufferFlagSystemMemory ) != 0 ) { outFile.WriteFloatString( "%sSystemMemory\n", indent.c_str() ); }
	if ( ( m_flags & rvIndexBufferFlagVideoMemory ) != 0 ) { outFile.WriteFloatString( "%sVideoMemory\n", indent.c_str() ); }
	outFile.WriteFloatString( "%sIndex[ %d ]\n%s{\n%s\t", indent.c_str(), m_numIndicesWritten, indent.c_str(), indent.c_str() );
	void *base = NULL;
	if ( !Lock( 0, m_numIndicesWritten, rvIndexBufferLockFlagRead, base ) ) {
		common->FatalError( "Index buffer cannot be mapped for access" );
		return;
	}
	for ( int i = 0; i < m_numIndicesWritten; ++i ) {
		const unsigned int value = ( m_flags & rvIndexBufferFlag16Bit ) != 0 ?
			static_cast<unsigned short *>( base )[i] : static_cast<unsigned int *>( base )[i];
		outFile.WriteFloatString( "%d ", value );
		if ( ( i & 15 ) == 15 ) { outFile.WriteFloatString( "\n%s\t", indent.c_str() ); }
	}
	outFile.WriteFloatString( "\n" );
	Unlock();
	outFile.WriteFloatString( "%s}\n%s}\n", indent.c_str(), prepend );
}

void rvIndexBuffer::Shutdown() {
	if ( m_lockStatus != 0 ) { Unlock(); }
	if ( m_systemMemStorage != NULL ) { Mem_Free16( m_systemMemStorage ); }
	if ( m_ibID != 0 ) { qglDeleteBuffersARB( 1, &m_ibID ); }
	m_ibID = 0;
	m_flags = 0;
	m_lockStatus = 0;
	m_numIndices = 0;
	m_lockIndexOffset = 0;
	m_lockIndexCount = 0;
	m_lockedBase = NULL;
	m_systemMemStorage = NULL;
	m_numIndicesWritten = 0;
}

void rvIndexBuffer::Resize( int numIndices ) {
	if ( numIndices == m_numIndices || ( m_flags & rvIndexBufferFlagSystemMemory ) == 0 ) {
		return;
	}
	const int indexSize = ( m_flags & rvIndexBufferFlag16Bit ) != 0 ? 2 : 4;
	const int copyCount = Min( m_numIndices, numIndices );
	unsigned char *newStorage = static_cast<unsigned char *>( Mem_Alloc16( indexSize * numIndices, MA_RENDER ) );
	if ( newStorage == NULL ) {
		common->FatalError( "Ran out of memory trying to allocate system memory index storage" );
		Shutdown();
		return;
	}
	SIMDProcessor->Memcpy( newStorage, m_systemMemStorage, indexSize * copyCount );
	Mem_Free16( m_systemMemStorage );
	m_systemMemStorage = newStorage;
	if ( ( m_flags & rvIndexBufferFlagVideoMemory ) != 0 ) {
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, m_ibID );
		qglBufferDataARB( GL_ELEMENT_ARRAY_BUFFER_ARB, indexSize * numIndices, m_systemMemStorage, GL_STATIC_DRAW_ARB );
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	}
	m_numIndices = numIndices;
}

rvIndexBuffer::~rvIndexBuffer() {
	Shutdown();
}

void rvIndexBuffer::Init( int numIndices, unsigned int flagMask ) {
	if ( m_flags != 0 ) { Shutdown(); }
	m_numIndices = numIndices;
	m_flags = flagMask;
	CreateIndexStorage();
}

void rvIndexBuffer::Init( Lexer &lexer ) {
	if ( m_flags != 0 ) { Shutdown(); }
	lexer.ExpectTokenString( "{" );
	m_flags = 0;
	idToken token;
	while ( lexer.ReadToken( &token ) ) {
		if ( !token.Icmp( "SystemMemory" ) ) { m_flags |= rvIndexBufferFlagSystemMemory; }
		else if ( !token.Icmp( "VideoMemory" ) ) { m_flags |= rvIndexBufferFlagVideoMemory; }
		else { break; }
	}
	if ( m_flags == 0 ) { m_flags = rvIndexBufferFlagVideoMemory; }
	if ( !token.Icmp( "BitDepth" ) ) {
		if ( lexer.ParseInt() == 16 ) { m_flags |= rvIndexBufferFlag16Bit; }
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "Index" ) ) { lexer.Error( "Expected index header" ); }
	lexer.ExpectTokenString( "[" );
	m_numIndices = lexer.ParseInt();
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	if ( m_numIndices <= 0 ) { lexer.Error( "Invalid index count" ); }
	CreateIndexStorage();
	void *base = NULL;
	if ( !Lock( 0, m_numIndices, rvIndexBufferLockFlagWrite | rvIndexBufferLockFlagEmpty, base ) ) {
		lexer.Error( "Index buffer cannot be mapped for access" );
		Shutdown();
		return;
	}
	if ( ( m_flags & rvIndexBufferFlag16Bit ) != 0 ) {
		unsigned short *out = static_cast<unsigned short *>( base );
		for ( int i = 0; i < m_numIndices; ++i ) { out[i] = static_cast<unsigned short>( lexer.ParseInt() ); }
	} else {
		unsigned int *out = static_cast<unsigned int *>( base );
		for ( int i = 0; i < m_numIndices; ++i ) { out[i] = lexer.ParseInt(); }
	}
	Unlock();
	lexer.ExpectTokenString( "}" );
	lexer.ExpectTokenString( "}" );
}
