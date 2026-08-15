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
//
// Quake 4 off-screen special effects reconstructed from quake4.pdb.

#ifndef __RENDERER_RVSPECIAL_H__
#define __RENDERER_RVSPECIAL_H__

class idMaterial;
class idPBufferImage;
class rvNewShaderStage;
struct drawSurf_s;
struct drawSurfsCommand_s;
typedef struct drawSurfsCommand_s drawSurfsCommand_t;
struct viewDef_s;
struct viewEntity_s;

class rvBlurTexture {
public:
					rvBlurTexture();

	static bool	CreateBuffer( const char *name, idPBufferImage **image );
	void		Render( drawSurfsCommand_t *drawSurfs );
	void		Display( viewEntity_s *viewEnts, bool prePass );

	idPBufferImage *mDepthImage;
	idPBufferImage *mBlurImage[2];
	const idMaterial *mDepthMaterial;
	float *		regs;
	float		shaderParms[12];
};

class rvAL {
public:
					rvAL();

	static bool	CreateBuffer( const char *name, idPBufferImage **image );
	void		Render( drawSurfsCommand_t *drawSurfs );
	void		DrawLight( const idVec3 &origin, float size, const idVec3 &color );
	void		Display( viewEntity_s *viewEnts, bool prePass );

private:
	rvNewShaderStage *mainStage;
	int			mLightLocParm;
	int			mLightColorParm;
	int			mLightSizeParm;
	int			mLightMinDistanceParm;

public:
	idPBufferImage *mDepthImage;
	idPBufferImage *mBlurImage[2];
	const idMaterial *mDepthMaterial;
	idVec3		lOrigin[100];
	idVec3		lColor[100];
	float		lSize[100];
	float		offset;
	int			count;
	float *		regs;
	float		shaderParms[12];
};

void RB_RestoreDrawingView();
void R_AddSpecialEffects( viewDef_s *parms );
void RB_T_FillDepthTexture( const drawSurf_s *surf );
void RB_T_FillDepthTextureAL( const drawSurf_s *surf );
void RB_SetGL2D2();
void R_ShutdownSpecialEffects();
void RB_DrawDepthTexture( const void *data );
void RB_DisplaySpecialEffects( viewEntity_s *viewEnts, bool prePass );

#endif
