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


#ifndef _BSE_PARTICLE_H_INC_
#define _BSE_PARTICLE_H_INC_

#include "BSE_Envelope.h"
#include "BSE_SpawnDomains.h"
#include "../renderer/ModelManager.h"
#include "../renderer/RenderWorld.h"

#define BSE_FUTURE				( 0.016f )			// How far into the future to check for particle spawning
#define BSE_TIME_EPSILON		( 0.002f )			// Edge condition checks
#define BSE_PHYSICS_TIME_SAMPLE	( 0.1f )			// Number of seconds to check the position delta for physics
#define BSE_MINIMUM_TRACE_DIST	( 16.0f )			// The square of the distance below which physics will not check
#define BSE_SURFACE_OFFSET		( 2.0f )			// Amount a collision is pushed back along the normal
#define BSE_BOUNCE_LIMIT		( 2500.0f )			// Square of velocity below which a particle stops bouncing
#define BSE_TRACE_OFFSET		( 0.02f )			// How much the bounce should move back from the endpos
#define MAX_PARTICLES			( 2048 )			// Max number of particles attached to an effect (arbitrary sanity check)
#define BSE_DENSITY_FACTOR		( 50.0f )

#define BSE_MAX_FORKS			( 16 )

#define BSE_MAX_DURATION		( 60.0f * 5.0f )	// 5 Minutes

#define BSE_NUM_SPAWNABLE		( 4 )				// Number of random effects to choose from

enum
{
	PTYPE_NONE = 0,									// A non sprite - for sound and vision segments
	PTYPE_SPRITE,									// Simple 2D alpha blended quad
	PTYPE_LINE,										// 2D alpha blended line
	PTYPE_ORIENTED,									// 2D particle oriented in 3D - alpha blended
	PTYPE_DECAL,									// Hook into id's decal system
	PTYPE_MODEL,									// Model - must only have 1 surface
	PTYPE_LIGHT,									// Dynamic light - very expensive
	PTYPE_ELECTRICITY,								// A bolt of electricity
	PTYPE_LINKED,									// A series of linked lines
	PTYPE_DEBRIS,									// A client side moveable entity spawned in the game
	PTYPE_COUNT
};

// Defined classes 
class rvParticle;
class rvSpriteParticle;
class rvLineParticle;
class rvOrientedParticle;
class rvElectricityParticle;
class rvDecalParticle;
class rvModelParticle;
class rvLightParticle;
class rvLinkedParticle;
class sdOrientedLinkedParticle;
class rvDebrisParticle;

class rvParticleTemplate;
class rvParticleParms;

// Referenced classes
class rvBSE;
class rvDeclEffect;
class rvSegment;
class rvSegmentTemplate;

#define PTFLAG_STATIONARY			BIT( 0 )
#define PTFLAG_LOCKED				BIT( 1 )
#define PTFLAG_HAS_OFFSET			BIT( 2 )

#define PTFLAG_PARSED				BIT( 8 )
#define PTFLAG_HAS_PHYSICS			BIT( 9 )
#define PTFLAG_DELETE_ON_IMPACT		BIT( 10 )
#define PTFLAG_GENERATED_NORMAL		BIT( 11 )
#define PTFLAG_GENERATED_ORG_NORMAL	BIT( 12 )
#define PTFLAG_FLIPPED_NORMAL		BIT( 13 )
#define PTFLAG_CALCED_NORMAL		BIT( 14 )
#define PTFLAG_ADDITIVE				BIT( 15 )
#define PTFLAG_GENERATED_LINE		BIT( 16 )
#define PTFLAG_SHADOWS				BIT( 17 )
#define PTFLAG_SPECULAR				BIT( 18 )
#define PTFLAG_LINKED				BIT( 19 )
#define PTFLAG_TILED				BIT( 20 )
#define PTFLAG_PERSIST				BIT( 21 )
#define PTFLAG_USELIGHTNING_AXIS	BIT( 22 )
#define PTFLAG_FADE_IN				BIT( 23 )
#define PTFLAG_USE_MATERIAL_COLOR	BIT( 24 )
#define PTFLAG_PARENTVEL			BIT( 25 )
#define PTFLAG_HAS_LINEHIT			BIT( 26 )
#define PTFLAG_INITED				BIT( 27 )

// ==============================================
// Particle types (from multiple elements)
// ==============================================
class rvParticle
{
public:
	friend		class			rvParticleTemplate;
	friend		class			rvSegment;

								rvParticle( void ) {}
	virtual						~rvParticle( void ) {}

