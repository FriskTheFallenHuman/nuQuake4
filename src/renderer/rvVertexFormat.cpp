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
#include "rvVertexFormat.h"

struct rvVertexStorageDesc {
	unsigned char tokenSubType;
	unsigned char numComponents;
};

struct rvVertexFormatStorageDesc {
	unsigned int glStorage;
	unsigned int countMask;
	unsigned int countAdd;
	unsigned int compressedCount;
	bool normalized;
};

static const rvVertexStorageDesc vertexStorageDescArray[RV_NUM_VERTEX_DATA_TYPES] = {
	{ 0, 0 }, { 128, 1 }, { 65, 2 }, { 1, 1 }, { 65, 1 }, { 1, 1 }, { 65, 1 },
	{ 65, 1 }, { 65, 1 }, { 65, 1 }, { 65, 1 }, { 65, 1 }, { 65, 2 }, { 65, 2 },
	{ 65, 2 }, { 65, 2 }, { 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 },
	{ 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 }, { 65, 3 }
};

static const rvVertexFormatStorageDesc formatDescs[RV_NUM_VERTEX_DATA_TYPES] = {
	{ 0, 0, 0, 0, false },
	{ GL_FLOAT, ~0u, 0, 0, false }, { GL_FLOAT, ~1u, 1, 0, false },
	{ GL_INT, ~0u, 0, 0, false }, { GL_UNSIGNED_INT, ~0u, 0, 0, false },
	{ GL_INT, ~0u, 0, 0, true }, { GL_UNSIGNED_INT, ~0u, 0, 0, true },
	{ GL_UNSIGNED_BYTE, 0, 0, 4, true }, { GL_UNSIGNED_BYTE, 0, 0, 4, false },
	{ GL_BYTE, 0, 0, 4, false }, { GL_UNSIGNED_BYTE, 0, 0, 4, true },
	{ GL_BYTE, 0, 0, 4, true },
	{ GL_SHORT, ~1u, 1, 0, false }, { GL_UNSIGNED_SHORT, ~1u, 1, 0, false },
	{ GL_SHORT, ~1u, 1, 0, true }, { GL_UNSIGNED_SHORT, ~1u, 1, 0, true },
	{ GL_UNSIGNED_BYTE, 0, 0, 3, false }, { GL_BYTE, 0, 0, 3, false },
	{ GL_UNSIGNED_BYTE, 0, 0, 3, true }, { GL_BYTE, 0, 0, 3, true },
	{ GL_UNSIGNED_SHORT, 0, 0, 3, false }, { GL_SHORT, 0, 0, 3, false },
	{ GL_UNSIGNED_SHORT, 0, 0, 3, true }, { GL_SHORT, 0, 0, 3, true },
	{ GL_UNSIGNED_INT, 0, 0, 3, false }, { GL_INT, 0, 0, 3, false },
	{ GL_UNSIGNED_INT, 0, 0, 3, true }, { GL_INT, 0, 0, 3, true }
};

static const char *outputDataTypeStrings[RV_NUM_VERTEX_DATA_TYPES] = {
	"", "Float ", "Float16 ", "Int ", "UInt ", "IntN ", "UIntN ", "Color ",
	"UByte ", "Byte ", "UByteN ", "ByteN ", "Short ", "UShort ", "ShortN ", "UShortN ",
	"UDec_10_10_10 ", "Dec_10_10_10 ", "UDec_10_10_10N ", "Dec_10_10_10N ",
	"UDec_10_11_11 ", "Dec_10_11_11 ", "UDec_10_11_11N ", "Dec_10_11_11N ",
	"UDec_11_11_10 ", "Dec_11_11_10 ", "UDec_11_11_10N ", "Dec_11_11_10N "
};

static int VertexElementCount( int dimension, const rvVertexFormatStorageDesc &desc ) {
	return ( ~desc.countMask & desc.compressedCount ) + ( dimension & ( desc.countMask + desc.countAdd ) );
}

