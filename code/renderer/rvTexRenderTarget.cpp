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
#include "rvTexRenderTarget.h"

// Retail compilation unit: rvTexRenderTarget.obj.

// WGL_ARB_pixel_format, WGL_ARB_pbuffer, WGL_ARB_render_texture, and
// WGL_NV_float_buffer constants used by the retail implementation.  qgl.h
// intentionally declares the entry points without importing wglext.h.
enum {
	WGL_SUPPORT_OPENGL_ARB_Q4 = 0x2010,
	WGL_COLOR_BITS_ARB_Q4 = 0x2014,
	WGL_RED_BITS_ARB_Q4 = 0x2015,
	WGL_GREEN_BITS_ARB_Q4 = 0x2017,
	WGL_BLUE_BITS_ARB_Q4 = 0x2019,
	WGL_ALPHA_BITS_ARB_Q4 = 0x201B,
	WGL_DEPTH_BITS_ARB_Q4 = 0x2022,
	WGL_STENCIL_BITS_ARB_Q4 = 0x2023,
	WGL_BIND_TO_TEXTURE_RGB_ARB_Q4 = 0x2070,
	WGL_BIND_TO_TEXTURE_RGBA_ARB_Q4 = 0x2071,
	WGL_TEXTURE_FORMAT_ARB_Q4 = 0x2072,
	WGL_TEXTURE_TARGET_ARB_Q4 = 0x2073,
	WGL_MIPMAP_TEXTURE_ARB_Q4 = 0x2074,
	WGL_TEXTURE_RGB_ARB_Q4 = 0x2075,
	WGL_TEXTURE_RGBA_ARB_Q4 = 0x2076,
	WGL_TEXTURE_2D_ARB_Q4 = 0x207A,
	WGL_TEXTURE_CUBE_MAP_ARB_Q4 = 0x2078,
	WGL_CUBE_MAP_FACE_ARB_Q4 = 0x207C,
	WGL_FRONT_LEFT_ARB_Q4 = 0x2083,
	WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV_Q4 = 0x20A0,
	WGL_BIND_TO_TEXTURE_RECTANGLE_RGBA_NV_Q4 = 0x20A1,
	WGL_TEXTURE_RECTANGLE_NV_Q4 = 0x20A2,
	WGL_FLOAT_COMPONENTS_NV_Q4 = 0x20B0,
	WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV_Q4 = 0x20B1,
	WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RG_NV_Q4 = 0x20B2,
	WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGB_NV_Q4 = 0x20B3,
	WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_RGBA_NV_Q4 = 0x20B4,
	WGL_TEXTURE_FLOAT_R_NV_Q4 = 0x20B5,
	WGL_TEXTURE_FLOAT_RG_NV_Q4 = 0x20B6,
	WGL_TEXTURE_FLOAT_RGB_NV_Q4 = 0x20B7,
	WGL_TEXTURE_FLOAT_RGBA_NV_Q4 = 0x20B8
};

unsigned int rvTexRenderTarget::m_prevReadBuffer;
unsigned int rvTexRenderTarget::m_prevDrawBuffer;
int rvTexRenderTarget::m_prevViewport[4];
HDC rvTexRenderTarget::m_hPrevDC;
HGLRC rvTexRenderTarget::m_hPrevGLRC;

void rvTexRenderTarget::ResetValues() {
	m_hPBuffer = NULL;
	m_hDC = NULL;
	m_hPrevDC = NULL;
	m_textureObjName = 0;
	m_resWidth = 0;
	m_resHeight = 0;
	m_flags = 0;
	m_numRedBits = 0;
	m_numGreenBits = 0;
	m_numBlueBits = 0;
	m_numAlphaBits = 0;
	m_numDepthBits = 0;
	m_numStencilBits = 0;
	m_target = GL_TEXTURE_2D;
}

rvTexRenderTarget::rvTexRenderTarget() {
	ResetValues();
}

rvTexRenderTarget::~rvTexRenderTarget() {
	Release();
}

