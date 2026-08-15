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
#include "../framework/Session.h"
#include "../game/Game.h"

// Retail compilation unit: BSE_Particle.obj. Implementations are recovered here.

void rvParticle::SetOriginUsingEndOrigin( rvBSE *effect,
		rvParticleTemplate *pt, idVec3 *normal, idVec3 *centre ) {
	pt->mSpawnPosition.Spawn( mInitPos.ToFloatPtr(), pt->mSpawnPosition,
		normal, centre );

	rvParticleParms temp = pt->mSpawnPosition;
	temp.mMins.x = mInitPos.x;
	temp.mMaxs.x = ( effect->GetCurrentEndOrigin() -
		effect->GetOriginalOrigin() ).Length();
	mInitPos.x = mFraction;
	temp.Spawn( mInitPos.ToFloatPtr(), temp, normal, centre );
}

void rvParticle::HandleEndOrigin( rvBSE *effect, rvParticleTemplate *pt,
		idVec3 *normal, idVec3 *centre ) {
	mInitPos.x = mFraction;
	if ( effect->GetHasEndOrigin() &&
			( pt->mSpawnPosition.mFlags & PPFLAG_USEENDORIGIN ) ) {
		SetOriginUsingEndOrigin( effect, pt, normal, centre );
	} else {
		pt->mSpawnPosition.Spawn( mInitPos.ToFloatPtr(),
			pt->mSpawnPosition, normal, centre );
	}
}

void rvParticle::SetLengthUsingEndOrigin( rvBSE *effect,
		rvParticleParms &parms, float *length ) {
	rvParticleParms temp = parms;
	const float endOriginLength = ( effect->GetCurrentEndOrigin() -
		effect->GetCurrentOrigin() ).Length();
	temp.mFlags = 0;
	temp.mMins.x += endOriginLength;
	temp.mMaxs.x += endOriginLength;
	temp.Spawn( length, temp );
}

