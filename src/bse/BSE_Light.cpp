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
#include "BSE.h"
#include "BSE_Particle.h"

/*
===============================================================================

	Quake 4 BSE dynamic lights

	Function ownership, signatures, and object layouts come from
	BSE_Light.obj in quake4.pdb.  Control flow is reconstructed from the
	address-matched retail executable bodies.

===============================================================================
*/

bool rvLightParticle::Destroy( void ) {
	if ( mLightDefHandle != -1 ) {
		session->rw->FreeLightDef( mLightDefHandle );
		mLightDefHandle = -1;
	}
	return true;
}

void rvSegment::InitLight( rvBSE *effect, rvSegmentTemplate *st, float time ) {
	if ( mUsedHead == NULL ) {
		SpawnParticle( effect, st, time, vec3_origin, mat3_identity );
		mUsedHead->InitLight( effect, st, time );
	}
}

bool rvSegment::HandleLight( rvBSE *effect, rvSegmentTemplate *st, float time ) {
	if ( mUsedHead == NULL ) {
		return false;
	}

	const bool infinite = st->GetInfiniteDuration();
	mUsedHead->PresentLight( effect, time, infinite );
	if ( infinite || !mUsedHead->Expired( time ) ) {
		return false;
	}

	mUsedHead->Destroy();
	mFreeHead = mUsedHead;
	mUsedHead = NULL;
	return true;
}

bool rvLightParticle::InitLight( rvBSE *effect, rvSegmentTemplate *st, float time ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime, false ) ) {
		return false;
	}

	memset( &mLight, 0, sizeof( mLight ) );

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	idVec3 size;
	EvaluateSize( evalTime, size.ToFloatPtr() );

	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	mLight.origin = effect->GetCurrentOrigin() + position * effect->GetCurrentAxis();
	mLight.lightRadius.Set(
		size[0] < 1.0f ? 1.0f : size[0],
		size[1] < 1.0f ? 1.0f : size[1],
		size[2] < 1.0f ? 1.0f : size[2] );
	mLight.axis = effect->GetCurrentAxis();
	mLight.shaderParms[SHADERPARM_RED] = tint[0];
	mLight.shaderParms[SHADERPARM_GREEN] = tint[1];
	mLight.shaderParms[SHADERPARM_BLUE] = tint[2];

	const rvParticleTemplate *particleTemplate = st->GetParticleTemplate();
	mLight.shader = particleTemplate->GetMaterial();
	mLight.pointLight = true;
	mLight.detailLevel = 10.0f;
	mLight.noShadows = !particleTemplate->GetShadows();
	mLight.noSpecular = !particleTemplate->GetSpecular();
	mLightDefHandle = session->rw->AddLightDef( &mLight );
	return true;
}

bool rvLightParticle::PresentLight( rvBSE *effect, float time, bool infinite ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime, infinite ) ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	idVec3 size;
	EvaluateSize( evalTime, size.ToFloatPtr() );

	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	mLight.origin = effect->GetCurrentOrigin() + position * effect->GetCurrentAxis();
	mLight.lightRadius.Set(
		size[0] < 1.0f ? 1.0f : size[0],
		size[1] < 1.0f ? 1.0f : size[1],
		size[2] < 1.0f ? 1.0f : size[2] );
	mLight.axis = effect->GetCurrentAxis();
	mLight.shaderParms[SHADERPARM_RED] = tint[0];
	mLight.shaderParms[SHADERPARM_GREEN] = tint[1];
	mLight.shaderParms[SHADERPARM_BLUE] = tint[2];

	session->rw->UpdateLightDef( mLightDefHandle, &mLight );
	return true;
}
