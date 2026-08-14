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
// Quake 4 special-effect render targets reconstructed from quake4.pdb and
// the licensed retail executable.  This is the retail rvSpecial.obj owner.

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "tr_local.h"
#include "RenderWorld_local.h"
#include "rvSpecial.h"
#include "rvTexRenderTarget.h"
#include "Shaders.h"

int numDrawn;
rvBlurTexture *DepthTexture;
rvAL *AL;
const idMaterial *ALMaterial;

namespace {

static void RB_SpecialFullScreenQuad() {
	qglBegin( GL_QUADS );
	qglTexCoord2f( 0.0f, 1.0f ); qglVertex2f( 0.0f, 0.0f );
	qglTexCoord2f( 1.0f, 1.0f ); qglVertex2f( 640.0f, 0.0f );
	qglTexCoord2f( 1.0f, 0.0f ); qglVertex2f( 640.0f, 480.0f );
	qglTexCoord2f( 0.0f, 0.0f ); qglVertex2f( 0.0f, 480.0f );
	qglEnd();
}

static void RB_ResetSpecialTextureState() {
	backEnd.glState.forceGlState = true;
	for ( int unit = 0; unit < MAX_MULTITEXTURE_UNITS; ++unit ) {
		GL_SelectTexture( unit );
		qglDisable( GL_TEXTURE_CUBE_MAP_ARB );
		qglDisable( GL_TEXTURE_3D );
		qglDisable( GL_TEXTURE_2D );
		backEnd.glState.tmu[unit].current2DMap = -1;
		backEnd.glState.tmu[unit].current3DMap = -1;
		backEnd.glState.tmu[unit].currentCubeMap = -1;
		backEnd.glState.tmu[unit].textureType = TT_DISABLED;
		globalImages->whiteImage->Bind();
	}
	GL_SelectTexture( 0 );
}

static rvNewShaderStage *RB_SpecialStage( const idMaterial *material, int index ) {
	if ( material == NULL || index < 0 || index >= material->GetNumStages() ) {
		return NULL;
	}
	return material->GetStage( index )->newShaderStage;
}

static bool RB_ProjectSpecialPoint( const idVec3 &global, idVec3 &ndc ) {
	if ( backEnd.viewDef == NULL ) {
		return false;
	}
	idVec4 view;
	idVec4 clip;
	const float *modelView = backEnd.viewDef->worldSpace.modelViewMatrix;
	const float *projection = backEnd.viewDef->projectionMatrix;
	for ( int i = 0; i < 4; ++i ) {
		view[i] = global[0] * modelView[i + 0 * 4] +
			global[1] * modelView[i + 1 * 4] +
			global[2] * modelView[i + 2 * 4] + modelView[i + 3 * 4];
	}
	for ( int i = 0; i < 4; ++i ) {
		clip[i] = view[0] * projection[i + 0 * 4] +
			view[1] * projection[i + 1 * 4] +
			view[2] * projection[i + 2 * 4] + view[3] * projection[i + 3 * 4];
	}
	if ( idMath::Fabs( clip[3] ) < 1.0e-6f ) {
		return false;
	}
	ndc.Set( clip[0] / clip[3], clip[1] / clip[3], clip[2] / clip[3] );
	return true;
}

static void RB_FillSpecialDepth( const drawSurf_t *surf, bool ambientLightImage ) {
	const idMaterial *shader = surf->material;
	const srfTriangles_t *tri = surf->geo;
	if ( shader == NULL || tri == NULL || !shader->IsDrawn() ||
		tri->numIndexes == 0 || shader->Coverage() == MC_TRANSLUCENT ) {
		return;
	}
	if ( tri->ambientCache == NULL ) {
		common->Printf( "RB_T_FillDepthTexture: !tri->ambientCache\n" );
		return;
	}

	const float *registers = surf->shaderRegisters;
	int stageIndex;
	for ( stageIndex = 0; stageIndex < shader->GetNumStages(); ++stageIndex ) {
		if ( registers[shader->GetStage( stageIndex )->conditionRegister] != 0.0f ) {
			break;
		}
	}
	if ( stageIndex == shader->GetNumStages() ) {
		return;
	}

	GL_PolygonOffset( shader, true );
	float color[4] = { 0.0f, 0.0f, 0.0f, 1.0f };
	if ( shader->GetSort() == SS_SUBVIEW ) {
		GL_State( GLS_SRCBLEND_DST_COLOR | GLS_DSTBLEND_ZERO | GLS_DEPTHFUNC_LESS );
		color[0] = color[1] = color[2] = 1.0f / backEnd.overBright;
	}

	idDrawVert *ambient = static_cast<idDrawVert *>( vertexCache.Position( tri->ambientCache ) );
	qglVertexPointer( 3, GL_FLOAT, sizeof( idDrawVert ), ambient->xyz.ToFloatPtr() );
	qglTexCoordPointer( 2, GL_FLOAT, sizeof( idDrawVert ), &ambient->st );

	bool drawSolid = shader->Coverage() == MC_OPAQUE;
	if ( shader->Coverage() == MC_PERFORATED ) {
		bool didDraw = false;
		qglEnable( GL_ALPHA_TEST );
		for ( int i = 0; i < shader->GetNumStages(); ++i ) {
			const shaderStage_t *stage = shader->GetStage( i );
			if ( !stage->hasAlphaTest || registers[stage->conditionRegister] == 0.0f ) {
				continue;
			}
			didDraw = true;
			color[3] = registers[stage->color.registers[3]];
			if ( color[3] <= 0.0f ) {
				continue;
			}
			qglColor4fv( color );
			qglAlphaFunc( stage->hasAlphaFunc ? stage->alphaTestMode : GL_GREATER,
				registers[stage->alphaTestRegister] );
			stage->texture.image->Bind();
			RB_PrepareStageTexturing( stage, surf, ambient, false );
			RB_DrawElementsWithCounters( tri );
			RB_FinishStageTexturing( stage, surf, ambient, false );
		}
		qglDisable( GL_ALPHA_TEST );
		if ( !didDraw ) {
			drawSolid = true;
		}
	}

	if ( drawSolid ) {
		qglColor4fv( color );
		if ( ambientLightImage && ALMaterial != NULL && AL != NULL ) {
			for ( int i = 0; i < shader->GetNumStages(); ++i ) {
				const shaderStage_t *stage = shader->GetStage( i );
				if ( stage->lighting == SL_DIFFUSE ) {
					rvNewShaderStage *alStage = RB_SpecialStage( ALMaterial, 0 );
					if ( alStage != NULL ) {
						alStage->SetTextureParm( "Image", stage->texture.image );
						alStage->Bind( AL->regs, NULL );
					}
					break;
				}
			}
		} else {
			globalImages->whiteImage->Bind();
		}
		RB_DrawElementsWithCounters( tri );
	}

	GL_PolygonOffset( shader, false );
	if ( shader->GetSort() == SS_SUBVIEW ) {
		GL_State( GLS_DEPTHFUNC_LESS );
	}
}

}

