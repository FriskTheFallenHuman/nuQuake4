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
#include "../renderer/tr_local.h"
#include "../renderer/Model_local.h"

// Retail compilation unit: BSE_Effect.obj. Implementations are recovered here.

idSoundEmitter *rvBSE::GetReferenceSound( int worldId ) const {
	return soundSystem->EmitterForIndex( worldId, mReferenceSoundHandle );
}

float rvBSE::GetAttenuation( rvSegmentTemplate *segmentTemplate ) const {
	if ( ( segmentTemplate->mAttenuation.x <= 0.0f &&
			segmentTemplate->mAttenuation.y <= 0.0f ) ||
			segmentTemplate->mAttenuation.x + 1.0f > mShortestDistanceToCamera ) {
		return mAttenuation;
	}
	if ( segmentTemplate->mAttenuation.y - 1.0f >= mShortestDistanceToCamera ) {
		return ( 1.0f - ( mShortestDistanceToCamera -
			segmentTemplate->mAttenuation.x ) /
			( segmentTemplate->mAttenuation.y - segmentTemplate->mAttenuation.x ) ) *
			mAttenuation;
	}
	return 0.0f;
}

float rvBSE::GetOriginAttenuation( rvSegmentTemplate *segmentTemplate ) const {
	if ( ( segmentTemplate->mAttenuation.x <= 0.0f &&
			segmentTemplate->mAttenuation.y <= 0.0f ) ||
			segmentTemplate->mAttenuation.x + 1.0f > mOriginDistanceToCamera ) {
		return segmentTemplate->mScale * mAttenuation;
	}
	if ( segmentTemplate->mAttenuation.y - 1.0f >= mOriginDistanceToCamera ) {
		return ( 1.0f - ( mOriginDistanceToCamera -
			segmentTemplate->mAttenuation.x ) /
			( segmentTemplate->mAttenuation.y - segmentTemplate->mAttenuation.x ) ) *
			segmentTemplate->mScale * mAttenuation;
	}
	return 0.0f;
}

void rvBSE::UpdateSoundEmitter( rvSegmentTemplate *segmentTemplate,
		rvSegment *segment ) {
	soundShaderParms_t parms;
	memset( &parms, 0, sizeof( parms ) );
	idSoundEmitter *emitter = GetReferenceSound( 1 );
	if ( emitter == NULL ) {
		return;
	}
	if ( mFlags & EFLAG_STOPPED ) {
		if ( segmentTemplate->GetSoundLooping() && segment->GetSoundPlaying() ) {
			emitter->StopSound( segment->GetSoundChannel() );
		}
	} else {
		parms.volume = segment->mSoundVolume;
		parms.frequencyShift = segment->mFreqShift;
		emitter->UpdateEmitter( mCurrentOrigin, mCurrentVelocity, 0, &parms );
	}
}

const idVec3 rvBSE::GetInterpolatedOffset( float time ) const {
	idVec3 result = vec3_origin;
	const float delta = mCurrentTime - mLastTime;
	if ( delta >= BSE_TIME_EPSILON ) {
		result = ( mCurrentOrigin - mLastOrigin ) *
			( 1.0f - ( time - mLastTime ) / delta );
	}
	return result;
}

void rvBSE::SetDuration( float time ) {
	if ( time > mDuration ) {
		mDuration = time;
	}
}

const char *rvBSE::GetDeclName( void ) {
	return mDeclEffect->GetName();
}

