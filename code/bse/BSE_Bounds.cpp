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

	Quake 4 BSE conservative-bound evaluation

	Function ownership and signatures come from BSE_Bounds.obj in quake4.pdb.
	The sampled corner evaluation below follows the address-matched retail
	executable body.

===============================================================================
*/

void rvParticleTemplate::EvaluateSimplePosition( idVec3 &pos, float time,
		float lifeTime, idVec3 &initPos, idVec3 &velocity,
		idVec3 &acceleration, idVec3 &friction ) {
	pos = initPos + velocity * time;
	const float halfTimeSquared = time * time * 0.5f;
	pos += acceleration * halfTimeSquared;

	const float frictionScale =
		( expf( ( lifeTime - halfTimeSquared ) / lifeTime ) - 1.0f ) *
		halfTimeSquared * halfTimeSquared * ( 1.0f / 3.0f );
	pos += friction * frictionScale;
}

float rvParticleTemplate::GetMaxParmValue( rvParticleParms &spawn,
		rvParticleParms &death, rvEnvParms &envelope ) {
	idBounds bounds;
	spawn.GetMinsMaxs( bounds[0], bounds[1] );

	float envelopeMin;
	float envelopeMax;
	if ( envelope.GetMinMax( envelopeMin, envelopeMax ) ) {
		bounds[0] *= envelopeMin;
		bounds[1] *= envelopeMax;

		idBounds deathBounds;
		death.GetMinsMaxs( deathBounds[0], deathBounds[1] );
		deathBounds[0] *= envelopeMin;
		deathBounds[1] *= envelopeMax;
		for ( int axis = 0; axis < 3; ++axis ) {
			if ( deathBounds[0][axis] < bounds[0][axis] ) {
				bounds[0][axis] = deathBounds[0][axis];
			}
			if ( deathBounds[1][axis] > bounds[1][axis] ) {
				bounds[1][axis] = deathBounds[1][axis];
			}
		}
	}

	const float minLength = bounds[0].Length();
	const float maxLength = bounds[1].Length();
	return maxLength > minLength ? maxLength : minLength;
}

float rvParticleTemplate::GetFurthestDistance( void ) {
	idBounds spawnPosition;
	idBounds velocity;
	idBounds acceleration;
	idBounds friction;
	idBounds offset;
	mSpawnPosition.GetMinsMaxs( spawnPosition[0], spawnPosition[1] );
	mSpawnVelocity.GetMinsMaxs( velocity[0], velocity[1] );
	mSpawnAcceleration.GetMinsMaxs( acceleration[0], acceleration[1] );
	mSpawnFriction.GetMinsMaxs( friction[0], friction[1] );
	mSpawnOffset.GetMinsMaxs( offset[0], offset[1] );

	idVec3 gravity( 0.0f, 0.0f,
		-( game->IsMultiplayer() ? cvarSystem->GetCVarFloat( "g_mp_gravity" )
			: cvarSystem->GetCVarFloat( "g_gravity" ) ) );
	acceleration[0] -= gravity * mGravity[0];
	acceleration[1] += gravity * mGravity[1];

	idBounds result;
	result.Zero();
	for ( int sample = 0; sample < 8; ++sample ) {
		const float time = sample * mDuration[1] * 0.125f;
		for ( int positionSide = 0; positionSide < 2; ++positionSide ) {
			for ( int velocitySide = 0; velocitySide < 2; ++velocitySide ) {
				for ( int accelerationSide = 0; accelerationSide < 2; ++accelerationSide ) {
					for ( int frictionSide = 0; frictionSide < 2; ++frictionSide ) {
						idVec3 position;
						EvaluateSimplePosition( position, time, mDuration[1],
							spawnPosition[positionSide], velocity[velocitySide],
							acceleration[accelerationSide], friction[frictionSide] );
						result.AddPoint( position );
					}
				}
			}
		}
	}

	const float minLength = result[0].Length() * 0.5f;
	const float maxLength = result[1].Length() * 0.5f;
	return maxLength > minLength ? maxLength : minLength;
}

float rvSegmentTemplate::CalculateBounds( void ) {
	switch ( mSegType ) {
		case SEG_EMITTER:
		case SEG_SPAWNER:
		case SEG_LIGHT: {
			const float maxSize = mParticleTemplate.GetMaxSize();
			const float maxDistance = mParticleTemplate.GetFurthestDistance();
			float maxLength = 0.0f;
			if ( mParticleTemplate.GetType() == PTYPE_LINE ||
					mParticleTemplate.GetType() == PTYPE_ELECTRICITY ) {
				maxLength = mParticleTemplate.GetMaxLength();
			}
			return mParticleTemplate.GetMaxOffset() + maxLength + maxDistance + maxSize;
		}

		case SEG_DECAL:
			return mParticleTemplate.GetMaxSize();

		default:
			return 8.0f;
	}
}

float rvDeclEffect::CalculateBounds( void ) {
	float size = 0.0f;
	for ( int i = 0; i < mSegmentTemplates.Num(); ++i ) {
		const float segmentSize = mSegmentTemplates[i].CalculateBounds();
		if ( segmentSize > size ) {
			size = segmentSize;
		}
	}
	return ceilf( size );
}
