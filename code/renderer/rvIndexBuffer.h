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

#ifndef __RENDERER_RVINDEXBUFFER_H__
#define __RENDERER_RVINDEXBUFFER_H__

class Lexer;

enum rvIndexBufferFlags {
	rvIndexBufferFlagSystemMemory	= BIT( 0 ),
	rvIndexBufferFlagVideoMemory	= BIT( 1 ),
	rvIndexBufferFlag16Bit			= BIT( 2 ),
	rvIndexBufferFlagDynamicStream	= BIT( 3 )
};

enum rvIndexBufferLockFlags {
	rvIndexBufferLockFlagRead	= BIT( 0 ),
	rvIndexBufferLockFlagWrite	= BIT( 1 ),
	rvIndexBufferLockFlagEmpty	= BIT( 2 )
};

class rvIndexBuffer {
public:
				rvIndexBuffer();
				~rvIndexBuffer();

	void		Init( int numIndices, unsigned int flagMask );
	void		Init( Lexer &lexer );
	void		Shutdown();
	void		Resize( int numIndices );
	bool		Lock( int indexOffset, int numIndicesToLock, unsigned int lockFlags, void *&indexPtr );
	void		Unlock();
	void		CopyRemappedData( int indexBufferOffset, int numIndices, unsigned int *indexMapping,
				int *indices, unsigned int indexBase );
	void		CopyData( int indexBufferOffset, int numIndices, int *indices, unsigned int indexBase );
	void		Write( idFile &outFile, const char *prepend );

	int			GetNumIndices() const { return m_numIndices; }
	int			GetNumIndicesWritten() const { return m_numIndicesWritten; }
	unsigned int GetBufferId() const { return m_ibID; }
	bool		Is16Bit() const { return ( m_flags & rvIndexBufferFlag16Bit ) != 0; }
	bool		IsVideoMemory() const { return ( m_flags & rvIndexBufferFlagVideoMemory ) != 0; }

protected:
	void		CreateIndexStorage();

	unsigned int	m_flags;
	unsigned int	m_lockStatus;
	int				m_numIndices;
	unsigned int	m_ibID;
	int				m_lockIndexOffset;
	int				m_lockIndexCount;
	unsigned char *m_lockedBase;
	unsigned char *m_systemMemStorage;
	int				m_numIndicesWritten;
};

#endif
