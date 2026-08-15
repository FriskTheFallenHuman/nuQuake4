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
#include "rvMesh.h"

#include "cg_explicit.h"

CGcontext cg_context;

static const int texDimArray[7] = { 2, 0, 0, 0, 0, 0, 0 };
rvVertexFormat supportedMD5RVertexFormats[3] = {
	rvVertexFormat( 0x4BD, 3, 3, 4, texDimArray ),
	rvVertexFormat( 0x4F5, 3, 0, 1, texDimArray ),
	rvVertexFormat( 0x4F1, 4, 0, 1, texDimArray )
};
rvVertexFormat supportedMD5RDepthVertexFormats[3] = {
	rvVertexFormat( 0x0D, 3, 3, 4, NULL ),
	rvVertexFormat( 0x05, 3, 0, 1, NULL ),
	rvVertexFormat( 0x01, 4, 0, 1, NULL )
};
rvVertexFormat supportedMD5RShadowVolVertexFormats[3] = {
	rvVertexFormat( 0x0D, 4, 3, 4, NULL ),
	rvVertexFormat( 0x05, 3, 0, 1, NULL ),
	rvVertexFormat( 0x01, 4, 0, 1, NULL )
};
idMat4 colorMatrix;

/*
=========================================================================================

GENERAL INTERACTION RENDERING

=========================================================================================
*/

/*
====================
GL_SelectTextureNoClient
====================
*/
static __forceinline void GL_SelectTextureNoClient( int unit ) {
	backEnd.glState.currenttmu = unit;
	qglActiveTextureARB( GL_TEXTURE0_ARB + unit );
	RB_LogComment( "glActiveTextureARB( %i )\n", unit );
}

void RB_ARB2_LoadMVPMatrixIntoVPParams( const drawSurf_t *surf ) {
	if ( backEnd.mvpSpace != surf->space ) {
		myGlMultMatrix( surf->space->modelViewMatrix, backEnd.projectionMatrix,
			backEnd.modelViewProjection );
		backEnd.mvpSpace = surf->space;
	}
	float parm[4];
	for ( int column = 0; column < 4; ++column ) {
		for ( int row = 0; row < 4; ++row ) {
			parm[row] = backEnd.modelViewProjection[column + row * 4];
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 75 + column, parm );
	}
}

void RB_ARB2_LoadProjectionMatrixIntoVPParams( const drawSurf_t *surf ) {
	(void)surf;
	float parm[4];
	for ( int column = 0; column < 4; ++column ) {
		for ( int row = 0; row < 4; ++row ) {
			parm[row] = backEnd.projectionMatrix[column + row * 4];
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 81 + column, parm );
	}
}

void RB_ARB2_LoadShaderTextureMatrixIntoVPParams( const float *shaderRegisters,
		const textureStage_t *texture ) {
	float matrix[16];
	float parm[4];
	RB_GetShaderTextureMatrix( shaderRegisters, texture, matrix );
	for ( int column = 0; column < 2; ++column ) {
		for ( int row = 0; row < 4; ++row ) {
			parm[row] = matrix[column + row * 4];
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 85 + column, parm );
	}
}

void RB_ARB2_LoadModelMatrixIntoVPParams( const drawSurf_t *surf ) {
	float parm[4];
	for ( int column = 0; column < 3; ++column ) {
		for ( int row = 0; row < 4; ++row ) {
			parm[row] = surf->space->modelMatrix[column + row * 4];
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 87 + column, parm );
	}
}

void RB_ARB2_LoadModelViewMatrixIntoVPParams( const drawSurf_t *surf ) {
	float parm[4];
	for ( int column = 0; column < 3; ++column ) {
		for ( int row = 0; row < 4; ++row ) {
			parm[row] = surf->space->modelViewMatrix[column + row * 4];
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 87 + column, parm );
	}
}

void RB_ARB2_LoadLocalViewOriginIntoVPParams( const drawSurf_t *surf ) {
	idVec4 parm;
	R_GlobalPointToLocal( surf->space->modelMatrix,
		backEnd.viewDef->renderView.vieworg, parm.ToVec3() );
	parm[3] = 1.0f;
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 80, parm.ToFloatPtr() );
}

