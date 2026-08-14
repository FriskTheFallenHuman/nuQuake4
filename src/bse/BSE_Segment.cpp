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
#include "../game/Game.h"
#include "../renderer/tr_local.h"
#include "../renderer/Model_local.h"

// Retail compilation unit: BSE_Segment.obj.

float rvSegment::mSegmentBaseCosts[SEG_COUNT] = {
	0.0f, 5.0f, 20.0f, 20.0f, 5.0f, 50.0f, 20.0f, 100.0f, 1.0f, 50.0f, 5.0f, 50.0f
};

void rvModelParticle::SetModel( const char *modelName ) {
	mModel = renderModelManager->FindModel( modelName );
}

void rvParticle::DoRenderBurnTrail( rvBSE *effect, const idMat3 &view, srfTriangles_t *tri, float time ) {
	if ( mTrailCount <= 0 || mTrailTime <= 0.0f ) { return; }
	const float delta = mTrailTime / mTrailCount;
	for ( int i = 1; i <= mTrailCount; ++i ) {
		const float trailTime = time - i * delta;
		if ( trailTime >= mStartTime && trailTime < mEndTime ) {
			Render( effect, view, tri, trailTime, (float)( mTrailCount - i ) / mTrailCount );
		}
	}
}

rvSegment::~rvSegment() {
	if ( !mParticles ) {
		return;
	}
	rvSegmentTemplate *st = GetSegmentTemplate();
	const int type = st ? st->GetParticleTemplate()->GetType() : PTYPE_SPRITE;
	switch ( type ) {
		case PTYPE_LINE: delete[] static_cast<rvLineParticle *>( mParticles ); break;
		case PTYPE_ORIENTED: delete[] static_cast<rvOrientedParticle *>( mParticles ); break;
		case PTYPE_DECAL: delete[] static_cast<rvDecalParticle *>( mParticles ); break;
		case PTYPE_MODEL: delete[] static_cast<rvModelParticle *>( mParticles ); break;
		case PTYPE_LIGHT: delete[] static_cast<rvLightParticle *>( mParticles ); break;
		case PTYPE_ELECTRICITY: delete[] static_cast<rvElectricityParticle *>( mParticles ); break;
		case PTYPE_LINKED: delete[] static_cast<rvLinkedParticle *>( mParticles ); break;
		case PTYPE_DEBRIS: delete[] static_cast<rvDebrisParticle *>( mParticles ); break;
		default: delete[] static_cast<rvSpriteParticle *>( mParticles ); break;
	}
	mParticles = NULL;
	mFreeHead = NULL;
	mUsedHead = NULL;
}

rvSegmentTemplate *rvSegment::GetSegmentTemplate() {
	return mEffectDecl ? const_cast<rvDeclEffect *>( mEffectDecl )->GetSegmentTemplate( mSegmentTemplateHandle ) : NULL;
}

bool rvSegment::GetLocked() {
	rvSegmentTemplate *st = GetSegmentTemplate();
	return st && st->GetLocked();
}

void rvSegment::ValidateSpawnRates() {
	mSecondsPerParticle.y = idMath::ClampFloat( BSE_TIME_EPSILON, BSE_MAX_DURATION, mSecondsPerParticle.y );
	mSecondsPerParticle.x = idMath::ClampFloat( mSecondsPerParticle.y, BSE_MAX_DURATION, mSecondsPerParticle.x );
}

void rvSegment::GetSecondsPerParticle( rvBSE *effect, rvSegmentTemplate *st, rvParticleTemplate *pt ) {
	if ( st->mDensity.y == 0.0f ) {
		mCount = st->mCount;
	} else {
		const float volume = idMath::ClampFloat( BSE_TIME_EPSILON, 1000.0f, pt->GetSpawnVolume( effect ) );
		mCount.Set( volume * st->mDensity.x, volume * st->mDensity.y );
		if ( st->mParticleCap != 0.0f ) {
			mCount.x = idMath::ClampFloat( 1.0f, st->mParticleCap, mCount.x );
			mCount.y = idMath::ClampFloat( 1.0f, st->mParticleCap, mCount.y );
		}
	}
	if ( st->mSegType == SEG_EMITTER || st->mSegType == SEG_TRAIL ) {
		if ( mCount.x != 0.0f ) { mSecondsPerParticle.x = 1.0f / mCount.x; }
		if ( mCount.y != 0.0f ) { mSecondsPerParticle.y = 1.0f / mCount.y; }
		ValidateSpawnRates();
	}
}