				void			SetFlag( bool on, int flag ) { on ? mFlags |= flag : mFlags &= ~flag; }
				bool			GetFlag( int flag ) const { return ( mFlags & flag ) != 0 ; }
				
				int			GetStationary( void ) const { return( ( mFlags & PTFLAG_STATIONARY ) ); }
				int			GetLocked( void ) const { return( ( mFlags & PTFLAG_LOCKED ) ); }
				int			GetHasOffset( void ) const { return( ( mFlags & PTFLAG_HAS_OFFSET ) ); }

				int			GetGeneratedLine( void ) const { return( ( mFlags & PTFLAG_GENERATED_LINE ) ); }
				int			GetAdditive( void ) const { return( ( mFlags & PTFLAG_ADDITIVE ) ); }
				int			GetTiled( void ) const { return( ( mFlags & PTFLAG_TILED ) ); }
				int			GetPersist( void ) const { return( ( mFlags & PTFLAG_PERSIST ) ); }

				void			SetStationary( bool stopped ) { SetFlag( stopped, PTFLAG_STATIONARY ); }
				void			SetLocked( bool locked ) { SetFlag( locked, PTFLAG_LOCKED ); }
				void			SetHasOffset( bool hasOffset ) { SetFlag( hasOffset, PTFLAG_HAS_OFFSET ); }

				void			SetNext( rvParticle *next ) { mNext = next; }
				rvParticle		*GetNext( void ) const { return( mNext ); }	

	ID_INLINE   float			GetDuration( void ) const { return( mEndTime - mStartTime ); }
				void			ExtendLife( float time ) { mEndTime = time; }	
				bool			Expired( float time ) const { return( time >= mEndTime - BSE_TIME_EPSILON ); }
	
				void			CalcImpactPoint( idVec3 &endPos, const idVec3 &origin, const idVec3 &motion, const idBounds &bounds, const idVec3 &normal );
				void			SetOriginUsingEndOrigin( rvBSE *effect, rvParticleTemplate *pt, idVec3 *normal, idVec3 *centre );
				void			HandleEndOrigin( rvBSE *effect, rvParticleTemplate *pt, idVec3 *normal = NULL, idVec3 *centre = NULL );
				void			SetLengthUsingEndOrigin( rvBSE *effect, rvParticleParms &parms, float *length );
				void			HandleEndLength( rvBSE *effect, rvParticleTemplate *pt, rvParticleParms &parms, float *length );
				void			Bounce( rvBSE *effect, rvParticleTemplate *pt, idVec3 endPos, idVec3 normal, float time );
				bool			RunPhysics( rvBSE *effect, rvSegmentTemplate *pt, float time );
				void			CheckTimeoutEffect( rvBSE *effect, rvSegmentTemplate *st, float time );
				int				HandleTint( const rvBSE *effect, idVec4 &colour, float alpha );
				void			RenderQuadTrail( const rvBSE *effect, srfTriangles_t *tri, idVec3 offset, float fraction, idVec4 &colour, idVec3 &pos, bool first );
				void			EmitSmokeParticles( rvBSE *effect, rvSegment *child, float time );
				void			ScaleAngle( float constant );
				float			GetEndTime( void ) const { return( mEndTime ); }

	virtual		rvParticle		*GetArrayEntry( int i ) const { assert( 0 ); return( NULL ); }
	virtual		int				GetArrayIndex( rvParticle *p ) const { assert( 0 ); return( 0 ); }

				bool			GetEvaluationTime( float time, float &evalTime, bool infinite = false );
				void			EvaluatePosition( const rvBSE *effect, idVec3 &pos, float time );
				void			EvaluateVelocity( const rvBSE *effect, idVec3 &velocity, float time );

	ID_INLINE	void			EvaluateTint( const float time, idVec4 &dest ) {
									mTintEnv.Evaluate( time, dest.ToFloatPtr() );
									mFadeEnv.Evaluate( time, &dest[3] );
								}

	ID_INLINE	void			EvaluateAngle( const float time, rvAngles &dest ) {
									mAngleEnv.Evaluate( time, dest.ToFloatPtr() );
								}

	ID_INLINE	void			EvaluateOffset( const float time, idVec3 &dest ) {
									mOffsetEnv.Evaluate( time, dest.ToFloatPtr() );
								}

	
	virtual		void			EvaluateSize( float time, float *dest ) { assert( 0 ); }
	virtual		void			EvaluateRotation( float time, float *dest ) { assert( 0 ); }
	virtual		void			EvaluateLength( float time, idVec3 &dest ) { assert( 0 ); }
	