void rvParticle::FinishSpawn( rvBSE *effect, rvSegment *segment,
		float birthTime, float fraction, const idVec3 &initOffset,
		const idMat3 &initAxis ) {
	rvSegmentTemplate *segmentTemplate = segment->GetSegmentTemplate();
	if ( segmentTemplate == NULL ) {
		return;
	}
	rvParticleTemplate *pt = segmentTemplate->GetParticleTemplate();

	mFlags = pt->mFlags;
	SetLocked( segment->GetLocked() );
	pt->mSpawnVelocity.Spawn( mVelocity.ToFloatPtr(), pt->mSpawnVelocity );
	pt->mSpawnAcceleration.Spawn( mAcceleration.ToFloatPtr(),
		pt->mSpawnAcceleration );
	pt->mSpawnFriction.Spawn( mFriction.ToFloatPtr(), pt->mSpawnFriction );
	mFraction = fraction;
	mTextureScale = 1.0f;

	idVec3 *normal = NULL;
	idVec3 *centre = NULL;
	if ( pt->GetGeneratedOriginNormal() ) {
		normal = &mNormal;
	} else if ( pt->GetGeneratedNormal() ) {
		normal = &mNormal;
		centre = &pt->mCentre;
	} else if ( pt->GetCalculatedNormal() ) {
		pt->mSpawnDirection.Spawn( mNormal.ToFloatPtr(),
			pt->mSpawnDirection );
	} else {
		mNormal.Set( 1.0f, 0.0f, 0.0f );
	}
	HandleEndOrigin( effect, pt, normal, centre );

	if ( pt->GetLinked() ) {
		mVelocity = initAxis * mVelocity;
	}

	rvAngles orientation = mNormal.ToRadians();
	if ( pt->GetGeneratedNormal() || pt->GetGeneratedOriginNormal() ) {
		mNormal.Normalize();
		idMat3 normalAxis;
		mNormal.ToMat3( normalAxis );
		mVelocity = normalAxis * mVelocity;
		TransformLength( mNormal );
	}
	if ( pt->GetFlippedNormal() ) {
		mVelocity = -mVelocity;
		ScaleLength( -1.0f );
	}

	if ( mVelocity.LengthSqr() != 0.0f ) {
		mNormal = mVelocity;
		mNormal.Normalize();
	}
	idMat3 motionAxis;
	mNormal.ToMat3( motionAxis );
	mAcceleration = motionAxis * mAcceleration;
	if ( mAcceleration.LengthSqr() != 0.0f ) {
		mNormal = mAcceleration;
		mNormal.Normalize();
	}
	mNormal.ToMat3( motionAxis );
	mFriction = motionAxis * mFriction;

	if ( !GetLocked() ) {
		mInitAxis = effect->GetCurrentAxis();
		mInitEffectPos = effect->GetCurrentOrigin();
		mInitPos -= mInitAxis.Transpose() *
			effect->GetInterpolatedOffset( birthTime );
	}
	if ( pt->GetLinked() ) {
		mInitPos += initOffset;
	}

	pt->mSpawnTint.Spawn( mTintEnv.GetStart(), pt->mSpawnTint );
	pt->mSpawnFade.Spawn( mFadeEnv.GetStart(), pt->mSpawnFade );
	pt->mSpawnSize.Spawn( GetInitSize(), pt->mSpawnSize );
	pt->mSpawnRotate.Spawn( GetInitRotation(), pt->mSpawnRotate );
	pt->mSpawnAngle.Spawn( mAngleEnv.GetStart(), pt->mSpawnAngle );
	pt->mSpawnOffset.Spawn( mOffsetEnv.GetStart(), pt->mSpawnOffset );
	pt->mDeathTint.Spawn( mTintEnv.GetEnd(), pt->mDeathTint );
	pt->mDeathFade.Spawn( mFadeEnv.GetEnd(), pt->mDeathFade );
	pt->mDeathSize.Spawn( GetDestSize(), pt->mDeathSize );
	pt->mDeathRotate.Spawn( GetDestRotation(), pt->mDeathRotate );
	pt->mDeathAngle.Spawn( mAngleEnv.GetEnd(), pt->mDeathAngle );
	pt->mDeathOffset.Spawn( mOffsetEnv.GetEnd(), pt->mDeathOffset );
	if ( pt->mSpawnOffset.mSpawnType != SPF_NONE_3 ||
			pt->mDeathOffset.mSpawnType != SPF_NONE_3 ) {
		SetHasOffset( true );
	}

	pt->mDeathTint.HandleRelativeParms( mTintEnv.GetEnd(),
		mTintEnv.GetStart(), 3 );
	pt->mDeathFade.HandleRelativeParms( mFadeEnv.GetEnd(),
		mFadeEnv.GetStart(), 1 );
	pt->mDeathSize.HandleRelativeParms( GetDestSize(), GetInitSize(),
		pt->mNumSizeParms );
	pt->mDeathRotate.HandleRelativeParms( GetDestRotation(),
		GetInitRotation(), pt->mNumRotateParms );
	pt->mDeathAngle.HandleRelativeParms( mAngleEnv.GetEnd(),
		mAngleEnv.GetStart(), 3 );
	pt->mDeathOffset.HandleRelativeParms( mOffsetEnv.GetEnd(),
		mOffsetEnv.GetStart(), 3 );

	ScaleRotation( idMath::TWO_PI );
	ScaleAngle( idMath::TWO_PI );
	HandleOrientation( orientation );
	mTrailTime = pt->GetTrailTime();
	mTrailCount = pt->GetTrailCount();
	SetModel( pt->mModelName.c_str() );
	SetupElectricity( pt );

	const float attenuation = effect->GetAttenuation( segmentTemplate );
	AttenuateFade( attenuation, pt->mSpawnFade );
	AttenuateSize( attenuation, pt->mSpawnSize );

	const float duration = pt->GetDuration();
	mStartTime = birthTime;
	mEndTime = birthTime + duration;
	mMotionStartTime = birthTime;
	mLastTrailTime = birthTime;
	mTintEnv.Init( pt->mTintEnvelope, duration );
	mFadeEnv.Init( pt->mFadeEnvelope, duration );
	InitSizeEnv( pt->mSizeEnvelope, duration );
	InitRotationEnv( pt->mRotateEnvelope, duration );
	mAngleEnv.Init( pt->mAngleEnvelope, duration );
	mOffsetEnv.Init( pt->mOffsetEnvelope, duration );

	const idVec3 gravity = pt->GetGravity() * effect->GetGravity();
	mAcceleration += effect->GetCurrentAxisTransposed() * gravity;
}