void rvSegment::InitTime( rvBSE *effect, rvSegmentTemplate *st, float time ) {
	SetExpired( false );
	mSegStartTime = st->GetStartTime() + time;
	mSegEndTime = st->GetDuration() + mSegStartTime;
	if ( !st->GetIgnoreDuration() || ( !effect->GetLooping() && !st->GetSoundLooping() ) ) {
		effect->SetDuration( mSegEndTime - time );
	}
}

void rvSegment::Init( rvBSE *effect, const rvDeclEffect *decl, int segmentTemplateHandle, float time ) {
	mFlags = 0;
	mEffectDecl = decl;
	mSegmentTemplateHandle = segmentTemplateHandle;
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st ) { return; }
	mLastTime = time;
	mActiveCount = 0;
	mSecondsPerParticle.Zero();
	mCount.Set( 1.0f, 1.0f );
	mSoundVolume = 0.0f;
	mParticles = NULL;
	mFreeHead = NULL;
	mUsedHead = NULL;
	mFreqShift = 1.0f;
	mParticleCount = 0;
	mLoopParticleCount = 0;
	InitTime( effect, st, effect->GetStartTime() );
	GetSecondsPerParticle( effect, st, st->GetParticleTemplate() );
	st->mBSEEffect = effect;
}

void rvSegment::ResetTime( rvBSE *effect, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( st && !st->GetInfiniteDuration() ) {
		InitTime( effect, st, time );
	}
}

void rvSegment::Rewind( rvBSE *effect ) {
	if ( effect->GetDuration() == mSegEndTime - mSegStartTime ) {
		mSegStartTime -= effect->GetDuration() * 2.0f;
		mLastTime = mSegStartTime;
	}
}

void rvSegment::Advance( rvBSE *effect ) {
	mSegStartTime += effect->GetDuration();
	mLastTime = mSegStartTime;
}

bool rvSegment::Active() {
	rvSegmentTemplate *st = GetSegmentTemplate();
	return st && st->GetHasParticles() && st->GetEnabled() && mActiveCount != 0;
}

rvParticle *rvSegment::InitParticleArray( rvBSE *effect ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st ) { return NULL; }
	int count = effect->GetLooping() ? mLoopParticleCount : mParticleCount;
	count = idMath::ClampInt( 0, bse_maxParticles.GetInteger(), count );
	if ( count == 0 ) { mFreeHead = NULL; return NULL; }
	rvParticle *particles = NULL;
	switch ( st->GetParticleTemplate()->GetType() ) {
		case PTYPE_LINE: particles = new rvLineParticle[count]; break;
		case PTYPE_ORIENTED: particles = new rvOrientedParticle[count]; break;
		case PTYPE_DECAL: particles = new rvDecalParticle[count]; break;
		case PTYPE_MODEL: particles = new rvModelParticle[count]; break;
		case PTYPE_LIGHT: particles = new rvLightParticle[count]; break;
		case PTYPE_ELECTRICITY: particles = new rvElectricityParticle[count]; break;
		case PTYPE_LINKED: particles = new rvLinkedParticle[count]; break;
		case PTYPE_DEBRIS: particles = new rvDebrisParticle[count]; break;
		default: particles = new rvSpriteParticle[count]; break;
	}
	for ( int i = 0; i < count - 1; ++i ) {
		particles->GetArrayEntry( i )->SetNext( particles->GetArrayEntry( i + 1 ) );
	}
	particles->GetArrayEntry( count - 1 )->SetNext( NULL );
	mFreeHead = particles;
	mUsedHead = NULL;
	return particles;
}

void rvSegment::InitParticles( rvBSE *effect ) {
	if ( GetSegmentTemplate() ) {
		mParticles = InitParticleArray( effect );
		mActiveCount = 0;
	}
}

rvParticle *rvSegment::GetFreeParticle( rvBSE *effect ) {
	rvParticle *particle = mFreeHead;
	if ( particle ) {
		mFreeHead = particle->GetNext();
	}
	return particle;
}