void rvVertexFormat::CalcSize() {
	m_size = 0;
	m_numValues = 0;
	m_glVASMask = 0;
	m_byteOffset[0] = m_byteOffset[1] = 0;
	if ( ( m_flags & rvVertexFormatFlagSwizzledPosition ) != 0 ) {
		m_size = 12;
	} else if ( ( m_flags & rvVertexFormatFlagPosition ) != 0 ) {
		const rvVertexStorageDesc &desc = vertexStorageDescArray[m_dataTypes[0]];
		for ( int remaining = GetPositionDimension(); remaining > 0; remaining -= desc.numComponents ) {
			m_tokenSubTypes[m_numValues++] = desc.tokenSubType;
			m_size += 4;
		}
		m_glVASMask |= BIT( 0 );
	}

	for ( int component = 2; component <= 9; ++component ) {
		m_byteOffset[component] = m_size;
		if ( ( m_flags & BIT( component ) ) == 0 ) { continue; }
		const rvVertexStorageDesc &desc = vertexStorageDescArray[m_dataTypes[component]];
		int dimensions = 1;
		if ( component == RV_VERTEX_COMPONENT_BLEND_INDEX || component == RV_VERTEX_COMPONENT_DIFFUSE_COLOR ||
			component == RV_VERTEX_COMPONENT_SPECULAR_COLOR ) { dimensions = 4; }
		else if ( component == RV_VERTEX_COMPONENT_BLEND_WEIGHT ) { dimensions = GetBlendWeightDimension(); }
		else if ( component == RV_VERTEX_COMPONENT_NORMAL || component == RV_VERTEX_COMPONENT_TANGENT ||
			component == RV_VERTEX_COMPONENT_BINORMAL ) { dimensions = 3; }
		for ( int remaining = dimensions; remaining > 0; remaining -= desc.numComponents ) {
			m_tokenSubTypes[m_numValues++] = desc.tokenSubType;
			m_size += 4;
		}
		static const unsigned int componentMasks[10] = {
			BIT( 0 ), 0, BIT( 17 ), BIT( 21 ), BIT( 1 ), BIT( 22 ), BIT( 23 ), BIT( 2 ), BIT( 20 ), BIT( 31 )
		};
		m_glVASMask |= componentMasks[component];
	}

	if ( ( m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int texture = 0; texture < 7; ++texture ) {
			const int component = RV_VERTEX_COMPONENT_TEXTURE_COORDINATE_0 + texture;
			m_byteOffset[component] = m_size;
			const rvVertexStorageDesc &desc = vertexStorageDescArray[m_dataTypes[component]];
			const int dimensions = GetTextureDimension( texture );
			for ( int remaining = dimensions; remaining > 0; remaining -= desc.numComponents ) {
				m_tokenSubTypes[m_numValues++] = desc.tokenSubType;
				m_size += 4;
			}
			if ( dimensions != 0 ) { m_glVASMask |= BIT( 24 + texture ); }
		}
	}
}

void rvVertexFormat::BuildDataTypes( Rv_Vertex_Data_Type_t *dataTypes ) {
	if ( ( m_flags & ( rvVertexFormatFlagPosition | rvVertexFormatFlagSwizzledPosition ) ) != 0 ) {
		m_dataTypes[0] = dataTypes != NULL && dataTypes[0] != RV_VERTEX_DATA_TYPE_NONE ? dataTypes[0] : RV_VERTEX_DATA_TYPE_FLOAT;
	}
	const Rv_Vertex_Data_Type_t defaults[10] = {
		RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_UBYTEN,
		RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT,
		RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_COLOR, RV_VERTEX_DATA_TYPE_COLOR,
		RV_VERTEX_DATA_TYPE_FLOAT
	};
	for ( int component = 2; component <= 9; ++component ) {
		if ( ( m_flags & BIT( component ) ) != 0 ) {
			m_dataTypes[component] = dataTypes != NULL && dataTypes[component] != RV_VERTEX_DATA_TYPE_NONE ?
				dataTypes[component] : defaults[component];
		}
	}
	if ( ( m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int component = 10; component < 17; ++component ) {
			m_dataTypes[component] = dataTypes != NULL && dataTypes[component] != RV_VERTEX_DATA_TYPE_NONE ?
				dataTypes[component] : RV_VERTEX_DATA_TYPE_FLOAT;
		}
	}
	CalcSize();
}

