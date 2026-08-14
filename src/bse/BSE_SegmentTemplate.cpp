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

// Retail compilation unit: BSE_SegmentTemplate.obj. Implementations are recovered here.

void rvSegmentTemplate::CreateParticleTemplate( rvDeclEffect *effect,
		idLexer *lexer, int particleType ) {
	mParticleTemplate.Init();
	mParticleTemplate.SetType( particleType );
	mParticleTemplate.SetParameterCounts();
	mParticleTemplate.Parse( effect, lexer );
}

void rvSegmentTemplate::Init( rvDeclEffect *decl ) {
	mDeclEffect = decl;
	mFlags = STFLAG_ENABLED;
	mSegType = SEG_NONE;
	mLocalStartTime.Zero();
	mLocalDuration.Zero();
	mAttenuation.Zero();
	mParticleCap = 0.0f;
	mDetail = 0.0f;
	mScale = 1.0f;
	mCount.Set( 1.0f, 1.0f );
	mDensity.Zero();
	mTrailSegmentIndex = -1;
	mNumEffects = 0;
	for ( int effect = 0; effect < BSE_NUM_SPAWNABLE; ++effect ) {
		mEffects[effect] = NULL;
	}
	mSoundShader = NULL;
	mSoundVolume.Zero();
	mFreqShift.Set( 1.0f, 1.0f );
	mParticleTemplate.Init();
	mBSEEffect = NULL;
}

int rvSegmentTemplate::GetTexelCount( void ) {
	const idMaterial *material = mParticleTemplate.GetMaterial();
	return material != NULL ? material->GetTexelCount() : 0;
}

bool rvSegmentTemplate::GetSmoker( void ) {
	return mParticleTemplate.GetTrailType() == TRAIL_PARTICLE;
}

bool rvSegmentTemplate::Compare( const rvSegmentTemplate &other ) const {
	if ( mSegmentName.Cmp( other.mSegmentName ) != 0 ) {
		return false;
	}
	if ( ( mFlags ^ other.mFlags ) & ~STFLAG_ENABLED ) {
		return false;
	}
	if ( mSegType != other.mSegType ) {
		return false;
	}
	if ( mSegType != SEG_TRAIL &&
			( mLocalStartTime != other.mLocalStartTime ||
			mLocalDuration != other.mLocalDuration ) ) {
		return false;
	}
	if ( mScale != other.mScale || mDetail != other.mDetail ||
			mAttenuation != other.mAttenuation ) {
		return false;
	}
	if ( mDensity.y == 0.0f ) {
		if ( mCount != other.mCount ) {
			return false;
		}
	} else if ( mDensity != other.mDensity || mParticleCap != other.mParticleCap ) {
		return false;
	}
	if ( mTrailSegmentIndex != other.mTrailSegmentIndex ||
			mNumEffects != other.mNumEffects ) {
		return false;
	}
	for ( int effect = 0; effect < mNumEffects; ++effect ) {
		if ( mEffects[effect] != other.mEffects[effect] ) {
			return false;
		}
	}
	if ( mSoundShader != other.mSoundShader ||
			mSoundVolume != other.mSoundVolume ||
			mFreqShift != other.mFreqShift || mDetail != other.mDetail ) {
		return false;
	}
	return mParticleTemplate == other.mParticleTemplate;
}

void rvSegmentTemplate::SetMaxDuration( rvDeclEffect *effect ) {
	if ( mFlags & STFLAG_IGNORE_DURATION ) {
		return;
	}
	effect->SetMaxDuration( mLocalStartTime.x + mLocalDuration.x );
	if ( mParticleTemplate.GetType() != PTYPE_NONE ) {
		effect->SetMaxDuration( mParticleTemplate.GetMaxDuration() +
			mLocalStartTime.x + mLocalDuration.x );
	}
}

bool rvSegmentTemplate::GetSoundLooping( void ) {
	return mSoundShader != NULL && mSoundShader->IsLooping();
}