bool rvBlurTexture::CreateBuffer( const char *name, idPBufferImage **image ) {
	*image = globalImages->AllocPBufferImage( name );
	if ( *image == NULL ) {
		return false;
	}
	(*image)->useCount = 1;
	(*image)->type = TT_2D;
	(*image)->uploadWidth = 256;
	(*image)->uploadHeight = 256;
	(*image)->mRenderTarget->Init( 256, 256, 32, 8, 8, 8, 8, 24, 0,
		rvTexRenderTargetFlagDepthStencil | rvTexRenderTargetFlagMipMap );
	(*image)->mRenderTarget->DefaultD3GL();
	return true;
}

bool rvAL::CreateBuffer( const char *name, idPBufferImage **image ) {
	*image = globalImages->AllocPBufferImage( name );
	if ( *image == NULL ) {
		return false;
	}
	(*image)->useCount = 1;
	(*image)->type = TT_2D;
	(*image)->uploadWidth = 512;
	(*image)->uploadHeight = 512;
	(*image)->mRenderTarget->Init( 512, 512, 32, 8, 8, 8, 8, 24, 0,
		rvTexRenderTargetFlagDepthStencil | rvTexRenderTargetFlagMipMap );
	(*image)->mRenderTarget->DefaultD3GL();
	return true;
}