void rvVertexFormat::GetTokenSubTypes( Rv_Vertex_Component_t vertexComponent, int *tokenSubTypes ) {
	const int tokenType = vertexStorageDescArray[m_dataTypes[vertexComponent]].tokenSubType;
	for ( int i = 0; i < 4; ++i ) { tokenSubTypes[i] = tokenType; }
}

void rvVertexFormat::SetVertexDeclaration( int vertexStartOffset ) const {
	const int base = vertexStartOffset * m_size;
	if ( ( m_flags & rvVertexFormatFlagBlendIndex ) != 0 ) {
		const rvVertexFormatStorageDesc &desc = formatDescs[m_dataTypes[2]];
		qglVertexAttribPointerARB( 1, VertexElementCount( 4, desc ), desc.glStorage, desc.normalized, m_size,
			reinterpret_cast<const void *>( base + m_byteOffset[2] ) );
	}
	if ( ( m_flags & rvVertexFormatFlagBlendWeight ) != 0 ) {
		const rvVertexFormatStorageDesc &desc = formatDescs[m_dataTypes[3]];
		qglVertexAttribPointerARB( 5, VertexElementCount( GetBlendWeightDimension(), desc ), desc.glStorage,
			desc.normalized, m_size, reinterpret_cast<const void *>( base + m_byteOffset[3] ) );
	}
	if ( ( m_flags & rvVertexFormatFlagNormal ) != 0 ) {
		qglNormalPointer( formatDescs[m_dataTypes[4]].glStorage, m_size, reinterpret_cast<const void *>( base + m_byteOffset[4] ) );
	}
	const int attribComponents[] = { 5, 6, 7, 8, 9 };
	const unsigned int attribBindings[] = { 6, 7, 0, 4, 15 };
	const int attribDimensions[] = { 3, 3, 4, 4, 1 };
	for ( int i = 0; i < 5; ++i ) {
		const int component = attribComponents[i];
		if ( ( m_flags & BIT( component ) ) == 0 ) { continue; }
		const rvVertexFormatStorageDesc &desc = formatDescs[m_dataTypes[component]];
		if ( component == RV_VERTEX_COMPONENT_DIFFUSE_COLOR ) {
			qglColorPointer( VertexElementCount( 4, desc ), desc.glStorage, m_size,
				reinterpret_cast<const void *>( base + m_byteOffset[component] ) );
		} else {
			qglVertexAttribPointerARB( attribBindings[i], VertexElementCount( attribDimensions[i], desc ),
				desc.glStorage, desc.normalized, m_size, reinterpret_cast<const void *>( base + m_byteOffset[component] ) );
		}
	}
	if ( ( m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int texture = 0; texture < 7; ++texture ) {
			const int dimensions = GetTextureDimension( texture );
			if ( dimensions == 0 ) { continue; }
			const int component = 10 + texture;
			const rvVertexFormatStorageDesc &desc = formatDescs[m_dataTypes[component]];
			qglVertexAttribPointerARB( 8 + texture, VertexElementCount( dimensions, desc ), desc.glStorage,
				desc.normalized, m_size, reinterpret_cast<const void *>( base + m_byteOffset[component] ) );
		}
	}
	if ( ( m_flags & rvVertexFormatFlagPosition ) != 0 ) {
		const rvVertexFormatStorageDesc &desc = formatDescs[m_dataTypes[0]];
		qglVertexPointer( VertexElementCount( GetPositionDimension(), desc ), desc.glStorage, m_size,
			reinterpret_cast<const void *>( base + m_byteOffset[0] ) );
	}
}