void RB_ARB2_MD5R_DrawDepthElements( const drawSurf_t *surf ) {
	rvMesh *mesh = surf->geo->primBatchMesh;
	const rvVertexFormat *drawFormat = mesh->GetDrawVertexBufferFormat();
	int formatIndex;
	for ( formatIndex = 0; formatIndex < 3; ++formatIndex ) {
		if ( drawFormat->HasSameComponents( supportedMD5RDepthVertexFormats[formatIndex] ) ) {
			break;
		}
	}
	if ( formatIndex == 3 ) {
		return;
	}
	const rvVertexFormat *format = &supportedMD5RDepthVertexFormats[formatIndex];
	qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 24 + formatIndex );
	qglEnable( GL_VERTEX_PROGRAM_ARB );
	RB_ARB2_LoadMVPMatrixIntoVPParams( surf );
	mesh->SetupForDrawRender( format );
	GL_DisableVertexAttribState( 4 );
	mesh->Draw( surf->geo->skinToModelTransforms, format );
	qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 0 );
	qglDisable( GL_VERTEX_PROGRAM_ARB );
	qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
}

/*
==================
RB_ARB2_DrawInteraction
==================
*/
void	RB_ARB2_DrawInteraction( const drawInteraction_t *din ) {
	int parmBase = 0;
	if ( din->surf->geo->primBatchMesh ) {
		RB_ARB2_LoadMVPMatrixIntoVPParams( din->surf );
		parmBase = 75;
	}
	// load all the vertex program parameters
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_LIGHT_ORIGIN, din->localLightOrigin.ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_VIEW_ORIGIN, din->localViewOrigin.ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_LIGHT_PROJECT_S, din->lightProjection[0].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_LIGHT_PROJECT_T, din->lightProjection[1].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_LIGHT_PROJECT_Q, din->lightProjection[2].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_LIGHT_FALLOFF_S, din->lightProjection[3].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_BUMP_MATRIX_S, din->bumpMatrix[0].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_BUMP_MATRIX_T, din->bumpMatrix[1].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_DIFFUSE_MATRIX_S, din->diffuseMatrix[0].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_DIFFUSE_MATRIX_T, din->diffuseMatrix[1].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_SPECULAR_MATRIX_S, din->specularMatrix[0].ToFloatPtr() );
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_SPECULAR_MATRIX_T, din->specularMatrix[1].ToFloatPtr() );

	// testing fragment based normal mapping
	if ( r_testARBProgram.GetBool() ) {
		qglProgramEnvParameter4fvARB( GL_FRAGMENT_PROGRAM_ARB, 2, din->localLightOrigin.ToFloatPtr() );
		qglProgramEnvParameter4fvARB( GL_FRAGMENT_PROGRAM_ARB, 3, din->localViewOrigin.ToFloatPtr() );
	}

	// Quake 4 packs the vertex-color multiplier and addend into x/y.
	// interaction.vfp evaluates: color * env[16].x + env[16].y.
	static const float zeroOne[4] = { 0, 1, 0, 0 };
	static const float oneZero[4] = { 1, 0, 0, 0 };
	static const float negOneOne[4] = { -1, 1, 0, 0 };

	switch ( din->vertexColor ) {
	case SVC_IGNORE:
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_COLOR_MODULATE, zeroOne );
		break;
	case SVC_MODULATE:
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_COLOR_MODULATE, oneZero );
		break;
	case SVC_INVERSE_MODULATE:
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, parmBase + PP_COLOR_MODULATE, negOneOne );
		break;
	}

	// set the constant colors
	qglProgramEnvParameter4fvARB( GL_FRAGMENT_PROGRAM_ARB, 0, din->diffuseColor.ToFloatPtr() );
	float specularColor_x2[4] = {
		din->specularColor[0] * 2.0f, din->specularColor[1] * 2.0f,
		din->specularColor[2] * 2.0f, din->specularColor[3] * 2.0f
	};
	qglProgramEnvParameter4fvARB( GL_FRAGMENT_PROGRAM_ARB, 1, specularColor_x2 );
	GL_PolygonOffset( din->surf->material, true );

	// set the textures

	// texture 1 will be the per-surface bump map
	GL_SelectTextureNoClient( 1 );
	din->bumpImage->Bind();

	// texture 2 will be the light falloff texture
	GL_SelectTextureNoClient( 2 );
	din->lightFalloffImage->Bind();

	// texture 3 will be the light projection texture
	GL_SelectTextureNoClient( 3 );
	din->lightImage->Bind();

	// texture 4 is the per-surface diffuse map
	GL_SelectTextureNoClient( 4 );
	din->diffuseImage->Bind();

	// texture 5 is the per-surface specular map
	GL_SelectTextureNoClient( 5 );
	din->specularImage->Bind();

	// draw it
	RB_DrawElementsWithCounters( din->surf->geo );
	GL_PolygonOffset( din->surf->material, false );
}