void RB_RestoreDrawingView() {
	if ( backEnd.viewDef == NULL ) {
		return;
	}
	qglMatrixMode( GL_PROJECTION );
	qglLoadMatrixf( backEnd.viewDef->projectionMatrix );
	qglMatrixMode( GL_MODELVIEW );
	qglLoadIdentity();
	backEnd.currentSpace = NULL;
	qglViewport( tr.viewportOffset[0] + backEnd.viewDef->viewport.x1,
		tr.viewportOffset[1] + backEnd.viewDef->viewport.y1,
		backEnd.viewDef->viewport.x2 - backEnd.viewDef->viewport.x1 + 1,
		backEnd.viewDef->viewport.y2 - backEnd.viewDef->viewport.y1 + 1 );
	qglScissor( tr.viewportOffset[0] + backEnd.viewDef->viewport.x1 + backEnd.viewDef->scissor.x1,
		tr.viewportOffset[1] + backEnd.viewDef->viewport.y1 + backEnd.viewDef->scissor.y1,
		backEnd.viewDef->scissor.x2 - backEnd.viewDef->scissor.x1 + 1,
		backEnd.viewDef->scissor.y2 - backEnd.viewDef->scissor.y1 + 1 );
	backEnd.currentScissor = backEnd.viewDef->scissor;
	GL_State( GLS_DEFAULT );
	if ( backEnd.viewDef->viewEntitys != NULL ) {
		qglEnable( GL_DEPTH_TEST );
		qglEnable( GL_STENCIL_TEST );
	} else {
		qglDisable( GL_DEPTH_TEST );
		qglDisable( GL_STENCIL_TEST );
	}
	backEnd.glState.faceCulling = -1;
	GL_Cull( CT_FRONT_SIDED );
}

void R_AddSpecialEffects( viewDef_t *parms ) {
	if ( ( tr.specialEffectsEnabled & ( SPECIAL_EFFECT_BLUR | SPECIAL_EFFECT_AL ) ) == 0 ) {
		return;
	}
	drawSurfsCommand_t *cmd = static_cast<drawSurfsCommand_t *>(
		R_GetCommandBuffer( sizeof( *cmd ) ) );
	cmd->commandId = RC_DRAW_DEPTH_TEXTURE;
	cmd->viewDef = parms;
}

void idRenderSystemLocal::SetSpecialEffectParm( ESpecialEffectType which, int parm, float value ) {
	if ( parm < 0 || parm >= 12 ) {
		return;
	}
	if ( which == SPECIAL_EFFECT_BLUR && DepthTexture != NULL ) {
		DepthTexture->shaderParms[parm] = value;
	} else if ( which == SPECIAL_EFFECT_AL && AL != NULL ) {
		AL->shaderParms[parm] = value;
	}
}

rvBlurTexture::rvBlurTexture() :
	mDepthImage( NULL ), mDepthMaterial( NULL ), regs( NULL ) {
	mBlurImage[0] = mBlurImage[1] = NULL;
	memset( shaderParms, 0, sizeof( shaderParms ) );
	CreateBuffer( "DepthTexture", &mDepthImage );
	CreateBuffer( "BlurTexture1", &mBlurImage[0] );
	mDepthMaterial = declManager->FindMaterial( "hs/MedLabs", true );
	regs = static_cast<float *>( Mem_ClearedAlloc(
		mDepthMaterial->GetNumRegisters() * sizeof( float ), MA_RENDER ) );
	shaderParms[0] = 0.694f;
	shaderParms[1] = 0.694f;
	shaderParms[2] = 0.694f;
	shaderParms[3] = 1.0f;
	shaderParms[4] = 4.0f;
	shaderParms[5] = 0.31f;
	shaderParms[6] = 0.5f;
	shaderParms[7] = 500.0f;
}

void RB_T_FillDepthTexture( const drawSurf_t *surf ) {
	RB_FillSpecialDepth( surf, false );
}

