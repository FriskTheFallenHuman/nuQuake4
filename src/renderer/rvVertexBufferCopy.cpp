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

// Retail compilation unit: rvVertexBufferCopy.obj.

static ID_INLINE unsigned int SourceVertex( const unsigned int *copyMapping, int vertex ) {
	return copyMapping != NULL ? copyMapping[vertex] : vertex;
}

static unsigned short FloatToHalf( float value ) {
	unsigned int bits;
	memcpy( &bits, &value, sizeof( bits ) );
	const unsigned int sign = ( bits >> 16 ) & 0x8000;
	int exponent = static_cast<int>( ( bits >> 23 ) & 0xFF ) - 127 + 15;
	unsigned int mantissa = bits & 0x7FFFFF;
	if ( exponent <= 0 ) {
		if ( exponent < -10 ) { return static_cast<unsigned short>( sign ); }
		mantissa = ( mantissa | 0x800000 ) >> ( 1 - exponent );
		return static_cast<unsigned short>( sign | ( ( mantissa + 0x1000 ) >> 13 ) );
	}
	if ( exponent >= 31 ) { return static_cast<unsigned short>( sign | 0x7C00 ); }
	return static_cast<unsigned short>( sign | ( exponent << 10 ) | ( ( mantissa + 0x1000 ) >> 13 ) );
}

static float HalfToFloat( unsigned short value ) {
	const unsigned int sign = static_cast<unsigned int>( value & 0x8000 ) << 16;
	unsigned int exponent = ( value >> 10 ) & 0x1F;
	unsigned int mantissa = value & 0x3FF;
	unsigned int bits;
	if ( exponent == 0 ) {
		if ( mantissa == 0 ) { bits = sign; }
		else {
			int unbiased = -14;
			while ( ( mantissa & 0x400 ) == 0 ) { mantissa <<= 1; --unbiased; }
			mantissa &= 0x3FF;
			bits = sign | static_cast<unsigned int>( unbiased + 127 ) << 23 | mantissa << 13;
		}
	} else if ( exponent == 31 ) {
		bits = sign | 0x7F800000 | mantissa << 13;
	} else {
		bits = sign | ( exponent - 15 + 127 ) << 23 | mantissa << 13;
	}
	float result;
	memcpy( &result, &bits, sizeof( result ) );
	return result;
}

static void ConvertFloat16PairToFloat( float *destFloats, unsigned int float16Pair ) {
	destFloats[0] = HalfToFloat( static_cast<unsigned short>( float16Pair ) );
	destFloats[1] = HalfToFloat( static_cast<unsigned short>( float16Pair >> 16 ) );
}

static void ConvertFloatToFloat16Pair( unsigned int &float16Pair, const float *srcFloats ) {
	float16Pair = FloatToHalf( srcFloats[0] ) | static_cast<unsigned int>( FloatToHalf( srcFloats[1] ) ) << 16;
}

static void rvVtxCopyFloatToFloat( unsigned char *destPtr, int destStride,
		int destNumValuesPerComponent, const unsigned char *srcPtr, int srcStride,
		int srcNumValuesPerComponent, int numComponents, const unsigned int *copyMapping,
		const float *srcTailPtr, bool absFlag ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		const float *src = reinterpret_cast<const float *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		const int commonValues = Min( destNumValuesPerComponent, srcNumValuesPerComponent );
		for ( int value = 0; value < commonValues; ++value ) { dest[value] = absFlag ? idMath::Fabs( src[value] ) : src[value]; }
		for ( int value = commonValues; value < destNumValuesPerComponent; ++value ) { dest[value] = srcTailPtr != NULL ? srcTailPtr[value - commonValues] : 0.0f; }
	}
}

