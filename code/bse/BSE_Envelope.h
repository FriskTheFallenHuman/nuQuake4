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

// Copyright (C) 2007 Id Software, Inc.
//


#ifndef _BSE_ENVELOPE_H_INC_
#define _BSE_ENVELOPE_H_INC_

#include "../framework/DeclTable.h"

class rvEnvParms
{
public:
	friend	class		rvEnvParms1;
	friend	class		rvEnvParms2;
	friend	class		rvEnvParms3;

						rvEnvParms( void ) { Init(); }
						rvEnvParms( const rvEnvParms &copy ) { *this = copy; }
						~rvEnvParms( void ) {}
	
			void		SetDefaultType( void );
			void		SetType( const char *type ) { mTable = declManager->FindTable( type ); }
			void		SetType( const idDeclTable *tabl ) { mTable = tabl; }

			idVec3		&GetOffsetRef( void ) { return( mEnvOffset ); }
			const idVec3 &GetOffsetRef( void ) const { return( mEnvOffset ); }
			idVec3		&GetRateRef( void ) { return( mRate ); }
			const idVec3 &GetRateRef( void ) const { return( mRate ); }
			const idDeclTable *GetType( void ) const { return mTable; }
			void		SetIsCount( bool isCount ) { mIsCount = isCount; }

			bool		GetIsCount( void ) const { return( mIsCount != 0 ); }
			void		CalcRate( float *rate, float duration, int count );

			void		Init( void );
			bool		GetMinMax( float &min, float &max );

			void		Evaluate3( const float time, const float *start, const float *rate, const float *end, float *dest );
			void		Evaluate( class rvEnvParms1Particle &env, float time, float oneOverDuration, float *v );
			void		Evaluate( class rvEnvParms2Particle &env, float time, float oneOverDuration, float *v );
			void		Evaluate( class rvEnvParms3Particle &env, float time, float oneOverDuration, float *v );

			void		operator=	( const rvEnvParms &copy ) {
				mTable = copy.mTable;
				mIsCount = copy.mIsCount;
				mEnvOffset = copy.mEnvOffset;
				mRate = copy.mRate;
			}
			bool		operator==	( const rvEnvParms &comp ) const { return( Compare( comp ) ); }
			bool		operator!=	( const rvEnvParms &comp ) const { return( !Compare( comp ) ); }

private:
			bool		Compare( const rvEnvParms &comp ) const;

	const	idDeclTable	*mTable;
			bool		mIsCount;
			idVec3		mEnvOffset;
			idVec3		mRate;
};

class rvEnvParms1
{
public:
	friend	class		rvEnvParms;

						rvEnvParms1( void ) {}
						~rvEnvParms1( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const float time, float *dest );

			float		*GetStart( void ) { return( &mStart ); }
			float		*GetEnd( void ) { return( &mEnd ); }

			void		Scale( const float constant ) { mStart *= constant; mEnd *= constant; }
			void		Transform( const idVec3 normal ) {}
			void		Rotate( const rvAngles &angles );
private:
	const	idDeclTable	*mTable;
			float		mEnvOffset;

			float		mStart;
			float		mRate;
			float		mEnd;
};

class rvEnvParms2
{
public:
	friend	class		rvEnvParms;

						rvEnvParms2( void ) {}
						~rvEnvParms2( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const float time, float *dest );

			float		*GetStart( void ) { return( mStart.ToFloatPtr() ); }
			float		*GetEnd( void ) { return( mEnd.ToFloatPtr() ); }

			void		Scale( const float constant ) { mStart *= constant; mEnd *= constant; }
			void		Transform( const idVec3 normal ) {}
			void		Rotate( const rvAngles &angles );
private:
	const	idDeclTable	*mTable;
			idVec2		mEnvOffset;

			bool		mFixedRateAndOffset;
			idVec2		mStart;
			idVec2		mRate;
			idVec2		mEnd;
};

class rvEnvParms3
{
public:
	friend	class		rvEnvParms;

						rvEnvParms3( void ) {}
						~rvEnvParms3( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const float time, float *dest );

			float		*GetStart( void ) { return( mStart.ToFloatPtr() ); }
			float		*GetEnd( void ) { return( mEnd.ToFloatPtr() ); }

			void		Scale( const float constant );
			void		Transform( const idVec3 normal ) { mStart *= normal.ToMat3(); mEnd *= normal.ToMat3(); }
			void		Rotate( const rvAngles &angles );
private:
	const	idDeclTable	*mTable;
			idVec3		mEnvOffset;

			bool		mFixedRateAndOffset;
			idVec3		mStart;
			idVec3		mRate;
			idVec3		mEnd;
};

class rvEnvParms1Particle
{
public:
	friend	class		rvEnvParms;
	friend	class		rvParticle;

						rvEnvParms1Particle( void ) {}
						~rvEnvParms1Particle( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const rvEnvParms & params, const float time, float oneOverDuration, float *dest );

			float		*GetStart( void ) { return( &mStart ); }
			float		*GetEnd( void ) { return( &mEnd ); }

			void		Scale( const float constant ) { mStart *= constant; mEnd *= constant; }
			void		Transform( const idVec3 normal ) {}
			void		Rotate( const rvAngles &angles );
private:
			float		mStart;
			float		mEnd;
};

class rvEnvParms2Particle
{
public:
	friend	class		rvEnvParms;
	friend	class		rvParticle;

						rvEnvParms2Particle( void ) {}
						~rvEnvParms2Particle( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const rvEnvParms & params, const float time, float oneOverDuration, float *dest );

			float		*GetStart( void ) { return( mStart.ToFloatPtr() ); }
			float		*GetEnd( void ) { return( mEnd.ToFloatPtr() ); }

			void		Scale( const float constant ) { mStart *= constant; mEnd *= constant; }
			void		Transform( const idVec3 normal ) {}
			void		Rotate( const rvAngles &angles );
private:
			idVec2		mStart;
			idVec2		mEnd;
};

class rvEnvParms3Particle
{
public:
	friend	class		rvEnvParms;
	friend	class		rvParticle;
	friend  class		rvDebrisParticle;
	friend  class		rvLineParticle;
	friend  class		rvElectricityParticle;

						rvEnvParms3Particle( void ) {}
						~rvEnvParms3Particle( void ) {}

			void		Init( const rvEnvParms & copy, float duration );
			void		Evaluate( const rvEnvParms & params, const float time, float oneOverDuration, float *dest );

			float		*GetStart( void ) { return( mStart.ToFloatPtr() ); }
			float		*GetEnd( void ) { return( mEnd.ToFloatPtr() ); }

			void		Scale( const float constant ) { mStart *= constant; mEnd *= constant; }
			void		Transform( const idMat3 &m ) { mStart *= m; mEnd *= m; }
			void		Transform( const idVec3 normal ) { idMat3 const m = normal.ToMat3(); mStart *= m; mEnd *= m; }
			void		Rotate( const rvAngles &angles );
private:
			idVec3		mStart;
			idVec3		mEnd;
};

#endif // _BSE_ENVELOPE_H_INC_