void rvSegment::InsertParticle( rvParticle *particle, rvSegmentTemplate *st ) {
	if ( st->GetTemporary() ) { return; }
	++mActiveCount;
	if ( st->GetComplexParticle() ) {
		particle->SetNext( mUsedHead );
		mUsedHead = particle;
		return;
	}
	rvParticle *previous = NULL;
	rvParticle *current = mUsedHead;
	while ( current && particle->mEndTime > current->mEndTime ) {
		previous = current;
		current = current->GetNext();
	}
	particle->SetNext( current );
	if ( previous ) { previous->SetNext( particle ); } else { mUsedHead = particle; }
}

rvParticle *rvSegment::SpawnParticle( rvBSE *effect, rvSegmentTemplate *st, float birthTime,
		const idVec3 &initPos, const idMat3 &initAxis ) {
	if ( !GetSegmentTemplate() ) { return NULL; }
	rvParticle *particle = st->GetTemporary() ? mParticles : GetFreeParticle( effect );
	if ( !particle ) { return NULL; }
	// Quake 4 feeds the single-particle birth time through as the spawn
	// fraction as well.  Several locked/constant weapon effects use that
	// value to seed their linear spacing and envelope evaluation.
	particle->FinishSpawn( effect, this, birthTime, birthTime, initPos, initAxis );
	InsertParticle( particle, st );
	return particle;
}

void rvSegment::SpawnParticles( rvBSE *effect, rvSegmentTemplate *st, float birthTime, int count ) {
	count = Min( count, bse_maxParticles.GetInteger() );
	for ( int i = 0; i < count; ++i ) {
		rvParticle *particle = st->GetTemporary() ? mParticles : GetFreeParticle( effect );
		if ( !particle ) { break; }
		particle->FinishSpawn( effect, this, birthTime, count ? (float)i / count : 0.0f );
		InsertParticle( particle, st );
	}
}

float rvSegment::EvaluateCost() {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st || !st->GetEnabled() ) { return 0.0f; }
	float cost = mSegmentBaseCosts[st->GetType()];
	const rvParticleTemplate *pt = st->GetParticleTemplate();
	if ( pt->GetType() != PTYPE_NONE ) {
		cost += pt->CostTrail( (float)mActiveCount );
		if ( pt->GetHasPhysics() ) { cost += mActiveCount * BSE_PHYSICS_COST; }
	}
	return cost;
}

float rvSegment::AttenuateDuration( rvBSE *effect, rvSegmentTemplate *st ) {
	return effect->GetAttenuation( st ) * ( mSegEndTime - mSegStartTime );
}

float rvSegment::AttenuateInterval( rvBSE *effect, rvSegmentTemplate *st ) {
	float rate = ( mSecondsPerParticle.y - mSecondsPerParticle.x ) * bse_scale.GetFloat() + mSecondsPerParticle.x;
	rate = idMath::ClampFloat( mSecondsPerParticle.y, mSecondsPerParticle.x, rate );
	if ( !st->GetAttenuateEmitter() ) { return rate; }
	float attenuation = effect->GetAttenuation( st );
	if ( st->GetInverseAttenuate() ) { attenuation = 1.0f - attenuation; }
	return attenuation >= BSE_TIME_EPSILON ? rate / attenuation : 1.0f;
}

float rvSegment::AttenuateCount( rvBSE *effect, rvSegmentTemplate *st, float min, float max ) {
	const float scaledMax = ( max - min ) * bse_scale.GetFloat() + min;
	float count = idMath::ClampFloat( min, max, rvRandom::flrand( min, scaledMax ) );
	if ( st->GetAttenuateEmitter() ) {
		float attenuation = effect->GetAttenuation( st );
		if ( st->GetInverseAttenuate() ) { attenuation = 1.0f - attenuation; }
		count *= attenuation;
	}
	return count;
}

void rvSegment::AddToParticleCount( rvBSE *effect, int count, int loopCount, float duration ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st ) { return; }
	duration = Max( duration, st->GetParticleTemplate()->GetMaxDuration() );
	const int multiplier = mSecondsPerParticle.y > 0.0f ? (int)ceilf( ( duration + BSE_FUTURE ) / mSecondsPerParticle.y ) + 1 : 1;
	mParticleCount += count * multiplier;
	mLoopParticleCount += loopCount * multiplier;
}

