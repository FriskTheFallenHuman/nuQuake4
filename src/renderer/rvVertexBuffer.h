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

#ifndef __RENDERER_RVVERTEXBUFFER_H__
#define __RENDERER_RVVERTEXBUFFER_H__

#include "rvVertexFormat.h"

class Lexer;

enum rvVertexBufferFlags {
	rvVertexBufferFlagSystemMemory				= BIT( 0 ),
	rvVertexBufferFlagVideoMemory				= BIT( 1 ),
	rvVertexBufferFlagSoA						= BIT( 2 ),
	rvVertexBufferFlagDynamicStream			= BIT( 3 ),
	rvVertexBufferFlagInitiallyEmpty			= BIT( 4 ),
	rvVertexBufferFlagWriteLoadFormatAsPrimary	= BIT( 5 ),
	rvVertexBufferFlagUsageDraw					= BIT( 6 ),
	rvVertexBufferFlagUsageShadow				= BIT( 7 ),
	rvVertexBufferFlagUsageSilTrace				= BIT( 8 ),
	rvVertexBufferFlagUsageExplicitShadow		= BIT( 9 )
};

enum rvVertexBufferLockFlags {
	rvVertexBufferLockFlagRead	= BIT( 0 ),
	rvVertexBufferLockFlagWrite	= BIT( 1 ),
	rvVertexBufferLockFlagEmpty	= BIT( 2 )
};

class rvVertexBuffer {
friend class rvRenderModelMD5R;
public:
				rvVertexBuffer();
				~rvVertexBuffer();

	void		Init( const rvVertexFormat &vertexFormat, int numVertices, unsigned int flagMask );
	void		Init( Lexer &lexer );
	void		Shutdown();
	void		Resize( int numVertices );
	void		SetupForRender( int vertexStartOffset, const rvVertexFormat &formatNeeded );
	void		SetLoadFormat( const rvVertexFormat &loadFormat );
	void		Unlock();

	bool		LockPosition( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					  unsigned char *&positionPtr, int &stride );
	bool		LockBlendIndex( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					unsigned char *&blendIndexPtr, int &stride );
	bool		LockBlendWeight( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					 unsigned char *&blendWeightPtr, int &stride );
	bool		LockNormal( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					unsigned char *&normalPtr, int &stride );
	bool		LockTangent( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					 unsigned char *&tangentPtr, int &stride );
	bool		LockBinormal( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
					  unsigned char *&binormalPtr, int &stride );
	bool		LockDiffuseColor( int vertexBufferOffset, int numVerticesToLock, unsigned int lockFlags,
						unsigned char *&diffuseColorPtr, int &stride );
	bool		LockTextureCoordinate( int textureCoordinate, int vertexBufferOffset,
						int numVerticesToLock, unsigned int lockFlags,
						unsigned char *&textureCoordinatePtr, int &stride );

	void		CopyData( int destVertexOffset, int numVertices, const unsigned char *srcPtr,
					  int srcStride, const rvVertexFormat &srcFormat, const unsigned int *copyMapping );
	void		CopyData( unsigned char *destPtr, int destStride, const rvVertexFormat &destFormat,
					  int srcVertexOffset, int numVertices, const unsigned int *copyMapping );
	void		CopyRemappedData( int vertexBufferOffset, int numVertices, unsigned int *copyMapping,
						  unsigned int *transformMapOldToNew, rvBlend4DrawVert *srcVertData,
						  bool absBlendWeights );
	void		CopyRemappedShadowVolData( int vertexBufferOffset, int numVertices,
						  unsigned int *copyMapping, unsigned int *transformMapOldToNew,
						  rvBlend4DrawVert *srcVertData );
	int			CopySilTraceData( unsigned int *indexMapping, int vertexBufferOffset,
					  int numVertices, int *copyMapping, const idDrawVert *srcVertData );
	void		CopyData( int vertexBufferOffset, int numVertices, const idDrawVert *srcVertData );
	void		CopyRemappedShadowVolData( int vertexBufferOffset, int numVertices,
						  int *copyMapping, const idDrawVert *srcVertData );
	void		CopyShadowVolData( int vertexBufferOffset, int numVertices, shadowCache_t *srcVertData );
	void		Write( idFile &outFile, const char *prepend );

	static void ComponentCopy( unsigned char *destPtr, int destStride,
		Rv_Vertex_Data_Type_t destDataType, int destDimension,
		const unsigned char *srcPtr, int srcStride, Rv_Vertex_Data_Type_t srcDataType,
		int srcDimension, int numVertices, const unsigned int *copyMapping,
		float *transform, bool normalize );

	const rvVertexFormat &GetFormat() const { return m_format; }
	int			GetNumVertices() const { return m_numVertices; }
	int			GetNumVerticesWritten() const { return m_numVerticesWritten; }
	unsigned int GetBufferId() const { return m_vbID; }
	bool		IsInitiallyEmpty() const { return ( m_flags & rvVertexBufferFlagInitiallyEmpty ) != 0; }
	bool		IsSystemMemory() const { return ( m_flags & rvVertexBufferFlagSystemMemory ) != 0; }
	rvSilTraceVertT *GetSilTraceVertexArray( int vertexOffset );

protected:
	void		ResetValues();
	void		CreateVertexStorage();
	bool		LockInterleaved( int vertexOffset, int numVerticesToLock, unsigned int lockFlags,
						 void *&startPtr, int &stride );
	void		TransferSoAToAoS( unsigned char *vertexDest );

	rvVertexFormat	m_format;
	rvVertexFormat	m_loadFormat;
	unsigned int	m_flags;
	unsigned int	m_lockStatus;
	int				m_numVertices;
	unsigned int	m_vbID;
	int				m_lockVertexOffset;
	int				m_lockVertexCount;
	unsigned char *m_lockedBase;
	int				m_numVerticesWritten;
	unsigned char *m_interleavedStorage;
	float			*m_positionArray;
	float			*m_swizzledPositionArray;
	unsigned int	*m_blendIndexArray;
	float			*m_blendWeightArray;
	float			*m_normalArray;
	float			*m_tangentArray;
	float			*m_binormalArray;
	unsigned int	*m_diffuseColorArray;
	unsigned int	*m_specularColorArray;
	float			*m_pointSizeArray;
	float			*m_texCoordArrays[7];
};

#endif
