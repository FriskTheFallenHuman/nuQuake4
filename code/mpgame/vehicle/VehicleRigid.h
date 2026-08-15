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
// VehicleRigid.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLERIGID_H__
#define __GAME_VEHICLERIGID_H__

#ifndef __GAME_VEHICLE_H__
#include "Vehicle.h"
#endif

class rvVehicleRigid : public rvVehicle
{
public:

	CLASS_PROTOTYPE( rvVehicleRigid );

							rvVehicleRigid		( void );
							~rvVehicleRigid		( void );

	void					Spawn				( void );
	void					Save				( idSaveGame *savefile ) const;
	void					Restore				( idRestoreGame *savefile );

	void					WriteToSnapshot		( idBitMsgDelta &msg ) const;
	void					ReadFromSnapshot	( const idBitMsgDelta &msg );

	bool					SkipImpulse			( idEntity* ent, int id );

protected:
	
	void					SetClipModel	( void );
	
	// twhitaker:
	virtual void			RunPrePhysics			( void );
	virtual void			RunPostPhysics			( void );
	idVec3					storedVelocity;
	// end twhitaker:

	idPhysics_RigidBody		physicsObj;				// physics object
};

#endif // __GAME_VEHICLERIGID_H__