void rvSegment::CalcTrailCounts( rvBSE *effect, rvSegmentTemplate *st, rvParticleTemplate *pt, float duration ) {
	if ( st->mTrailSegmentIndex >= 0 && st->mTrailSegmentIndex < effect->mSegments.Num() ) {
		effect->mSegments[st->mTrailSegmentIndex].AddToParticleCount( effect, mParticleCount, mLoopParticleCount, duration );
	}
}

void rvSegment::CalcCounts( rvBSE *effect, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st || st->GetType() == SEG_TRAIL || st->GetParticleTemplate()->GetType() == PTYPE_NONE ) { return; }

	rvParticleTemplate *pt = st->GetParticleTemplate();
	const float particleMaxDuration = pt->GetMaxDuration() + BSE_FUTURE;
	const float effectMinDuration = mEffectDecl->GetMinDuration();
	int particleCount = 0;
	int loopParticleCount = 0;
	float duration = 0.0f;

	switch ( st->GetType() ) {
		case SEG_EMITTER:
			if ( pt->GetType() == PTYPE_DEBRIS ) {
				particleCount = loopParticleCount = 1;
				break;
			}
			duration = Min( particleMaxDuration, st->mLocalDuration.y ) + BSE_FUTURE;
			particleCount = loopParticleCount = (int)ceilf( duration / mSecondsPerParticle.y ) + 1;
			if ( effectMinDuration < particleMaxDuration ) {
				loopParticleCount = (int)ceilf( ( (float)particleCount / effectMinDuration ) * particleMaxDuration ) + 1;
			}
			break;

		case SEG_SPAWNER:
			if ( pt->GetType() == PTYPE_DEBRIS ) {
				particleCount = loopParticleCount = 1;
				break;
			}
			particleCount = loopParticleCount = (int)ceilf( mCount.y );
			if ( effectMinDuration != 0.0f && !st->GetInfiniteDuration() && effectMinDuration < particleMaxDuration ) {
				loopParticleCount = particleCount * ( (int)ceilf( particleMaxDuration / effectMinDuration ) + 1 ) + 1;
			}
			break;

		case SEG_DECAL:
		case SEG_LIGHT:
			particleCount = loopParticleCount = 1;
			break;

		default:
			break;
	}

	mParticleCount = particleCount;
	mLoopParticleCount = loopParticleCount;

	if ( st->GetHasParticles() ) {
		if ( particleCount == 0 || loopParticleCount == 0 ) {
			common->Warning( "^4BSE:^1 '%s'\nSegment with no particles for effect", mEffectDecl->GetName() );
		}
		if ( st->GetType() == SEG_EMITTER || st->GetType() == SEG_SPAWNER ) {
			CalcTrailCounts( effect, st, pt, duration );
		}
	}

	if ( !effect->GetLooping() ) {
		effect->SetDuration( mSegEndTime - time + pt->GetMaxDuration() );
	}

	if ( bse_debug.GetInteger() == 2 ) {
		common->Printf( "BSE: Segment %s: Count: %d Looping: %d\n",
			rvBSEManagerLocal::mSegmentNames[st->GetType()], particleCount, loopParticleCount );
	}
}

void rvSegment::UpdateSimpleParticles( float time ) {
	while ( mUsedHead && mUsedHead->Expired( time ) ) {
		rvParticle *expired = mUsedHead;
		mUsedHead = expired->GetNext();
		expired->SetNext( mFreeHead );
		mFreeHead = expired;
		--mActiveCount;
	}
}

void rvSegment::UpdateElectricityParticles( float time ) {
	mActiveCount = 0;
	for ( rvParticle *particle = mUsedHead; particle; particle = particle->GetNext() ) {
		mActiveCount += particle->Update( time );
	}
}

void rvSegment::RefreshParticles( rvBSE *effect, rvSegmentTemplate *st ) {
	if ( st->GetParticleTemplate()->UsesEndOrigin() ) {
		for ( rvParticle *particle = mUsedHead; particle; particle = particle->GetNext() ) {
			particle->Refresh( effect, st, st->GetParticleTemplate() );
		}
	}
}

