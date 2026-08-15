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

// Retail compilation unit: BSE_ParseParticle2.obj.

bool rvParticleTemplate::UsesEndOrigin() {
	return ( mSpawnPosition.mFlags & PPFLAG_USEENDORIGIN ) != 0 ||
		( mSpawnLength.mFlags & PPFLAG_USEENDORIGIN ) != 0;
}

bool rvParticleTemplate::GetVector( idLexer *lexer, int count, idVec3 &result ) {
	result.Zero();
	for ( int i = 0; i < count && i < 3; ++i ) {
		if ( i && !lexer->ExpectTokenString( "," ) ) {
			return false;
		}
		result[i] = lexer->ParseFloat();
	}
	return true;
}

bool rvParticleTemplate::ParseMotionParms( idLexer *lexer, int count,
		rvEnvParms &envelope ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "envelope" ) == 0 ) {
			if ( !lexer->ReadToken( &token ) ) {
				return false;
			}
			envelope.SetType( token.c_str() );
		} else if ( token.Icmp( "rate" ) == 0 ) {
			if ( !GetVector( lexer, count, envelope.GetRateRef() ) ) {
				return false;
			}
			envelope.SetIsCount( false );
		} else if ( token.Icmp( "count" ) == 0 ) {
			if ( !GetVector( lexer, count, envelope.GetRateRef() ) ) {
				return false;
			}
			envelope.SetIsCount( true );
		} else if ( token.Icmp( "offset" ) == 0 ) {
			if ( !GetVector( lexer, count, envelope.GetOffsetRef() ) ) {
				return false;
			}
		} else {
			common->Warning( "^4BSE:^1 Invalid motion parameter '%s' (file: %s, line: %d)",
				token.c_str(), lexer->GetFileName(), lexer->GetLineNum() );
		}
		if ( !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}