				void			InitTintEnv( rvEnvParms &env, float duration ) { mTintEnv.Init( env, duration ); }
				void			InitFadeEnv( rvEnvParms &env, float duration ) { mFadeEnv.Init( env, duration ); }
				void			InitAngleEnv( rvEnvParms &env, float duration ) { mAngleEnv.Init( env, duration ); }
				void			InitOffsetEnv( rvEnvParms &env, float duration ) { mOffsetEnv.Init( env, duration ); }
	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { assert( 0 ); }
	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) { assert( 0 ); }
	virtual		void			InitLengthEnv( rvEnvParms &env, float duration ) { assert( 0 ); }

	virtual		float			*GetInitSize( void ) { assert( 0 ); return( NULL ); }
	virtual		float			*GetDestSize( void ) { assert( 0 ); return( NULL ); }

	virtual		float			*GetInitRotation( void ) { assert( 0 ); return( NULL ); }
	virtual		float			*GetDestRotation( void ) { assert( 0 ); return( NULL ); }
	virtual		void			ScaleRotation( float constant ) {}

	virtual		float			*GetInitLength( void ) { assert( 0 );  return( NULL ); }
	virtual		float			*GetDestLength( void ) { assert( 0 );  return( NULL ); }

				void			Attenuate( float atten, rvParticleParms &parms, rvEnvParms1 &result );
				void			Attenuate( float atten, rvParticleParms &parms, rvEnvParms2 &result );
				void			Attenuate( float atten, rvParticleParms &parms, rvEnvParms3 &result );
				void			AttenuateFade( float atten, rvParticleParms &parms );
	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) {}
	virtual		void			AttenuateLength( float atten, rvParticleParms &parms ) {}

	virtual		void			TransformLength( idVec3 normal ) {}
	virtual		void			ScaleLength( float constant ) {}
	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) { assert( 0 ); }
	virtual		void			HandleTiling( rvParticleTemplate *pt ) {}

	virtual		void			HandleOrientation( rvAngles &angles ) {}
	virtual		void			FinishSpawn( rvBSE *effect, rvSegment *segment, float birthTime, float fraction = 0.0f, const idVec3 &initOffset = vec3_origin, const idMat3 &initAxis = mat3_identity );
	virtual		int				Update( float time ) { return( 1 ); }
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t *tri, float time, float override = 1.0f ) { return( false ); }
				void			DoRenderBurnTrail( rvBSE *effect, const idMat3 &view, srfTriangles_t *tri, float time );
	virtual		void			RenderBurnTrail( rvBSE *effect, const idMat3 &view, srfTriangles_t *tri, float time ) {}
	virtual		void			RenderMotion( rvBSE *effect, srfTriangles_t *tri, const struct renderEffect_s *owner, float time );
	virtual		bool			InitLight( rvBSE *effect, rvSegmentTemplate *st, float time ) { return( false ); }
	virtual		bool			PresentLight( rvBSE *effect, float time, bool infinite ) { return( false ); }
	virtual		bool			Destroy( void ) { return( false ); }
	virtual		void			SetModel( const char *modelName ) {}
	virtual		void			SetupElectricity( rvParticleTemplate *pt ) {}
	virtual		void			Refresh( rvBSE *effect, rvSegmentTemplate *st, rvParticleTemplate *pt ) {}

protected:
				// Can be altered in UpdateParticles
	class		rvParticle		*mNext;
				float			mMotionStartTime;						// World start time for motion calcs - reset on a bounce

				// could be stored as a delta from start
				float			mLastTrailTime;							// Last time a smoke particle was emitted

				// need to restructure flags
				int				mFlags;

				// Fixed at spawn time
				float			mStartTime;								// World start time of particle in seconds
				float			mEndTime;								// End of particle's life

				float			mTrailTime;								// Length of trail
				int				mTrailCount;							// Number of particles in trail

				// always between 0 and 1 inc
				float			mFraction;								// Fraction along the line

				float			mTextureScale;							// Multiplier for the texture coord

				idVec3			mInitEffectPos;							// Initial effect position when the particle is spawned
				idMat3			mInitAxis;								// Initial effect axis when the particle is spawned

				idVec3			mInitPos;								// Position at time = 0
				idVec3			mNormal;
				idVec3			mVelocity;								// Initial velocity
				idVec3			mAcceleration;							// Initial acceleration
				idVec3			mFriction;

				rvEnvParms3		mTintEnv;
				rvEnvParms1		mFadeEnv;
				rvEnvParms3		mAngleEnv;
				rvEnvParms3		mOffsetEnv;
};

class rvSpriteParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {
		mSizeEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateRotation( float time, float *dest ) {
		mRotationEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}
	//virtual		void			EvaluateLength( rvEnvParms *length, const float time, float oneOverDuration, idVec3 &dest ) {}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { mSizeEnv.Init( env, duration ); }
	virtual		float			*GetInitSize( void ) { return( mSizeEnv.GetStart() ); }
	virtual		float			*GetDestSize( void ) { return( mSizeEnv.GetEnd() ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) { mRotationEnv.Init( env, duration ); }
	virtual		float			*GetInitRotation( void ) { return( mRotationEnv.GetStart() ); }
	virtual		float			*GetDestRotation( void ) { return( mRotationEnv.GetEnd() ); }

	virtual		void			ScaleRotation( float constant ) { mRotationEnv.Scale( constant ); }

	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mSizeEnv ); }

	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate );
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );
	virtual		void			RenderBurnTrail( rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time ) { DoRenderBurnTrail( effect, view, tri, time ); }

protected:
				// Fixed at spawn time
				rvEnvParms2		mSizeEnv;
				rvEnvParms1		mRotationEnv;
};

class rvLineParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {
		mSizeEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {
		mLengthEnv.Evaluate( time, dest.ToFloatPtr() );
	}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { mSizeEnv.Init( env, duration ); }
	virtual		float			*GetInitSize( void ) { return( mSizeEnv.GetStart() ); }
	virtual		float			*GetDestSize( void ) { return( mSizeEnv.GetEnd() ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) {}
	virtual		float			*GetInitRotation( void ) { return( NULL ); }
	virtual		float			*GetDestRotation( void ) { return( NULL ); }
	virtual		void			SetRotation( void ) {}

	virtual		void			InitLengthEnv( rvEnvParms &env, float duration ) { mLengthEnv.Init( env, duration ); }
	virtual		float			*GetInitLength( void ) { return( mLengthEnv.GetStart() ); }
	virtual		float			*GetDestLength( void ) { return( mLengthEnv.GetEnd() ); }
	virtual		void			TransformLength( idVec3 normal ) { mLengthEnv.Transform( normal ); }
	virtual		void			ScaleLength( float constant ) { mLengthEnv.Scale( constant ); }

	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mSizeEnv ); }
	virtual		void			AttenuateLength( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mLengthEnv ); }

	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate );
	virtual		void			HandleTiling( rvParticleTemplate *pt );
	virtual		void			FinishSpawn( rvBSE *effect, rvSegment *segment, float birthTime, float fraction = 0.0f, const idVec3 &initOffset = vec3_origin, const idMat3 &initAxis = mat3_identity );
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );
	virtual		void			RenderBurnTrail( rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time ) { DoRenderBurnTrail( effect, view, tri, time ); }
	virtual		void			Refresh( rvBSE *effect, rvSegmentTemplate *st, rvParticleTemplate *pt );

protected:
				// Fixed at spawn time
				rvEnvParms1		mSizeEnv;
				rvEnvParms3		mLengthEnv;
};

class rvOrientedParticle : public rvSpriteParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateRotation( float time, float *dest ) {
		mRotationEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) { mRotationEnv.Init( env, duration ); }
	virtual		float			*GetInitRotation( void ) { return( mRotationEnv.GetStart() ); }
	virtual		float			*GetDestRotation( void ) { return( mRotationEnv.GetEnd() ); }

	virtual		void			ScaleRotation( float constant ) { mRotationEnv.Scale( constant ); }

	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate );
	virtual		void			HandleOrientation( rvAngles &angles ) { mRotationEnv.Rotate( angles ); }
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );

private:
				// Fixed at spawn time
				rvEnvParms3		mRotationEnv;
};

class rvElectricityParticle : public rvLineParticle
{
public:
	friend		class			rvParticleTemplate;

				int				GetBoltCount( float length );
				void			RenderBranch( const rvBSE *effect, struct SElecWork *work, idVec3 start, idVec3 end );
				void			RenderLineSegment( const rvBSE *effect, struct SElecWork *work, idVec3 start, float startFraction );
				void			ApplyShape( const rvBSE *effect, struct SElecWork *work, idVec3 start, idVec3 end, int count, float startFraction, float endFraction );

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		int				Update( float time );
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t *tri, float time, float override = 1.0f );

	virtual		void			SetupElectricity( rvParticleTemplate *pt );