void rvBlurTexture::Render( drawSurfsCommand_t *drawSurfs ) {
	if ( mDepthImage == NULL || mDepthImage->mRenderTarget == NULL ||
		drawSurfs == NULL || drawSurfs->viewDef == NULL ) {
		return;
	}
	mDepthImage->mRenderTarget->BeginRender( 0 );
	qglClearColor( 0.0f, 0.0f, 0.0f, 1.0f );
	qglClearDepth( 1.0 );
	qglDepthRange( 0.0, 1.0 );
	qglClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	backEnd.viewDef = drawSurfs->viewDef;
	RB_BeginDrawingView();
	qglViewport( 0, 0, mDepthImage->uploadWidth, mDepthImage->uploadHeight );
	qglDisable( GL_BLEND );
	qglColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
	GL_SelectTexture( 1 );
	GL_SelectTexture( 0 );
	globalImages->defaultImage->Bind();
	globalImages->whiteImage->Bind();
	qglEnableClientState( GL_TEXTURE_COORD_ARRAY );
	qglEnableClientState( GL_VERTEX_ARRAY );
	qglDepthFunc( GL_LEQUAL );
	qglDisable( GL_STENCIL_TEST );
	qglStencilFunc( GL_ALWAYS, 1, 255 );
	idVec3 randomizer( 0.0f, 0.0f, 0.0f );
	mDepthMaterial->EvaluateRegisters( regs, shaderParms, drawSurfs->viewDef, 0, &randomizer );
	rvNewShaderStage *stage = RB_SpecialStage( mDepthMaterial, 0 );
	if ( stage != NULL ) {
		stage->Bind( regs, NULL );
	}
	RB_RenderDrawSurfListWithFunction( drawSurfs->viewDef->drawSurfs,
		drawSurfs->viewDef->numDrawSurfs, RB_T_FillDepthTexture );
	if ( stage != NULL ) {
		stage->UnBind();
	}
	mDepthImage->mRenderTarget->EndRender( true );
	RB_ResetSpecialTextureState();
}

void rvBlurTexture::Display( viewEntity_t *viewEnts, bool prePass ) {
	if ( !prePass || viewEnts != NULL || mBlurImage[0] == NULL ) {
		return;
	}
	mBlurImage[0]->mRenderTarget->BeginRender( 0 );
	RB_SetGL2D();
	qglViewport( 0, 0, mBlurImage[0]->uploadWidth, mBlurImage[0]->uploadHeight );
	qglColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
	qglClearColor( 0.0f, 0.0f, 0.0f, 1.0f );
	qglClearDepth( 1.0 );
	qglDepthRange( 0.0, 1.0 );
	qglClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	qglDisable( GL_BLEND );
	GL_SelectTexture( 1 );
	GL_SelectTexture( 0 );
	globalImages->defaultImage->Bind();
	globalImages->whiteImage->Bind();
	rvNewShaderStage *blurStage = RB_SpecialStage( mDepthMaterial, 1 );
	if ( blurStage != NULL ) {
		blurStage->Bind( regs, NULL );
		RB_SpecialFullScreenQuad();
		blurStage->UnBind();
	}
	mBlurImage[0]->mRenderTarget->EndRender( true );

	RB_SetGL2D();
	qglBlendFunc( GL_ONE, GL_ZERO );
	rvNewShaderStage *displayStage = RB_SpecialStage( mDepthMaterial, 2 );
	if ( displayStage != NULL ) {
		displayStage->Bind( regs, NULL );
		qglEnable( GL_BLEND );
		qglBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
		qglColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
		RB_SpecialFullScreenQuad();
		displayStage->UnBind();
	}
	backEnd.glState.forceGlState = true;
}