bool rvParticleTemplate::ParseMotionDomains( rvDeclEffect *effect,
		idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		bool parsed = true;
		if ( token.Icmp( "tint" ) == 0 ) {
			parsed = ParseMotionParms( lexer, 3, mTintEnvelope );
		} else if ( token.Icmp( "fade" ) == 0 ) {
			parsed = ParseMotionParms( lexer, 1, mFadeEnvelope );
		} else if ( token.Icmp( "size" ) == 0 ) {
			parsed = ParseMotionParms( lexer, mNumSizeParms, mSizeEnvelope );
		} else if ( token.Icmp( "rotate" ) == 0 ) {
			parsed = ParseMotionParms( lexer, mNumRotateParms, mRotateEnvelope );
		} else if ( token.Icmp( "angle" ) == 0 ) {
			parsed = ParseMotionParms( lexer, 3, mAngleEnvelope );
		} else if ( token.Icmp( "offset" ) == 0 ) {
			parsed = ParseMotionParms( lexer, 3, mOffsetEnvelope );
		} else if ( token.Icmp( "length" ) == 0 ) {
			parsed = ParseMotionParms( lexer, 3, mLengthEnvelope );
		} else {
			common->Warning( "^4BSE:^1 Invalid motion domain '%s' in '%s' (file: %s, line: %d)",
				token.c_str(), effect ? effect->GetName() : "<unknown>",
				lexer->GetFileName(), lexer->GetLineNum() );
			lexer->SkipBracedSection( true );
		}
		if ( !parsed || !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}

bool rvParticleTemplate::CheckCommonParms( idLexer *lexer,
		rvParticleParms &parms ) {
	idToken token;
	if ( !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "surface" ) == 0 ) {
			parms.mFlags |= PPFLAG_SURFACE;
		} else if ( token.Icmp( "useEndOrigin" ) == 0 ) {
			parms.mFlags |= PPFLAG_USEENDORIGIN;
		} else if ( token.Icmp( "cone" ) == 0 ) {
			parms.mFlags |= PPFLAG_CONE;
		} else if ( token.Icmp( "relative" ) == 0 ) {
			parms.mFlags |= PPFLAG_RELATIVE;
		} else if ( token.Icmp( "linearSpacing" ) == 0 ) {
			parms.mFlags |= PPFLAG_LINEARSPACING;
		} else if ( token.Icmp( "attenuate" ) == 0 ) {
			parms.mFlags |= PPFLAG_ATTENUATE;
		} else if ( token.Icmp( "inverseAttenuate" ) == 0 ) {
			parms.mFlags |= PPFLAG_INV_ATTENUATE;
		}
		if ( !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}

bool rvParticleTemplate::ParseSpawnParms( rvDeclEffect *effect,
		idLexer *lexer, rvParticleParms &parms, int count ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	if ( token.Cmp( "}" ) == 0 ) {
		return true;
	}

	bool fixup = true;
	if ( token.Icmp( "point" ) == 0 ) {
		parms.mSpawnType = SPF_POINT_0 + count;
		if ( !GetVector( lexer, count, parms.mMins ) ) { return false; }
	} else if ( token.Icmp( "line" ) == 0 ) {
		parms.mSpawnType = SPF_LINEAR_0 + count;
		if ( !GetVector( lexer, count, parms.mMins ) ||
				!lexer->ExpectTokenString( "," ) ||
				!GetVector( lexer, count, parms.mMaxs ) ) { return false; }
	} else if ( token.Icmp( "box" ) == 0 || token.Icmp( "sphere" ) == 0 ||
			token.Icmp( "cylinder" ) == 0 ) {
		const int base = token.Icmp( "box" ) == 0 ? SPF_BOX_0 :
			( token.Icmp( "sphere" ) == 0 ? SPF_SPHERE_0 : SPF_CYLINDER_0 );
		parms.mSpawnType = base + count;
		if ( !GetVector( lexer, count, parms.mMins ) ||
				!lexer->ExpectTokenString( "," ) ||
				!GetVector( lexer, count, parms.mMaxs ) ) { return false; }
	} else if ( token.Icmp( "spiral" ) == 0 ) {
		parms.mSpawnType = SPF_SPIRAL_0 + count;
		if ( !GetVector( lexer, count, parms.mMins ) ||
				!lexer->ExpectTokenString( "," ) ||
				!GetVector( lexer, count, parms.mMaxs ) ||
				!lexer->ExpectTokenString( "," ) ) { return false; }
		parms.mRange = lexer->ParseFloat();
	} else if ( token.Icmp( "model" ) == 0 ) {
		parms.mSpawnType = SPF_MODEL_0 + count;
		if ( !lexer->ReadToken( &token ) ) { return false; }
		idRenderModel *model = renderModelManager->FindModel( token.c_str() );
		if ( model == NULL || model->NumSurfaces() == 0 ) {
			common->Warning( "^4BSE:^1 No surfaces defined in model '%s' in '%s' (file: %s, line: %d)",
				token.c_str(), effect ? effect->GetName() : "<unknown>",
				lexer->GetFileName(), lexer->GetLineNum() );
			model = renderModelManager->FindModel( "_default" );
		}
		parms.mMisc = model;
		if ( !lexer->ExpectTokenString( "," ) ||
				!GetVector( lexer, count, parms.mMins ) ||
				!lexer->ExpectTokenString( "," ) ||
				!GetVector( lexer, count, parms.mMaxs ) ) { return false; }
		fixup = false;
	} else {
		common->Warning( "^4BSE:^1 Invalid spawn domain '%s' in '%s' (file: %s, line: %d)",
			token.c_str(), effect ? effect->GetName() : "<unknown>",
			lexer->GetFileName(), lexer->GetLineNum() );
		return CheckCommonParms( lexer, parms );
	}

	if ( !CheckCommonParms( lexer, parms ) ) {
		return false;
	}
	if ( parms.mFlags & PPFLAG_SURFACE ) {
		if ( parms.mSpawnType >= SPF_BOX_0 && parms.mSpawnType <= SPF_BOX_3 ) {
			parms.mSpawnType += SPF_SURFACE_BOX_0 - SPF_BOX_0;
		} else if ( parms.mSpawnType >= SPF_SPHERE_0 && parms.mSpawnType <= SPF_SPHERE_3 ) {
			parms.mSpawnType += SPF_SURFACE_SPHERE_0 - SPF_SPHERE_0;
		} else if ( parms.mSpawnType >= SPF_CYLINDER_0 && parms.mSpawnType <= SPF_CYLINDER_3 ) {
			parms.mSpawnType += SPF_SURFACE_CYLINDER_0 - SPF_CYLINDER_0;
		}
	}
	if ( fixup ) {
		FixupParms( parms );
	}
	return true;
}

bool rvParticleTemplate::ParseSpawnDomains( rvDeclEffect *effect,
		idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		bool parsed = true;
		if ( token.Icmp( "position" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnPosition, 3 );
		} else if ( token.Icmp( "direction" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnDirection, 3 );
			SetCalculatedNormal( true );
		} else if ( token.Icmp( "velocity" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnVelocity, 3 );
		} else if ( token.Icmp( "acceleration" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnAcceleration, 3 );
		} else if ( token.Icmp( "friction" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnFriction, 3 );
		} else if ( token.Icmp( "tint" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnTint, 3 );
		} else if ( token.Icmp( "fade" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnFade, 1 );
		} else if ( token.Icmp( "size" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnSize, mNumSizeParms );
		} else if ( token.Icmp( "rotate" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnRotate, mNumRotateParms );
		} else if ( token.Icmp( "angle" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnAngle, 3 );
		} else if ( token.Icmp( "offset" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnOffset, 3 );
		} else if ( token.Icmp( "length" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mSpawnLength, 3 );
		} else {
			common->Warning( "^4BSE:^1 Invalid spawn type '%s' in '%s' (file: %s, line: %d)",
				token.c_str(), effect ? effect->GetName() : "<unknown>",
				lexer->GetFileName(), lexer->GetLineNum() );
			lexer->SkipBracedSection( true );
		}
		if ( !parsed || !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}

bool rvParticleTemplate::ParseDeathDomains( rvDeclEffect *effect,
		idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		bool parsed = true;
		rvEnvParms *envelope = NULL;
		if ( token.Icmp( "tint" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathTint, 3 ); envelope = &mTintEnvelope;
		} else if ( token.Icmp( "fade" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathFade, 1 ); envelope = &mFadeEnvelope;
		} else if ( token.Icmp( "size" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathSize, mNumSizeParms ); envelope = &mSizeEnvelope;
		} else if ( token.Icmp( "rotate" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathRotate, mNumRotateParms ); envelope = &mRotateEnvelope;
		} else if ( token.Icmp( "angle" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathAngle, 3 ); envelope = &mAngleEnvelope;
		} else if ( token.Icmp( "offset" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathOffset, 3 ); envelope = &mOffsetEnvelope;
		} else if ( token.Icmp( "length" ) == 0 ) {
			parsed = ParseSpawnParms( effect, lexer, mDeathLength, 3 ); envelope = &mLengthEnvelope;
		} else {
			common->Warning( "^4BSE:^1 Invalid end type '%s' in '%s' (file: %s, line: %d)",
				token.c_str(), effect ? effect->GetName() : "<unknown>",
				lexer->GetFileName(), lexer->GetLineNum() );
			lexer->SkipBracedSection( true );
		}
		if ( envelope != NULL ) {
			envelope->SetDefaultType();
		}
		if ( !parsed || !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	return true;
}

bool rvParticleTemplate::ParseImpact( rvDeclEffect *effect, idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	SetHasPhysics( true );
	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "effect" ) == 0 ) {
			if ( !lexer->ReadToken( &token ) ) { return false; }
			if ( mNumImpactEffects < BSE_NUM_SPAWNABLE ) {
				mImpactEffects[mNumImpactEffects++] = declManager->FindEffect( token.c_str() );
			} else {
				common->Warning( "^4BSE:^1 Too many impact effects '%s' in '%s'",
					token.c_str(), effect ? effect->GetName() : "<unknown>" );
			}
		} else if ( token.Icmp( "remove" ) == 0 ) {
			SetDeleteOnImpact( lexer->ParseInt() != 0 );
		} else if ( token.Icmp( "bounce" ) == 0 ) {
			mBounce = lexer->ParseFloat();
		} else {
			common->Warning( "^4BSE:^1 Invalid impact parameter '%s' in '%s'",
				token.c_str(), effect ? effect->GetName() : "<unknown>" );
		}
		if ( !lexer->ReadToken( &token ) ) { return false; }
	}
	return true;
}