static void rvVtxCopyFloatToInt( unsigned char *destPtr, int destStride,
		int destNumValuesPerComponent, const unsigned char *srcPtr, int srcStride,
		int srcNumValuesPerComponent, int numComponents, const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		int *dest = reinterpret_cast<int *>( destPtr + vertex * destStride );
		const float *src = reinterpret_cast<const float *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		for ( int value = 0; value < destNumValuesPerComponent; ++value ) { dest[value] = value < srcNumValuesPerComponent ? static_cast<int>( src[value] ) : 0; }
	}
}

static void rvVtxCopyIntToFloat( unsigned char *destPtr, int destStride,
		int destNumValuesPerComponent, const unsigned char *srcPtr, int srcStride,
		int srcNumValuesPerComponent, int numComponents, const unsigned int *copyMapping,
		const float *srcTailPtr ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		const int *src = reinterpret_cast<const int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		for ( int value = 0; value < destNumValuesPerComponent; ++value ) { dest[value] = value < srcNumValuesPerComponent ? static_cast<float>( src[value] ) : ( srcTailPtr != NULL ? srcTailPtr[value - srcNumValuesPerComponent] : 0.0f ); }
	}
}

static void rvVtxCopyIntToInt( unsigned char *destPtr, int destStride,
		int destNumValuesPerComponent, const unsigned char *srcPtr, int srcStride,
		int srcNumValuesPerComponent, int numComponents, const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		int *dest = reinterpret_cast<int *>( destPtr + vertex * destStride );
		const int *src = reinterpret_cast<const int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		for ( int value = 0; value < destNumValuesPerComponent; ++value ) { dest[value] = value < srcNumValuesPerComponent ? src[value] : 0; }
	}
}

static void rvVtxCopyDWordToDWord( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		*reinterpret_cast<unsigned int *>( destPtr + vertex * destStride ) =
			*reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
	}
}

static void rvVtxCopyFloatToDec16Pair( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *destScales,
		const unsigned int *destMasks, const int *destShifts, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const float *src = reinterpret_cast<const float *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		unsigned int packed = 0;
		for ( int value = 0; value < 2; ++value ) { packed |= ( static_cast<unsigned int>( static_cast<int>( idMath::Ftob( src[value] * destScales[value] ) ) ) << destShifts[value] ) & destMasks[value]; }
		*reinterpret_cast<unsigned int *>( destPtr + vertex * destStride ) = packed;
	}
}

static void rvVtxCopyDec16PairToFloat( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *srcScales,
		const unsigned int *srcMasks, const int *srcShifts, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const unsigned int packed = *reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		for ( int value = 0; value < 2; ++value ) { dest[value] = static_cast<float>( ( packed & srcMasks[value] ) >> srcShifts[value] ) * srcScales[value]; }
	}
}

static void rvVtxCopySignedDec16PairToFloat( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *srcScales,
		const unsigned int *srcMasks, const int *srcShifts, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const unsigned int packed = *reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		for ( int value = 0; value < 2; ++value ) { const short decoded = static_cast<short>( ( packed & srcMasks[value] ) >> srcShifts[value] ); dest[value] = decoded * srcScales[value]; }
	}
}

static void rvVtxCopyFloatToFloat16Pair( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		ConvertFloatToFloat16Pair( *reinterpret_cast<unsigned int *>( destPtr + vertex * destStride ),
			reinterpret_cast<const float *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride ) );
	}
}

static void rvVtxCopyFloat16PairToFloat( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		ConvertFloat16PairToFloat( reinterpret_cast<float *>( destPtr + vertex * destStride ),
			*reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride ) );
	}
}

static void rvVtxCopyFloatToDecTriple( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *destScales,
		const unsigned int *destMasks, const int *destShifts, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const float *src = reinterpret_cast<const float *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		unsigned int packed = 0;
		for ( int value = 0; value < 3; ++value ) { packed |= ( static_cast<unsigned int>( static_cast<int>( src[value] * destScales[value] ) ) << destShifts[value] ) & destMasks[value]; }
		*reinterpret_cast<unsigned int *>( destPtr + vertex * destStride ) = packed;
	}
}

