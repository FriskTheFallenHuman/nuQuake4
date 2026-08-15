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
#include "RenderWorld_local.h"

rvRenderEffectLocal::rvRenderEffectLocal() {
	memset( &parms, 0, sizeof( parms ) );
	memset( modelMatrix, 0, sizeof( modelMatrix ) );
	model = NULL;
	effect = NULL;
	index = 0;
	referenceBounds = bounds_zero;
	world = NULL;
	lastModifiedFrameNum = 0;
	writeToDemo = false;
	archived = false;
	dynamicModel = NULL;
	dynamicModelFrameCount = 0;
	viewCount = 0;
	viewEffect = NULL;
	visibleCount = 0;
	effectRefs = NULL;
}

rvRenderEffectLocal::~rvRenderEffectLocal() {
	if ( effect && bse ) {
		bse->FreeEffect( this );
	}
}

void rvRenderEffectLocal::FreeRenderEffect() {
	if ( world ) {
		world->FreeEffectDef( index );
	}
}

void rvRenderEffectLocal::UpdateRenderEffect( const renderEffect_t *newParms, bool forceUpdate ) {
	if ( world ) {
		world->UpdateEffectDef( index, newParms, tr.viewDef ? tr.viewDef->renderView.time : 0 );
	}
}

void rvRenderEffectLocal::ForceUpdate() {
	lastModifiedFrameNum = -1;
}

int rvRenderEffectLocal::GetIndex() {
	return index;
}

idRenderEntityLocal::idRenderEntityLocal() {
	memset( &parms, 0, sizeof( parms ) );
	memset( modelMatrix, 0, sizeof( modelMatrix ) );

	world					= NULL;
	index					= 0;
	lastModifiedFrameNum	= 0;
	archived				= false;
	dynamicModel			= NULL;
	dynamicModelFrameCount	= 0;
	cachedDynamicModel		= NULL;
	referenceBounds			= bounds_zero;
	viewCount				= 0;
	viewEntity				= NULL;
	visibleCount			= 0;
	decals					= NULL;
	overlay					= NULL;
	entityRefs				= NULL;
	firstInteraction		= NULL;
	lastInteraction			= NULL;
	needsPortalSky			= false;
}

void idRenderEntityLocal::FreeRenderEntity() {
}

void idRenderEntityLocal::UpdateRenderEntity( const renderEntity_t *re, bool forceUpdate ) {
}

void idRenderEntityLocal::GetRenderEntity( renderEntity_t *re ) {
}

void idRenderEntityLocal::ForceUpdate() {
}

int idRenderEntityLocal::GetIndex() {
	return index;
}

void idRenderEntityLocal::ProjectOverlay( const idPlane localTextureAxis[2], const idMaterial *material ) {
}
void idRenderEntityLocal::RemoveDecals() {
}

//======================================================================

idRenderLightLocal::idRenderLightLocal() {
	memset( &parms, 0, sizeof( parms ) );
	memset( modelMatrix, 0, sizeof( modelMatrix ) );
	memset( shadowFrustums, 0, sizeof( shadowFrustums ) );
	memset( lightProject, 0, sizeof( lightProject ) );
	memset( frustum, 0, sizeof( frustum ) );
	memset( frustumWindings, 0, sizeof( frustumWindings ) );

	lightHasMoved			= false;
	world					= NULL;
	index					= 0;
	areaNum					= 0;
	lastModifiedFrameNum	= 0;
	archived				= false;
	lightShader				= NULL;
	falloffImage			= NULL;
	globalLightOrigin		= vec3_zero;
	frustumTris				= NULL;
	numShadowFrustums		= 0;
	viewCount				= 0;
	viewLight				= NULL;
	references				= NULL;
	foggedPortals			= NULL;
	firstInteraction		= NULL;
	lastInteraction			= NULL;
}

void idRenderLightLocal::FreeRenderLight() {
	if ( world ) {
		world->FreeLightDef( index );
	} else {
		R_FreeLightDefDerivedData( this );
	}
}
void idRenderLightLocal::UpdateRenderLight( const renderLight_t *re, bool forceUpdate ) {
	if ( world ) {
		world->UpdateLightDef( index, re );
		return;
	}
	if ( forceUpdate || memcmp( &parms, re, sizeof( parms ) ) ) {
		R_FreeLightDefDerivedData( this );
		parms = *re;
		R_DeriveLightData( this );
	}
}
void idRenderLightLocal::GetRenderLight( renderLight_t *re ) {
	*re = parms;
}
void idRenderLightLocal::ForceUpdate() {
	if ( world ) {
		world->UpdateLightDef( index, &parms );
	} else {
		R_FreeLightDefDerivedData( this );
		R_DeriveLightData( this );
	}
}
int idRenderLightLocal::GetIndex() {
	return index;
}
