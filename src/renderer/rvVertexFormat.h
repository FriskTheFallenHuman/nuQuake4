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

#ifndef __RENDERER_RVVERTEXFORMAT_H__
#define __RENDERER_RVVERTEXFORMAT_H__

class Lexer;

enum Rv_Vertex_Data_Type_t {
	RV_VERTEX_DATA_TYPE_NONE = 0,
	RV_VERTEX_DATA_TYPE_FLOAT,
	RV_VERTEX_DATA_TYPE_FLOAT16,
	RV_VERTEX_DATA_TYPE_INT,
	RV_VERTEX_DATA_TYPE_UINT,
	RV_VERTEX_DATA_TYPE_INTN,
	RV_VERTEX_DATA_TYPE_UINTN,
	RV_VERTEX_DATA_TYPE_COLOR,
	RV_VERTEX_DATA_TYPE_UBYTE,
	RV_VERTEX_DATA_TYPE_BYTE,
	RV_VERTEX_DATA_TYPE_UBYTEN,
	RV_VERTEX_DATA_TYPE_BYTEN,
	RV_VERTEX_DATA_TYPE_SHORT,
	RV_VERTEX_DATA_TYPE_USHORT,
	RV_VERTEX_DATA_TYPE_SHORTN,
	RV_VERTEX_DATA_TYPE_USHORTN,
	RV_VERTEX_DATA_TYPE_UDEC_10_10_10,
	RV_VERTEX_DATA_TYPE_DEC_10_10_10,
	RV_VERTEX_DATA_TYPE_UDEC_10_10_10N,
	RV_VERTEX_DATA_TYPE_DEC_10_10_10N,
	RV_VERTEX_DATA_TYPE_UDEC_10_11_11,
	RV_VERTEX_DATA_TYPE_DEC_10_11_11,
	RV_VERTEX_DATA_TYPE_UDEC_10_11_11N,
	RV_VERTEX_DATA_TYPE_DEC_10_11_11N,
	RV_VERTEX_DATA_TYPE_UDEC_11_11_10,
	RV_VERTEX_DATA_TYPE_DEC_11_11_10,
	RV_VERTEX_DATA_TYPE_UDEC_11_11_10N,
	RV_VERTEX_DATA_TYPE_DEC_11_11_10N,
	RV_NUM_VERTEX_DATA_TYPES
};

enum Rv_Vertex_Component_t {
	RV_VERTEX_COMPONENT_POSITION = 0,
	RV_VERTEX_COMPONENT_SWIZZLED_POSITION,
	RV_VERTEX_COMPONENT_BLEND_INDEX,
	RV_VERTEX_COMPONENT_BLEND_WEIGHT,
	RV_VERTEX_COMPONENT_NORMAL,
	RV_VERTEX_COMPONENT_TANGENT,
	RV_VERTEX_COMPONENT_BINORMAL,
	RV_VERTEX_COMPONENT_DIFFUSE_COLOR,
	RV_VERTEX_COMPONENT_SPECULAR_COLOR,
	RV_VERTEX_COMPONENT_POINT_SIZE,
	RV_VERTEX_COMPONENT_TEXTURE_COORDINATE_0,
	RV_NUM_VERTEX_COMPONENTS = 18
};

enum rvVertexFormatFlags {
	rvVertexFormatFlagPosition			= BIT( 0 ),
	rvVertexFormatFlagSwizzledPosition	= BIT( 1 ),
	rvVertexFormatFlagBlendIndex		= BIT( 2 ),
	rvVertexFormatFlagBlendWeight		= BIT( 3 ),
	rvVertexFormatFlagNormal			= BIT( 4 ),
	rvVertexFormatFlagTangent			= BIT( 5 ),
	rvVertexFormatFlagBinormal			= BIT( 6 ),
	rvVertexFormatFlagDiffuseColor		= BIT( 7 ),
	rvVertexFormatFlagSpecularColor	= BIT( 8 ),
	rvVertexFormatFlagPointSize			= BIT( 9 ),
	rvVertexFormatFlagTextureCoordinate	= BIT( 10 )
};

class rvVertexFormat {
	friend class rvVertexBuffer;
	friend class rvRenderModelMD5R;
public:
				rvVertexFormat();
				rvVertexFormat( unsigned int vtxFmtFlags, int posDim, int numWeights,
					int numTransforms, const int *texDimArray );
				~rvVertexFormat();

	void		Shutdown();
	void		Init( unsigned int vtxFmtFlags, int posDim, int numWeights, int numTransforms,
					const int *texDimArray, Rv_Vertex_Data_Type_t *dataTypes = NULL );
	void		Init( Lexer &lexer );
	void		Init( const rvVertexFormat &format );
	void		Write( idFile &outFile, const char *prepend );
	void		GetTokenSubTypes( Rv_Vertex_Component_t vertexComponent, int *tokenSubTypes );
	void		SetVertexDeclaration( int vertexStartOffset ) const;
	void		EnableVertexDeclaration() const;
	bool		HasSameComponents( const rvVertexFormat &format ) const;
	bool		HasSameDataTypes( const rvVertexFormat &format ) const;

	unsigned int GetFlags() const { return m_flags; }
	int			GetSize() const { return m_size; }
	int			GetNumValues() const { return m_numValues; }
	int			GetByteOffset( Rv_Vertex_Component_t component ) const { return m_byteOffset[component]; }
	Rv_Vertex_Data_Type_t GetDataType( Rv_Vertex_Component_t component ) const {
		return static_cast<Rv_Vertex_Data_Type_t>( m_dataTypes[component] );
	}
	int			GetPositionDimension() const { return m_dimensions & 7; }
	int			GetBlendWeightDimension() const { return ( m_dimensions >> 3 ) & 7; }
	int			GetNumBlendTransforms() const { return ( m_dimensions >> 6 ) & 7; }
	int			GetTextureDimension( int unit ) const { return ( m_dimensions >> ( 9 + unit * 3 ) ) & 7; }

protected:
	void		CalcSize();
	void		BuildDataTypes( Rv_Vertex_Data_Type_t *dataTypes );
	void		ParseComponentDataType( Rv_Vertex_Component_t vertexComponent,
					Rv_Vertex_Data_Type_t defaultDataType, Lexer &lexer );

	unsigned int	m_flags;
	unsigned int	m_dimensions;
	int				m_size;
	int				m_numValues;
	int				m_byteOffset[18];
	unsigned char	m_tokenSubTypes[72];
	unsigned char	m_dataTypes[18];
	unsigned int	m_glVASMask;
};

#endif
