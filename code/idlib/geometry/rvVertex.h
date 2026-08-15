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

//
// rvVertex.h - Describes some commonly used vertices (alternatives to the idDrawVert)
// Date: 1/10/05
// Created by: Dwight Luetscher - Raven Software
//

#ifndef __RV_VERTEX_H__
#define __RV_VERTEX_H__

//
// rvBlend4DrawVert
//
// a vertex that is used to communicate data to drawing vertices stored in vertex buffers
//
class rvBlend4DrawVert {
public:
	idVec3			xyz;
	int				blendIndex[4];			
	float			blendWeight[4];		// NOTE: the vertex stored in the actual buffer that is actually used for drawing may leave out the last weight (implied 1 - sum of other weights)
	idVec3			normal;
	idVec3			tangent;
	idVec3			binormal;
	byte			color[4];			// diffuse color, [0] red, [1] green, [2] blue, [3] alpha
	idVec2			st;
};

//
// rvSilTraceVertT
//
// a transformed vert that typically resides in system-memory and is used for operations
// like silhouette determination and trace testing
//
class rvSilTraceVertT {
public:
	idVec4			xyzw;

	float			operator[]( const int index ) const;
	float &			operator[]( const int index );

	void			Clear( void );

	void			Lerp( const rvSilTraceVertT &a, const rvSilTraceVertT &b, const float f );
	void			LerpAll( const rvSilTraceVertT &a, const rvSilTraceVertT &b, const float f );
};

#define SILTRACEVERT_SIZE_SHIFT			4
#define SILTRACEVERT_SIZE				(1 << SILTRACEVERT_SIZE_SHIFT)
#define SILTRACEVERT_XYZW_OFFSET		0

assert_sizeof( rvSilTraceVertT,			SILTRACEVERT_SIZE );
assert_sizeof( rvSilTraceVertT,			(1<<SILTRACEVERT_SIZE_SHIFT) );
assert_offsetof( rvSilTraceVertT, xyzw,	SILTRACEVERT_XYZW_OFFSET );

ID_INLINE float rvSilTraceVertT::operator[]( const int index ) const 
{
	assert( index >= 0 && index < 4 );
	return ((float *)(&xyzw))[index];
}

ID_INLINE float	&rvSilTraceVertT::operator[]( const int index ) 
{
	assert( index >= 0 && index < 4 );
	return ((float *)(&xyzw))[index];
}

ID_INLINE void rvSilTraceVertT::Clear( void ) 
{
	xyzw.Zero();
}

ID_INLINE void rvSilTraceVertT::Lerp( const rvSilTraceVertT &a, const rvSilTraceVertT &b, const float f ) 
{
	xyzw = a.xyzw + f * ( b.xyzw - a.xyzw );
}

ID_INLINE void rvSilTraceVertT::LerpAll( const rvSilTraceVertT &a, const rvSilTraceVertT &b, const float f ) 
{
	xyzw = a.xyzw + f * ( b.xyzw - a.xyzw );
}

#endif	// #ifndef __RV_VERTEX_H__