/*
=============
RB_ARB2_CreateDrawInteractions

=============
*/
void RB_ARB2_CreateDrawInteractions( const drawSurf_t *surf ) {
	if ( !surf ) {
		return;
	}

	GL_State( GLS_SRCBLEND_ONE | GLS_DSTBLEND_ONE | GLS_DEPTHMASK | backEnd.depthFunc );

	GLuint defaultVertexProgram;
	if ( r_testARBProgram.GetBool() ) {
		defaultVertexProgram = 10;
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 10 );
		qglBindProgramARB( GL_FRAGMENT_PROGRAM_ARB, 14 );
	} else if ( r_useSimpleInteraction.GetBool() ) {
		defaultVertexProgram = 19;
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 19 );
		qglBindProgramARB( GL_FRAGMENT_PROGRAM_ARB, 20 );
	} else {
		defaultVertexProgram = 1;
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 1 );
		qglBindProgramARB( GL_FRAGMENT_PROGRAM_ARB, 11 );
	}

	qglEnable( GL_VERTEX_PROGRAM_ARB );
	qglEnable( GL_FRAGMENT_PROGRAM_ARB );

	GL_SelectTextureNoClient( 0 );
	if ( backEnd.vLight->lightShader->IsAmbientLight() ) {
		globalImages->ambientNormalMap->Bind();
	} else {
		globalImages->normalCubeMapImage->Bind();
	}

	rvMesh *previousMesh = NULL;
	for ( ; surf ; surf=surf->nextOnLight ) {
		rvMesh *mesh = surf->geo->primBatchMesh;
		if ( mesh ) {
			const rvVertexFormat *drawFormat = mesh->GetDrawVertexBufferFormat();
			int formatIndex;
			for ( formatIndex = 0; formatIndex < 3; ++formatIndex ) {
				if ( drawFormat->HasSameComponents( supportedMD5RVertexFormats[formatIndex] ) ) {
					break;
				}
			}
			if ( formatIndex < 3 ) {
				qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 21 + formatIndex );
			}
			previousMesh = mesh;
		} else {
			if ( previousMesh ) {
				qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
				qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
				qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, defaultVertexProgram );
				previousMesh = NULL;
			}
			idDrawVert *ac = (idDrawVert *)vertexCache.Position( surf->geo->ambientCache );
			qglColorPointer( 4, GL_UNSIGNED_BYTE, sizeof( idDrawVert ), ac->color );
			qglVertexAttribPointerARB( 11, 3, GL_FLOAT, false, sizeof( idDrawVert ), ac->normal.ToFloatPtr() );
			qglVertexAttribPointerARB( 10, 3, GL_FLOAT, false, sizeof( idDrawVert ), ac->tangents[1].ToFloatPtr() );
			qglVertexAttribPointerARB( 9, 3, GL_FLOAT, false, sizeof( idDrawVert ), ac->tangents[0].ToFloatPtr() );
			qglVertexAttribPointerARB( 8, 2, GL_FLOAT, false, sizeof( idDrawVert ), ac->st.ToFloatPtr() );
			qglVertexPointer( 3, GL_FLOAT, sizeof( idDrawVert ), ac->xyz.ToFloatPtr() );
			GL_VertexAttribState( 0x0F000005 );
		}
		RB_CreateSingleDrawInteractions( surf, RB_ARB2_DrawInteraction );
	}

	GL_VertexAttribState( 1 );
	if ( previousMesh ) {
		qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	}

	GL_SelectTextureNoClient( 5 );
	globalImages->BindNull();

	GL_SelectTextureNoClient( 4 );
	globalImages->BindNull();

	GL_SelectTextureNoClient( 3 );
	globalImages->BindNull();

	GL_SelectTextureNoClient( 2 );
	globalImages->BindNull();

	GL_SelectTextureNoClient( 1 );
	globalImages->BindNull();

	backEnd.glState.currenttmu = -1;
	GL_SelectTexture( 0 );

	qglDisable( GL_VERTEX_PROGRAM_ARB );
	qglDisable( GL_FRAGMENT_PROGRAM_ARB );
}


