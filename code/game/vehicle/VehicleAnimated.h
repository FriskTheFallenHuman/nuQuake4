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
// VehicleAnimated.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLEANIMATED_H__
#define __GAME_VEHICLEANIMATED_H__

#include "Vehicle.h"
#include "../physics/Physics_Monster.h"

class rvVehicleAnimated : public rvVehicle {
public:

	CLASS_PROTOTYPE( rvVehicleAnimated );

							rvVehicleAnimated			( void );
							~rvVehicleAnimated			( void );

	void					Spawn						( void );
	void					Think						( void );	
	void					Save						( idSaveGame *savefile ) const;
	void					Restore						( idRestoreGame *savefile );

	virtual const idMat3&	GetAxis						( int id = 0 ) const;

	void					ClientPredictionThink		( void );
	void					WriteToSnapshot				( idBitMsgDelta &msg ) const;
	void					ReadFromSnapshot			( const idBitMsgDelta &msg );

	virtual bool			GetPhysicsToVisualTransform ( idVec3 &origin, idMat3 &axis );

protected:

	// twhitaker:
	virtual void			RunPrePhysics			( void );
	virtual void			RunPostPhysics			( void );
	idVec3					storedPosition;
	// end twhitaker:

	idPhysics_Monster		physicsObj;

	idAngles				viewAngles;	
	float					turnRate;
	idVec3					additionalDelta;
};

#endif // __GAME_VEHICLEANIMATED_H__
