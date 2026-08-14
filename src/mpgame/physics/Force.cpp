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

CLASS_DECLARATION( idClass, idForce )
END_CLASS

idList<idForce*> idForce::forceList;

/*
================
idForce::idForce
================
*/
idForce::idForce( void ) {
	forceList.Append( this );
}

/*
================
idForce::~idForce
================
*/
idForce::~idForce( void ) {
	forceList.Remove( this );
}

/*
================
idForce::DeletePhysics
================
*/
void idForce::DeletePhysics( const idPhysics *phys ) {
	int i;

	for ( i = 0; i < forceList.Num(); i++ ) {
		forceList[i]->RemovePhysics( phys );
	}
}

/*
================
idForce::ClearForceList
================
*/
void idForce::ClearForceList( void ) {
	forceList.Clear();
}

/*
================
idForce::Evaluate
================
*/
void idForce::Evaluate( int time ) {
}

/*
================
idForce::RemovePhysics
================
*/
void idForce::RemovePhysics( const idPhysics *phys ) {
}