void rvLineParticle::FinishSpawn( rvBSE *effect, rvSegment *segment,
		float birthTime, float fraction, const idVec3 &initOffset,
		const idMat3 &initAxis ) {
	rvSegmentTemplate *segmentTemplate = segment->GetSegmentTemplate();
	if ( segmentTemplate == NULL ) {
		return;
	}
	rvParticleTemplate *pt = segmentTemplate->GetParticleTemplate();
	if ( effect->GetHasEndOrigin() &&
			( pt->mSpawnLength.mFlags & PPFLAG_USEENDORIGIN ) ) {
		SetLengthUsingEndOrigin( effect, pt->mSpawnLength, GetInitLength() );
	} else {
		pt->mSpawnLength.Spawn( GetInitLength(), pt->mSpawnLength );
	}
	if ( effect->GetHasEndOrigin() &&
			( pt->mDeathLength.mFlags & PPFLAG_USEENDORIGIN ) ) {
		SetLengthUsingEndOrigin( effect, pt->mDeathLength, GetDestLength() );
	} else {
		pt->mDeathLength.Spawn( GetDestLength(), pt->mDeathLength );
	}

	rvParticle::FinishSpawn( effect, segment, birthTime, fraction,
		initOffset, initAxis );
	pt->mDeathLength.HandleRelativeParms( GetDestLength(),
		GetInitLength(), 3 );
	HandleTiling( pt );
	AttenuateLength( effect->GetAttenuation( segmentTemplate ),
		pt->mSpawnLength );
	mLengthEnv.Init( pt->mLengthEnvelope, GetDuration() );
}

void rvLinkedParticle::FinishSpawn( rvBSE *effect, rvSegment *segment,
		float birthTime, float fraction, const idVec3 &initOffset,
		const idMat3 &initAxis ) {
	rvSegmentTemplate *segmentTemplate = segment->GetSegmentTemplate();
	if ( segmentTemplate == NULL ) {
		return;
	}
	rvParticle::FinishSpawn( effect, segment, birthTime, fraction,
		initOffset, initAxis );
	HandleTiling( segmentTemplate->GetParticleTemplate() );
}

