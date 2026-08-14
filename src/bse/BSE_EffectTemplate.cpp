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

// Retail compilation unit: BSE_EffectTemplate.obj. Implementations are recovered here.

const char *rvDeclEffect::DefaultDefinition( void ) const {
	return "{\n}\n";
}

void rvDeclEffect::SetMinDuration( float duration ) {
	if ( duration > mMinDuration ) {
		mMinDuration = duration;
	}
}

void rvDeclEffect::SetMaxDuration( float duration ) {
	if ( duration > mMaxDuration ) {
		mMaxDuration = duration;
	}
}

bool rvDeclEffect::Validate( const char *text, int textLength,
		idStr &report ) const {
	if ( textLength == 0 ) {
		return true;
	}
	idDecl *decl = declManager->AllocateDecl( DECL_EFFECT );
	const bool valid = decl->Parse( text, textLength, false );
	decl->FreeData();
	delete decl->base;
	delete decl;
	(void)report;
	return valid;
}

void rvDeclEffect::DeleteEditorOriginal( void ) {
	delete mEditorOriginal;
	mEditorOriginal = NULL;
}

rvParticleTemplate::rvParticleTemplate( void ) {
}

rvSegmentTemplate::rvSegmentTemplate( void ) {
	declEffectEdit->Init( this, NULL );
	SetEnabled( true );
}

bool rvDeclEffect::SetDefaultText( void ) {
	char generated[1024];
	idStr::snPrintf( generated, sizeof( generated ),
		"effect %s // IMPLICITLY GENERATED\n%s", GetName(), DefaultDefinition() );
	SetText( generated );
	return true;
}

rvSegmentTemplate *rvDeclEffect::GetSegmentTemplate( const char *name ) {
	for ( int index = mSegmentTemplates.Num() - 1; index >= 0; --index ) {
		if ( mSegmentTemplates[index].GetSegmentName().Icmp( name ) == 0 ) {
			return &mSegmentTemplates[index];
		}
	}
	return NULL;
}

rvSegmentTemplate *rvDeclEffect::GetSegmentTemplate( int index ) {
	if ( index >= mSegmentTemplates.Num() ) {
		return NULL;
	}
	return &mSegmentTemplates[index];
}

bool rvDeclEffect::Compare( const rvDeclEffect &other ) const {
	if ( mSegmentTemplates.Num() != other.mSegmentTemplates.Num() ) {
		return false;
	}
	for ( int index = 0; index < mSegmentTemplates.Num(); ++index ) {
		if ( !mSegmentTemplates[index].Compare( other.mSegmentTemplates[index] ) ) {
			return false;
		}
	}
	return true;
}

int rvDeclEffect::GetTrailSegmentIndex( const idStr &name ) {
	for ( int index = 0; index < mSegmentTemplates.Num(); ++index ) {
		if ( mSegmentTemplates[index].GetSegmentName().Icmp( name ) == 0 ) {
			return index;
		}
	}
	common->Warning( "^4BSE:^1 Unable to find segment '%s'", name.c_str() );
	return -1;
}

size_t rvDeclEffect::Size( void ) const {
	return sizeof( *this ) + mSegmentTemplates.Allocated();
}

bool rvDeclEffect::CompareToEditorOriginal( void ) {
	return Compare( *mEditorOriginal );
}