static void rvVtxCopyDecTripleToFloat( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *srcScales,
		const unsigned int *srcMasks, const int *srcShifts, int numComponents,
		const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const unsigned int packed = *reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		for ( int value = 0; value < 3; ++value ) { dest[value] = static_cast<float>( ( packed & srcMasks[value] ) >> srcShifts[value] ) * srcScales[value]; }
	}
}

static void rvVtxCopySignedDecTripleToFloat( unsigned char *destPtr, int destStride,
		const unsigned char *srcPtr, int srcStride, const float *srcScales,
		const int *srcLeftShifts, const int *srcShifts, const unsigned int *srcMasks,
		int numComponents, const unsigned int *copyMapping ) {
	for ( int vertex = 0; vertex < numComponents; ++vertex ) {
		const unsigned int packed = *reinterpret_cast<const unsigned int *>( srcPtr + SourceVertex( copyMapping, vertex ) * srcStride );
		float *dest = reinterpret_cast<float *>( destPtr + vertex * destStride );
		for ( int value = 0; value < 3; ++value ) {
			const int decoded = static_cast<int>( ( packed & srcMasks[value] ) << srcLeftShifts[value] ) >> ( srcLeftShifts[value] + srcShifts[value] );
			dest[value] = decoded * srcScales[value];
		}
	}
}

static const unsigned int mask16Bit[2] = { 0x0000FFFFu, 0xFFFF0000u };
static const int shift16Bit[2] = { 0, 16 };
static const float scaleOne2[2] = { 1.0f, 1.0f };
static const float scaleOne3[3] = { 1.0f, 1.0f, 1.0f };
static const float scale32767[2] = { 32767.0f, 32767.0f };
static const float scale65535[2] = { 65535.0f, 65535.0f };
static const float scaleInv32767[2] = { 1.0f / 32767.0f, 1.0f / 32767.0f };
static const float scaleInv65535[2] = { 1.0f / 65535.0f, 1.0f / 65535.0f };

struct PackedTripleDesc {
	unsigned int masks[3];
	int shifts[3];
	int leftShifts[3];
	float signedScale[3];
	float unsignedScale[3];
	float signedInvScale[3];
	float unsignedInvScale[3];
};

static const PackedTripleDesc packed10_10_10 = {
	{ 0x000003FFu, 0x000FFC00u, 0x3FF00000u }, { 0, 10, 20 }, { 22, 12, 2 },
	{ 511.0f, 511.0f, 511.0f }, { 1023.0f, 1023.0f, 1023.0f },
	{ 1.0f / 511.0f, 1.0f / 511.0f, 1.0f / 511.0f },
	{ 1.0f / 1023.0f, 1.0f / 1023.0f, 1.0f / 1023.0f }
};
static const PackedTripleDesc packed10_11_11 = {
	{ 0x000003FFu, 0x001FFC00u, 0xFFE00000u }, { 0, 10, 21 }, { 22, 11, 0 },
	{ 511.0f, 1023.0f, 1023.0f }, { 1023.0f, 2047.0f, 2047.0f },
	{ 1.0f / 511.0f, 1.0f / 1023.0f, 1.0f / 1023.0f },
	{ 1.0f / 1023.0f, 1.0f / 2047.0f, 1.0f / 2047.0f }
};
static const PackedTripleDesc packed11_11_10 = {
	{ 0x000007FFu, 0x003FF800u, 0xFFC00000u }, { 0, 11, 22 }, { 21, 10, 0 },
	{ 1023.0f, 1023.0f, 511.0f }, { 2047.0f, 2047.0f, 1023.0f },
	{ 1.0f / 1023.0f, 1.0f / 1023.0f, 1.0f / 511.0f },
	{ 1.0f / 2047.0f, 1.0f / 2047.0f, 1.0f / 1023.0f }
};

