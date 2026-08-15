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

#ifndef __PHYSICS_VEHICLE_MONSTER_H__
#define __PHYSICS_VEHICLE_MONSTER_H__

/*
===================================================================================

	Vehicle Monster Physics

	Employs an impulse based dynamic simulation which is not very accurate but
	relatively fast and still reliable due to the continuous collision detection.
	Extents particle physics with the ability to apply impulses.

===================================================================================
*/

class rvPhysics_VehicleMonster : public idPhysics_RigidBody {
public:
	CLASS_PROTOTYPE( rvPhysics_VehicleMonster );

	bool					Evaluate						( int timeStepMSec, int endTimeMSec );
	void					SetGravity						( const idVec3 & v );
};

#endif /* !__PHYSICS_VEHICLE_MONSTER_H__ */