void rvDebrisParticle::FinishSpawn( rvBSE *effect, rvSegment *segment,
		float birthTime, float fraction, const idVec3 &initOffset,
		const idMat3 &initAxis ) {
	(void)initOffset;
	(void)initAxis;
	if ( !bse_debris.GetBool() || session->readDemo != NULL ) {
		return;
	}
	rvSegmentTemplate *segmentTemplate = segment->GetSegmentTemplate();
	if ( segmentTemplate == NULL ) {
		return;
	}
	rvParticleTemplate *pt = segmentTemplate->GetParticleTemplate();
	mFlags = pt->mFlags;
	pt->mSpawnVelocity.Spawn( mVelocity.ToFloatPtr(), pt->mSpawnVelocity );
	mFraction = fraction;
	mTextureScale = 1.0f;
	if ( pt->GetGeneratedOriginNormal() ) {
		HandleEndOrigin( effect, pt, &mNormal, NULL );
	} else if ( pt->GetGeneratedNormal() ) {
		HandleEndOrigin( effect, pt, &mNormal, &pt->mCentre );
	} else {
		HandleEndOrigin( effect, pt );
		mNormal.Set( 1.0f, 0.0f, 0.0f );
	}
	if ( pt->GetGeneratedNormal() || pt->GetGeneratedOriginNormal() ) {
		mNormal.Normalize();
		idMat3 normalAxis;
		mNormal.ToMat3( normalAxis );
		mVelocity = normalAxis * mVelocity;
		TransformLength( mNormal );
	}
	if ( pt->GetFlippedNormal() ) {
		mVelocity = -mVelocity;
		ScaleLength( -1.0f );
	}
	if ( mVelocity.LengthSqr() != 0.0f ) {
		mNormal = mVelocity;
		mNormal.Normalize();
	}
	mFriction.Zero();
	mInitAxis = effect->GetCurrentAxis();
	mInitEffectPos = effect->GetCurrentOrigin();
	mInitPos -= mInitAxis.Transpose() *
		effect->GetInterpolatedOffset( birthTime );

	pt->mSpawnRotate.Spawn( GetInitRotation(), pt->mSpawnRotate );
	pt->mSpawnAngle.Spawn( mAngleEnv.GetStart(), pt->mSpawnAngle );
	pt->mDeathRotate.Spawn( GetDestRotation(), pt->mDeathRotate );
	ScaleRotation( idMath::TWO_PI );
	ScaleAngle( idMath::TWO_PI );
	InitRotationEnv( pt->mRotateEnvelope, 1.0f );
	mAngleEnv.Init( pt->mAngleEnvelope, 1.0f );
	mStartTime = birthTime;
	mMotionStartTime = birthTime;
	mEndTime = birthTime;
	mLastTrailTime = birthTime;
	mTrailTime = 0.0f;
	mTrailCount = 0;
	mAcceleration.Zero();
	const idVec3 gravity = pt->GetGravity() * effect->GetGravity();
	mAcceleration += effect->GetCurrentAxisTransposed() * gravity;

	const idVec3 origin = effect->GetOriginalOrigin() +
		effect->GetOriginalAxis() * mInitPos;
	const idMat3 axis = effect->GetCurrentAxis();
	const idVec3 velocity = axis * mVelocity;
	const float *angular = GetDestRotation();
	const idVec3 angularVelocity( angular[0], angular[1], angular[2] );
	game->SpawnClientMoveable( pt->mEntityDefName.c_str(),
		static_cast<int>( ( mEndTime - mStartTime ) * 1000.0f ), origin,
		axis, velocity, angularVelocity );
}

void rvLineParticle::Refresh( rvBSE *effect, rvSegmentTemplate *st,
		rvParticleTemplate *pt ) {
	(void)st;
	if ( effect->GetHasEndOrigin() &&
			( pt->mSpawnLength.mFlags & PPFLAG_USEENDORIGIN ) ) {
		SetLengthUsingEndOrigin( effect, pt->mSpawnLength, GetInitLength() );
	} else {
		pt->mSpawnLength.Spawn( GetInitLength(), pt->mSpawnLength );
	}
	if ( effect->GetHasEndOrigin() &&
			( pt->mDeathLength.mFlags & PPFLAG_USEENDORIGIN ) ) {
		SetLengthUsingEndOrigin( effect, pt->mDeathLength, GetDestLength() );
	} else {
		pt->mDeathLength.Spawn( GetDestLength(), pt->mDeathLength );
	}
	pt->mDeathLength.HandleRelativeParms( GetDestLength(),
		GetInitLength(), 3 );
	HandleTiling( pt );
	mLengthEnv.Init( pt->mLengthEnvelope, GetDuration() );
}

void rvParticle::Attenuate( float atten, rvParticleParms &parms, rvEnvParms1 &result ) {
	if ( parms.mFlags & PPFLAG_ATTENUATE ) {
		const float scale = ( parms.mFlags & PPFLAG_INV_ATTENUATE ) ? 1.0f - atten : atten;
		*result.GetStart() *= scale;
		*result.GetEnd() *= scale;
	}
}

void rvLineParticle::HandleTiling( rvParticleTemplate *pt ) {
	if ( mFlags & PTFLAG_TILED ) {
		const float *length = GetInitLength();
		mTextureScale = idVec3( length[0], length[1], length[2] ).Length() / pt->mTiling;
	}
}

void rvLinkedParticle::HandleTiling( rvParticleTemplate *pt ) {
	if ( mFlags & PTFLAG_TILED ) {
		mTextureScale = pt->mTiling;
	}
}

rvParticle *rvSpriteParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvSpriteParticle *>( this ) + i;
}

int rvSpriteParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvSpriteParticle *>( p ) - this );
}

rvParticle *rvDecalParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvDecalParticle *>( this ) + i;
}

int rvDecalParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvDecalParticle *>( p ) - this );
}

rvParticle *rvLineParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvLineParticle *>( this ) + i;
}

int rvLineParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvLineParticle *>( p ) - this );
}

rvParticle *rvOrientedParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvOrientedParticle *>( this ) + i;
}

int rvOrientedParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvOrientedParticle *>( p ) - this );
}

rvParticle *rvModelParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvModelParticle *>( this ) + i;
}

int rvModelParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvModelParticle *>( p ) - this );
}

rvParticle *rvElectricityParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvElectricityParticle *>( this ) + i;
}

int rvElectricityParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvElectricityParticle *>( p ) - this );
}

rvParticle *rvLightParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvLightParticle *>( this ) + i;
}

int rvLightParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvLightParticle *>( p ) - this );
}

rvParticle *rvLinkedParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvLinkedParticle *>( this ) + i;
}

int rvLinkedParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvLinkedParticle *>( p ) - this );
}

rvParticle *rvDebrisParticle::GetArrayEntry( int i ) const {
	return i < 0 ? NULL : const_cast<rvDebrisParticle *>( this ) + i;
}

int rvDebrisParticle::GetArrayIndex( rvParticle *p ) const {
	return p == NULL ? -1 : static_cast<int>( static_cast<rvDebrisParticle *>( p ) - this );
}

void rvParticle::EvaluateVelocity( const rvBSE *, idVec3 &velocity, float time ) {
	if ( mFlags & PTFLAG_STATIONARY ) {
		velocity.Set( 1.0f, 0.0f, 0.0f );
		return;
	}

	velocity = mVelocity + time * mAcceleration;
	const float duration = mEndTime - mStartTime;
	const float frictionScale =
		( idMath::Exp( ( duration - time ) / duration ) * ( 1.0f - time / 3.0f ) + 1.0f ) *
		time * time * 0.5f;
	velocity += frictionScale * mFriction;
}

void rvEnvParms3::Scale( const float constant ) {
	mStart *= constant;
	mEnd *= constant;
}

void rvParticle::ScaleAngle( float constant ) {
	mAngleEnv.Scale( constant );
}

void rvParticle::AttenuateFade( float atten, rvParticleParms &parms ) {
	Attenuate( atten, parms, mFadeEnv );
}

void rvParticle::Attenuate( float atten, rvParticleParms &parms, rvEnvParms3 &result ) {
	if ( parms.mFlags & PPFLAG_ATTENUATE ) {
		result.Scale( ( parms.mFlags & PPFLAG_INV_ATTENUATE ) ? 1.0f - atten : atten );
	}
}

void rvParticle::Attenuate( float atten, rvParticleParms &parms, rvEnvParms2 &result ) {
	if ( parms.mFlags & PPFLAG_ATTENUATE ) {
		result.Scale( ( parms.mFlags & PPFLAG_INV_ATTENUATE ) ? 1.0f - atten : atten );
	}
}

static void RV_GetParticleTint( rvEnvParms3 &tintEnv, rvEnvParms1 &fadeEnv, idVec4 &tint ) {
	const float *rgb = tintEnv.GetStart();
	tint.Set( rgb[0], rgb[1], rgb[2], *fadeEnv.GetStart() );
}

void rvSpriteParticle::GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {
	RV_GetParticleTint( mTintEnv, mFadeEnv, tint );
	const float *initialSize = mSizeEnv.GetStart();
	size.Set( initialSize[0], initialSize[1], 0.0f );
	rotate.Set( *mRotationEnv.GetStart(), 0.0f, 0.0f );
}

void rvLineParticle::GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {
	RV_GetParticleTint( mTintEnv, mFadeEnv, tint );
	size.Set( *mSizeEnv.GetStart(), 0.0f, 0.0f );
	rotate.Zero();
}

void rvOrientedParticle::GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {
	RV_GetParticleTint( mTintEnv, mFadeEnv, tint );
	const float *initialSize = mSizeEnv.GetStart();
	size.Set( initialSize[0], initialSize[1], 0.0f );
	const float *initialRotation = mRotationEnv.GetStart();
	rotate.Set( initialRotation[0], initialRotation[1], initialRotation[2] );
}

