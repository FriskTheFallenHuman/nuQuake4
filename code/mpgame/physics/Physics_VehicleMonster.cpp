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

CLASS_DECLARATION( idPhysics_RigidBody, rvPhysics_VehicleMonster )
END_CLASS

/*
================
rvPhysics_VehicleMonster::Evaluate

  Evaluate the impulse based rigid body physics.
  When a collision occurs an impulse is applied at the moment of impact but
  the remaining time after the collision is ignored.
================
*/
bool rvPhysics_VehicleMonster::Evaluate( int timeStepMSec, int endTimeMSec ) {
	if ( idPhysics_RigidBody::Evaluate( timeStepMSec, endTimeMSec ) ) {

		idAngles euler			= current.i.orientation.ToAngles();
		euler.pitch				= 0.0f;
		euler.roll				= 0.0f;
		current.i.orientation	= euler.ToMat3();

		return true;
	}

	return false;
}

void rvPhysics_VehicleMonster::SetGravity ( const idVec3 & v ) {
	gravityVector = v; 
	gravityNormal = gameLocal.GetGravity( );
	gravityNormal.Normalize();
}