private:
				// Alterable
				int				mNumBolts;

				// Fixed at spawn time
				int				mNumForks;
				int				mSeed;
				idVec3			mForkSizeMins;
				idVec3			mForkSizeMaxs;
				idVec3			mJitterSize;
				float			mLastJitter;
				float			mJitterRate;
	const		idDeclTable		*mJitterTable;
};

class rvDecalParticle : public rvSpriteParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) {}
	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) {}
private:
};

class rvModelParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {
		mSizeEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateRotation( float time, float *dest ) {
		mRotationEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { mSizeEnv.Init( env, duration ); }
	virtual		float			*GetInitSize( void ) { return( mSizeEnv.GetStart() ); }
	virtual		float			*GetDestSize( void ) { return( mSizeEnv.GetEnd() ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) { mRotationEnv.Init( env, duration ); }
	virtual		float			*GetInitRotation( void ) { return( mRotationEnv.GetStart() ); }
	virtual		float			*GetDestRotation( void ) { return( mRotationEnv.GetEnd() ); }

	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate );
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );
	virtual		void			SetModel( const char *modelName );

	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mSizeEnv ); }

private:
				// Fixed at spawn time
				rvEnvParms3		mSizeEnv;
				rvEnvParms3		mRotationEnv;

				const idRenderModel	*mModel;
};

class rvLightParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

								rvLightParticle( void ) { mLightDefHandle = -1; }
								~rvLightParticle( void ) { Destroy(); }

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {
		mSizeEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { mSizeEnv.Init( env, duration ); }
	virtual		float			*GetInitSize( void ) { return( mSizeEnv.GetStart() ); }
	virtual		float			*GetDestSize( void ) { return( mSizeEnv.GetEnd() ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) {}
	virtual		float			*GetInitRotation( void ) { return( NULL ); }
	virtual		float			*GetDestRotation( void ) { return( NULL ); }

	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mSizeEnv ); }

	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate );
	virtual		bool			InitLight( rvBSE *effect, rvSegmentTemplate *st, float time );
	virtual		bool			PresentLight( rvBSE *effect, float time, bool infinite );
	virtual		bool			Destroy( void );

private:
				// Fixed at spawn time
				rvEnvParms3		mSizeEnv;

				// Alterable
				qhandle_t		mLightDefHandle;
				renderLight_t	mLight;
};

class rvLinkedParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateSize( float time, float *dest ) {
		mSizeEnv.Evaluate( time, dest );
	}
	virtual		void			EvaluateLength( float time, idVec3 &dest ) {}

	virtual		void			InitSizeEnv( rvEnvParms &env, float duration ) { mSizeEnv.Init( env, duration ); }
	virtual		float			*GetInitSize( void ) { return( mSizeEnv.GetStart() ); }
	virtual		float			*GetDestSize( void ) { return( mSizeEnv.GetEnd() ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) {}
	virtual		float			*GetInitRotation( void ) { return( NULL ); }
	virtual		float			*GetDestRotation( void ) { return( NULL ); }

	virtual		void			AttenuateSize( float atten, rvParticleParms &parms ) { Attenuate( atten, parms, mSizeEnv ); }

	virtual		void			FinishSpawn( rvBSE *effect, rvSegment *segment, float birthTime, float fraction = 0.0f, const idVec3 &initOffset = vec3_origin, const idMat3 &initAxis = mat3_identity );
	virtual		void			GetSpawnInfo( idVec4 &tint, idVec3 &size, idVec3 &rotate ) {}
	virtual		void			HandleTiling( rvParticleTemplate *pt );
	virtual		bool			Render( const rvBSE *effect, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );

private:
				// Fixed at spawn time
				rvEnvParms1		mSizeEnv;
};

class sdOrientedLinkedParticle : public rvLinkedParticle
{
public:
	virtual		bool			Render( const rvBSE *effect, rvParticleTemplate *pt, const idMat3 &view, srfTriangles_t* tri, float time, float override = 1.0f );
};

class rvDebrisParticle : public rvParticle
{
public:
	friend		class			rvParticleTemplate;

	virtual		rvParticle		*GetArrayEntry( int i ) const;
	virtual		int				GetArrayIndex( rvParticle *p ) const;

	virtual		void			EvaluateRotation( float time, float *dest ) { mRotationEnv.Evaluate( time, dest ); }