/*
==================
RB_ARB2_DrawInteractions
==================
*/
void RB_ARB2_DrawInteractions( void ) {
	viewLight_t		*vLight;
	const idMaterial	*lightShader;

	GL_SelectTexture( 0 );
	GL_DisableVertexAttribState( 8 );

	//
	// for each light, perform adding and shadowing
	//
	for ( vLight = backEnd.viewDef->viewLights ; vLight ; vLight = vLight->next ) {
		backEnd.vLight = vLight;

		// do fogging later
		if ( vLight->lightShader->IsFogLight() ) {
			continue;
		}
		if ( vLight->lightShader->IsBlendLight() ) {
			continue;
		}

		if ( !vLight->localInteractions && !vLight->globalInteractions
			&& !vLight->translucentInteractions ) {
			continue;
		}

		lightShader = vLight->lightShader;

		// clear the stencil buffer if needed
		if ( vLight->globalShadows || vLight->localShadows ) {
			backEnd.currentScissor = vLight->scissorRect;
			if ( r_useScissor.GetBool() ) {
				qglScissor( backEnd.viewDef->viewport.x1 + backEnd.currentScissor.x1, 
					backEnd.viewDef->viewport.y1 + backEnd.currentScissor.y1,
					backEnd.currentScissor.x2 + 1 - backEnd.currentScissor.x1,
					backEnd.currentScissor.y2 + 1 - backEnd.currentScissor.y1 );
			}
			qglClear( GL_STENCIL_BUFFER_BIT );
		} else {
			// no shadows, so no need to read or write the stencil buffer
			// we might in theory want to use GL_ALWAYS instead of disabling
			// completely, to satisfy the invarience rules
			qglStencilFunc( GL_ALWAYS, 128, 255 );
		}

		if ( r_useShadowVertexProgram.GetBool() ) {
			qglEnable( GL_VERTEX_PROGRAM_ARB );
			qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, VPROG_STENCIL_SHADOW );
			RB_StencilShadowPass( vLight->globalShadows );
			RB_ARB2_CreateDrawInteractions( vLight->localInteractions );
			qglEnable( GL_VERTEX_PROGRAM_ARB );
			qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, VPROG_STENCIL_SHADOW );
			RB_StencilShadowPass( vLight->localShadows );
			RB_ARB2_CreateDrawInteractions( vLight->globalInteractions );
			qglDisable( GL_VERTEX_PROGRAM_ARB );	// if there weren't any globalInteractions, it would have stayed on
		} else {
			RB_StencilShadowPass( vLight->globalShadows );
			RB_ARB2_CreateDrawInteractions( vLight->localInteractions );
			RB_StencilShadowPass( vLight->localShadows );
			RB_ARB2_CreateDrawInteractions( vLight->globalInteractions );
		}

		// translucent surfaces never get stencil shadowed
		if ( r_skipTranslucent.GetBool() ) {
			continue;
		}

		qglStencilFunc( GL_ALWAYS, 128, 255 );

		backEnd.depthFunc = GLS_DEPTHFUNC_LESS;
		RB_ARB2_CreateDrawInteractions( vLight->translucentInteractions );

		backEnd.depthFunc = GLS_DEPTHFUNC_EQUAL;
	}

	// disable stencil shadow test
	qglStencilFunc( GL_ALWAYS, 128, 255 );

	GL_SelectTexture( 0 );
	GL_VertexAttribState( 9 );
}

//===================================================================================


typedef struct {
	GLenum			target;
	GLuint			ident;
	char			name[64];
} progDef_t;

static	const int	MAX_GLPROGS = 200;