rvAL::rvAL() :
	mainStage( NULL ), mLightLocParm( -1 ), mLightColorParm( -1 ),
	mLightSizeParm( -1 ), mLightMinDistanceParm( -1 ), mDepthImage( NULL ),
	mDepthMaterial( NULL ), offset( 0.0f ), count( 0 ), regs( NULL ) {
	mBlurImage[0] = mBlurImage[1] = NULL;
	memset( shaderParms, 0, sizeof( shaderParms ) );
	CreateBuffer( "DepthTexture", &mDepthImage );
	CreateBuffer( "BlurTexture1", &mBlurImage[0] );
	mDepthMaterial = declManager->FindMaterial( "hs/ALSetup", true );
	ALMaterial = mDepthMaterial;
	regs = static_cast<float *>( Mem_ClearedAlloc(
		mDepthMaterial->GetNumRegisters() * sizeof( float ), MA_RENDER ) );

	idRenderWorldLocal *world = tr.primaryWorld;
	if ( world != NULL ) {
		for ( int i = 0; i < world->entityDefs.Num() && count < 100; ++i ) {
			const idRenderEntityLocal *entity = world->entityDefs[i];
			if ( entity == NULL ) {
				continue;
			}
			lOrigin[count] = entity->parms.origin;
			lColor[count].Set( entity->parms.shaderParms[0],
				entity->parms.shaderParms[1], entity->parms.shaderParms[2] );
			if ( lColor[count].Normalize() == 0.0f ) {
				lColor[count].Set( 1.0f, 1.0f, 1.0f );
				lColor[count].Normalize();
			}
			lSize[count] = 300.0f;
			++count;
		}
	}
}

void RB_T_FillDepthTextureAL( const drawSurf_t *surf ) {
	RB_FillSpecialDepth( surf, true );
}

void rvAL::Render( drawSurfsCommand_t *drawSurfs ) {
	if ( mDepthImage == NULL || mDepthImage->mRenderTarget == NULL ||
		drawSurfs == NULL || drawSurfs->viewDef == NULL ) {
		return;
	}
	mDepthImage->mRenderTarget->BeginRender( 0 );
	qglClearColor( 0.0f, 0.0f, 0.0f, 1.0f );
	qglClearDepth( 1.0 );
	qglDepthRange( 0.0, 1.0 );
	qglClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
	backEnd.viewDef = drawSurfs->viewDef;
	RB_BeginDrawingView();
	memcpy( backEnd.projectionMatrix, drawSurfs->viewDef->projectionMatrix,
		sizeof( backEnd.projectionMatrix ) );
	qglViewport( 0, 0, mDepthImage->uploadWidth, mDepthImage->uploadHeight );
	qglDisable( GL_BLEND );
	qglColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
	GL_SelectTexture( 1 );
	GL_SelectTexture( 0 );
	globalImages->defaultImage->Bind();
	globalImages->whiteImage->Bind();
	qglEnableClientState( GL_TEXTURE_COORD_ARRAY );
	qglEnableClientState( GL_VERTEX_ARRAY );
	qglDepthFunc( GL_LEQUAL );
	qglDisable( GL_STENCIL_TEST );
	qglStencilFunc( GL_ALWAYS, 1, 255 );
	idVec3 randomizer( 0.0f, 0.0f, 0.0f );
	mDepthMaterial->EvaluateRegisters( regs, shaderParms, drawSurfs->viewDef, 0, &randomizer );
	rvNewShaderStage *stage = RB_SpecialStage( mDepthMaterial, 0 );
	if ( stage != NULL ) {
		stage->Bind( regs, NULL );
	}
	RB_RenderDrawSurfListWithFunction( drawSurfs->viewDef->drawSurfs,
		drawSurfs->viewDef->numDrawSurfs, RB_T_FillDepthTextureAL );
	if ( stage != NULL ) {
		stage->UnBind();
	}
	mDepthImage->mRenderTarget->EndRender( true );
	RB_ResetSpecialTextureState();
}