void rvModelParticle::GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {
	RV_GetParticleTint( mTintEnv, mFadeEnv, tint );
	const float *initialSize = mSizeEnv.GetStart();
	size.Set( initialSize[0], initialSize[1], initialSize[2] );
	const float *initialRotation = mRotationEnv.GetStart();
	rotate.Set( initialRotation[0], initialRotation[1], initialRotation[2] );
}

void rvLightParticle::GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {
	RV_GetParticleTint( mTintEnv, mFadeEnv, tint );
	const float *initialSize = mSizeEnv.GetStart();
	size.Set( initialSize[0], initialSize[1], initialSize[2] );
	rotate.Zero();
}

void rvParticle::Bounce( rvBSE *effect, rvParticleTemplate *pt,
		idVec3 endPos, idVec3 normal, float time ) {
	idVec3 oldVelocity;
	EvaluateVelocity( effect, oldVelocity, time - mMotionStartTime );
	oldVelocity = effect->GetCurrentAxis() * oldVelocity;
	const idVec3 reflected = ( oldVelocity -
		2.0f * ( oldVelocity * normal ) * normal ) * pt->mBounce;
	mVelocity = effect->GetCurrentAxisTransposed() * reflected;
	mMotionStartTime = time;
	mInitPos = effect->GetCurrentAxisTransposed() *
		( endPos - effect->GetCurrentOrigin() );

	if ( mVelocity.LengthSqr() < BSE_BOUNCE_LIMIT &&
			normal * effect->GetGravityDir() < -idMath::SQRT_1OVER2 ) {
		SetStationary( true );
		mVelocity.Zero();
	}
}

void rvParticle::EvaluatePosition( const rvBSE *effect, idVec3 &pos,
		float time ) {
	if ( GetStationary() ) {
		pos = mInitPos;
	} else {
		pos = mInitPos + time * mVelocity;
		if ( GetHasOffset() ) {
			rvAngles angle;
			idVec3 offset;
			mAngleEnv.Evaluate( time, angle.ToFloatPtr() );
			mOffsetEnv.Evaluate( time, offset.ToFloatPtr() );
			idMat3 angleAxis;
			angle.ToMat3( angleAxis );
			pos += angleAxis * offset;
		}

		const float halfTimeSquared = time * time * 0.5f;
		pos += halfTimeSquared * mAcceleration;
		if ( mFriction.LengthSqr() != 0.0f ) {
			const float duration = mEndTime - mStartTime;
			const float frictionScale = halfTimeSquared *
				( idMath::Exp( ( duration - halfTimeSquared ) / duration ) - 1.0f ) *
				halfTimeSquared * ( 1.0f / 3.0f );
			pos += frictionScale * mFriction;
		}
	}

	if ( !GetLocked() ) {
		const idMat3 axisDelta = mInitAxis *
			effect->GetCurrentAxis().Transpose();
		pos = axisDelta * pos;
		pos += effect->GetCurrentAxisTransposed() *
			( mInitEffectPos - effect->GetCurrentOrigin() );
	}
}

void rvParticle::CheckTimeoutEffect( rvBSE *effect,
		rvSegmentTemplate *st, float time ) {
	if ( !st->GetEnabled() ) {
		return;
	}
	rvParticleTemplate *pt = st->GetParticleTemplate();
	if ( pt->mNumTimeoutEffects == 0 ) {
		return;
	}

	const int random = rvRandom::irand( 0, pt->mNumTimeoutEffects - 1 );
	idVec3 position;
	idVec3 velocity;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	EvaluateVelocity( effect, velocity, time - mMotionStartTime );
	velocity.Normalize();
	velocity = effect->GetCurrentAxis() * velocity;
	position = effect->GetCurrentOrigin() +
		effect->GetCurrentAxis() * position;
	idMat3 axis;
	velocity.ToMat3( axis );
	game->PlayEffect( pt->mTimeoutEffects[random], position, axis );
}

