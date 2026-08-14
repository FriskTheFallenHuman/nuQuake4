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

#ifndef __RV_TEX_RENDER_TARGET_H__
#define __RV_TEX_RENDER_TARGET_H__

enum rvTexRenderTargetFlags {
	rvTexRenderTargetFlagDepthStencil = 1,
	rvTexRenderTargetFlagFloatingPoint = 2,
	rvTexRenderTargetFlagCubeMap = 4,
	rvTexRenderTargetFlagMipMap = 8
};

class rvTexRenderTarget {
public:
	rvTexRenderTarget();
	~rvTexRenderTarget();

	bool	Init( int resWidth, int resHeight, int numColorBits, int numRedBits,
			  int numGreenBits, int numBlueBits, int numAlphaBits,
			  int numDepthBits, int numStencilBits, int flags );
	void	Release();
	bool	Restore();
	void	BeginRender( int cubeFace );
	void	EndRender( bool restorePreviousDC );
	void	BeginTexture( unsigned int textureObjName, int minFilter, int magFilter, int wrap );
	void	EndTexture();
	void	DefaultD3GL();

private:
	void	ResetValues();

	HPBUFFERARB	m_hPBuffer;
	HDC			m_hDC;
	HGLRC		m_hGLRC;
	unsigned int m_textureObjName;
	int			m_resWidth;
	int			m_resWidthSave;
	int			m_resHeight;
	int			m_resHeightSave;
	int			m_flags;
	int			m_flagsSave;
	unsigned int m_target;
	unsigned char m_numColorBits;
	unsigned char m_numColorBitsSave;
	unsigned char m_numRedBits;
	unsigned char m_numRedBitsSave;
	unsigned char m_numGreenBits;
	unsigned char m_numGreenBitsSave;
	unsigned char m_numBlueBits;
	unsigned char m_numBlueBitsSave;
	unsigned char m_numAlphaBits;
	unsigned char m_numAlphaBitsSave;
	unsigned char m_numDepthBits;
	unsigned char m_numDepthBitsSave;
	unsigned char m_numStencilBits;
	unsigned char m_numStencilBitsSave;

	static unsigned int m_prevReadBuffer;
	static unsigned int m_prevDrawBuffer;
	static int	m_prevViewport[4];
	static HDC	m_hPrevDC;
	static HGLRC m_hPrevGLRC;
};

#endif