void RB_SetGL2D2() {
	qglViewport( 0, 0, glConfig.vidWidth, glConfig.vidHeight );
	if ( r_useScissor.GetBool() ) {
		qglScissor( 0, 0, glConfig.vidWidth, glConfig.vidHeight );
	}
	qglMatrixMode( GL_PROJECTION );
	qglLoadIdentity();
	qglOrtho( 0.0, 640.0, 480.0, 0.0, 0.0, 1.0 );
	qglMatrixMode( GL_MODELVIEW );
	qglLoadIdentity();
	GL_State( GLS_DEPTHFUNC_ALWAYS | GLS_SRCBLEND_SRC_ALPHA |
		GLS_DSTBLEND_ONE_MINUS_SRC_ALPHA );
	GL_Cull( CT_TWO_SIDED );
	qglDisable( GL_DEPTH_TEST );
	qglDisable( GL_STENCIL_TEST );
}

void R_ShutdownSpecialEffects() {
	if ( DepthTexture != NULL ) {
		Mem_Free( DepthTexture->regs );
		delete DepthTexture;
		DepthTexture = NULL;
	}
	if ( AL != NULL ) {
		Mem_Free( AL->regs );
		delete AL;
		AL = NULL;
	}
	ALMaterial = NULL;
	tr.specialEffectsEnabled = 0;
}

void RB_DrawDepthTexture( const void *data ) {
	const drawSurfsCommand_t *cmd = static_cast<const drawSurfsCommand_t *>( data );
	if ( cmd == NULL || cmd->viewDef == NULL ) {
		return;
	}
	backEnd.viewDef = cmd->viewDef;
	if ( backEnd.viewDef->numDrawSurfs != 0 ) {
		if ( DepthTexture != NULL ) {
			DepthTexture->Render( const_cast<drawSurfsCommand_t *>( cmd ) );
		}
		if ( AL != NULL ) {
			AL->Render( const_cast<drawSurfsCommand_t *>( cmd ) );
		}
	}
}

void idRenderSystemLocal::SetSpecialEffect( ESpecialEffectType which, bool enabled ) {
	if ( enabled ) {
		specialEffectsEnabled |= which;
		if ( which == SPECIAL_EFFECT_BLUR && DepthTexture == NULL && glConfig.allowARB2Path ) {
			DepthTexture = new rvBlurTexture;
		} else if ( which == SPECIAL_EFFECT_AL && AL == NULL && glConfig.allowARB2Path ) {
			AL = new rvAL;
		}
	} else {
		specialEffectsEnabled &= ~which;
	}
}

void idRenderSystemLocal::ShutdownSpecialEffects() {
	R_ShutdownSpecialEffects();
}