bool rvSegmentTemplate::Finish( rvDeclEffect *effect ) {
	if ( mLocalStartTime.x >= mLocalStartTime.y ) {
		idSwap( mLocalStartTime.x, mLocalStartTime.y );
	}
	if ( mLocalDuration.x >= mLocalDuration.y ) {
		idSwap( mLocalDuration.x, mLocalDuration.y );
	}
	if ( mCount.x >= mCount.y ) {
		idSwap( mCount.x, mCount.y );
	}
	if ( mDensity.x >= mDensity.y ) {
		idSwap( mDensity.x, mDensity.y );
	}
	if ( mAttenuation.x >= mAttenuation.y ) {
		idSwap( mAttenuation.x, mAttenuation.y );
	}

	if ( mParticleTemplate.GetType() != PTYPE_NONE ) {
		mParticleTemplate.Finish();
		mParticleTemplate.SetLinked( false );
	}

	switch ( mSegType ) {
		case SEG_EMITTER:
			mFlags |= STFLAG_HASPARTICLES;
			if ( mParticleTemplate.GetType() == PTYPE_NONE ||
					( mFlags & STFLAG_INFINITE_DURATION ) ) {
				return false;
			}
			break;
		case SEG_SPAWNER:
			mFlags |= STFLAG_HASPARTICLES;
			if ( mParticleTemplate.GetType() == PTYPE_NONE ) {
				return false;
			}
			break;
		case SEG_TRAIL:
			mFlags |= STFLAG_HASPARTICLES;
			mLocalStartTime.Zero();
			mLocalDuration.Zero();
			if ( mParticleTemplate.GetType() == PTYPE_NONE ) {
				return false;
			}
			mParticleTemplate.SetLinked( true );
			break;
		case SEG_SOUND:
			mFlags |= STFLAG_IGNORE_DURATION;
			break;
		case SEG_DECAL:
			mFlags &= ~STFLAG_HASPARTICLES;
			mFlags |= STFLAG_TEMPORARY;
			break;
		case SEG_DOUBLEVISION:
		case SEG_SHAKE:
		case SEG_TUNNEL:
		case SEG_COUNT:
			if ( mAttenuation.y > 0.0f ) {
				mFlags |= STFLAG_ATTENUATE_EMITTER;
			}
			mFlags &= ~STFLAG_HASPARTICLES;
			break;
		default:
			mFlags &= ~STFLAG_HASPARTICLES;
			break;
	}

	const int particleType = mParticleTemplate.GetType();
	if ( particleType == PTYPE_DEBRIS ) {
		mFlags &= ~STFLAG_HASPARTICLES;
		mFlags |= STFLAG_TEMPORARY;
	}
	if ( ( mFlags & STFLAG_INFINITE_DURATION ) ||
			mParticleTemplate.GetTrailType() == TRAIL_PARTICLE ||
			mParticleTemplate.GetHasPhysics() ||
			mParticleTemplate.GetNumTimeoutEffects() != 0 ||
			particleType == PTYPE_ELECTRICITY || particleType == PTYPE_LIGHT ) {
		mFlags |= STFLAG_COMPLEX;
	}
	return true;
}

void rvSegmentTemplate::EvaluateTrailSegment( rvDeclEffect *effect ) {
	if ( !mParticleTemplate.GetTrailTypeName().IsEmpty() &&
			mParticleTemplate.GetTrailType() != TRAIL_NONE ) {
		mTrailSegmentIndex = effect->GetTrailSegmentIndex(
			mParticleTemplate.GetTrailTypeName() );
	}
}

bool rvSegmentTemplate::DetailCull( void ) const {
	return mDetail != 0.0f && bse_scale.GetFloat() < mDetail;
}

void rvSegmentTemplate::SetMinDuration( rvDeclEffect *effect ) {
	if ( !( mFlags & STFLAG_IGNORE_DURATION ) && !GetSoundLooping() ) {
		effect->SetMinDuration( mLocalDuration.x + mLocalStartTime.x );
	}
}