rvParticleTemplate &rvParticleTemplate::operator=(
		const rvParticleTemplate &copy ) {
	if ( this == &copy ) {
		return *this;
	}
	mFlags = copy.mFlags;
	mType = copy.mType;
	mMaterial = copy.mMaterial;
	mMaterialName = copy.mMaterialName;
	mModelName = copy.mModelName;
	mEntityDefName = copy.mEntityDefName;
	mTraceModelIndex = copy.mTraceModelIndex;
	mGravity = copy.mGravity;
	mSoundVolume = copy.mSoundVolume;
	mFreqShift = copy.mFreqShift;
	mTiling = copy.mTiling;
	mTrailType = copy.mTrailType;
	mTrailTypeName = copy.mTrailTypeName;
	mTrailMaterial = copy.mTrailMaterial;
	mTrailMaterialName = copy.mTrailMaterialName;
	mTrailTime = copy.mTrailTime;
	mTrailCount = copy.mTrailCount;
	mBounce = copy.mBounce;
	mDuration = copy.mDuration;
	mCentre = copy.mCentre;
	mNumForks = copy.mNumForks;
	mForkSizeMins = copy.mForkSizeMins;
	mForkSizeMaxs = copy.mForkSizeMaxs;
	mJitterSize = copy.mJitterSize;
	mJitterRate = copy.mJitterRate;
	mJitterTable = copy.mJitterTable;
	mNumSizeParms = copy.mNumSizeParms;
	mNumRotateParms = copy.mNumRotateParms;
	mVertexCount = copy.mVertexCount;
	mIndexCount = copy.mIndexCount;
	mSpawnPosition = copy.mSpawnPosition;
	mSpawnDirection = copy.mSpawnDirection;
	mSpawnVelocity = copy.mSpawnVelocity;
	mSpawnAcceleration = copy.mSpawnAcceleration;
	mSpawnFriction = copy.mSpawnFriction;
	mSpawnTint = copy.mSpawnTint;
	mSpawnFade = copy.mSpawnFade;
	mSpawnSize = copy.mSpawnSize;
	mSpawnRotate = copy.mSpawnRotate;
	mSpawnAngle = copy.mSpawnAngle;
	mSpawnOffset = copy.mSpawnOffset;
	mSpawnLength = copy.mSpawnLength;
	mTintEnvelope = copy.mTintEnvelope;
	mFadeEnvelope = copy.mFadeEnvelope;
	mSizeEnvelope = copy.mSizeEnvelope;
	mRotateEnvelope = copy.mRotateEnvelope;
	mAngleEnvelope = copy.mAngleEnvelope;
	mOffsetEnvelope = copy.mOffsetEnvelope;
	mLengthEnvelope = copy.mLengthEnvelope;
	mDeathTint = copy.mDeathTint;
	mDeathFade = copy.mDeathFade;
	mDeathSize = copy.mDeathSize;
	mDeathRotate = copy.mDeathRotate;
	mDeathAngle = copy.mDeathAngle;
	mDeathOffset = copy.mDeathOffset;
	mDeathLength = copy.mDeathLength;
	mNumImpactEffects = copy.mNumImpactEffects;
	mNumTimeoutEffects = copy.mNumTimeoutEffects;
	for ( int effect = 0; effect < BSE_NUM_SPAWNABLE; ++effect ) {
		mImpactEffects[effect] = copy.mImpactEffects[effect];
		mTimeoutEffects[effect] = copy.mTimeoutEffects[effect];
	}
	return *this;
}

rvSegmentTemplate &rvSegmentTemplate::operator=(
		const rvSegmentTemplate &copy ) {
	if ( this == &copy ) {
		return *this;
	}
	mDeclEffect = copy.mDeclEffect;
	mSegmentName = copy.mSegmentName;
	mFlags = copy.mFlags;
	mSegType = copy.mSegType;
	mLocalStartTime = copy.mLocalStartTime;
	mLocalDuration = copy.mLocalDuration;
	mAttenuation = copy.mAttenuation;
	mParticleCap = copy.mParticleCap;
	mScale = copy.mScale;
	mDetail = copy.mDetail;
	mParticleTemplate = copy.mParticleTemplate;
	mCount = copy.mCount;
	mDensity = copy.mDensity;
	mTrailSegmentIndex = copy.mTrailSegmentIndex;
	mNumEffects = copy.mNumEffects;
	for ( int effect = 0; effect < BSE_NUM_SPAWNABLE; ++effect ) {
		mEffects[effect] = copy.mEffects[effect];
	}
	mSoundShader = copy.mSoundShader;
	mSoundVolume = copy.mSoundVolume;
	mFreqShift = copy.mFreqShift;
	mBSEEffect = copy.mBSEEffect;
	return *this;
}

void rvDeclEffect::FreeData( void ) {
	mSegmentTemplates.Clear();
}

void rvDeclEffect::Init( void ) {
	mEditorOriginal = NULL;
	mFlags = 0;
	mMinDuration = 0.0f;
	mMaxDuration = 0.0f;
	mSize = BSE_LARGEST;
	mPlayCount = 0;
	mLoopCount = 0;
	mSegmentTemplates.Clear();
}