	virtual		void			InitRotationEnv( rvEnvParms &env, float duration ) { mRotationEnv.Init( env, duration ); }
	virtual		float			*GetInitRotation( void ) { return( mRotationEnv.GetStart() ); }
	virtual		float			*GetDestRotation( void ) { return( mRotationEnv.GetEnd() ); }

	virtual		void			ScaleRotation( float constant ) { mRotationEnv.Scale( constant ); }
	virtual		void			FinishSpawn( rvBSE *effect, rvSegment *segment, float birthTime, float fraction = 0.0f, const idVec3 &initOffset = vec3_origin, const idMat3 &initAxis = mat3_identity );

private:
				// Fixed at spawn time
				rvEnvParms3		mRotationEnv;
};

// ================================================================================================

struct rvTrailInfo {
	short					mTrailType;
	byte					mStatic;
	byte					mPad;
	idStr					mTrailTypeName;
	const idMaterial		*mTrailMaterial;
	idVec2					mTrailTime;								// Length of trial in seconds
	idVec2					mTrailCount;							// Number of particles in trail
	float					mTrailScale;							// Width of the motion trails will be particleSize scaled by this

	rvTrailInfo() : mStatic(0) {
	}
};

struct rvElectricityInfo {
	int						mNumForks;								// Number of forks for 
	byte					mStatic;
	byte					mPad;
	idVec3					mForkSizeMins;
	idVec3					mForkSizeMaxs;
	idVec3					mJitterSize;							// Amount of jitter for the electricity
	float					mJitterRate;
	const idDeclTable		*mJitterTable;							// The envelope for the jitter in the lightning bolt

	rvElectricityInfo() : mStatic(0) {
	}
};

class rvParticleTemplate
{
public:
	friend		class				rvParticle;
	friend		class				rvSpriteParticle;
	friend		class				rvLineParticle;
	friend		class				rvOrientedParticle;
	friend		class				rvElectricityParticle;
	friend		class				rvModelParticle;
	friend		class				rvLightParticle;
	friend		class				rvDebrisParticle;
	friend		class				rvParticleTemplateWrapper;
	friend		class				rvDeclEffectEditLocal;
	friend		class				rvLinkedParticle;
	friend		class				sdOrientedLinkedParticle;

									rvParticleTemplate( void );
									~rvParticleTemplate( void ) {}

				bool				operator== ( const rvParticleTemplate& a ) const { return( Compare( a ) ); }
				bool				operator!= ( const rvParticleTemplate& a ) const { return( !Compare( a ) ); }

				void				SetFlag( bool on, int flag ) { on ? mFlags |= flag : mFlags &= ~flag; }
				bool				GetFlag( int flag ) const { return ( mFlags & flag ) != 0; }
				bool				GetParsed( void ) const { return( !!( mFlags & PTFLAG_PARSED ) ); }
				bool				GetHasPhysics( void ) const { return( !!( mFlags & PTFLAG_HAS_PHYSICS ) ); }
				bool				GetHasLineHit( void ) const { return( !!( mFlags & PTFLAG_HAS_LINEHIT ) ); }
				bool				GetDeleteOnImpact( void ) const { return( !!( mFlags & PTFLAG_DELETE_ON_IMPACT ) ); }
				bool				GetGeneratedNormal( void ) const { return( !!( mFlags & PTFLAG_GENERATED_NORMAL ) ); }
				bool				GetGeneratedOriginNormal( void ) const { return( !!( mFlags & PTFLAG_GENERATED_ORG_NORMAL ) ); }
				bool				GetFlippedNormal( void ) const { return( !!( mFlags & PTFLAG_FLIPPED_NORMAL ) ); }
				bool				GetCalculatedNormal( void ) const { return( !!( mFlags & PTFLAG_CALCED_NORMAL ) ); }
				bool				GetAdditive( void ) const { return( !!( mFlags & PTFLAG_ADDITIVE ) ); }
				bool				GetGeneratedLine( void ) const { return( !!( mFlags & PTFLAG_GENERATED_LINE ) ); }
				bool				GetShadows( void ) const { return( !!( mFlags & PTFLAG_SHADOWS ) ); }
				bool				GetSpecular( void ) const { return( !!( mFlags & PTFLAG_SPECULAR ) ); }
				bool				GetLinked( void ) const { return( !!( mFlags & PTFLAG_LINKED ) ); }
				bool				GetTiled( void ) const { return( !!( mFlags & PTFLAG_TILED ) ); }
				bool				GetPersist( void ) const { return( !!( mFlags & PTFLAG_PERSIST ) ); }
				bool				GetParentVelocity( void ) const { return( !!( mFlags & PTFLAG_PARENTVEL ) ); }