static const PackedTripleDesc &PackedDescForType( Rv_Vertex_Data_Type_t type ) {
	if ( type >= RV_VERTEX_DATA_TYPE_UDEC_11_11_10 ) { return packed11_11_10; }
	if ( type >= RV_VERTEX_DATA_TYPE_UDEC_10_11_11 ) { return packed10_11_11; }
	return packed10_10_10;
}

static void CopyPackedByteComponent( unsigned char *destPtr, int destStride,
		Rv_Vertex_Data_Type_t destType, const unsigned char *srcPtr, int srcStride,
		Rv_Vertex_Data_Type_t srcType, int srcDimension, int numVertices,
		const unsigned int *copyMapping ) {
	const bool destSigned = destType == RV_VERTEX_DATA_TYPE_BYTE || destType == RV_VERTEX_DATA_TYPE_BYTEN;
	const bool destNormalized = destType == RV_VERTEX_DATA_TYPE_COLOR || destType == RV_VERTEX_DATA_TYPE_UBYTEN || destType == RV_VERTEX_DATA_TYPE_BYTEN;
	for ( int vertex = 0; vertex < numVertices; ++vertex ) {
		unsigned char *dest = destPtr + vertex * destStride;
		const unsigned char *source = srcPtr + SourceVertex( copyMapping, vertex ) * srcStride;
		if ( srcType == RV_VERTEX_DATA_TYPE_FLOAT ) {
			const float *src = reinterpret_cast<const float *>( source );
			for ( int value = 0; value < 4; ++value ) {
				const float input = value < srcDimension ? src[value] : ( value == 3 ? 1.0f : 0.0f );
				const float scale = destNormalized ? ( destSigned ? 127.0f : 255.0f ) : 1.0f;
				if ( destSigned ) { reinterpret_cast<signed char *>( dest )[value] = static_cast<signed char>( idMath::ClampInt( -128, 127, static_cast<int>( input * scale ) ) ); }
				else { dest[value] = static_cast<unsigned char>( idMath::ClampInt( 0, 255, static_cast<int>( input * scale ) ) ); }
			}
		} else { memcpy( dest, source, 4 ); }
	}
}

