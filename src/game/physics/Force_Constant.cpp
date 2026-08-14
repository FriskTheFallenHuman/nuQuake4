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

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

CLASS_DECLARATION( idForce, idForce_Constant )
END_CLASS

/*
================
idForce_Constant::idForce_Constant
================
*/
idForce_Constant::idForce_Constant( void ) {
	force		= vec3_zero;
	physics		= NULL;
	id			= 0;
	point		= vec3_zero;
}

/*
================
idForce_Constant::~idForce_Constant
================
*/
idForce_Constant::~idForce_Constant( void ) {
}

/*
================
idForce_Constant::Save
================
*/
void idForce_Constant::Save( idSaveGame *savefile ) const {
	savefile->WriteVec3( force );
	// TOSAVE: idPhysics *		physics	
	savefile->WriteInt( id );
	savefile->WriteVec3( point );
}

/*
================
idForce_Constant::Restore
================
*/
void idForce_Constant::Restore( idRestoreGame *savefile ) {
	// Owner needs to call SetPhysics!!
	savefile->ReadVec3( force );
	savefile->ReadInt( id );
	savefile->ReadVec3( point );
}

/*
================
idForce_Constant::SetPosition
================
*/
void idForce_Constant::SetPosition( idPhysics *physics, int id, const idVec3 &point ) {
	this->physics = physics;
	this->id = id;
	this->point = point;
}

/*
================
idForce_Constant::SetForce
================
*/
void idForce_Constant::SetForce( const idVec3 &force ) {
	this->force = force;
}

/*
================
idForce_Constant::SetPhysics
================
*/
void idForce_Constant::SetPhysics( idPhysics *physics ) {
	this->physics = physics;
}

/*
================
idForce_Constant::Evaluate
================
*/
void idForce_Constant::Evaluate( int time ) {
	idVec3 p;

	if ( !physics ) {
		return;
	}

	p = physics->GetOrigin( id ) + point * physics->GetAxis( id );

	physics->AddForce( id, p, force );
}

/*
================
idForce_Constant::RemovePhysics
================
*/
void idForce_Constant::RemovePhysics( const idPhysics *phys ) {
	if ( physics == phys ) {
		physics = NULL;
	}
}
