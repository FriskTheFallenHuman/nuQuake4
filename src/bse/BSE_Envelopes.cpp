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

#include "BSE_Envelope.h"

/*
===============================================================================

	Quake 4 BSE envelopes

	Compilation-unit boundary and signatures are taken from BSE_Envelopes.obj
	in quake4.pdb.  Control flow is reconstructed from the matching retail RVAs.

===============================================================================
*/

void rvEnvParms1::Evaluate( const float time, float *dest ) {
	if ( mTable != NULL ) {
		const float lookup = mTable->TableLookup( time * mRate + mEnvOffset );
		*dest = mStart + ( mEnd - mStart ) * lookup;
	} else {
		*dest = mStart;
	}
}

void rvEnvParms::SetDefaultType( void ) {
	if ( mTable == NULL ) {
		mTable = declManager->FindTable( "linear", true );
		mIsCount = true;
	}
}

void rvEnvParms2::Evaluate( const float time, float *dest ) {
	if ( mTable == NULL ) {
		dest[0] = mStart[0];
		dest[1] = mStart[1];
		return;
	}

	float lookup = mTable->TableLookup( time * mRate[0] + mEnvOffset[0] );
	dest[0] = mStart[0] + ( mEnd[0] - mStart[0] ) * lookup;
	if ( !mFixedRateAndOffset ) {
		lookup = mTable->TableLookup( time * mRate[1] + mEnvOffset[1] );
	}
	dest[1] = mStart[1] + ( mEnd[1] - mStart[1] ) * lookup;
}

void rvEnvParms3::Evaluate( const float time, float *dest ) {
	if ( mTable == NULL ) {
		dest[0] = mStart[0];
		dest[1] = mStart[1];
		dest[2] = mStart[2];
		return;
	}

	float lookup = mTable->TableLookup( time * mRate[0] + mEnvOffset[0] );
	dest[0] = mStart[0] + ( mEnd[0] - mStart[0] ) * lookup;
	if ( mFixedRateAndOffset ) {
		dest[1] = mStart[1] + ( mEnd[1] - mStart[1] ) * lookup;
	} else {
		lookup = mTable->TableLookup( time * mRate[1] + mEnvOffset[1] );
		dest[1] = mStart[1] + ( mEnd[1] - mStart[1] ) * lookup;
		lookup = mTable->TableLookup( time * mRate[2] + mEnvOffset[2] );
	}
	dest[2] = mStart[2] + ( mEnd[2] - mStart[2] ) * lookup;
}

void rvEnvParms::Init( void ) {
	mTable = NULL;
	mIsCount = true;
	mEnvOffset.Zero();
	mRate.Set( 1.0f, 1.0f, 1.0f );
}

void rvEnvParms1::Init( const rvEnvParms &copy, float duration ) {
	mTable = copy.mTable;
	mEnvOffset = copy.mEnvOffset[0];
	mRate = copy.mIsCount ? copy.mRate[0] / duration : copy.mRate[0];
}

void rvEnvParms2::Init( const rvEnvParms &copy, float duration ) {
	mTable = copy.mTable;
	mEnvOffset.Set( copy.mEnvOffset[0], copy.mEnvOffset[1] );
	if ( copy.mIsCount ) {
		const float inverseDuration = 1.0f / duration;
		mRate.Set( copy.mRate[0] * inverseDuration, copy.mRate[1] * inverseDuration );
	} else {
		mRate.Set( copy.mRate[0], copy.mRate[1] );
	}
	mFixedRateAndOffset = mRate[0] == mRate[1] && mEnvOffset[0] == mEnvOffset[1];
}

void rvEnvParms3::Init( const rvEnvParms &copy, float duration ) {
	mTable = copy.mTable;
	mEnvOffset = copy.mEnvOffset;
	if ( copy.mIsCount ) {
		mRate = copy.mRate * ( 1.0f / duration );
	} else {
		mRate = copy.mRate;
	}
	mFixedRateAndOffset =
		mRate[0] == mRate[1] && mRate[0] == mRate[2] &&
		mEnvOffset[0] == mEnvOffset[1] && mEnvOffset[0] == mEnvOffset[2];
}

void rvEnvParms3::Rotate( const rvAngles &angles ) {
	mStart[0] += angles.pitch;
	mStart[1] += angles.yaw;
	mStart[2] += angles.roll;
	mEnd[0] += angles.pitch;
	mEnd[1] += angles.yaw;
	mEnd[2] += angles.roll;
}

bool rvEnvParms::GetMinMax( float &min, float &max ) {
	if ( mTable == NULL ) {
		min = max = 0.0f;
		return false;
	}
	min = mTable->GetMinValue();
	max = mTable->GetMaxValue();
	return true;
}

bool rvEnvParms::Compare( const rvEnvParms &comp ) const {
	return mTable == comp.mTable &&
		mIsCount == comp.mIsCount &&
		mRate == comp.mRate &&
		mEnvOffset == comp.mEnvOffset;
}

void rvEnvParms::CalcRate( float *rate, float duration, int count ) {
	for ( int i = 0; i < count; ++i ) {
		rate[i] = mIsCount ? mRate[i] / duration : mRate[i];
	}
}

void rvEnvParms::Evaluate3( const float time, const float *start, const float *rate,
		const float *end, float *dest ) {
	if ( mTable == NULL ) {
		memcpy( dest, start, sizeof( float ) * 3 );
		return;
	}
	for ( int i = 0; i < 3; ++i ) {
		const float lookup = mTable->TableLookup( time * rate[i] + mEnvOffset[i] );
		dest[i] = start[i] + ( end[i] - start[i] ) * lookup;
	}
}