bool rvTexRenderTarget::Init( int resWidth, int resHeight, int numColorBits,
		int numRedBits, int numGreenBits, int numBlueBits, int numAlphaBits,
		int numDepthBits, int numStencilBits, int flags ) {
	HDC hdc = qwglGetCurrentDC();
	HGLRC glRC = qwglGetCurrentContext();
	int pixelFormatIndex = 0;
	UINT formatCount = 0;
	int attributePairs[24];
	int attributeIndex = 0;

	attributePairs[attributeIndex++] = WGL_SUPPORT_OPENGL_ARB_Q4;
	attributePairs[attributeIndex++] = TRUE;

	if ( flags & rvTexRenderTargetFlagFloatingPoint ) {
		attributePairs[attributeIndex++] = WGL_FLOAT_COMPONENTS_NV_Q4;
		attributePairs[attributeIndex++] = TRUE;
		attributePairs[attributeIndex++] = WGL_BIND_TO_TEXTURE_RECTANGLE_FLOAT_R_NV_Q4
			+ ( numAlphaBits ? 3 : numBlueBits ? 2 : numGreenBits ? 1 : 0 );
		attributePairs[attributeIndex++] = TRUE;
	} else {
		const int bindBase = ( flags & ( rvTexRenderTargetFlagCubeMap | rvTexRenderTargetFlagMipMap ) )
			? WGL_BIND_TO_TEXTURE_RGB_ARB_Q4
			: WGL_BIND_TO_TEXTURE_RECTANGLE_RGB_NV_Q4;
		attributePairs[attributeIndex++] = bindBase + ( numAlphaBits != 0 );
		attributePairs[attributeIndex++] = TRUE;
	}

	attributePairs[attributeIndex++] = WGL_COLOR_BITS_ARB_Q4;
	attributePairs[attributeIndex++] = numColorBits;
	attributePairs[attributeIndex++] = WGL_RED_BITS_ARB_Q4;
	attributePairs[attributeIndex++] = numRedBits;
	attributePairs[attributeIndex++] = WGL_GREEN_BITS_ARB_Q4;
	attributePairs[attributeIndex++] = numGreenBits;
	attributePairs[attributeIndex++] = WGL_BLUE_BITS_ARB_Q4;
	attributePairs[attributeIndex++] = numBlueBits;
	attributePairs[attributeIndex++] = WGL_ALPHA_BITS_ARB_Q4;
	attributePairs[attributeIndex++] = numAlphaBits;

	if ( flags & rvTexRenderTargetFlagDepthStencil ) {
		attributePairs[attributeIndex++] = WGL_DEPTH_BITS_ARB_Q4;
		attributePairs[attributeIndex++] = numDepthBits;
		attributePairs[attributeIndex++] = WGL_STENCIL_BITS_ARB_Q4;
		attributePairs[attributeIndex++] = numStencilBits;
	}
	attributePairs[attributeIndex++] = 0;
	attributePairs[attributeIndex] = 0;

	if ( !qwglChoosePixelFormatARB( hdc, attributePairs, NULL, 1, &pixelFormatIndex, &formatCount ) ) {
		common->Warning( "qwglChoosePixelFormatARB() failed, last error %x\n", GetLastError() );
		return false;
	}
	if ( formatCount == 0 ) {
		common->Warning( "qwglChoosePixelFormatARB() couldn't find any matches\n" );
		return false;
	}

	attributeIndex = 0;
	attributePairs[attributeIndex++] = WGL_TEXTURE_TARGET_ARB_Q4;
	if ( flags & rvTexRenderTargetFlagCubeMap ) {
		attributePairs[attributeIndex++] = WGL_TEXTURE_CUBE_MAP_ARB_Q4;
		m_target = GL_TEXTURE_CUBE_MAP_ARB;
	} else if ( flags & rvTexRenderTargetFlagMipMap ) {
		attributePairs[attributeIndex++] = WGL_TEXTURE_2D_ARB_Q4;
		m_target = GL_TEXTURE_2D;
	} else {
		attributePairs[attributeIndex++] = WGL_TEXTURE_RECTANGLE_NV_Q4;
		m_target = GL_TEXTURE_RECTANGLE_NV;
	}

	attributePairs[attributeIndex++] = WGL_TEXTURE_FORMAT_ARB_Q4;
	if ( flags & rvTexRenderTargetFlagFloatingPoint ) {
		attributePairs[attributeIndex++] = WGL_TEXTURE_FLOAT_R_NV_Q4
			+ ( numAlphaBits ? 3 : numBlueBits ? 2 : numGreenBits ? 1 : 0 );
	} else {
		attributePairs[attributeIndex++] = WGL_TEXTURE_RGB_ARB_Q4 + ( numAlphaBits != 0 );
	}
	if ( flags & rvTexRenderTargetFlagMipMap ) {
		attributePairs[attributeIndex++] = WGL_MIPMAP_TEXTURE_ARB_Q4;
		attributePairs[attributeIndex++] = TRUE;
	}
	attributePairs[attributeIndex++] = 0;
	attributePairs[attributeIndex] = 0;

	m_hPBuffer = qwglCreatePbufferARB( hdc, pixelFormatIndex, resWidth, resHeight, attributePairs );
	if ( !m_hPBuffer ) {
		common->Warning( "qwglCreatePbufferARB() failed, last error %x\n", GetLastError() );
		return false;
	}

	m_hDC = qwglGetPbufferDCARB( m_hPBuffer );
	if ( m_hDC ) {
		m_hGLRC = qwglCreateContext( m_hDC );
		if ( m_hGLRC ) {
			if ( !glRC || qwglShareLists( glRC, m_hGLRC ) ) {
				m_flagsSave = m_flags = flags;
				m_numColorBitsSave = m_numColorBits = static_cast<unsigned char>( numColorBits );
				m_numRedBitsSave = m_numRedBits = static_cast<unsigned char>( numRedBits );
				m_numGreenBitsSave = m_numGreenBits = static_cast<unsigned char>( numGreenBits );
				m_numBlueBitsSave = m_numBlueBits = static_cast<unsigned char>( numBlueBits );
				m_numAlphaBitsSave = m_numAlphaBits = static_cast<unsigned char>( numAlphaBits );
				m_numDepthBitsSave = m_numDepthBits = static_cast<unsigned char>( numDepthBits );
				m_numStencilBitsSave = m_numStencilBits = static_cast<unsigned char>( numStencilBits );
				m_resWidthSave = m_resWidth = resWidth;
				m_resHeightSave = m_resHeight = resHeight;
				return true;
			}
			common->Warning( "qwglShareLists() couldn't share display list resources\n" );
			qwglDeleteContext( m_hGLRC );
		}
		qwglReleasePbufferDCARB( m_hPBuffer, m_hDC );
	}

	qwglDestroyPbufferARB( m_hPBuffer );
	ResetValues();
	return false;
}