void rvSegment::Handle( rvBSE *effect, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st || time < mSegStartTime ) { return; }
	switch ( st->GetType() ) {
		case SEG_EMITTER:
		case SEG_SPAWNER:
			if ( effect->GetEndOriginChanged() ) { RefreshParticles( effect, st ); }
			break;
		case SEG_SOUND: effect->UpdateSoundEmitter( st, this ); break;
		case SEG_LIGHT: if ( st->GetEnabled() ) { HandleLight( effect, st, time ); } break;
		default: break;
	}
}

void rvSegment::UpdateGenericParticles( rvBSE *effect, rvSegmentTemplate *st, float time ) {
	const bool infinite = st->GetInfiniteDuration();
	const bool smoker = st->GetSmoker();
	rvParticle *previous = NULL;
	rvParticle *particle = mUsedHead;
	while ( particle ) {
		rvParticle *next = particle->GetNext();
		bool remove = false;
		if ( infinite ) {
			particle->RunPhysics( effect, st, time );
			remove = effect->GetStopped();
		} else if ( particle->Expired( time ) ) {
			particle->CheckTimeoutEffect( effect, st, time );
			remove = true;
		} else {
			remove = particle->RunPhysics( effect, st, time );
		}
		if ( effect->GetStopped() && !particle->GetPersist() ) { remove = true; }
		if ( smoker && st->mTrailSegmentIndex >= 0 &&
				st->mTrailSegmentIndex < effect->mSegments.Num() ) {
			particle->EmitSmokeParticles( effect,
				&effect->mSegments[st->mTrailSegmentIndex], time );
		}
		if ( remove ) {
			if ( previous ) { previous->SetNext( next ); } else { mUsedHead = next; }
			--mActiveCount;
			particle->SetNext( mFreeHead );
			particle->Destroy();
			mFreeHead = particle;
		} else {
			previous = particle;
		}
		particle = next;
	}
}

bool rvSegment::UpdateParticles( rvBSE *effect, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st ) { return false; }
	Handle( effect, time );
	if ( effect->GetStopped() || st->GetComplexParticle() ) { UpdateGenericParticles( effect, st, time ); }
	else { UpdateSimpleParticles( time ); }
	if ( st->GetParticleTemplate()->GetType() == PTYPE_ELECTRICITY ) { UpdateElectricityParticles( time ); }
	if ( com_debugHudActive ) {
		rvBSEManagerLocal::mPerfCounters[PERF_NUM_PARTICLES] += mActiveCount;
		if ( mUsedHead ) { rvBSEManagerLocal::mPerfCounters[PERF_NUM_TEXELS] += st->GetTexelCount(); }
	}
	return mUsedHead != NULL;
}

void rvSegment::PlayEffect( rvBSE *effect, rvSegmentTemplate *st ) {
	if ( game && st->mNumEffects > 0 ) {
		game->PlayEffect( st->mEffects[rvRandom::irand( 0, st->mNumEffects - 1 )],
			effect->GetCurrentOrigin(), effect->GetCurrentAxis() );
	}
}