void rvParticle::CalcImpactPoint( idVec3 &endPos, const idVec3 &origin,
		const idVec3 &motion, const idBounds &bounds,
		const idVec3 &normal ) {
	endPos = origin;
	const idVec3 extents = bounds[1] - bounds[0];
	if ( extents.x == 0.0f || extents.y == 0.0f || extents.z == 0.0f ||
			motion.LengthSqr() == 0.0f ) {
		return;
	}

	idVec3 work( motion.x / extents.x, motion.y / extents.y,
		motion.z / extents.z );
	work.Normalize();
	int dominantAxis = 0;
	if ( idMath::Fabs( work.y ) >= idMath::Fabs( work.x ) &&
			idMath::Fabs( work.y ) >= idMath::Fabs( work.z ) ) {
		dominantAxis = 1;
	} else if ( idMath::Fabs( work.z ) >= idMath::Fabs( work.x ) &&
			idMath::Fabs( work.z ) >= idMath::Fabs( work.y ) ) {
		dominantAxis = 2;
	}
	const float scale = 0.5f / idMath::Fabs( work[dominantAxis] );
	work.x *= extents.x * scale;
	work.y *= extents.y * scale;
	work.z *= extents.z * scale;
	endPos += work + normal * BSE_SURFACE_OFFSET;
}

void rvParticle::EmitSmokeParticles( rvBSE *effect, rvSegment *child,
		float time ) {
	const float futureTime = time + BSE_FUTURE;
	while ( mLastTrailTime < futureTime ) {
		rvSegmentTemplate *childTemplate = child->GetSegmentTemplate();
		if ( mLastTrailTime >= mStartTime && mLastTrailTime < mEndTime ) {
			idVec3 position;
			idVec3 velocity;
			EvaluatePosition( effect, position, mLastTrailTime - mStartTime );
			EvaluateVelocity( effect, velocity, mLastTrailTime - mStartTime );
			velocity.Normalize();
			idMat3 axis;
			velocity.ToMat3( axis );
			child->SpawnParticle( effect, childTemplate, mLastTrailTime,
				position, axis );
		}
		mLastTrailTime += child->AttenuateInterval( effect, childTemplate );
	}
}

bool rvParticle::RunPhysics( rvBSE *effect, rvSegmentTemplate *st,
		float time ) {
	if ( !bse_physics.GetBool() || session->readDemo != NULL ||
			GetStationary() || !st->GetEnabled() ) {
		return false;
	}
	rvParticleTemplate *pt = st->GetParticleTemplate();
	if ( !pt->GetHasPhysics() ||
			time - mMotionStartTime < BSE_PHYSICS_TIME_SAMPLE ) {
		return false;
	}

	idVec3 source;
	idVec3 dest;
	EvaluatePosition( effect, source,
		time - mMotionStartTime - BSE_PHYSICS_TIME_SAMPLE );
	EvaluatePosition( effect, dest, time - mMotionStartTime );
	source = effect->GetCurrentOrigin() + effect->GetCurrentAxis() * source;
	dest = effect->GetCurrentOrigin() + effect->GetCurrentAxis() * dest;

	trace_t trace;
	idTraceModel *traceModel = pt->GetTraceModel();
	game->Translation( trace, source, dest, traceModel,
		CONTENTS_SOLID | CONTENTS_RENDERMODEL );
	if ( trace.fraction >= 1.0f ) {
		return false;
	}

	if ( pt->mNumImpactEffects != 0 &&
			bse->CanPlayRateLimited( EC_IMPACT_PARTICLES ) ) {
		idVec3 impactPoint = trace.endpos;
		if ( traceModel != NULL ) {
			const idVec3 motion = ( dest - source ) * trace.fraction;
			CalcImpactPoint( impactPoint, trace.endpos, motion,
				traceModel->bounds, trace.c.normal );
		}
		const int random = rvRandom::irand( 0, pt->mNumImpactEffects - 1 );
		idMat3 impactAxis;
		trace.c.normal.ToMat3( impactAxis );
		game->PlayEffect( pt->mImpactEffects[random], impactPoint, impactAxis );
	}
	if ( pt->mBounce != 0.0f ) {
		Bounce( effect, pt, trace.endpos, trace.c.normal, time );
	}
	return pt->GetDeleteOnImpact();
}
