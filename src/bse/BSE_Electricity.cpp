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

	Electricity particle rendering

	The work structure layout and all method ownership/signatures come from
	BSE_Electricity.obj in quake4.pdb. The bodies follow the address-matched
	retail executable.

===============================================================================
*/

struct SElecWork {
	float		fraction;
	float		step;
	idVec4		tint;
	float		alpha;
	float		size;
	idVec3		length;
	idVec3		forward;
	idVec3		viewPos;
	srfTriangles_t *tri;
	idVec3		coords[BSE_ELEC_MAX_BOLTS];
};

assert_sizeof( SElecWork, 2472 );

int rvElectricityParticle::GetBoltCount( float length ) {
	return idMath::ClampInt( 3, BSE_ELEC_MAX_BOLTS,
		static_cast<int>( idMath::Ceil( length * ( 1.0f / 16.0f ) ) ) );
}

int rvElectricityParticle::Update( float time ) {
	idVec3 length;
	EvaluateLength( time - mStartTime, length );
	mNumBolts = GetBoltCount( length.Length() );
	return mNumBolts;
}

void rvElectricityParticle::RenderLineSegment( const rvBSE *effect,
		SElecWork *work, idVec3 start, float startFraction ) {
	idDrawVert *vertices = &work->tri->verts[work->tri->numVerts];
	const dword color = HandleTint( effect, work->tint, work->alpha );
	idVec3 offset = work->length.Cross( work->viewPos );
	offset.Normalize();
	offset *= work->size;
	const float textureFraction =
		startFraction * work->step + work->fraction;

	vertices[0].xyz = start + offset;
	vertices[0].SetColor( color );
	vertices[0].st.Set( textureFraction, 0.0f );
	vertices[1].xyz = start - offset;
	vertices[1].SetColor( color );
	vertices[1].st.Set( textureFraction, 1.0f );
	work->tri->numVerts += 2;
}

void rvElectricityParticle::ApplyShape( const rvBSE *effect,
		SElecWork *work, idVec3 start, idVec3 end, int count,
		float startFraction, float endFraction ) {
	int nextCount = count - 1;
	while ( count >= 1 ) {
		const float downScale = rvRandom::flrand( 0.05f, 0.09f );
		const float leftScale = rvRandom::flrand( 0.05f, 0.09f );
		const float firstFraction = rvRandom::flrand( 0.56f, 0.76f );
		const float firstDown = rvRandom::flrand(
			-downScale - 0.02f, 0.02f - downScale );
		const float secondDown = rvRandom::flrand(
			-leftScale - 0.02f, 0.02f - leftScale );
		const float secondFraction = rvRandom::flrand( 0.23f, 0.43f );

		idVec3 forward = end - start;
		const float shapeLength = forward.Normalize() * 0.7f;
		idVec3 left( -forward.y, forward.x, 0.0f );
		if ( left.Normalize() == 0.0f ) {
			left.Set( 1.0f, 0.0f, 0.0f );
		}
		const idVec3 down = left.Cross( forward );
		const idVec3 point1 = start * firstFraction +
			end * ( 1.0f - firstFraction ) +
			left * ( leftScale * shapeLength ) +
			down * ( downScale * shapeLength );
		const idVec3 point2 = start * secondFraction +
			end * ( 1.0f - secondFraction ) +
			left * ( secondDown * shapeLength ) +
			down * ( firstDown * shapeLength );

		const float fraction1 = startFraction * ( 2.0f / 3.0f ) +
			endFraction * ( 1.0f / 3.0f );
		ApplyShape( effect, work, start, point1, nextCount,
			startFraction, fraction1 );
		const float fraction2 = startFraction * ( 1.0f / 3.0f ) +
			endFraction * ( 2.0f / 3.0f );
		ApplyShape( effect, work, point1, point2, nextCount,
			fraction1, fraction2 );
		start = point2;
		startFraction = fraction2;
		--count;
		--nextCount;
	}
	RenderLineSegment( effect, work, start, startFraction );
}