bool rvParticleTemplate::ParseTimeout( rvDeclEffect *effect, idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "effect" ) == 0 ) {
			if ( !lexer->ReadToken( &token ) ) { return false; }
			if ( mNumTimeoutEffects < BSE_NUM_SPAWNABLE ) {
				mTimeoutEffects[mNumTimeoutEffects++] = declManager->FindEffect( token.c_str() );
			} else {
				common->Warning( "^4BSE:^1 Too many timeout effects '%s' in '%s'",
					token.c_str(), effect ? effect->GetName() : "<unknown>" );
			}
		} else {
			common->Warning( "^4BSE:^1 Invalid timeout parameter '%s' in '%s'",
				token.c_str(), effect ? effect->GetName() : "<unknown>" );
		}
		if ( !lexer->ReadToken( &token ) ) { return false; }
	}
	return true;
}

bool rvParticleTemplate::ParseBlendParms( rvDeclEffect *effect, idLexer *lexer ) {
	idToken token;
	if ( !lexer->ReadToken( &token ) ) {
		return false;
	}
	if ( token.Icmp( "add" ) == 0 ) {
		SetAdditive( true );
	} else {
		common->Warning( "^4BSE:^1 Invalid blend type '%s' in '%s' (file: %s, line: %d)",
			token.c_str(), effect ? effect->GetName() : "<unknown>",
			lexer->GetFileName(), lexer->GetLineNum() );
	}
	return true;
}