void rvBSE::UpdateFromOwner( renderEffect_t *parms, float time, bool init ) {
	mLastTime = mCurrentTime;
	mLastOrigin = mCurrentOrigin;
	mCurrentTime = time;
	mCurrentOrigin = parms->origin;
	mCurrentAxis = parms->axis;
	mCurrentAxisTransposed = mCurrentAxis.Transpose();

	const float timeDelta = mCurrentTime - mLastTime;
	if ( timeDelta > BSE_TIME_EPSILON ) {
		mCurrentVelocity = ( mCurrentOrigin - mLastOrigin ) / timeDelta;
	}

	mGravity = parms->gravity;
	mGravityDir = mGravity;
	mGravityDir.Normalize();

	const float size = mDeclEffect->GetSize();
	mCurrentWorldBounds.AddPoint( mCurrentOrigin + idVec3( size, size, size ) );
	mCurrentWorldBounds.AddPoint( mCurrentOrigin - idVec3( size, size, size ) );

	if ( GetHasEndOrigin() && mDeclEffect->GetUsesEndOrigin() &&
			( init || mCurrentEndOrigin != parms->endOrigin ||
			mCurrentOrigin != mLastOrigin ) ) {
		mCurrentEndOrigin = parms->endOrigin;
		mCurrentWorldBounds.AddPoint( mCurrentEndOrigin + idVec3( size, size, size ) );
		mCurrentWorldBounds.AddPoint( mCurrentEndOrigin - idVec3( size, size, size ) );
		SetEndOriginChanged( true );
	}

	mCurrentLocalBounds.Clear();
	for ( int corner = 0; corner < 8; ++corner ) {
		idVec3 point( mCurrentWorldBounds[( corner & 1 ) != 0].x,
			mCurrentWorldBounds[( corner & 2 ) != 0].y,
			mCurrentWorldBounds[( corner & 4 ) != 0].z );
		point -= mCurrentOrigin;
		point *= mCurrentAxisTransposed;
		mCurrentLocalBounds.AddPoint( point );
	}

	mTint.Set( parms->shaderParms[SHADERPARM_RED],
		parms->shaderParms[SHADERPARM_GREEN],
		parms->shaderParms[SHADERPARM_BLUE],
		parms->shaderParms[SHADERPARM_ALPHA] );
	mBrightness = parms->shaderParms[SHADERPARM_BRIGHTNESS];
	mSpriteSize.Set( parms->shaderParms[SHADERPARM_SPRITE_WIDTH],
		parms->shaderParms[SHADERPARM_SPRITE_HEIGHT] );
	mAttenuation = parms->attenuation;
}

void rvBSE::UpdateAttenuation( void ) {
	if ( !mDeclEffect->GetAttenuates() ) {
		return;
	}

	idVec3 viewOrigin;
	idMat3 viewAxis;
	game->GetPlayerView( viewOrigin, viewAxis );
	mOriginDistanceToCamera = idMath::ClampFloat( 1.0f, 131072.0f,
		mCurrentOrigin.Dist( viewOrigin ) );
	idVec3 localOrigin = viewOrigin - mCurrentOrigin;
	localOrigin *= mCurrentAxis;
	mShortestDistanceToCamera = idMath::ClampFloat( 1.0f, 131072.0f,
		mCurrentLocalBounds.ShortestDistance( localOrigin ) );
}

void rvBSE::LoopInstant( float time ) {
	if ( mDuration != 0.0f ) {
		return;
	}
	mStartTime += mDeclEffect->GetMaxDuration() + 0.5f;
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].ResetTime( this, mStartTime );
	}
	if ( bse_debug.GetInteger() == 2 ) {
		common->Printf( "BSE: Looping duration: %g\n",
			mDeclEffect->GetMaxDuration() + 0.5f );
	}
	mDeclEffect->IncLoopCount();
}

void rvBSE::LoopLooping( float time ) {
	if ( mDuration == 0.0f ) {
		return;
	}
	mStartTime += mDuration;
	mDuration = 0.0f;
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].ResetTime( this, mStartTime );
	}
	if ( bse_debug.GetInteger() == 2 ) {
		common->Printf( "BSE: Looping duration: %g\n", mDuration );
	}
	mDeclEffect->IncLoopCount();
}

bool rvBSE::Service( renderEffect_t *parms, float time ) {
	UpdateFromOwner( parms, time );
	UpdateAttenuation();
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].Check( this, time );
	}
	if ( !GetStopped() && parms->loop && mStartTime + mDuration < time ) {
		LoopLooping( time );
	}

	bool active = false;
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		if ( mSegments[segment].UpdateParticles( this, time ) ) {
			active = true;
		}
	}
	SetEndOriginChanged( false );
	if ( GetStopped() ) {
		return !active;
	}
	if ( parms->loop ) {
		if ( mStartTime + mDuration < time ) {
			LoopInstant( time );
		}
		return false;
	}
	return mStartTime + mDuration < time;
}

float rvBSE::EvaluateCost( int segment ) {
	if ( segment != -1 ) {
		return mSegments[segment].EvaluateCost();
	}
	mCost = 0.0f;
	for ( int index = 0; index < mSegments.Num(); ++index ) {
		mCost += mSegments[index].EvaluateCost();
	}
	return mCost;
}