void rvSegment::CreateDecal( rvBSE *effect, float time ) {
	static const idVec3 decalWinding[4] = {
		idVec3(  1.0f,  1.0f, 0.0f ),
		idVec3( -1.0f,  1.0f, 0.0f ),
		idVec3( -1.0f, -1.0f, 0.0f ),
		idVec3(  1.0f, -1.0f, 0.0f )
	};

	if ( !bse_render.GetBool() || effect == NULL || session == NULL ||
			session->rw == NULL ) {
		return;
	}

	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( st == NULL ) {
		return;
	}

	if ( bse_debug.GetBool() ) {
		static int decalCount;
		const idMaterial *material = st->GetParticleTemplate()->GetMaterial();
		common->Printf( "BSE: Decal %d: %s\n", ++decalCount,
			material != NULL ? material->GetName() : "<null>" );
	}

	rvParticle *particle = SpawnParticle( effect, st, time,
		vec3_origin, mat3_identity );
	if ( particle == NULL ) {
		return;
	}

	idVec4 tint;
	idVec3 size;
	idVec3 rotation;
	particle->GetSpawnInfo( tint, size, rotation );

	float sine;
	float cosine;
	idMath::SinCos( rotation.x, sine, cosine );

	// BSE decals project opposite the effect's forward axis.  The retail code
	// uses a fixed eight-unit projection depth and rotates the winding around
	// that direction by the particle's randomized rotation parameter.
	idMat3 axis;
	axis[2] = -effect->GetCurrentAxis()[0];
	axis[2].Normalize();
	idVec3 tangent0;
	idVec3 tangent1;
	axis[2].NormalVectors( tangent0, tangent1 );
	axis[0] = tangent0 * cosine + tangent1 * -sine;
	axis[1] = tangent0 * -sine + tangent1 * -cosine;

	const idVec3 &origin = effect->GetCurrentOrigin();
	const idVec3 windingOrigin = origin + axis[2] * 8.0f;
	const idVec3 projectionOrigin = origin - axis[2] * 8.0f;

	idFixedWinding winding;
	for ( int point = 0; point < 4; ++point ) {
		winding += idVec5( windingOrigin + ( axis * decalWinding[point] ) * size.x,
			idVec2( point == 0 || point == 3 ? 1.0f : 0.0f,
				point < 2 ? 1.0f : 0.0f ) );
	}

	session->rw->ProjectDecalOntoWorld( winding, projectionOrigin, true, 8.0f,
		st->GetParticleTemplate()->GetMaterial(), idMath::Ftoi( time * 1000.0f ) );
}

bool rvSegment::Check( rvBSE *effect, float time ) {
	float spawnTime = mLastTime;
	mLastTime = time;
	if ( GetExpired() || effect->GetStopped() ) { return true; }
	if ( time < mSegStartTime ) { return false; }
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st || st->DetailCull() ) { SetExpired( true ); return true; }
	switch ( st->GetType() ) {
		case SEG_EFFECT:
			if ( st->GetEnabled() ) { PlayEffect( effect, st ); }
			SetExpired( true );
			break;
		case SEG_EMITTER: {
			if ( !effect->CanInterpolate() ) { break; }
			const float end = Min( time + BSE_FUTURE, mSegEndTime );
			while ( spawnTime < end ) {
				if ( spawnTime >= mSegStartTime ) { SpawnParticle( effect, st, spawnTime ); }
				spawnTime += AttenuateInterval( effect, st );
			}
			mLastTime = spawnTime;
			if ( end >= mSegEndTime - BSE_TIME_EPSILON ) { SetExpired( true ); }
			break;
		}
		case SEG_SPAWNER:
			SpawnParticles( effect, st, mSegStartTime, idMath::Ftoi( AttenuateCount( effect, st, mCount.x, mCount.y ) ) );
			SetExpired( true );
			break;
		case SEG_SOUND: {
			if ( st->GetEnabled() ) {
				idSoundEmitter *emitter = effect->GetReferenceSound( 1 );
				mSoundVolume = st->GetSoundVolume();
				mFreqShift = st->GetFreqShift();
				effect->UpdateSoundEmitter( st, this );
				if ( emitter && st->mSoundShader ) {
					emitter->StartSound( st->mSoundShader, GetSoundChannel(), rvRandom::flrand( 0.0f, 1.0f ), st->GetSoundLooping() ? SSF_LOOPING : 0 );
					SetSoundPlaying( st->GetSoundLooping() );
				}
			}
			SetExpired( true );
			break;
		}
		case SEG_DECAL:
			if ( st->GetEnabled() && ( !rvBSEManagerLocal::g_decals || rvBSEManagerLocal::g_decals->GetBool() ) ) { CreateDecal( effect, mSegStartTime ); }
			SetExpired( true );
			break;
		case SEG_LIGHT:
			if ( st->GetEnabled() ) { InitLight( effect, st, mSegStartTime ); }
			SetExpired( true );
			break;
		case SEG_DOUBLEVISION:
			if ( st->GetEnabled() ) { static_cast<rvBSEManagerLocal *>( bse )->SetDoubleVisionParms( mSegStartTime + AttenuateDuration( effect, st ), effect->GetOriginAttenuation( st ) ); }
			SetExpired( true );
			break;
		case SEG_SHAKE:
			if ( st->GetEnabled() ) { static_cast<rvBSEManagerLocal *>( bse )->SetShakeParms( mSegStartTime + AttenuateDuration( effect, st ), effect->GetOriginAttenuation( st ) ); }
			SetExpired( true );
			break;
		case SEG_TUNNEL:
			if ( st->GetEnabled() ) { static_cast<rvBSEManagerLocal *>( bse )->SetTunnelParms( mSegStartTime + AttenuateDuration( effect, st ), effect->GetOriginAttenuation( st ) ); }
			SetExpired( true );
			break;
		default:
			SetExpired( true );
			break;
	}
	return GetExpired();
}