void rvParticleTemplate::SetParameterCounts() {
	int sizeParms;
	int rotateParms;
	int sizeSpawnType;
	switch ( mType ) {
		case PTYPE_SPRITE:
		case PTYPE_DECAL:
			sizeParms = 2; rotateParms = 1; sizeSpawnType = SPF_ONE_2; break;
		case PTYPE_LINE:
		case PTYPE_ELECTRICITY:
		case PTYPE_LINKED:
			sizeParms = 1; rotateParms = 0; sizeSpawnType = SPF_ONE_1; break;
		case PTYPE_ORIENTED:
			sizeParms = 2; rotateParms = 3; sizeSpawnType = SPF_ONE_2; break;
		case PTYPE_MODEL:
			sizeParms = 3; rotateParms = 3; sizeSpawnType = SPF_ONE_3; break;
		case PTYPE_LIGHT:
			sizeParms = 3; rotateParms = 0; sizeSpawnType = SPF_ONE_3; break;
		case PTYPE_DEBRIS:
			sizeParms = 0; rotateParms = 3; sizeSpawnType = SPF_ONE_3; break;
		default:
			return;
	}
	mNumSizeParms = sizeParms;
	mNumRotateParms = rotateParms;
	mSpawnSize.mSpawnType = sizeSpawnType;
	mSpawnRotate.mSpawnType = rotateParms;
	mDeathSize.mSpawnType = sizeSpawnType;
	mDeathRotate.mSpawnType = rotateParms;
}

void rvParticleTemplate::FixupParms( rvParticleParms &parms ) {
	const int count = parms.mSpawnType & 3;
	if ( count <= 0 ) {
		return;
	}
	bool constant = true;
	for ( int i = 0; i < count; ++i ) {
		if ( parms.mMins[i] != parms.mMaxs[i] ) {
			constant = false;
			break;
		}
	}
	if ( constant ) {
		bool allZero = true;
		bool allOne = true;
		for ( int i = 0; i < count; ++i ) {
			allZero &= parms.mMins[i] == 0.0f;
			allOne &= parms.mMins[i] == 1.0f;
		}
		parms.mSpawnType = ( allZero ? SPF_NONE_0 : allOne ? SPF_ONE_0 : SPF_POINT_0 ) + count;
	}
	for ( int i = count; i < 3; ++i ) {
		parms.mMins[i] = parms.mMaxs[i] = 0.0f;
	}
	if ( parms.mSpawnType < SPF_LINEAR_0 ) {
		parms.mMaxs = parms.mMins;
	}
	if ( parms.mFlags & PPFLAG_USEENDORIGIN ) {
		const int base = parms.mSpawnType & ~3;
		if ( base <= SPF_POINT_0 ) {
			parms.mSpawnType = SPF_LINEAR_0 + count;
		}
	}
}