void rvBSE::DisplayDebugInfo( const renderEffect_t *parms,
		const viewDef_t *view, idBounds &bounds ) {
	if ( bse_debug.GetInteger() != 0 ) {
		const idStr text = va( "(%g) (%g) (%g)\n%s", mCost,
			mDeclEffect->GetSize(), parms->shaderParms[SHADERPARM_BRIGHTNESS],
			GetDeclName() );
		view->renderWorld->DebugAxis( parms->origin, parms->axis );
		view->renderWorld->DrawText( text.c_str(), parms->origin, 0.3f,
			colorCyan, view->renderView.viewaxis, 1 );
	}
	if ( bse_showBounds.GetInteger() != 0 ) {
		idBounds geometryWorldBounds;
		geometryWorldBounds.FromTransformedBounds( bounds, parms->origin, parms->axis );
		view->renderWorld->DebugBounds( colorGreen, mCurrentWorldBounds );
		if ( geometryWorldBounds[0].x < mCurrentWorldBounds[0].x ||
				geometryWorldBounds[0].y < mCurrentWorldBounds[0].y ||
				geometryWorldBounds[0].z < mCurrentWorldBounds[0].z ||
				geometryWorldBounds[1].x > mCurrentWorldBounds[1].x ||
				geometryWorldBounds[1].y > mCurrentWorldBounds[1].y ||
				geometryWorldBounds[1].z > mCurrentWorldBounds[1].z ) {
			view->renderWorld->DebugBounds( colorRed, geometryWorldBounds );
		}
	}
}

idRenderModel *rvBSE::Render( const renderEffect_t *owner,
		const viewDef_t *view ) {
	if ( !bse_render.GetBool() ) {
		return NULL;
	}

	rvRenderModelBSE *model = new rvRenderModelBSE;
	mViewAxis = view->renderView.viewaxis;
	mViewOrg = view->renderView.vieworg;
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		if ( mSegments[segment].Active() ) {
			mSegments[segment].Render( this, owner, model, view->floatTime );
			mSegments[segment].RenderTrail( this, owner, model, view->floatTime );
		}
	}
	DisplayDebugInfo( owner, view, model->bounds );
	return model;
}

void rvBSE::Destroy( void ) {
	idSoundEmitter *emitter = GetReferenceSound( 1 );
	if ( emitter != NULL ) {
		emitter->StopSound( SCHANNEL_ANY );
		soundSystem->FreeSoundEmitter( 1, emitter->Handle(), true );
	}
	mSegments.Clear();
}

void rvBSE::UpdateSegments( float time ) {
	mSegments.SetNum( mDeclEffect->GetNumSegmentTemplates() );
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].Init( this, mDeclEffect, segment, time );
	}
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].CalcCounts( this, time );
	}
	for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
		mSegments[segment].InitParticles( this );
	}

	if ( GetLooping() && ( mFlags & BIT( 4 ) ) && mDuration != 0.0f ) {
		while ( time - mDuration * 2.0f > mStartTime ) {
			mStartTime += mDuration;
			for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
				mSegments[segment].Advance( this );
			}
		}
		mCurrentTime -= mDuration * 2.0f;
		mStartTime -= mDuration * 2.0f;
		for ( int segment = 0; segment < mSegments.Num(); ++segment ) {
			mSegments[segment].Rewind( this );
		}
	}
}

void rvBSE::Init( rvDeclEffect *declEffect, renderEffect_t *parms, float time ) {
	mFlags = 0;
	mDeclEffect = declEffect;
	mStartTime = parms->startTime;
	mLastTime = time;
	mDuration = 0.0f;
	mAttenuation = 1.0f;
	mCost = 0.0f;
	SetLooping( parms->loop );
	SetFlag( parms->ambient, BIT( 4 ) );

	mCurrentLocalBounds.Zero();
	mCurrentLocalBounds.ExpandSelf( declEffect->GetSize() );
	mOriginalOrigin = parms->origin;
	mOriginalEndOrigin.Zero();
	mOriginalAxis = parms->axis;
	mCurrentWorldBounds = mCurrentLocalBounds;
	mCurrentWorldBounds.TranslateSelf( mOriginalOrigin );
	if ( parms->hasEndOrigin ) {
		SetHasEndOrigin( true );
		mOriginalEndOrigin = parms->endOrigin;
		mCurrentEndOrigin = parms->endOrigin;
	}
	mCurrentTime = time;
	mCurrentOrigin = mOriginalOrigin;
	mCurrentVelocity.Zero();
	UpdateFromOwner( parms, time, true );
	mReferenceSoundHandle = parms->referenceSoundHandle;
	UpdateSegments( time );
	mOriginDistanceToCamera = 0.0f;
	mShortestDistanceToCamera = 0.0f;
	mSpriteSize.Zero();
}