// a single file can have both a vertex program and a fragment program
static progDef_t	progs[MAX_GLPROGS] = {
	{ GL_VERTEX_PROGRAM_ARB, VPROG_TEST, "test.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_TEST, "test.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_INTERACTION, "interaction.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_INTERACTION, "interaction.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_BUMPY_ENVIRONMENT, "bumpyEnvironment.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_BUMPY_ENVIRONMENT, "bumpyEnvironment.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_AMBIENT, "ambientLight.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_AMBIENT, "ambientLight.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_SIMPLE_INTERACTION, "SimpleInteraction.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_SIMPLE_INTERACTION, "SimpleInteraction.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_INTERACTION4, "md5rInteraction4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_INTERACTION1, "md5rInteraction1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_INTERACTION, "md5rInteraction.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SIMPLE4, "md5rSimple4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SIMPLE1, "md5rSimple1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SIMPLE, "md5rSimple.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_STDTEX4, "md5rStdTex4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_STDTEX1, "md5rStdTex1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_STDTEX, "md5rStdTex.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SKYBOX4, "md5rSkyBox4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SKYBOX1, "md5rSkyBox1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SKYBOX, "md5rSkyBox.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVNORMAL4, "md5rEnvNormal4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVNORMAL1, "md5rEnvNormal1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVNORMAL, "md5rEnvNormal.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVREFLECT4, "md5rEnvReflect4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVREFLECT1, "md5rEnvReflect1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVREFLECT, "md5rEnvReflect.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVBUMP4, "md5rEnvBump4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVBUMP1, "md5rEnvBump1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_ENVBUMP, "md5rEnvBump.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SHADOW4, "md5rShadow4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SHADOW1, "md5rShadow1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_SHADOW, "md5rShadow.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_BASICFOG4, "md5rBasicFog4.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_BASICFOG1, "md5rBasicFog1.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_MD5R_BASICFOG, "md5rBasicFog.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_STENCIL_SHADOW, "shadow.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_R200_INTERACTION, "R200_interaction.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_NV20_BUMP_AND_LIGHT, "nv20_bumpAndLight.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_NV20_DIFFUSE_COLOR, "nv20_diffuseColor.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_NV20_SPECULAR_COLOR, "nv20_specularColor.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_NV20_DIFFUSE_AND_SPECULAR_COLOR, "nv20_diffuseAndSpecularColor.vp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_ENVIRONMENT, "environment.vfp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_ENVIRONMENT, "environment.vfp" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_GLASSWARP, "arbVP_glasswarp.txt" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_GLASSWARP, "arbFP_glasswarp.txt" },
	{ GL_VERTEX_PROGRAM_ARB, VPROG_DEPTH, "arbVP_depth.vp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_DEPTH, "arbFP_depth.fp" },
	{ GL_FRAGMENT_PROGRAM_ARB, FPROG_DEPTH_COC, "arbFP_depth_coc.fp" },

	// additional programs can be dynamically specified in materials
};

/*
=================
R_LoadARBProgram
=================
*/
void R_LoadARBProgram( int progIndex ) {
	int		ofs;
	int		err;
	idStr	fullPath = "glprogs/";
	const char *expecting = NULL;
	if ( strstr( fullPath.c_str(), ".cg" ) ) {
		idStr newName = progs[progIndex].name;
		newName.StripFileExtension();
		if ( progs[progIndex].target == GL_VERTEX_PROGRAM_ARB ) {
			newName += ".vp";
		} else if ( progs[progIndex].target == GL_FRAGMENT_PROGRAM_ARB ) {
			newName += ".fp";
		}
		strncpy( progs[progIndex].name, newName.c_str(), sizeof( progs[progIndex].name ) - 1 );
	}
	fullPath += progs[progIndex].name;
	char	*fileBuffer;
	char	*buffer;
	char	*start, *end;

	common->Printf( "%s", fullPath.c_str() );

	// load the program even if we don't support it, so
	// fs_copyfiles can generate cross-platform data dumps
	fileSystem->ReadFile( fullPath.c_str(), (void **)&fileBuffer, NULL );
	if ( !fileBuffer ) {
		common->Printf( ": File not found\n" );
		progs[progIndex].ident = 0;
		return;
	}

	// copy to stack memory and free
	buffer = (char *)_alloca( strlen( fileBuffer ) + 1 );
	strcpy( buffer, fileBuffer );
	fileSystem->FreeFile( fileBuffer );

	if ( !glConfig.isInitialized ) {
		return;
	}

	//
	// submit the program string at start to GL
	//
	if ( progs[progIndex].ident == 0 ) {
		// allocate a new identifier for this program
		progs[progIndex].ident = PROG_USER + progIndex;
	}

	// vertex and fragment programs can both be present in a single file, so
	// scan for the proper header to be the start point, and stamp a 0 in after the end

	if ( progs[progIndex].target == GL_VERTEX_PROGRAM_ARB ) {
		if ( !glConfig.ARBVertexProgramAvailable ) {
			common->Printf( ": GL_VERTEX_PROGRAM_ARB not available\n" );
			return;
		}
		expecting = "!!ARBvp";
	}
	if ( progs[progIndex].target == GL_FRAGMENT_PROGRAM_ARB ) {
		if ( !glConfig.ARBFragmentProgramAvailable ) {
			common->Printf( ": GL_FRAGMENT_PROGRAM_ARB not available\n" );
			return;
		}
		expecting = "!!ARBfp";
	}
	if ( progs[progIndex].target == GL_FRAGMENT_PROGRAM_NV ) {
		if ( !glConfig.nvProgramsAvailable ) {
			common->Printf( ": GL_FRAGMENT_PROGRAM_NV not available\n" );
			return;
		}
		expecting = "!!FP";
	}
	start = strstr( (char *)buffer, expecting );
	if ( !start ) {
		common->Printf( ": %s not found\n", expecting );
		return;
	}
	end = strstr( start, "END" );

	if ( !end ) {
		common->Printf( ": END not found\n" );
		return;
	}
	end[3] = 0;

	if ( progs[progIndex].target == GL_FRAGMENT_PROGRAM_NV ) {
		qglLoadProgramNV( GL_FRAGMENT_PROGRAM_NV, progs[progIndex].ident,
			strlen( start ), (unsigned char *)start );
	} else {
		qglBindProgramARB( progs[progIndex].target, progs[progIndex].ident );
		qglGetError();
		qglProgramStringARB( progs[progIndex].target, GL_PROGRAM_FORMAT_ASCII_ARB,
			strlen( start ), (unsigned char *)start );
	}

	err = qglGetError();
	qglGetIntegerv( GL_PROGRAM_ERROR_POSITION_ARB, (GLint *)&ofs );
	if ( err == GL_INVALID_OPERATION ) {
		const GLubyte *str = qglGetString( GL_PROGRAM_ERROR_STRING_ARB );
		common->Printf( "\nGL_PROGRAM_ERROR_STRING_ARB: %s\n", str );
		if ( ofs < 0 ) {
			common->Printf( "GL_PROGRAM_ERROR_POSITION_ARB < 0 with error\n" );
		} else if ( ofs >= (int)strlen( (char *)start ) ) {
			common->Printf( "error at end of program\n" );
		} else {
			common->Printf( "error at %i:\n%s", ofs, start + ofs );
		}
		return;
	}
	if ( ofs != -1 ) {
		common->Printf( "\nGL_PROGRAM_ERROR_POSITION_ARB != -1 without error\n" );
		return;
	}

	common->Printf( "\n" );
}

/*
==================
R_FindARBProgram

Returns a GL identifier that can be bound to the given target, parsing
a text file if it hasn't already been loaded.
==================
*/
int R_FindARBProgram( GLenum target, const char *program ) {
	int		i;
	idStr	stripped = program;

	stripped.StripFileExtension();

	// see if it is already loaded
	for ( i = 0 ; progs[i].name[0] ; i++ ) {
		if ( progs[i].target != target ) {
			continue;
		}

		idStr	compare = progs[i].name;
		compare.StripFileExtension();

		if ( !idStr::Icmp( stripped.c_str(), compare.c_str() ) ) {
			return progs[i].ident;
		}
	}

	if ( i == MAX_GLPROGS ) {
		common->Error( "R_FindARBProgram: MAX_GLPROGS" );
	}

	// add it to the list and load it
	progs[i].ident = (program_t)0;	// will be gen'd by R_LoadARBProgram
	progs[i].target = target;
	strncpy( progs[i].name, program, sizeof( progs[i].name ) - 1 );

	R_LoadARBProgram( i );

	return progs[i].ident;
}

/*
==================
R_ReloadARBPrograms_f
==================
*/
void R_ReloadARBPrograms_f( const idCmdArgs &args ) {
	int		i;

	fileSystem->SetIsFileLoadingAllowed( true );
	common->Printf( "------------ R_ReloadARBPrograms ------------\n" );
	for ( i = 0 ; progs[i].name[0] ; i++ ) {
		R_LoadARBProgram( i );
	}
	common->Printf( "---------------------------------------------\n" );
	fileSystem->SetIsFileLoadingAllowed( false );
}

/*
==================
R_ARB2_Init

==================
*/
void R_ARB2_Init( void ) {
	glConfig.allowARB2Path = false;
	glConfig.preferNV20Path = false;

	common->Printf( "---------------- R_ARB2_Init ----------------\n" );

	if ( !glConfig.ARBVertexProgramAvailable || !glConfig.ARBFragmentProgramAvailable ) {
		common->Printf( "Not available.\n" );
		return;
	}

	common->Printf( "Available.\n" );
	common->Printf( "---------------------------------------------\n" );

	glConfig.allowARB2Path = true;
	idStr renderer = glConfig.renderer_string;
	glConfig.preferSimpleLighting = false;
	if ( renderer.Find( "GeForce", false ) >= 0 &&
		( renderer.Find( "5200", false ) >= 0 || renderer.Find( "5600", false ) >= 0 ) ) {
		if ( glConfig.allowNV20Path ) {
			glConfig.preferNV20Path = true;
		}
	} else if ( renderer.Find( "RADEON", false ) >= 0 &&
		( renderer.Find( "9700", false ) >= 0 || renderer.Find( "9600", false ) >= 0 ) ) {
		common->Printf( "%s: prefers simple lighting\n", renderer.c_str() );
		glConfig.preferSimpleLighting = true;
	}
}

void RB_ARB2_MD5R_DrawShadowElements( const drawSurf_t *surf, int numIndices ) {
	const srfTriangles_t *tri = surf->geo;
	rvMesh *mesh = tri->primBatchMesh;
	const rvVertexFormat *drawFormat = mesh->GetShadowVolVertexBufferFormat();
	int formatIndex;
	for ( formatIndex = 0; formatIndex < 3; ++formatIndex ) {
		if ( drawFormat->HasSameComponents( supportedMD5RShadowVolVertexFormats[formatIndex] ) ) {
			break;
		}
	}
	if ( formatIndex >= 3 ) {
		return;
	}
	const rvVertexFormat *format = &supportedMD5RShadowVolVertexFormats[formatIndex];
	qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 42 + formatIndex );
	idVec4 localLight;
	R_GlobalPointToLocal( surf->space->modelMatrix, backEnd.vLight->globalLightOrigin,
		localLight.ToVec3() );
	localLight.w = 0.0f;
	qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 79, localLight.ToFloatPtr() );
	RB_ARB2_LoadMVPMatrixIntoVPParams( surf );
	mesh->SetupForShadowVolRender( format );
	mesh->DrawShadowVolume( tri->skinToModelTransforms, tri->indexes,
		numIndices == tri->numIndexes, format );
	qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, VPROG_STENCIL_SHADOW );
	qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
}

