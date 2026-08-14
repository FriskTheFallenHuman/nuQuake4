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
// rvVehicleAI.cpp
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include <cfloat>

#include "../Game_local.h"

#ifndef __GAME_VEHICLEAI_H__
#include "VehicleAI.h"
#endif

CLASS_DECLARATION( idAI, rvVehicleAI )
	EVENT( VD_ChoosePathTarget, rvVehicleAI::Event_ChoosePathTarget )
END_CLASS

/*
================
rvVehicleAI::rvVehicleAI
================
*/
rvVehicleAI::rvVehicleAI ( void ) {
	flags = 0;
}

/*
================
rvVehicleAI::~rvVehicleAI
================
*/
rvVehicleAI::~rvVehicleAI ( void ) {
}

/*
================
rvVehicleAI::Spawn
================
*/
void rvVehicleAI::Spawn ( void ) {
	driver = static_cast<rvVehicleDriver *>( gameLocal.SpawnEntityType( rvVehicleDriver::GetClassType() ) );
}

/*
================
rvVehicleAI::Save
================
*/
void rvVehicleAI::Save ( idSaveGame *savefile ) const {
	driver.Save ( savefile );
	savefile->WriteInt ( flags );
}

/*
================
rvVehicleAI::Restore
================
*/
void rvVehicleAI::Restore ( idRestoreGame *savefile ) {
	driver.Restore ( savefile );
	savefile->ReadInt ( flags );
}

/*
================
rvVehicleAI::SetVehicle
================
*/
void rvVehicleAI::SetVehicle ( rvVehicleMonster * vehicle ) {
	const idKeyValue * val = spawnArgs.MatchPrefix( "target", 0 );

	if ( !driver ) {
		return;
	}

	driver->ProcessEvent ( &AI_EnterVehicle, vehicle );
	driver->SetPathingMode( rvVehicleDriver::VDPM_Custom, this );
	vehicle->ProcessEvent ( &EV_Door_Lock, true );
	vehicle->team = team;
	driver->team = team;

	if ( val ) {
		driver->ProcessEvent ( &AI_ScriptedMove, gameLocal.FindEntity( val->GetValue() ), 0.0f, 0 );
	} else {
		driver->ProcessEvent ( &AI_ScriptedMove, FindClosestNode(), 0.0f, 0 );
	}
}

/*
================
rvVehicleAI::Event_ChoosePathTarget
================
*/
void rvVehicleAI::Event_ChoosePathTarget ( idEntity * current ) {
	if ( !current ) {
		current = const_cast<idEntity*>( FindClosestNode() );
	}

	if ( ( flags & VAIF_Freeze ) == 0 ) {
		const idVec3 & playerOrigin = gameLocal.GetLocalPlayer()->GetPhysics()->GetOrigin();
		switch ( flags & 0x03 ) {
		case 1 :
			idThread::ReturnEntity(	MoveCloserTo( playerOrigin, current ) );
			break;

		case 2 :
			idThread::ReturnEntity(	MoveAwayFrom( playerOrigin, current ) );
			break;

		default:
			idThread::ReturnEntity(	NULL );
		}
	}

	//PostEventMS( &VD_ChoosePathTarget, gameLocal.random.RandomInt( 100 ) + 100, driver->lastPathTargetInfo.node.GetEntity() );
}

/*
================
rvVehicleAI::OnWakeUp
================
*/
void rvVehicleAI::OnWakeUp ( void ) {
	SetMoveType ( MOVETYPE_CUSTOM );
}

/*
================
rvVehicleAI::CustomMove
================
*/
void rvVehicleAI::CustomMove ( void ) {	
	if ( !driver->pathTargetInfo.node && !(flags & VAIF_Freeze) ) {
		driver->ProcessEvent( &AI_ScriptedMove, FindClosestNode(), 0.0f, 0 );
	}
}

/*
================
rvVehicleAI::MoveCloserTo
================
*/
const idEntity * rvVehicleAI::MoveCloserTo ( const idVec3 & point, idEntity * current ) {
	const idEntity * best	= NULL;

	if ( current && current->targets.Num() ) {
		const idEntity & target	= *current;
		float shortestDistance	= FLT_MAX;

		for ( int i = target.targets.Num() - 1; i; i -- ) {
			float distance = ( target.targets[ i ]->GetPhysics()->GetOrigin() - point ).LengthSqr();

			if ( shortestDistance > distance ) {
				shortestDistance = distance;
				best = target.targets[ i ];
			}
		}
	}

	return best;
}

/*
================
rvVehicleAI::MoveAwayFrom
================
*/
const idEntity * rvVehicleAI::MoveAwayFrom ( const idVec3 & point, idEntity * current ) {
	const idEntity * best	= NULL;

	if ( current && current->targets.Num() ) {
		const idEntity & target	= *current;
		float longestDistance	= FLT_MIN;

		for ( int i = target.targets.Num() - 1; i; i -- ) {
			float distance = ( target.targets[ i ]->GetPhysics()->GetOrigin() - point ).LengthSqr();

			if ( longestDistance < distance ) {
				longestDistance = distance;
				best = target.targets[ i ];
			}
		}
	}

	return best;
}

/*
================
rvVehicleAI::FindClosestNode
================
*/
const idEntity * rvVehicleAI::FindClosestNode ( void ) const {
	idEntity * current = 0;
	const idEntity * best = 0;
	float bestDistance = FLT_MAX;

	for (;;) {
		current = gameLocal.FindEntityUsingDef( current, "target_vehicle_path" );

		if ( !current ) {
			break;
		}

		float dist = ( current->GetPhysics()->GetOrigin() - GetPhysics()->GetOrigin() ).LengthSqr();

		if ( dist < bestDistance ) {
			bestDistance = dist;
			best = current;
		}
	}

	return best;
}

/*
================
rvVehicleAI::Think
================
*/
void rvVehicleAI::Think ( void ) {
	idAI::Think();

	// Keep the enemy status up to date
	if ( !enemy.ent || enemy.fl.dead ) {
		enemy.fl.dead = false;
		CheckForEnemy ( true );
	}

	//HACK: always choose player as the enemy... something is broken somewhere, 
	// and this is a quick way to get some gameplay out of this for now.  Deadlines pwn.
	if ( driver && driver->IsDriving() ) {
		enemy.ent	= gameLocal.GetLocalPlayer();
		enemy.range	= ( enemy.ent->GetPhysics()->GetOrigin() - driver->vehicleController.GetVehicle()->GetPhysics()->GetOrigin() ).Length();
	}
}