				void				SetParsed( bool parsed ) { SetFlag( parsed, PTFLAG_PARSED ); }
				void				SetHasPhysics( bool hasPhysics ) { SetFlag( hasPhysics, PTFLAG_HAS_PHYSICS ); }
				void				SetHasLineHit( bool hasLH ) { SetFlag( hasLH, PTFLAG_HAS_LINEHIT ); }
				void				SetDeleteOnImpact( bool deleteOnImpact ) { SetFlag( deleteOnImpact, PTFLAG_DELETE_ON_IMPACT ); }
				void				SetGeneratedNormal( bool generatedNormal ) { SetFlag( generatedNormal, PTFLAG_GENERATED_NORMAL ); }
				void				SetGeneratedOriginNormal( bool generatedNormal ) { SetFlag( generatedNormal, PTFLAG_GENERATED_ORG_NORMAL ); }
				void				SetFlippedNormal( bool flippedNormal ) { SetFlag( flippedNormal, PTFLAG_FLIPPED_NORMAL ); }
				void				SetCalculatedNormal( bool calcedNormal ) { SetFlag( calcedNormal, PTFLAG_CALCED_NORMAL ); }
				void				SetAdditive( bool additive ) { SetFlag( additive, PTFLAG_ADDITIVE ); }
				void				SetGeneratedLine( bool generatedLine ) { SetFlag( generatedLine, PTFLAG_GENERATED_LINE ); }
				void				SetShadows( bool shadows ) { SetFlag( shadows, PTFLAG_SHADOWS ); }
				void				SetSpecular( bool specular ) { SetFlag( specular, PTFLAG_SPECULAR ); }
				void				SetLinked( bool linked ) { SetFlag( linked, PTFLAG_LINKED ); }
				void				SetTiled( bool tiled ) { SetFlag( tiled, PTFLAG_TILED ); }
				void				SetPersist( bool tiled ) { SetFlag( tiled, PTFLAG_PERSIST ); }
				void				SetParentVelocity( bool pv ) { SetFlag( pv, PTFLAG_PARENTVEL ); }

				void				SetType( int type ) { mType = type; }
				int					GetType( void ) const { return( mType ); }

				const idMaterial	*GetMaterial( void ) const { return( mMaterial ); }
				void				SetMaterial( idMaterial *material ) { mMaterial = material; }

				idRenderModel		*GetModel( void ) const { return renderModelManager->FindModel( mModelName ); }
				idTraceModel		*GetTraceModel( void ) const;

				const char			*GetEntityDefName( void ) const { return( mEntityDefName ); }

				float				GetGravity( void ) const { return( rvRandom::flrand( mGravity[0], mGravity[1] ) ); }
				float				GetTiling( void ) const { return( mTiling ); }
				int					GetTrailType( void ) const { return( mTrailType ); }
				const idMaterial	*GetTrailMaterial( void ) const { return( mTrailMaterial ); }
				float				GetTrailTime( void ) const { return( rvRandom::flrand( mTrailTime[0], mTrailTime[1] ) ); }
				float				GetMaxTrailTime( void ) const { return( mTrailTime[1] ); }
				int					GetTrailCount( void ) const;
				int					GetMaxTrailCount( void ) const { return( ( int )ceilf( mTrailCount[1] ) + 1 ); }
				float				GetDuration( void ) const { return( rvRandom::flrand( mDuration[0], mDuration[1] ) ); }
				float				GetMaxDuration( void ) const { return( mDuration[1] ); }
				int					GetNumTimeoutEffects( void ) const { return( mNumTimeoutEffects ); }
				bool				HasTrail( void ) const { return( mTrailType != 0 && !mTrailTypeName.IsEmpty() ); }

				int					GetVertexCount( void ) const { return( mVertexCount ); }
				int					GetIndexCount( void ) const { return( mIndexCount ); }