void rvParticleTemplate::Init() {
	mFlags = 0;
	mType = PTYPE_NONE;
	mMaterialName = "_default";
	mMaterial = declManager->FindMaterial( mMaterialName );
	mModelName = "_default";
	mEntityDefName.Clear();
	mTraceModelIndex = -1;
	mGravity.Zero();
	mSoundVolume.Zero();
	mFreqShift.Zero();
	mTiling = 8.0f;
	mTrailType = TRAIL_NONE;
	mTrailTypeName.Clear();
	mTrailMaterialName = "gfx/effects/particles_shapes/motionblur";
	mTrailMaterial = declManager->FindMaterial( mTrailMaterialName );
	mTrailTime.Zero();
	mTrailCount.Zero();
	mBounce = 0.0f;
	mDuration.Set( BSE_TIME_EPSILON, BSE_TIME_EPSILON );
	mCentre.Zero();
	mNumForks = 0;
	mForkSizeMins.Set( -20.0f, -20.0f, -20.0f );
	mForkSizeMaxs = -mForkSizeMins;
	mJitterSize.Set( 3.0f, 7.0f, 7.0f );
	mJitterRate = 0.0f;
	mJitterTable = declManager->FindTable( "halfsintable" );
	mNumSizeParms = 2;
	mNumRotateParms = 1;
	mVertexCount = 4;
	mIndexCount = 6;

	mSpawnPosition.Init( SPF_NONE_3 );
	mSpawnDirection.Init( SPF_NONE_3 );
	mSpawnVelocity.Init( SPF_NONE_3 );
	mSpawnAcceleration.Init( SPF_NONE_3 );
	mSpawnFriction.Init( SPF_NONE_3 );
	mSpawnTint.Init( SPF_ONE_3 );
	mSpawnFade.Init( SPF_ONE_1 );
	mSpawnSize.Init( SPF_ONE_3 );
	mSpawnRotate.Init( SPF_NONE_3 );
	mSpawnAngle.Init( SPF_NONE_3 );
	mSpawnOffset.Init( SPF_NONE_3 );
	mSpawnLength.Init( SPF_NONE_3 );

	mTintEnvelope.Init();
	mFadeEnvelope.Init();
	mSizeEnvelope.Init();
	mRotateEnvelope.Init();
	mAngleEnvelope.Init();
	mOffsetEnvelope.Init();
	mLengthEnvelope.Init();

	mDeathTint.Init( SPF_NONE_3 );
	mDeathFade.Init( SPF_NONE_1 );
	mDeathSize.Init( SPF_ONE_3 );
	mDeathRotate.Init( SPF_NONE_3 );
	mDeathAngle.Init( SPF_NONE_3 );
	mDeathOffset.Init( SPF_NONE_3 );
	mDeathLength.Init( SPF_NONE_3 );

	mNumImpactEffects = 0;
	mNumTimeoutEffects = 0;
	memset( mImpactEffects, 0, sizeof( mImpactEffects ) );
	memset( mTimeoutEffects, 0, sizeof( mTimeoutEffects ) );
}

idTraceModel *rvParticleTemplate::GetTraceModel() const {
	return mTraceModelIndex >= 0 && mTraceModelIndex < rvBSEManagerLocal::mTraceModels.Num()
		? rvBSEManagerLocal::mTraceModels[mTraceModelIndex] : NULL;
}

int rvParticleTemplate::GetTrailCount() const {
	return Max( 0, idMath::Ftoi( rvRandom::flrand( mTrailCount.x, mTrailCount.y ) ) );
}

