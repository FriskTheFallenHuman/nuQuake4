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
// rvVehicleAI.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLEAI_H__
#define __GAME_VEHICLEAI_H__

#ifndef __AI_H__
#include "AI.h"
#endif
#ifndef __GAME_VEHICLEMONSTER_H__
#include "../vehicle/VehicleMonster.h"
#endif

enum VehicleAI_Flags {
	VAIF_Chase		= 1,
	VAIF_Avoid		= 2,
	VAIF_Freeze		= 4,
};

class rvVehicleAI : public idAI {
	friend class rvVehicleMonster;

public:
	CLASS_PROTOTYPE( rvVehicleAI );

							rvVehicleAI				( void );
							~rvVehicleAI			( void );

	void					Spawn					( void );
	void					Think					( void );
	void					Save					( idSaveGame *savefile ) const;
	void					Restore					( idRestoreGame *savefile );

	void					SetVehicle				( rvVehicleMonster * vehicle );

	void					Random					( void );
	void					StraightToEnemy			( void );
	void					ChaseEnemy				( void );
	void					AvoidEnemy				( void );
	void					Stop					( void );
	void					Start					( void );

	int &					GetFlags				( void ) { return flags; }

	bool					IsDriving				( void ) { return driver && driver->IsDriving(); }
	rvVehicleDriver*		GetDriver				( void ) { return driver.GetEntity(); }
	const rvVehicleDriver*	GetDriver				( void ) const { return driver.GetEntity(); }

private:
	virtual void			OnWakeUp				( void );
	virtual void			CustomMove				( void );

	const idEntity *		MoveCloserTo			( const idVec3 & point, idEntity * current );
	const idEntity *		MoveAwayFrom			( const idVec3 & point, idEntity * current );
	const idEntity *		FindClosestNode			( void ) const;

	void					Event_ChoosePathTarget	( idEntity * current );

	idEntityPtr<rvVehicleDriver>	driver;
	int								flags;
};

ID_INLINE void rvVehicleAI::Random ( void ) {
	flags = 0;
	CustomMove();
}

ID_INLINE void rvVehicleAI::StraightToEnemy ( void ) {
	driver->ProcessEvent( &AI_ScriptedMove, enemy.ent.GetEntity(), 0.0f, 0 );
}

ID_INLINE void rvVehicleAI::ChaseEnemy ( void ) {
	flags = VAIF_Chase;
	CustomMove();
}

ID_INLINE void rvVehicleAI::AvoidEnemy ( void ) {
	flags = VAIF_Avoid;
	CustomMove();
}

ID_INLINE void rvVehicleAI::Stop ( void ) {
	flags = ( flags & 0x03 ) | VAIF_Freeze;
	driver->ProcessEvent( &AI_ScriptedStop );
}

ID_INLINE void rvVehicleAI::Start ( void ) {
	flags = ( flags & 0x03 ) & ~VAIF_Freeze;
	//driver->ProcessEvent( &EV_Activate, this );
	CustomMove();
}

#endif // __GAME_VEHICLEAI_H__