void rvTexRenderTarget::Release() {
	if ( m_hPBuffer ) {
		if ( m_hDC ) {
			if ( m_hGLRC ) {
				qwglDeleteContext( m_hGLRC );
			}
			qwglReleasePbufferDCARB( m_hPBuffer, m_hDC );
		}
		qwglDestroyPbufferARB( m_hPBuffer );
	}
	ResetValues();
}

bool rvTexRenderTarget::Restore() {
	return Init( m_resWidthSave, m_resHeightSave, m_numColorBitsSave,
		m_numRedBitsSave, m_numGreenBitsSave, m_numBlueBitsSave,
		m_numAlphaBitsSave, m_numDepthBitsSave, m_numStencilBitsSave, m_flagsSave );
}

void rvTexRenderTarget::BeginRender( int cubeFace ) {
	if ( m_textureObjName ) {
		qwglReleaseTexImageARB( m_hPBuffer, WGL_FRONT_LEFT_ARB_Q4 );
		m_textureObjName = 0;
	}

	if ( !m_hPrevDC && !m_hPrevGLRC ) {
		m_hPrevDC = qwglGetCurrentDC();
		m_hPrevGLRC = qwglGetCurrentContext();
		qglGetIntegerv( GL_DRAW_BUFFER, reinterpret_cast<int *>( &m_prevDrawBuffer ) );
		qglGetIntegerv( GL_READ_BUFFER, reinterpret_cast<int *>( &m_prevReadBuffer ) );
		qglGetIntegerv( GL_VIEWPORT, m_prevViewport );
	}

	if ( m_flags & rvTexRenderTargetFlagCubeMap ) {
		int attributePairs[4] = { WGL_CUBE_MAP_FACE_ARB_Q4, cubeFace, 0, 0 };
		qwglSetPbufferAttribARB( m_hPBuffer, attributePairs );
	}

	if ( !qwglMakeCurrent( m_hDC, m_hGLRC ) ) {
		common->FatalError( "qwglMakeCurrent(m_hDC, m_hGLRC) failed, last error %x\n", GetLastError() );
	}
	qglDrawBuffer( GL_FRONT_LEFT );
	qglReadBuffer( GL_FRONT_LEFT );
	qglViewport( 0, 0, m_resWidth, m_resHeight );
}