float rvParticleTemplate::GetSpawnVolume( rvBSE *effect ) {
	float x = mSpawnPosition.mMaxs.x - mSpawnPosition.mMins.x;
	if ( mSpawnPosition.mFlags & PPFLAG_USEENDORIGIN ) {
		x = ( effect->GetOriginalEndOrigin() - effect->GetOriginalOrigin() ).Length() - mSpawnPosition.mMins.x;
	}
	return ( x + ( mSpawnPosition.mMaxs.y - mSpawnPosition.mMins.y ) +
		( mSpawnPosition.mMaxs.z - mSpawnPosition.mMins.z ) ) * BSE_PARTICLE_TEXCOORDSCALE;
}

float rvParticleTemplate::CostTrail( float cost ) const {
	switch ( mTrailType ) {
		case TRAIL_BURN: return cost * mTrailCount.y * 2.0f;
		case TRAIL_MOTION: return cost * mTrailCount.y * 1.5f + BSE_TESS_COST;
		default: return cost;
	}
}

bool rvParticleTemplate::Compare( const rvParticleTemplate &a ) const {
	if ( mFlags != a.mFlags || mType != a.mType || mMaterialName != a.mMaterialName ||
		mModelName != a.mModelName || mEntityDefName != a.mEntityDefName ||
		mGravity != a.mGravity || mSoundVolume != a.mSoundVolume || mFreqShift != a.mFreqShift ||
		mTiling != a.mTiling || mTrailType != a.mTrailType || mTrailTypeName != a.mTrailTypeName ||
		mTrailMaterialName != a.mTrailMaterialName || mTrailTime != a.mTrailTime ||
		mTrailCount != a.mTrailCount || mBounce != a.mBounce || mDuration != a.mDuration ||
		mNumForks != a.mNumForks || mForkSizeMins != a.mForkSizeMins ||
		mForkSizeMaxs != a.mForkSizeMaxs || mJitterSize != a.mJitterSize ||
		mJitterRate != a.mJitterRate || mJitterTable != a.mJitterTable ||
		mNumSizeParms != a.mNumSizeParms || mNumRotateParms != a.mNumRotateParms ||
		mVertexCount != a.mVertexCount || mIndexCount != a.mIndexCount ) {
		return false;
	}
	if ( mSpawnPosition != a.mSpawnPosition || mSpawnDirection != a.mSpawnDirection ||
		mSpawnVelocity != a.mSpawnVelocity || mSpawnAcceleration != a.mSpawnAcceleration ||
		mSpawnFriction != a.mSpawnFriction || mSpawnTint != a.mSpawnTint ||
		mSpawnFade != a.mSpawnFade || mSpawnSize != a.mSpawnSize ||
		mSpawnRotate != a.mSpawnRotate || mSpawnAngle != a.mSpawnAngle ||
		mSpawnOffset != a.mSpawnOffset || mSpawnLength != a.mSpawnLength ||
		mDeathTint != a.mDeathTint || mDeathFade != a.mDeathFade ||
		mDeathSize != a.mDeathSize || mDeathRotate != a.mDeathRotate ||
		mDeathAngle != a.mDeathAngle || mDeathOffset != a.mDeathOffset ||
		mDeathLength != a.mDeathLength || mTintEnvelope != a.mTintEnvelope ||
		mFadeEnvelope != a.mFadeEnvelope || mSizeEnvelope != a.mSizeEnvelope ||
		mRotateEnvelope != a.mRotateEnvelope || mAngleEnvelope != a.mAngleEnvelope ||
		mOffsetEnvelope != a.mOffsetEnvelope || mLengthEnvelope != a.mLengthEnvelope ||
		mNumImpactEffects != a.mNumImpactEffects || mNumTimeoutEffects != a.mNumTimeoutEffects ) {
		return false;
	}
	for ( int i = 0; i < mNumImpactEffects; ++i ) {
		if ( mImpactEffects[i] != a.mImpactEffects[i] ) { return false; }
	}
	for ( int i = 0; i < mNumTimeoutEffects; ++i ) {
		if ( mTimeoutEffects[i] != a.mTimeoutEffects[i] ) { return false; }
	}
	return true;
}