void rvSegment::RenderMotion( rvBSE *effect, const renderEffect_t *owner, rvRenderModelBSE *model,
		rvParticleTemplate *pt, float time ) {
	if ( !model || !pt || !mUsedHead ) { return; }
	const int trails = Max( 0, pt->GetMaxTrailCount() - 1 );
	const int count = mActiveCount * ( trails + 1 );
	srfTriangles_t *tri = R_AllocStaticTriSurf();
	R_AllocStaticTriSurfVerts( tri, 2 * count + 2 );
	R_AllocStaticTriSurfIndexes( tri, 12 * count );
	for ( rvParticle *particle = mUsedHead; particle; particle = particle->GetNext() ) {
		particle->RenderMotion( effect, tri, owner, time );
	}
	R_BoundTriSurf( tri );
	modelSurface_t surface;
	memset( &surface, 0, sizeof( surface ) );
	surface.shader = pt->GetTrailMaterial();
	surface.geometry = tri;
	model->AddSurface( surface );
}

void rvSegment::RenderTrail( rvBSE *effect, const renderEffect_t *owner, rvRenderModelBSE *model, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( st ) {
		rvParticleTemplate *pt = st->GetParticleTemplate();
		if ( pt->GetMaxTrailCount() >= 0 && pt->GetMaxTrailTime() >= BSE_TIME_EPSILON && pt->GetTrailType() == TRAIL_MOTION ) {
			RenderMotion( effect, owner, model, pt, time );
		}
	}
}

void rvSegment::Render( rvBSE *effect, const renderEffect_t *owner, rvRenderModelBSE *model, float time ) {
	rvSegmentTemplate *st = GetSegmentTemplate();
	if ( !st || !owner || !model || !mUsedHead ) { return; }
	rvParticleTemplate *pt = st->GetParticleTemplate();
	const int numVerts = mActiveCount * pt->GetVertexCount();
	if ( numVerts <= 0 || numVerts * (int)sizeof( idDrawVert ) > (int)MEMORY_BLOCK_SIZE ) { return; }
	srfTriangles_t *tri = R_AllocStaticTriSurf();
	R_AllocStaticTriSurfVerts( tri, numVerts );
	R_AllocStaticTriSurfIndexes( tri, mActiveCount * pt->GetIndexCount() );
	const idMat3 inverseAxis = owner->axis.Transpose();
	idMat3 view;
	view[0] = ( effect->GetViewOrg() - owner->origin ) * inverseAxis;
	view[1] = effect->GetViewAxis()[1] * inverseAxis;
	view[2] = effect->GetViewAxis()[2] * inverseAxis;
	for ( rvParticle *particle = mUsedHead; particle; particle = particle->GetNext() ) {
		if ( st->GetInfiniteDuration() ) { particle->ExtendLife( time + 1.0f ); }
		if ( particle->Render( effect, view, tri, time ) && pt->GetTrailType() == TRAIL_BURN ) {
			particle->RenderBurnTrail( effect, view, tri, time );
		}
	}
	R_BoundTriSurf( tri );
	modelSurface_t surface;
	memset( &surface, 0, sizeof( surface ) );
	surface.shader = pt->GetMaterial();
	surface.geometry = tri;
	model->AddSurface( surface );
}

void rvSegment::AllocateSurface( rvBSE *effect, idRenderModel *model ) {
}

void rvSegment::ClearSurface( rvBSE *effect, idRenderModel *model ) {
}

void rvSegment::Sort( const idVec3 &eyePos ) {
}
