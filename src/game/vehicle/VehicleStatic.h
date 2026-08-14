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
// VehicleStatic.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLESTATIC_H__
#define __GAME_VEHICLESTATIC_H__

#ifndef __GAME_VEHICLE_H__
#include "Vehicle.h"
#endif

class rvVehicleStatic : public rvVehicle
{
public:

	CLASS_PROTOTYPE( rvVehicleStatic );

							rvVehicleStatic		( void );
							~rvVehicleStatic	( void );

	void					Spawn				( void );

	virtual int				AddDriver			( int position, idActor* driver );
	virtual bool			RemoveDriver		( int position, bool force = false );

	virtual void			UpdateHUD			( idActor* driver, idUserInterface* gui );

	void					Event_ScriptedAnim	( const char* animname, int blendFrames, bool loop, bool endWithIdle );
	void 					Event_ScriptedDone	( void );
	void					Event_ScriptedStop	( void );
};

#endif // __GAME_VEHICLESTATIC_H__