void rvParticleTemplate::Finish() {
	mFlags |= PTFLAG_PARSED;
	if ( mTrailType == TRAIL_NONE || mTrailType == TRAIL_PARTICLE ) {
		mTrailTime.Zero();
		mTrailCount.Zero();
	}
	switch ( mType ) {
		case PTYPE_SPRITE:
		case PTYPE_LINE:
			mVertexCount = 4;
			mIndexCount = 6;
			if ( mTrailCount.y != 0.0f && mTrailType == TRAIL_BURN ) {
				mVertexCount *= GetMaxTrailCount();
				mIndexCount *= GetMaxTrailCount();
			}
			break;
		case PTYPE_DECAL:
		case PTYPE_LIGHT:
		case PTYPE_LINKED:
			mVertexCount = 4;
			mIndexCount = 6;
			break;
		case PTYPE_MODEL: {
			idRenderModel *model = renderModelManager->FindModel( mModelName );
			const modelSurface_t *surface = model && model->NumSurfaces() ? model->Surface( 0 ) : NULL;
			if ( surface ) {
				mMaterial = surface->shader;
				if ( mMaterial ) { mMaterialName = mMaterial->GetName(); }
				if ( surface->geometry ) {
					mVertexCount = surface->geometry->numVerts;
					mIndexCount = surface->geometry->numIndexes;
					idTraceModel *traceModel = new idTraceModel( surface->geometry->bounds );
					mTraceModelIndex = rvBSEManagerLocal::mTraceModels.Append( traceModel );
				}
			}
			break;
		}
		case PTYPE_ELECTRICITY:
			mVertexCount = 4 * ( 5 * mNumForks + 5 );
			mIndexCount = 60 * ( mNumForks + 1 );
			break;
		case PTYPE_DEBRIS:
			mVertexCount = mIndexCount = 0;
			break;
		default:
			break;
	}
	if ( mDuration.x > mDuration.y ) { idSwap( mDuration.x, mDuration.y ); }
	if ( mGravity.x > mGravity.y ) { idSwap( mGravity.x, mGravity.y ); }
	if ( mTrailTime.x > mTrailTime.y ) { idSwap( mTrailTime.x, mTrailTime.y ); }
	if ( mTrailCount.x > mTrailCount.y ) { idSwap( mTrailCount.x, mTrailCount.y ); }
	mCentre.Zero();
	if ( !GetGeneratedNormal() ) {
		const int domain = mSpawnPosition.mSpawnType & ~3;
		if ( domain == SPF_POINT_0 ) {
			mCentre = mSpawnPosition.mMins;
		} else if ( domain >= SPF_LINEAR_0 ) {
			mCentre = ( mSpawnPosition.mMins + mSpawnPosition.mMaxs ) * 0.5f;
		}
	}
}

static void BSE_ParseRange( idLexer *lexer, idVec2 &range, float minValue, float maxValue ) {
	range.x = idMath::ClampFloat( minValue, maxValue, lexer->ParseFloat() );
	lexer->ExpectTokenString( "," );
	range.y = idMath::ClampFloat( minValue, maxValue, lexer->ParseFloat() );
}