void rvElectricityParticle::RenderBranch( const rvBSE *effect,
		SElecWork *work, idVec3 start, idVec3 end ) {
	work->forward.Normalize();
	idVec3 left( -work->forward.y, work->forward.x, 0.0f );
	if ( left.Normalize() == 0.0f ) {
		left.Set( 1.0f, 0.0f, 0.0f );
	}
	const idVec3 down = left.Cross( work->forward );
	float fraction = work->step;
	const int firstVertex = work->tri->numVerts;
	idVec3 old = start;
	idVec3 offset( 0.0f, 0.0f, 0.0f );
	int count = 0;
	bool evaluate = true;
	while ( true ) {
		if ( count < BSE_ELEC_MAX_BOLTS ) {
			work->coords[count] = old;
		}
		++count;
		if ( fraction >= 1.0f - work->step * 0.5f ) {
			fraction = 1.0f;
			evaluate = false;
		}
		offset += work->forward * rvRandom::flrand(
			-mJitterSize.x, mJitterSize.x );
		offset += left * rvRandom::flrand( -mJitterSize.y, mJitterSize.y );
		offset += down * rvRandom::flrand( -mJitterSize.z, mJitterSize.z );
		const float jitter = mJitterTable != NULL
			? mJitterTable->TableLookup( fraction ) : 1.0f;
		const idVec3 current = start + ( end - start ) * fraction +
			offset * jitter;
		work->fraction = fraction - work->step;
		ApplyShape( effect, work, old, current, 2, 0.0f, 1.0f );
		old = current;
		fraction += work->step;
		if ( !evaluate ) {
			if ( count < BSE_ELEC_MAX_BOLTS ) {
				work->coords[count] = current;
			}
			RenderLineSegment( effect, work, current, 1.0f );
			break;
		}
	}

	int index = work->tri->numIndexes;
	for ( int vertex = firstVertex; vertex < work->tri->numVerts - 2;
			vertex += 2 ) {
		work->tri->indexes[index++] = vertex;
		work->tri->indexes[index++] = vertex + 1;
		work->tri->indexes[index++] = vertex + 3;
		work->tri->indexes[index++] = vertex;
		work->tri->indexes[index++] = vertex + 3;
		work->tri->indexes[index++] = vertex + 2;
	}
	work->tri->numIndexes = index;
}

void rvElectricityParticle::SetupElectricity( rvParticleTemplate *particleTemplate ) {
	mNumForks = particleTemplate->mNumForks;
	mSeed = rvRandom::Init();
	mForkSizeMins = particleTemplate->mForkSizeMins;
	mForkSizeMaxs = particleTemplate->mForkSizeMaxs;
	mJitterSize = particleTemplate->mJitterSize;
	mLastJitter = 0.0f;
	mJitterRate = particleTemplate->mJitterRate;
	mJitterTable = particleTemplate->mJitterTable;
}

bool rvElectricityParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evaluationTime;
	if ( !GetEvaluationTime( time, evaluationTime ) ) {
		return false;
	}

	SElecWork work;
	EvaluateTint( evaluationTime, work.tint );
	EvaluateSize( evaluationTime, &work.size );
	EvaluateLength( evaluationTime, work.length );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	if ( !GetLocked() ) {
		work.length *= mInitAxis * effect->GetCurrentAxis().Transpose();
	}
	if ( GetGeneratedLine() ) {
		idVec3 velocity;
		EvaluateVelocity( effect, velocity, time - mMotionStartTime );
		velocity.Normalize();
		work.length = velocity * work.length.Length();
	}
	const float mainLength = work.length.Length();
	if ( mainLength < 0.1f ) {
		return false;
	}

	const int savedSeed = rvRandom::irand( 0, 0x7FFF );
	if ( mLastJitter + mJitterRate <= time ) {
		mLastJitter = time;
		mSeed = rvRandom::Init();
	}
	rvRandom::Init( mSeed );
	work.step = mTextureScale / static_cast<float>( mNumBolts );
	work.viewPos = view[0];
	work.tri = tri;
	work.alpha = override;
	work.forward = work.length;
	const idVec3 end = position + work.length;
	RenderBranch( effect, &work, position, end );

	const int forkCount = Min( mNumForks, 16 );
	idVec3 forkPoints[16];
	for ( int i = 0; i < forkCount; ++i ) {
		const int bolt = rvRandom::irand( 1, mNumBolts - 1 );
		forkPoints[i] = work.coords[bolt];
	}
	for ( int i = 0; i < forkCount; ++i ) {
		const idVec3 &forkStart = forkPoints[i];
		idVec3 forkEnd = ( position + forkStart + work.length ) * 0.5f;
		forkEnd.x += rvRandom::flrand( mForkSizeMins.x, mForkSizeMaxs.x );
		forkEnd.y += rvRandom::flrand( mForkSizeMins.y, mForkSizeMaxs.y );
		forkEnd.z += rvRandom::flrand( mForkSizeMins.z, mForkSizeMaxs.z );
		work.forward = forkEnd - forkStart;
		const float forkLength = work.forward.Length();
		if ( forkLength > 1.0f && forkLength < mainLength ) {
			work.step = 1.0f / static_cast<float>( GetBoltCount( forkLength ) );
			RenderBranch( effect, &work, forkStart, forkEnd );
		}
	}
	rvRandom::Init( savedSeed );
	return true;
}