void rvVertexFormat::EnableVertexDeclaration() const {
	GL_VertexAttribState( m_glVASMask );
}

bool rvVertexFormat::HasSameComponents( const rvVertexFormat &format ) const {
	if ( ( m_flags & format.m_flags ) != format.m_flags ) { return false; }
	if ( ( format.m_flags & rvVertexFormatFlagPosition ) != 0 && GetPositionDimension() != format.GetPositionDimension() ) { return false; }
	if ( ( format.m_flags & rvVertexFormatFlagBlendWeight ) != 0 && GetBlendWeightDimension() != format.GetBlendWeightDimension() ) { return false; }
	if ( ( format.m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int i = 0; i < 7; ++i ) {
			if ( format.GetTextureDimension( i ) != 0 && GetTextureDimension( i ) != format.GetTextureDimension( i ) ) { return false; }
		}
	}
	return true;
}

bool rvVertexFormat::HasSameDataTypes( const rvVertexFormat &format ) const {
	for ( int component = 0; component <= 9; ++component ) {
		if ( ( m_flags & BIT( component ) ) != 0 && m_dataTypes[component] != format.m_dataTypes[component] ) { return false; }
	}
	if ( ( m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int i = 0; i < 7; ++i ) {
			if ( format.GetTextureDimension( i ) != 0 && m_dataTypes[10 + i] != format.m_dataTypes[10 + i] ) { return false; }
		}
	}
	return true;
}

rvVertexFormat::rvVertexFormat() {
	m_flags = 0; m_dimensions = 0; m_size = 0; memset( m_byteOffset, 0, sizeof( m_byteOffset ) ); m_glVASMask = 0;
}

void rvVertexFormat::Shutdown() {
	m_flags = 0; m_dimensions = 0; m_size = 0; memset( m_byteOffset, 0, sizeof( m_byteOffset ) ); m_glVASMask = 0;
}

rvVertexFormat::~rvVertexFormat() {
	Shutdown();
}

static Rv_Vertex_Data_Type_t VertexDataTypeFromToken( const idToken &token, bool &matched ) {
	matched = false;
	for ( int i = 1; i < RV_NUM_VERTEX_DATA_TYPES; ++i ) {
		idStr name = outputDataTypeStrings[i];
		name.StripTrailingWhitespace();
		if ( !token.Icmp( name ) ) {
			matched = true;
			return static_cast<Rv_Vertex_Data_Type_t>( i );
		}
	}
	return RV_VERTEX_DATA_TYPE_NONE;
}

void rvVertexFormat::ParseComponentDataType( Rv_Vertex_Component_t vertexComponent,
	Rv_Vertex_Data_Type_t defaultDataType, Lexer &lexer ) {
	idToken token;
	lexer.ReadToken( &token );
	bool matched;
	Rv_Vertex_Data_Type_t type = VertexDataTypeFromToken( token, matched );
	if ( !matched ) {
		lexer.UnreadToken( &token );
		type = defaultDataType;
	}
	m_dataTypes[vertexComponent] = static_cast<unsigned char>( type );
}

