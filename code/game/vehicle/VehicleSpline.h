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
// VehicleSpline.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLESPLINECOUPLING_H__
#define __GAME_VEHICLESPLINECOUPLING_H__

class rvVehicleSpline : public rvVehicle {
public:
	CLASS_PROTOTYPE( rvVehicleSpline );

							rvVehicleSpline					( void );
							~rvVehicleSpline				( void );
	
	void					Spawn							( void );
	void					Save							( idSaveGame *savefile ) const;
	void					Restore							( idRestoreGame *savefile );

	void					Think							( void );

	void					Event_PostSpawn					( void );
	void					Event_SetSpline					( idEntity * spline );
	void					Event_DoneMoving				( void );

protected:
	rvPhysics_Spline		physicsObj;
	idMat3					angleOffset;
	float					idealSpeed;
	float					accelWithStrafe;
};

#endif // __GAME_VEHICLESPLINECOUPLING_H__