bool rvParticleTemplate::Parse( rvDeclEffect *effect, idLexer *lexer ) {
	idToken token;
	if ( !lexer->ExpectTokenString( "{" ) || !lexer->ReadToken( &token ) ) {
		return false;
	}
	while ( token.Cmp( "}" ) != 0 ) {
		if ( token.Icmp( "start" ) == 0 ) {
			if ( !ParseSpawnDomains( effect, lexer ) ) { return false; }
		} else if ( token.Icmp( "end" ) == 0 ) {
			if ( !ParseDeathDomains( effect, lexer ) ) { return false; }
		} else if ( token.Icmp( "motion" ) == 0 ) {
			if ( !ParseMotionDomains( effect, lexer ) ) { return false; }
		} else if ( token.Icmp( "generatedNormal" ) == 0 ) {
			SetGeneratedNormal( true );
		} else if ( token.Icmp( "generatedOriginNormal" ) == 0 ) {
			SetGeneratedOriginNormal( true );
		} else if ( token.Icmp( "flipNormal" ) == 0 ) {
			SetFlippedNormal( true );
		} else if ( token.Icmp( "generatedLine" ) == 0 ) {
			SetGeneratedLine( true );
		} else if ( token.Icmp( "persist" ) == 0 ) {
			SetPersist( true );
		} else if ( token.Icmp( "tiling" ) == 0 ) {
			SetTiled( true );
			mTiling = idMath::ClampFloat( BSE_TIME_EPSILON, 1024.0f, lexer->ParseFloat() );
		} else if ( token.Icmp( "duration" ) == 0 ) {
			BSE_ParseRange( lexer, mDuration, BSE_TIME_EPSILON, 60.0f );
		} else if ( token.Icmp( "gravity" ) == 0 ) {
			BSE_ParseRange( lexer, mGravity, -WORLD_SIZE, WORLD_SIZE );
		} else if ( token.Icmp( "trailType" ) == 0 ) {
			lexer->ReadToken( &token );
			if ( token.Icmp( "burn" ) == 0 ) { mTrailType = TRAIL_BURN; }
			else if ( token.Icmp( "motion" ) == 0 ) { mTrailType = TRAIL_MOTION; }
			else { mTrailType = TRAIL_PARTICLE; mTrailTypeName = token; }
		} else if ( token.Icmp( "trailMaterial" ) == 0 ) {
			lexer->ReadToken( &token );
			mTrailMaterialName = token;
			mTrailMaterial = declManager->FindMaterial( token );
		} else if ( token.Icmp( "trailTime" ) == 0 ) {
			BSE_ParseRange( lexer, mTrailTime, 0.0f, BSE_MAX_DURATION );
		} else if ( token.Icmp( "trailCount" ) == 0 ) {
			BSE_ParseRange( lexer, mTrailCount, 0.0f, (float)MAX_PARTICLES );
		} else if ( token.Icmp( "material" ) == 0 ) {
			lexer->ReadToken( &token );
			mMaterialName = token;
			mMaterial = declManager->FindMaterial( token );
		} else if ( token.Icmp( "entityDef" ) == 0 ) {
			lexer->ReadToken( &token );
			mEntityDefName = token;
		} else if ( token.Icmp( "fork" ) == 0 ) {
			mNumForks = idMath::ClampInt( 0, BSE_MAX_FORKS, lexer->ParseInt() );
		} else if ( token.Icmp( "forkMins" ) == 0 ) {
			GetVector( lexer, 3, mForkSizeMins );
		} else if ( token.Icmp( "forkMaxs" ) == 0 ) {
			GetVector( lexer, 3, mForkSizeMaxs );
		} else if ( token.Icmp( "jitterSize" ) == 0 ) {
			GetVector( lexer, 3, mJitterSize );
		} else if ( token.Icmp( "jitterRate" ) == 0 ) {
			mJitterRate = lexer->ParseFloat();
		} else if ( token.Icmp( "jitterTable" ) == 0 ) {
			lexer->ReadToken( &token );
			mJitterTable = declManager->FindTable( token );
		} else if ( token.Icmp( "blend" ) == 0 ) {
			if ( !ParseBlendParms( effect, lexer ) ) { return false; }
		} else if ( token.Icmp( "shadows" ) == 0 ) {
			SetShadows( true );
		} else if ( token.Icmp( "specular" ) == 0 ) {
			SetSpecular( true );
		} else if ( token.Icmp( "model" ) == 0 ) {
			lexer->ReadToken( &token );
			mModelName = token;
			renderModelManager->FindModel( token );
		} else if ( token.Icmp( "impact" ) == 0 ) {
			if ( !ParseImpact( effect, lexer ) ) { return false; }
		} else if ( token.Icmp( "timeout" ) == 0 ) {
			if ( !ParseTimeout( effect, lexer ) ) { return false; }
		} else {
			common->Warning( "^4BSE:^1 Invalid particle keyword '%s' in '%s' (file: %s, line: %d)",
				token.c_str(), effect ? effect->GetName() : "<unknown>", lexer->GetFileName(), lexer->GetLineNum() );
		}
		if ( !lexer->ReadToken( &token ) ) {
			return false;
		}
	}
	Finish();
	return true;
}