				float				GetMaxParmValue( rvParticleParms &spawn, rvParticleParms &death, rvEnvParms &envelope );
	ID_INLINE	float				GetMaxSize( void ) { return GetMaxParmValue( mSpawnSize, mDeathSize, mSizeEnvelope ); }
	ID_INLINE	float				GetMaxOffset( void ) { return GetMaxParmValue( mSpawnOffset, mDeathOffset, mOffsetEnvelope ); }
	ID_INLINE	float				GetMaxLength( void ) { return GetMaxParmValue( mSpawnLength, mDeathLength, mLengthEnvelope ); }
				void				EvaluateSimplePosition( idVec3 &pos, float time, float lifeTime, idVec3 &initPos, idVec3 &velocity, idVec3 &acceleration, idVec3 &friction );
				float				GetFurthestDistance( void );
				float				CostTrail( float cost ) const;
				const idStr			&GetTrailTypeName( void ) const { return( mTrailTypeName ); }
				float				GetSpawnVolume( rvBSE *effect );
				bool				UsesEndOrigin( void );
				bool				GetVector( idLexer *src, int count, idVec3 &result );
				void				SetParameterCounts( void );
				bool				ParseMotionParms( idLexer *src, int count, rvEnvParms &parms );
				bool				ParseSpawnParms( rvDeclEffect *effect, idLexer *src, rvParticleParms &parms, int count );
				bool				ParseMotionDomains( rvDeclEffect *effect, idLexer *src );
				bool				CheckCommonParms( idLexer *src, rvParticleParms &parms );
				bool				ParseSpawnDomains( rvDeclEffect *effect, idLexer *src );
				bool				ParseDeathDomains( rvDeclEffect *effect, idLexer *src );
				bool				ParseImpact( rvDeclEffect *effect, idLexer *src );
				bool				ParseTimeout( rvDeclEffect *effect, idLexer *src );
				bool				ParseBlendParms( rvDeclEffect *effect, idLexer *src );
				bool				Parse( rvDeclEffect *effect, idLexer *src );
				void				Init( void );
				void				Finish( void );
				rvParticleTemplate &operator=( const rvParticleTemplate &copy );
private:
			bool					Compare( const rvParticleTemplate& a ) const;
			void					FixupParms( rvParticleParms &parms );

			int						mFlags;
			int						mType;									// Type of particle

			const idMaterial		*mMaterial;
			idStr					mMaterialName;
			idStr					mModelName;
			idStr					mEntityDefName;
			int						mTraceModelIndex;

			idVec2					mGravity;
			idVec2					mSoundVolume;
			idVec2					mFreqShift;
			float					mTiling;
			int						mTrailType;
			idStr					mTrailTypeName;
			const idMaterial		*mTrailMaterial;
			idStr					mTrailMaterialName;
			idVec2					mTrailTime;
			idVec2					mTrailCount;
			float					mBounce;
			idVec2					mDuration;
			idVec3					mCentre;								// Centre of bounds for normal generation
			int						mNumForks;
			idVec3					mForkSizeMins;
			idVec3					mForkSizeMaxs;
			idVec3					mJitterSize;
			float					mJitterRate;
			const idDeclTable		*mJitterTable;
			int						mNumSizeParms;
			int						mNumRotateParms;
			int						mVertexCount;
			int						mIndexCount;

			// Spawn info
			rvParticleParms			mSpawnPosition;
			rvParticleParms			mSpawnDirection;
			rvParticleParms			mSpawnVelocity;
			rvParticleParms			mSpawnAcceleration;
			rvParticleParms			mSpawnFriction;
			rvParticleParms			mSpawnTint;
			rvParticleParms			mSpawnFade;
			rvParticleParms			mSpawnSize;
			rvParticleParms			mSpawnRotate;
			rvParticleParms			mSpawnAngle;
			rvParticleParms			mSpawnOffset;
			rvParticleParms			mSpawnLength;

			// Motion info
			rvEnvParms				mTintEnvelope;
			rvEnvParms				mFadeEnvelope;
			rvEnvParms				mSizeEnvelope;
			rvEnvParms				mRotateEnvelope;
			rvEnvParms				mAngleEnvelope;
			rvEnvParms				mOffsetEnvelope;
			rvEnvParms				mLengthEnvelope;

			// Death (end condition) info
			rvParticleParms			mDeathTint;
			rvParticleParms			mDeathFade;
			rvParticleParms			mDeathSize;
			rvParticleParms			mDeathRotate;
			rvParticleParms			mDeathAngle;
			rvParticleParms			mDeathOffset;
			rvParticleParms			mDeathLength;

			// Misc info
			int						mNumImpactEffects;
			const rvDeclEffect		*mImpactEffects[BSE_NUM_SPAWNABLE];
			int						mNumTimeoutEffects;
			const rvDeclEffect		*mTimeoutEffects[BSE_NUM_SPAWNABLE];
};

#endif //_BSE_PARTICLE_H_INC_