void rvVertexBuffer::ComponentCopy( unsigned char *destPtr, int destStride,
		Rv_Vertex_Data_Type_t destDataType, int destNumValuesPerComponent,
		const unsigned char *srcPtr, int srcStride, Rv_Vertex_Data_Type_t srcDataType,
		int srcNumValuesPerComponent, int numComponents, const unsigned int *copyMapping,
		float *srcTailPtr, bool absFlag ) {
	if ( destDataType == RV_VERTEX_DATA_TYPE_FLOAT ) {
		switch ( srcDataType ) {
			case RV_VERTEX_DATA_TYPE_FLOAT:
				rvVtxCopyFloatToFloat( destPtr, destStride, destNumValuesPerComponent, srcPtr, srcStride, srcNumValuesPerComponent, numComponents, copyMapping, srcTailPtr, absFlag ); return;
			case RV_VERTEX_DATA_TYPE_FLOAT16:
				rvVtxCopyFloat16PairToFloat( destPtr, destStride, srcPtr, srcStride, numComponents, copyMapping );
				if ( srcNumValuesPerComponent == 4 ) { rvVtxCopyFloat16PairToFloat( destPtr + 8, destStride, srcPtr + 4, srcStride, numComponents, copyMapping ); } return;
			case RV_VERTEX_DATA_TYPE_INT:
			case RV_VERTEX_DATA_TYPE_UINT:
			case RV_VERTEX_DATA_TYPE_INTN:
			case RV_VERTEX_DATA_TYPE_UINTN:
				rvVtxCopyIntToFloat( destPtr, destStride, destNumValuesPerComponent, srcPtr, srcStride, srcNumValuesPerComponent, numComponents, copyMapping, srcTailPtr ); return;
			case RV_VERTEX_DATA_TYPE_SHORT:
				rvVtxCopySignedDec16PairToFloat( destPtr, destStride, srcPtr, srcStride, scaleOne2, mask16Bit, shift16Bit, numComponents, copyMapping ); break;
			case RV_VERTEX_DATA_TYPE_USHORT:
				rvVtxCopyDec16PairToFloat( destPtr, destStride, srcPtr, srcStride, scaleOne2, mask16Bit, shift16Bit, numComponents, copyMapping ); break;
			case RV_VERTEX_DATA_TYPE_SHORTN:
				rvVtxCopySignedDec16PairToFloat( destPtr, destStride, srcPtr, srcStride, scaleInv32767, mask16Bit, shift16Bit, numComponents, copyMapping ); break;
			case RV_VERTEX_DATA_TYPE_USHORTN:
				rvVtxCopyDec16PairToFloat( destPtr, destStride, srcPtr, srcStride, scaleInv65535, mask16Bit, shift16Bit, numComponents, copyMapping ); break;
			default:
				if ( srcDataType >= RV_VERTEX_DATA_TYPE_UDEC_10_10_10 ) {
					const PackedTripleDesc &desc = PackedDescForType( srcDataType );
					const bool signedType = ( static_cast<int>( srcDataType ) & 1 ) != 0;
					const bool normalized = srcDataType == RV_VERTEX_DATA_TYPE_UDEC_10_10_10N || srcDataType == RV_VERTEX_DATA_TYPE_DEC_10_10_10N || srcDataType == RV_VERTEX_DATA_TYPE_UDEC_10_11_11N || srcDataType == RV_VERTEX_DATA_TYPE_DEC_10_11_11N || srcDataType == RV_VERTEX_DATA_TYPE_UDEC_11_11_10N || srcDataType == RV_VERTEX_DATA_TYPE_DEC_11_11_10N;
					if ( signedType ) { rvVtxCopySignedDecTripleToFloat( destPtr, destStride, srcPtr, srcStride, normalized ? desc.signedInvScale : scaleOne3, desc.leftShifts, desc.shifts, desc.masks, numComponents, copyMapping ); }
					else { rvVtxCopyDecTripleToFloat( destPtr, destStride, srcPtr, srcStride, normalized ? desc.unsignedInvScale : scaleOne3, desc.masks, desc.shifts, numComponents, copyMapping ); }
					return;
				}
				CopyPackedByteComponent( destPtr, destStride, RV_VERTEX_DATA_TYPE_UBYTE, srcPtr, srcStride, srcDataType, srcNumValuesPerComponent, numComponents, copyMapping ); return;
		}
		if ( srcNumValuesPerComponent == 4 ) {
			if ( srcDataType == RV_VERTEX_DATA_TYPE_SHORT || srcDataType == RV_VERTEX_DATA_TYPE_SHORTN ) { rvVtxCopySignedDec16PairToFloat( destPtr + 8, destStride, srcPtr + 4, srcStride, srcDataType == RV_VERTEX_DATA_TYPE_SHORTN ? scaleInv32767 : scaleOne2, mask16Bit, shift16Bit, numComponents, copyMapping ); }
			else { rvVtxCopyDec16PairToFloat( destPtr + 8, destStride, srcPtr + 4, srcStride, srcDataType == RV_VERTEX_DATA_TYPE_USHORTN ? scaleInv65535 : scaleOne2, mask16Bit, shift16Bit, numComponents, copyMapping ); }
		}
		return;
	}

	if ( destDataType == RV_VERTEX_DATA_TYPE_FLOAT16 ) {
		if ( srcDataType == RV_VERTEX_DATA_TYPE_FLOAT ) {
			rvVtxCopyFloatToFloat16Pair( destPtr, destStride, srcPtr, srcStride, numComponents, copyMapping );
			if ( srcNumValuesPerComponent == 4 ) { rvVtxCopyFloatToFloat16Pair( destPtr + 4, destStride, srcPtr + 8, srcStride, numComponents, copyMapping ); }
		} else { rvVtxCopyDWordToDWord( destPtr, destStride, srcPtr, srcStride, numComponents, copyMapping ); }
		return;
	}

	if ( destDataType == RV_VERTEX_DATA_TYPE_INT || destDataType == RV_VERTEX_DATA_TYPE_UINT || destDataType == RV_VERTEX_DATA_TYPE_INTN || destDataType == RV_VERTEX_DATA_TYPE_UINTN ) {
		if ( srcDataType == RV_VERTEX_DATA_TYPE_FLOAT ) { rvVtxCopyFloatToInt( destPtr, destStride, destNumValuesPerComponent, srcPtr, srcStride, srcNumValuesPerComponent, numComponents, copyMapping ); }
		else { rvVtxCopyIntToInt( destPtr, destStride, destNumValuesPerComponent, srcPtr, srcStride, srcNumValuesPerComponent, numComponents, copyMapping ); }
		return;
	}

	if ( destDataType >= RV_VERTEX_DATA_TYPE_COLOR && destDataType <= RV_VERTEX_DATA_TYPE_BYTEN ) {
		CopyPackedByteComponent( destPtr, destStride, destDataType, srcPtr, srcStride, srcDataType, srcNumValuesPerComponent, numComponents, copyMapping );
		return;
	}

	if ( destDataType >= RV_VERTEX_DATA_TYPE_SHORT && destDataType <= RV_VERTEX_DATA_TYPE_USHORTN ) {
		if ( srcDataType == RV_VERTEX_DATA_TYPE_FLOAT ) {
			const float *scale = destDataType == RV_VERTEX_DATA_TYPE_SHORTN ? scale32767 : destDataType == RV_VERTEX_DATA_TYPE_USHORTN ? scale65535 : scaleOne2;
			rvVtxCopyFloatToDec16Pair( destPtr, destStride, srcPtr, srcStride, scale, mask16Bit, shift16Bit, numComponents, copyMapping );
			if ( srcNumValuesPerComponent == 4 ) { rvVtxCopyFloatToDec16Pair( destPtr + 4, destStride, srcPtr + 8, srcStride, scale, mask16Bit, shift16Bit, numComponents, copyMapping ); }
		} else {
			rvVtxCopyDWordToDWord( destPtr, destStride, srcPtr, srcStride, numComponents, copyMapping );
			if ( srcNumValuesPerComponent == 4 ) { rvVtxCopyDWordToDWord( destPtr + 4, destStride, srcPtr + 4, srcStride, numComponents, copyMapping ); }
		}
		return;
	}

	if ( destDataType >= RV_VERTEX_DATA_TYPE_UDEC_10_10_10 ) {
		if ( srcDataType == RV_VERTEX_DATA_TYPE_FLOAT ) {
			const PackedTripleDesc &desc = PackedDescForType( destDataType );
			const bool signedType = ( static_cast<int>( destDataType ) & 1 ) != 0;
			const bool normalized = destDataType == RV_VERTEX_DATA_TYPE_UDEC_10_10_10N || destDataType == RV_VERTEX_DATA_TYPE_DEC_10_10_10N || destDataType == RV_VERTEX_DATA_TYPE_UDEC_10_11_11N || destDataType == RV_VERTEX_DATA_TYPE_DEC_10_11_11N || destDataType == RV_VERTEX_DATA_TYPE_UDEC_11_11_10N || destDataType == RV_VERTEX_DATA_TYPE_DEC_11_11_10N;
			const float *scale = normalized ? ( signedType ? desc.signedScale : desc.unsignedScale ) : scaleOne3;
			rvVtxCopyFloatToDecTriple( destPtr, destStride, srcPtr, srcStride, scale, desc.masks, desc.shifts, numComponents, copyMapping );
		} else { rvVtxCopyDWordToDWord( destPtr, destStride, srcPtr, srcStride, numComponents, copyMapping ); }
	}
}