void rvVertexFormat::Write( idFile &outFile, const char *prepend ) {
	outFile.WriteFloatString( "{ " );
	if ( ( m_flags & rvVertexFormatFlagSwizzledPosition ) != 0 ) { outFile.WriteFloatString( "Pos3Swizzled " ); }
	else if ( ( m_flags & rvVertexFormatFlagPosition ) != 0 ) { outFile.WriteFloatString( "Position %d ", GetPositionDimension() ); }
	const char *componentNames[10] = { "", "", "BlendIndex ", "BlendWeight ", "Normal ", "Tangent ", "Binormal ", "DiffuseColor ", "SpecularColor ", "PointSize " };
	const Rv_Vertex_Data_Type_t defaults[10] = { RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_UBYTEN,
		RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT, RV_VERTEX_DATA_TYPE_FLOAT,
		RV_VERTEX_DATA_TYPE_COLOR, RV_VERTEX_DATA_TYPE_COLOR, RV_VERTEX_DATA_TYPE_FLOAT };
	if ( ( m_flags & ( rvVertexFormatFlagPosition | rvVertexFormatFlagSwizzledPosition ) ) != 0 && m_dataTypes[0] != RV_VERTEX_DATA_TYPE_FLOAT ) {
		outFile.WriteFloatString( outputDataTypeStrings[m_dataTypes[0]] );
	}
	for ( int component = 2; component <= 9; ++component ) {
		if ( ( m_flags & BIT( component ) ) == 0 ) { continue; }
		if ( component == 3 ) { outFile.WriteFloatString( "BlendWeight %d %d ", GetBlendWeightDimension(), GetNumBlendTransforms() ); }
		else { outFile.WriteFloatString( componentNames[component] ); }
		if ( m_dataTypes[component] != defaults[component] ) { outFile.WriteFloatString( outputDataTypeStrings[m_dataTypes[component]] ); }
	}
	if ( ( m_flags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int texture = 0; texture < 7; ++texture ) {
			if ( GetTextureDimension( texture ) != 0 ) { outFile.WriteFloatString( "TexCoord %d %d ", GetTextureDimension( texture ), texture ); }
			if ( m_dataTypes[10 + texture] != RV_VERTEX_DATA_TYPE_FLOAT ) { outFile.WriteFloatString( outputDataTypeStrings[m_dataTypes[10 + texture]] ); }
		}
	}
	outFile.WriteFloatString( "}\n" );
}

void rvVertexFormat::Init( unsigned int vtxFmtFlags, int posDim, int numWeights, int numTransforms,
	const int *texDimArray, Rv_Vertex_Data_Type_t *dataTypes ) {
	if ( m_flags != 0 ) { Shutdown(); }
	m_flags = vtxFmtFlags;
	if ( ( vtxFmtFlags & rvVertexFormatFlagSwizzledPosition ) != 0 ) { m_flags |= rvVertexFormatFlagPosition; posDim = 3; }
	else if ( posDim > 4 ) { common->Warning( "Vertex format was initialized with an unsupported position dimension" ); }
	if ( numWeights > 4 ) { common->Warning( "Vertex format was initialized with an unsupported number of blend weights" ); }
	if ( numTransforms < 1 ) { numTransforms = 1; }
	else if ( numTransforms > numWeights + 1 ) { common->Warning( "Vertex format was initialized with an unsupported number of blend transforms" ); }
	m_dimensions = ( posDim & 7 ) | ( ( numWeights & 7 ) << 3 ) | ( ( numTransforms & 7 ) << 6 );
	if ( ( vtxFmtFlags & rvVertexFormatFlagTextureCoordinate ) != 0 ) {
		for ( int i = 0; i < 7; ++i ) {
			if ( texDimArray[i] > 4 ) { common->Warning( "Vertex format was initialized with an unsupported texture dimension" ); }
			m_dimensions |= ( texDimArray[i] & 7 ) << ( 9 + i * 3 );
		}
	}
	BuildDataTypes( dataTypes );
}