void rvDeclEffect::CopyData( const rvDeclEffect &copy ) {
	mFlags = copy.mFlags;
	mSegmentTemplates = copy.mSegmentTemplates;
	mSize = copy.mSize;
	mMinDuration = copy.mMinDuration;
	mMaxDuration = copy.mMaxDuration;
}

rvDeclEffect::rvDeclEffect( const rvDeclEffect &copy ) {
	Init();
	CopyData( copy );
}

void rvDeclEffect::Finish( void ) {
	mFlags &= ~ETFLAG_HAS_SOUND;
	mMinDuration = 0.0f;
	mMaxDuration = 0.0f;
	const int segmentCount = mSegmentTemplates.Num();
	mSegmentTemplates.Resize( segmentCount );
	mSegmentTemplates.SetNum( segmentCount, false );
	for ( int index = 0; index < mSegmentTemplates.Num(); ++index ) {
		rvSegmentTemplate &segment = mSegmentTemplates[index];
		segment.Finish( this );
		if ( segment.GetType() == SEG_SOUND ) {
			mFlags |= ETFLAG_HAS_SOUND;
		}
		if ( segment.GetParticleTemplate()->UsesEndOrigin() ) {
			mFlags |= ETFLAG_USES_ENDORIGIN;
		}
		if ( segment.GetAttenuateEmitter() ) {
			mFlags |= ETFLAG_ATTENUATES;
		}
		segment.EvaluateTrailSegment( this );
		segment.SetMinDuration( this );
		segment.SetMaxDuration( this );
	}
	mSize = CalculateBounds();
}

void rvDeclEffect::CreateEditorOriginal( void ) {
	delete mEditorOriginal;
	mEditorOriginal = new rvDeclEffect( *this );
}

void rvDeclEffect::Revert( void ) {
	CopyData( *mEditorOriginal );
	CreateEditorOriginal();
}

bool rvDeclEffect::Parse( const char *text, const int textLength,
		bool noCaching ) {
	(void)noCaching;
	idLexer lexer;
	idToken token;
	lexer.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	lexer.SetFlags( DECL_LEXER_FLAGS );
	lexer.SkipUntilString( "{" );
	if ( !lexer.ReadToken( &token ) ) {
		return false;
	}

	rvSegmentTemplate segment;
	while ( token.Cmp( "}" ) != 0 ) {
		segment.Init( this );
		if ( token.Icmp( "size" ) == 0 ) {
			mSize = lexer.ParseFloat();
		} else {
			int type = SEG_NONE;
			if ( token.Icmp( "effect" ) == 0 ) {
				type = SEG_EFFECT;
			} else if ( token.Icmp( "emitter" ) == 0 ) {
				type = SEG_EMITTER;
			} else if ( token.Icmp( "spawner" ) == 0 ) {
				type = SEG_SPAWNER;
			} else if ( token.Icmp( "trail" ) == 0 ) {
				type = SEG_TRAIL;
			} else if ( token.Icmp( "sound" ) == 0 ) {
				type = SEG_SOUND;
			} else if ( token.Icmp( "decal" ) == 0 ) {
				type = SEG_DECAL;
			} else if ( token.Icmp( "light" ) == 0 ) {
				type = SEG_LIGHT;
			} else if ( token.Icmp( "delay" ) == 0 ) {
				type = SEG_DELAY;
			} else if ( token.Icmp( "doubleVision" ) == 0 ) {
				type = SEG_DOUBLEVISION;
			} else if ( token.Icmp( "shake" ) == 0 ) {
				type = SEG_SHAKE;
			} else if ( token.Icmp( "tunnel" ) == 0 ) {
				type = SEG_TUNNEL;
			}

			if ( type == SEG_NONE ) {
				common->Warning(
					"^4BSE:^1 Invalid segment type '%s' (file: %s, line: %d)",
					token.c_str(), lexer.GetFileName(), lexer.GetLineNum() );
				lexer.SkipBracedSection( true );
			} else {
				segment.Parse( this, type, &lexer );
				if ( segment.Finish( this ) ) {
					mSegmentTemplates.Append( segment );
				}
			}
		}
		if ( !lexer.ReadToken( &token ) ) {
			return false;
		}
	}
	Finish();
	return true;
}
