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

//----------------------------------------------------------------
// VehicleSplineCoupling.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "VehicleSpline.h"

CLASS_DECLARATION( rvVehicle, rvVehicleSpline )
	EVENT( EV_PostSpawn,	rvVehicleSpline::Event_PostSpawn )
	EVENT( EV_SetSpline,	rvVehicleSpline::Event_SetSpline )
	EVENT( EV_DoneMoving,	rvVehicleSpline::Event_DoneMoving )
END_CLASS

rvVehicleSpline::rvVehicleSpline ( void ) {
}

rvVehicleSpline::~rvVehicleSpline ( void ) {
	SetPhysics( NULL );
}

void rvVehicleSpline::Spawn ( void ) {

	physicsObj.SetSelf( this );
	physicsObj.SetClipModel( new idClipModel(GetPhysics()->GetClipModel()), 1.0f );
	physicsObj.SetContents( CONTENTS_SOLID );
	physicsObj.SetClipMask( 0 );
	physicsObj.SetLinearVelocity( GetPhysics()->GetLinearVelocity() );
	physicsObj.SetLinearAcceleration( spawnArgs.GetFloat( "accel", "200" ) );
	physicsObj.SetLinearDeceleration( spawnArgs.GetFloat( "decel", "200" ) );

	viewAxis		= idAngles( 0, spawnArgs.GetFloat( "angle" ) , 0 ).ToMat3();

	physicsObj.SetAxis( GetPhysics()->GetAxis() * viewAxis );
	physicsObj.SetOrigin( GetPhysics()->GetOrigin() );

	SetPhysics( &physicsObj );

	BecomeActive( TH_THINK );

	accelWithStrafe	= Sign( spawnArgs.GetFloat("accel_strafe") );

	idealSpeed		= spawnArgs.GetFloat( "speed", "200" );

	PostEventMS( &EV_PostSpawn, 0 );
}

/*
================
rvVehicleSpline::Save
================
*/
void rvVehicleSpline::Save ( idSaveGame *savefile ) const {
	savefile->WriteStaticObject( physicsObj );
	savefile->WriteMat3( angleOffset );
	savefile->WriteFloat( idealSpeed );
	savefile->WriteFloat( accelWithStrafe );
}

/*
================
rvVehicleSpline::Restore
================
*/
void rvVehicleSpline::Restore ( idRestoreGame *savefile ) {
	physicsObj.SetSelf( this );
	physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), 1.0f );
	savefile->ReadStaticObject ( physicsObj );
	RestorePhysics ( &physicsObj );
	physicsObj.EnableClip();

	savefile->ReadMat3( angleOffset );
	savefile->ReadFloat( idealSpeed );
	savefile->ReadFloat( accelWithStrafe );
}

void rvVehicleSpline::Think( void ) {
	float moveAmount = 0.0f;

	if ( positions[0].IsOccupied ( ) && !IsFrozen () && IsMovementEnabled ( ) )	{	

		if ( accelWithStrafe != 0.0f ) {
			moveAmount = positions[0].mInputCmd.rightmove * accelWithStrafe;
		} else {
			moveAmount = positions[0].mInputCmd.forwardmove;
		}
		
		moveAmount = Sign( moveAmount );
	}

	physicsObj.SetSpeed( idealSpeed * moveAmount );

	rvVehicle::Think( );
}

void rvVehicleSpline::Event_PostSpawn( void ) {
	idStr splinePath;

	if ( spawnArgs.GetString( "spline_path", "", splinePath ) ) {
		Event_SetSpline( gameLocal.FindEntity( splinePath.c_str() ) );
	} else {
		gameLocal.Warning( "\"spline_path\" key not found on %s (rvVehicleSpline)", this->GetName() );
	}
}

void rvVehicleSpline::Event_SetSpline ( idEntity * spline ) {
	if ( spline && spline->IsType( idSplinePath::GetClassType() ) ) {
		physicsObj.SetSplineEntity( static_cast< idSplinePath * >( spline ) );
		//HACK: force an intitial physics update so that the object orients itself with the spline
		//TEMP: this should be fixed after the build on friday (Jan 28, 2005)
		physicsObj.SetSpeed( 0.1f );
		RunPhysics();
		//END HACK
	}
}

void rvVehicleSpline::Event_DoneMoving() {
	idThread::ReturnInt( true );
}