void rvVertexFormat::Init( Lexer &lexer ) {
	if ( m_flags != 0 ) { Shutdown(); }
	lexer.ExpectTokenString( "{" );
	idToken token;
	while ( lexer.ReadToken( &token ) && token.Icmp( "}" ) ) {
		int component = -1;
		Rv_Vertex_Data_Type_t defaultType = RV_VERTEX_DATA_TYPE_FLOAT;
		if ( !token.Icmp( "Position" ) ) { m_flags |= BIT( 0 ); m_dimensions |= lexer.ParseInt(); component = 0; }
		else if ( !token.Icmp( "PositionSwizzled" ) || !token.Icmp( "Pos3Swizzled" ) ) { m_flags |= BIT( 1 ); m_dimensions |= 3; component = 1; }
		else if ( !token.Icmp( "BlendIndex" ) ) { m_flags |= BIT( 2 ); component = 2; defaultType = RV_VERTEX_DATA_TYPE_UBYTEN; }
		else if ( !token.Icmp( "BlendWeight" ) ) {
			m_flags |= BIT( 3 ); const int weights = lexer.ParseInt(); int transforms = lexer.ParseInt();
			if ( weights > 4 ) { lexer.Error( "Vertex format was initialized with an unsupported number of blend weights" ); }
			if ( transforms < 1 ) { transforms = 1; } else if ( transforms > weights + 1 ) { lexer.Error( "Vertex format was initialized with an unsupported number of blend transforms" ); }
			m_dimensions |= ( weights & 7 ) << 3 | ( transforms & 7 ) << 6; component = 3;
		}
		else if ( !token.Icmp( "Normal" ) ) { m_flags |= BIT( 4 ); component = 4; }
		else if ( !token.Icmp( "Tangent" ) ) { m_flags |= BIT( 5 ); component = 5; }
		else if ( !token.Icmp( "Binormal" ) ) { m_flags |= BIT( 6 ); component = 6; }
		else if ( !token.Icmp( "DiffuseColor" ) ) { m_flags |= BIT( 7 ); component = 7; defaultType = RV_VERTEX_DATA_TYPE_COLOR; }
		else if ( !token.Icmp( "SpecularColor" ) ) { m_flags |= BIT( 8 ); component = 8; defaultType = RV_VERTEX_DATA_TYPE_COLOR; }
		else if ( !token.Icmp( "PointSize" ) ) { m_flags |= BIT( 9 ); component = 9; }
		else if ( !token.Icmp( "TexCoord" ) ) {
			m_flags |= BIT( 10 ); const int dimension = lexer.ParseInt(); const int set = lexer.ParseInt();
			if ( dimension > 4 ) { lexer.Error( "Vertex format was initialized with an unsupported texture coordinate dimension" ); }
			if ( set >= 7 ) { lexer.Error( "Vertex format was initialized with an unsupported texture coordinate set" ); }
			m_dimensions |= dimension << ( 9 + 3 * set ); component = 10 + set;
		} else { lexer.Error( "Expected vertex format keyword" ); }
		ParseComponentDataType( static_cast<Rv_Vertex_Component_t>( component ), defaultType, lexer );
	}
	CalcSize();
	if ( GetNumBlendTransforms() < 1 ) { m_dimensions |= 1 << 6; }
}

void rvVertexFormat::Init( const rvVertexFormat &format ) {
	if ( m_flags != 0 ) { Shutdown(); }
	m_flags = format.m_flags; m_dimensions = format.m_dimensions; m_size = format.m_size; m_numValues = format.m_numValues;
	memcpy( m_byteOffset, format.m_byteOffset, sizeof( m_byteOffset ) );
	memcpy( m_tokenSubTypes, format.m_tokenSubTypes, sizeof( m_tokenSubTypes ) );
	memcpy( m_dataTypes, format.m_dataTypes, sizeof( m_dataTypes ) );
	m_glVASMask = format.m_glVASMask;
}

rvVertexFormat::rvVertexFormat( unsigned int vtxFmtFlags, int posDim, int numWeights,
	int numTransforms, const int *texDimArray ) {
	m_flags = 0; m_dimensions = 0; m_size = 0; memset( m_byteOffset, 0, sizeof( m_byteOffset ) ); m_glVASMask = 0;
	Init( vtxFmtFlags, posDim, numWeights, numTransforms, texDimArray, NULL );
}