bool rvSegmentTemplate::Parse( rvDeclEffect *effect, int segmentType,
		idLexer *lexer ) {
	mSegType = segmentType;
	idToken token;
	if ( !lexer->ReadToken( &token ) ) {
		return false;
	}
	if ( token.Icmp( "{" ) != 0 ) {
		mSegmentName = token;
	} else {
		mSegmentName = va( "unnamed%d", effect->GetNumSegmentTemplates() );
		lexer->UnreadToken( &token );
	}
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}

	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "count" ) == 0 || token.Icmp( "rate" ) == 0 ) {
			mCount.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mCount.y = lexer->ParseFloat();
		} else if ( token.Icmp( "density" ) == 0 ) {
			mDensity.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mDensity.y = lexer->ParseFloat();
		} else if ( token.Icmp( "particleCap" ) == 0 ) {
			mParticleCap = lexer->ParseFloat();
		} else if ( token.Icmp( "start" ) == 0 ) {
			mLocalStartTime.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mLocalStartTime.y = lexer->ParseFloat();
		} else if ( token.Icmp( "duration" ) == 0 ) {
			mLocalDuration.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mLocalDuration.y = lexer->ParseFloat();
		} else if ( token.Icmp( "detail" ) == 0 ) {
			mDetail = lexer->ParseFloat();
		} else if ( token.Icmp( "soundShader" ) == 0 ) {
			lexer->ReadToken( &token );
			mSoundShader = declManager->FindSound( token.c_str() );
			const float length = mSoundShader->GetTimeLength();
			mLocalDuration.Set( length, length );
		} else if ( token.Icmp( "volume" ) == 0 ) {
			mSoundVolume.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mSoundVolume.y = lexer->ParseFloat();
		} else if ( token.Icmp( "freqShift" ) == 0 ) {
			mFreqShift.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mFreqShift.y = lexer->ParseFloat();
		} else if ( token.Icmp( "effect" ) == 0 ) {
			lexer->ReadToken( &token );
			if ( mNumEffects >= BSE_NUM_SPAWNABLE ) {
				common->Warning( "Unable to add effect '%s' - too many effects",
					token.c_str() );
			} else {
				mEffects[mNumEffects++] = declManager->FindEffect( token.c_str() );
			}
		} else if ( token.Icmp( "channel" ) == 0 ) {
			lexer->ReadToken( &token );
		} else if ( token.Icmp( "scale" ) == 0 ) {
			mScale = lexer->ParseFloat();
		} else if ( token.Icmp( "attenuateEmitter" ) == 0 ) {
			mFlags |= STFLAG_ATTENUATE_EMITTER;
		} else if ( token.Icmp( "inverseAttenuateEmitter" ) == 0 ) {
			mFlags |= STFLAG_ATTENUATE_EMITTER | STFLAG_INVERSE_ATTENUATE;
		} else if ( token.Icmp( "attenuation" ) == 0 ) {
			mAttenuation.x = lexer->ParseFloat();
			lexer->ExpectTokenString( "," );
			mAttenuation.y = lexer->ParseFloat();
		} else if ( token.Icmp( "locked" ) == 0 ) {
			mFlags |= STFLAG_LOCKED;
		} else if ( token.Icmp( "constant" ) == 0 ) {
			mFlags |= STFLAG_INFINITE_DURATION;
		} else if ( token.Icmp( "sprite" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_SPRITE );
		} else if ( token.Icmp( "line" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_LINE );
		} else if ( token.Icmp( "oriented" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_ORIENTED );
		} else if ( token.Icmp( "decal" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_DECAL );
		} else if ( token.Icmp( "model" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_MODEL );
		} else if ( token.Icmp( "light" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_LIGHT );
		} else if ( token.Icmp( "electricity" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_ELECTRICITY );
		} else if ( token.Icmp( "linked" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_LINKED );
		} else if ( token.Icmp( "debris" ) == 0 ) {
			CreateParticleTemplate( effect, lexer, PTYPE_DEBRIS );
		} else {
			common->Warning( "^4BSE:^1 Invalid segment parameter '%s' (file: %s, line: %d)",
				token.c_str(), lexer->GetFileName(), lexer->GetLineNum() );
		}
		if ( !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}
