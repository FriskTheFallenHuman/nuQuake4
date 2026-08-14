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
#include "AI.h"

class rvMonsterFailedTransfer : public idAI {
public:

	CLASS_PROTOTYPE( rvMonsterFailedTransfer );

	rvMonsterFailedTransfer ( void );

	void				Spawn			( void );
	void				Killed			( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location );
	void				Save			( idSaveGame *savefile ) const;
	void				Restore			( idRestoreGame *savefile );

protected:

	bool				allowSplit;

	virtual void		OnDeath			( void );

private:

	CLASS_STATES_PROTOTYPE ( rvMonsterFailedTransfer );
};

CLASS_DECLARATION( idAI, rvMonsterFailedTransfer )
END_CLASS

/*
================
rvMonsterFailedTransfer::rvMonsterFailedTransfer
================
*/
rvMonsterFailedTransfer::rvMonsterFailedTransfer ( ) {
	allowSplit = false;
}

/*
================
rvMonsterFailedTransfer::Spawn
================
*/
void rvMonsterFailedTransfer::Spawn ( void ) {
	LoadAF ( "ragdoll_legs", true );
	LoadAF ( NULL, true );
}

/*
================
rvMonsterFailedTransfer::Save
================
*/
void rvMonsterFailedTransfer::Save( idSaveGame *savefile ) const {
	savefile->WriteBool ( allowSplit );
}

/*
================
rvMonsterFailedTransfer::Restore
================
*/
void rvMonsterFailedTransfer::Restore( idRestoreGame *savefile ) {
	savefile->ReadBool ( allowSplit );
}

/*
================
rvMonsterFailedTransfer::OnDeath
================
*/
void rvMonsterFailedTransfer::OnDeath ( void ) {
	idAI::OnDeath ( );
	
	if ( allowSplit ) {
		idEntity* torso;
		idDict	  args;

		LoadAF ( "ragdoll_legs", true );

		PlayEffect ( "fx_bloodyburst", animator.GetJointHandle ( "chest" ) );	
		SetSkin ( declManager->FindSkin	 ( spawnArgs.GetString ( "skin_legs" ) ) );

		args.Copy ( *gameLocal.FindEntityDefDict ( "monster_failed_transfer_torso" ) );
		args.SetVector ( "origin", GetPhysics()->GetOrigin() + GetPhysics()->GetGravityNormal() * -50.0f );
		args.SetInt ( "angle", move.current_yaw );
		gameLocal.SpawnEntityDef ( args, &torso );
		torso->fl.takedamage = false;
		PostEventMS( &AI_TakeDamage, 100, 1.0f );
	}
}

/*
================
rvMonsterFailedTransfer::Killed
================
*/
void rvMonsterFailedTransfer::Killed( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location ) {
	if ( !idStr::Icmp ( GetDamageGroup( location ), "legs" ) && damage < 999 ) {
		allowSplit = true;
	} else {
		allowSplit = false;
	}

	idAI::Killed ( inflictor, attacker, damage, dir, location );
}

/*
===============================================================================

	States 

===============================================================================
*/

CLASS_STATES_DECLARATION ( rvMonsterFailedTransfer )
END_CLASS_STATES