void rvTexRenderTarget::EndRender( bool restorePreviousDC ) {
	if ( restorePreviousDC ) {
		if ( !qwglMakeCurrent( m_hPrevDC, m_hPrevGLRC ) ) {
			common->FatalError( "qwglMakeCurrent(m_hPrevDC, m_hPrevGLRC) failed, last error %x\n", GetLastError() );
		}
		qglDrawBuffer( m_prevDrawBuffer );
		qglReadBuffer( m_prevReadBuffer );
		qglViewport( m_prevViewport[0], m_prevViewport[1], m_prevViewport[2], m_prevViewport[3] );
		m_hPrevDC = NULL;
		m_hPrevGLRC = NULL;
	}
}

void rvTexRenderTarget::BeginTexture( unsigned int textureObjName, int minFilter,
		int magFilter, int wrap ) {
	if ( m_textureObjName ) {
		qwglReleaseTexImageARB( m_hPBuffer, WGL_FRONT_LEFT_ARB_Q4 );
		m_textureObjName = 0;
	}
	qglBindTexture( m_target, textureObjName );
	qglTexParameteri( m_target, GL_TEXTURE_MIN_FILTER, minFilter );
	qglTexParameteri( m_target, GL_TEXTURE_MAG_FILTER, magFilter );
	qglTexParameteri( m_target, GL_TEXTURE_WRAP_S, wrap );
	qglTexParameteri( m_target, GL_TEXTURE_WRAP_T, wrap );
	qwglBindTexImageARB( m_hPBuffer, WGL_FRONT_LEFT_ARB_Q4 );
	m_textureObjName = textureObjName;
}

void rvTexRenderTarget::EndTexture() {
	qwglReleaseTexImageARB( m_hPBuffer, WGL_FRONT_LEFT_ARB_Q4 );
	m_textureObjName = 0;
}

void rvTexRenderTarget::DefaultD3GL() {
	BeginRender( 0 );
	qglClearDepth( 1.0 );
	qglClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	qglEnable( GL_DEPTH_TEST );
	qglDisable( GL_ALPHA_TEST );
	qglDepthFunc( GL_LEQUAL );
	qglMatrixMode( GL_MODELVIEW );
	qglLoadIdentity();
	qglMatrixMode( GL_PROJECTION );
	qglLoadIdentity();
	qglEnableClientState( GL_VERTEX_ARRAY );
	qglDisableClientState( GL_NORMAL_ARRAY );
	qglEnableClientState( GL_TEXTURE_COORD_ARRAY );
	qglDisableClientState( GL_COLOR_ARRAY );
	qglShadeModel( GL_SMOOTH );
	qglCullFace( GL_BACK );
	qglEnable( GL_CULL_FACE );
	qglDisable( GL_BLEND );
	qglDisable( GL_LIGHTING );
	qglDisable( GL_TEXTURE_2D );
	EndRender( true );
}