void rvAL::DrawLight( const idVec3 &origin, float size, const idVec3 &color ) {
	if ( mainStage == NULL || backEnd.viewDef == NULL ) {
		return;
	}
	for ( int i = 0; i < 5; ++i ) {
		if ( backEnd.viewDef->frustum[i].Distance( origin ) > size ) {
			return;
		}
	}

	const idVec3 right = backEnd.viewDef->renderView.viewaxis[1] * size;
	const idVec3 up = backEnd.viewDef->renderView.viewaxis[2] * size;
	idVec3 points[4];
	points[0] = origin + right + up;
	points[1] = origin - right + up;
	points[2] = origin - right - up;
	points[3] = origin + right - up;
	idVec3 ndc0, ndc2;
	if ( !RB_ProjectSpecialPoint( points[0], ndc0 ) ||
		!RB_ProjectSpecialPoint( points[2], ndc2 ) ) {
		return;
	}

	const idScreenRect &viewport = backEnd.viewDef->viewport;
	float x1 = ( viewport.x2 - viewport.x1 ) * ( ndc0.x + 1.0f ) * 0.5f;
	float y1 = viewport.y2 - ( viewport.y2 - viewport.y1 ) * ( ndc0.y + 1.0f ) * 0.5f;
	float x2 = ( viewport.x2 - viewport.x1 ) * ( ndc2.x + 1.0f ) * 0.5f;
	float y2 = viewport.y2 - ( viewport.y2 - viewport.y1 ) * ( ndc2.y + 1.0f ) * 0.5f;
	if ( x1 > x2 ) {
		idSwap( x1, x2 );
	}
	if ( y1 > y2 ) {
		idSwap( y1, y2 );
	}

	idVec3 globalOrigin;
	R_LocalPointToGlobal( backEnd.viewDef->worldSpace.modelMatrix, origin, globalOrigin );
	idVec3 planeNormal = backEnd.viewDef->renderView.viewaxis[2].Cross(
		backEnd.viewDef->renderView.viewaxis[1] );
	planeNormal.Normalize();
	const float minDistance = planeNormal *
		( origin - backEnd.viewDef->renderView.vieworg );
	mainStage->SetShaderParameter( mLightLocParm, regs, globalOrigin.ToFloatPtr(), 3 );
	mainStage->SetShaderParameter( mLightColorParm, regs,
		const_cast<float *>( color.ToFloatPtr() ), 3 );
	mainStage->SetShaderParameter( mLightSizeParm, regs, &size, 1 );
	float distance = idMath::Fabs( minDistance );
	mainStage->SetShaderParameter( mLightMinDistanceParm, regs, &distance, 1 );
	mainStage->UpdateShaderParms( regs, NULL );

	qglBegin( GL_QUADS );
	qglTexCoord2f( x1 / 639.0f, 1.0f - y1 / 479.0f );
	qglMultiTexCoord2fARB( GL_TEXTURE1_ARB, 0.0f, 0.0f ); qglVertex2f( x1, y1 );
	qglTexCoord2f( x2 / 639.0f, 1.0f - y1 / 479.0f );
	qglMultiTexCoord2fARB( GL_TEXTURE1_ARB, 1.0f, 0.0f ); qglVertex2f( x2, y1 );
	qglTexCoord2f( x2 / 639.0f, 1.0f - y2 / 479.0f );
	qglMultiTexCoord2fARB( GL_TEXTURE1_ARB, 1.0f, 1.0f ); qglVertex2f( x2, y2 );
	qglTexCoord2f( x1 / 639.0f, 1.0f - y2 / 479.0f );
	qglMultiTexCoord2fARB( GL_TEXTURE1_ARB, 0.0f, 1.0f ); qglVertex2f( x1, y2 );
	qglEnd();
	++numDrawn;
}

void rvAL::Display( viewEntity_t *viewEnts, bool prePass ) {
	if ( prePass ) {
		return;
	}
	mainStage = RB_SpecialStage( ALMaterial, 1 );
	if ( mainStage == NULL ) {
		return;
	}
	mLightLocParm = mainStage->FindShaderParameter( "LightLoc" );
	mLightColorParm = mainStage->FindShaderParameter( "LightColor" );
	mLightSizeParm = mainStage->FindShaderParameter( "LightSize" );
	mLightMinDistanceParm = mainStage->FindShaderParameter( "LightMinDistance" );
	RB_SetGL2D2();
	qglColor4f( 1.0f, 1.0f, 1.0f, 1.0f );
	GL_State( GLS_DSTBLEND_ONE );
	numDrawn = 0;
	if ( viewEnts != NULL && !cvarSystem->GetCVarBool( "rj" ) ) {
		mainStage->Bind( regs, NULL );
		DrawLight( vec3_origin, 200.0f, idVec3( 1.0f, 1.0f, 0.0f ) );
		offset += 0.005f;
		for ( int i = 0; i < count; ++i ) {
			idVec3 animatedOrigin = lOrigin[i];
			animatedOrigin.x += idMath::Cos( 0.78423f * i + offset ) * 0.0f;
			animatedOrigin.y += idMath::Cos( 0.234f * i + offset ) * 0.0f;
			DrawLight( animatedOrigin, lSize[i], lColor[i] );
		}
		mainStage->UnBind();
	}
	backEnd.glState.forceGlState = true;
	RB_RestoreDrawingView();
}

void RB_DisplaySpecialEffects( viewEntity_t *viewEnts, bool prePass ) {
	if ( ( tr.specialEffectsEnabled & SPECIAL_EFFECT_BLUR ) != 0 && DepthTexture != NULL ) {
		DepthTexture->Display( viewEnts, prePass );
	}
	if ( ( tr.specialEffectsEnabled & SPECIAL_EFFECT_AL ) != 0 && AL != NULL ) {
		AL->Display( viewEnts, prePass );
	}
}