static const float envParam[2][4] = {
	{ 1.0f, 0.0f, 0.0f, 0.0f },
	{ 0.0f, 1.0f, 0.0f, 0.0f }
};

void RB_ARB2_PrepareStageTexturing( const shaderStage_t *pStage,
		const drawSurf_t *surf, bool fillingDepth ) {
	rvMesh *mesh = surf->geo->primBatchMesh;
	const rvVertexFormat *drawFormat = mesh->GetDrawVertexBufferFormat();
	int formatIndex;
	for ( formatIndex = 0; formatIndex < 3; ++formatIndex ) {
		if ( drawFormat->HasSameComponents( supportedMD5RVertexFormats[formatIndex] ) ) {
			break;
		}
	}
	if ( formatIndex >= 3 ) {
		return;
	}

	if ( pStage->privatePolygonOffset != 0.0f ) {
		GL_PolygonOffsetState( true, r_offsetFactor.GetFloat(),
			r_offsetUnits.GetFloat() * pStage->privatePolygonOffset );
	}
	if ( !mesh->m_drawSetUp ) {
		mesh->SetupForDrawRender( NULL );
	}

	switch ( pStage->texture.texgen ) {
	case TG_DIFFUSE_CUBE:
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 33 + formatIndex );
		qglEnable( GL_VERTEX_PROGRAM_ARB );
		break;
	case TG_REFLECT_CUBE: {
		const shaderStage_t *bumpStage = surf->material->GetBumpStage();
		if ( bumpStage ) {
			GL_SelectTexture( 1 );
			bumpStage->texture.image->Bind();
			GL_SelectTexture( 0 );
			qglBindProgramARB( GL_FRAGMENT_PROGRAM_ARB, 13 );
			qglEnable( GL_FRAGMENT_PROGRAM_ARB );
			qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 39 + formatIndex );
			qglEnable( GL_VERTEX_PROGRAM_ARB );
			RB_ARB2_LoadModelMatrixIntoVPParams( surf );
		} else {
			qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 36 + formatIndex );
			qglEnable( GL_VERTEX_PROGRAM_ARB );
		}
		RB_ARB2_LoadLocalViewOriginIntoVPParams( surf );
		break;
	}
	case TG_SKYBOX_CUBE:
	case TG_WOBBLESKY_CUBE:
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 30 + formatIndex );
		qglEnable( GL_VERTEX_PROGRAM_ARB );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 80,
			surf->texGenTransformAndViewOrg + 12 );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 81,
			surf->texGenTransformAndViewOrg );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 82,
			surf->texGenTransformAndViewOrg + 4 );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 83,
			surf->texGenTransformAndViewOrg + 8 );
		break;
	case TG_SCREEN:
		return;
	default:
		qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 27 + formatIndex );
		qglEnable( GL_VERTEX_PROGRAM_ARB );
		break;
	}

	float color[4];
	if ( fillingDepth ) {
		color[0] = color[1] = color[2] = color[3] = 0.0f;
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 91, color );
		color[3] = surf->shaderRegisters[pStage->color.registers[3]];
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 92, color );
	} else if ( pStage->vertexColor != SVC_IGNORE ) {
		color[0] = color[1] = color[2] = color[3] = 1.0f;
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 91, color );
		color[0] = color[1] = color[2] = color[3] = 0.0f;
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 92, color );
	} else {
		color[0] = color[1] = color[2] = color[3] = 0.0f;
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 91, color );
		if ( surf->mFlags & 1 ) {
			color[0] = color[1] = color[2] = color[3] = 1.0f;
		} else {
			for ( int i = 0; i < 4; ++i ) {
				color[i] = surf->shaderRegisters[pStage->color.registers[i]];
			}
		}
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 92, color );
	}

	RB_ARB2_LoadMVPMatrixIntoVPParams( surf );
	if ( pStage->texture.hasMatrix ) {
		RB_ARB2_LoadShaderTextureMatrixIntoVPParams( surf->shaderRegisters, &pStage->texture );
	} else {
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 85, envParam[0] );
		qglProgramEnvParameter4fvARB( GL_VERTEX_PROGRAM_ARB, 86, envParam[1] );
	}
}

void RB_ARB2_DisableStageTexturing( const shaderStage_t *pStage,
		const drawSurf_t *surf ) {
	if ( pStage->privatePolygonOffset != 0.0f &&
		!surf->material->TestMaterialFlag( MF_POLYGONOFFSET ) ) {
		GL_PolygonOffsetState( false, 0.0f, 0.0f );
	}
	qglDisable( GL_FRAGMENT_PROGRAM_ARB );
	qglDisable( GL_VERTEX_PROGRAM_ARB );
	qglBindProgramARB( GL_VERTEX_PROGRAM_ARB, 0 );
	qglBindBufferARB( GL_ARRAY_BUFFER_ARB, 0 );
	qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, 0 );
	if ( pStage->texture.texgen == TG_REFLECT_CUBE && surf->material->GetBumpStage() ) {
		GL_SelectTexture( 1 );
		globalImages->BindNull();
		GL_SelectTexture( 0 );
	}
}
