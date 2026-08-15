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

class rvMonsterTurretFlying : public idAI {
public:

	CLASS_PROTOTYPE( rvMonsterTurretFlying );

	rvMonsterTurretFlying ( void );

	void				InitSpawnArgsVariables( void );
	void				Spawn				( void );
	void				Save				( idSaveGame *savefile ) const;
	void				Restore				( idRestoreGame *savefile );

	virtual bool		Pain				( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location );

	virtual bool		CheckActions					( void );

protected:

	stateResult_t		State_Combat				( const stateParms_t& parms );
	stateResult_t		State_Fall					( const stateParms_t& parms );
	stateResult_t		State_Killed				( const stateParms_t& parms );

	stateResult_t		State_Torso_Idle			( const stateParms_t& parms );
	stateResult_t		State_Legs_Idle				( const stateParms_t& parms );

	stateResult_t		State_Torso_BlasterAttack	( const stateParms_t& parms );

	int					shieldHealth;
	int					maxShots;	
	int					minShots;
	int					shots;

private:

	rvAIAction			actionBlasterAttack;

	CLASS_STATES_PROTOTYPE ( rvMonsterTurretFlying );
};

CLASS_DECLARATION( idAI, rvMonsterTurretFlying )
END_CLASS

/*
================
rvMonsterTurretFlying::rvMonsterTurretFlying
================
*/
rvMonsterTurretFlying::rvMonsterTurretFlying ( ) {
	shieldHealth = spawnArgs.GetInt ( "shieldHealth" );
}

void rvMonsterTurretFlying::InitSpawnArgsVariables( void )
{
	maxShots	= spawnArgs.GetInt ( "maxShots", "1" );
	minShots	= spawnArgs.GetInt ( "minShots", "1" );
}
/*
================
rvMonsterTurretFlying::Spawn
================
*/
void rvMonsterTurretFlying::Spawn ( void ) {
	shieldHealth = spawnArgs.GetInt ( "shieldHealth" );

	InitSpawnArgsVariables();
	shots		= 0;
	
	actionBlasterAttack.Init ( spawnArgs,	"action_blasterAttack",	"Torso_BlasterAttack",	AIACTIONF_ATTACK );

	//don't take damage until we open up
	fl.takedamage = false;
}

/*
================
rvMonsterTurretFlying::CheckActions
================
*/
bool rvMonsterTurretFlying::CheckActions ( void ) {
	// Attacks
	if ( PerformAction ( &actionBlasterAttack, (checkAction_t)&idAI::CheckAction_RangedAttack, &actionTimerRangedAttack ) ) {
		return true;
	}
	return idAI::CheckActions ( );
}


/*
================
rvMonsterTurretFlying::Pain
================
*/
bool rvMonsterTurretFlying::Pain ( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location ) {
	// Handle the shield effects
	if ( shieldHealth > 0 ) {
		shieldHealth -= damage;
		if ( shieldHealth <= 0 ) {
			PlayEffect ( "fx_shieldBreak", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3() );
		} else {
			PlayEffect ( "fx_shieldHit", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3() );
		}
	}

	return idAI::Pain ( inflictor, attacker, damage, dir, location );
}

/*
================
rvMonsterTurretFlying::Save
================
*/
void rvMonsterTurretFlying::Save( idSaveGame *savefile ) const {
	savefile->WriteInt ( shieldHealth );
	savefile->WriteInt ( shots );
	actionBlasterAttack.Save ( savefile ) ;	
}

/*
================
rvMonsterTurretFlying::Restore
================
*/
void rvMonsterTurretFlying::Restore( idRestoreGame *savefile ) {
	savefile->ReadInt ( shieldHealth );
	savefile->ReadInt ( shots );
	actionBlasterAttack.Restore ( savefile ) ;	

	InitSpawnArgsVariables();
}

/*
===============================================================================

	States 

===============================================================================
*/

CLASS_STATES_DECLARATION ( rvMonsterTurretFlying )
	STATE ( "State_Combat",			rvMonsterTurretFlying::State_Combat )
	STATE ( "State_Fall",			rvMonsterTurretFlying::State_Fall )
	STATE ( "State_Killed",			rvMonsterTurretFlying::State_Killed )

	STATE ( "Torso_Idle",			rvMonsterTurretFlying::State_Torso_Idle )
	STATE ( "Legs_Idle",			rvMonsterTurretFlying::State_Legs_Idle )
	
	STATE ( "Torso_BlasterAttack",	rvMonsterTurretFlying::State_Torso_BlasterAttack )
END_CLASS_STATES

/*
================
rvMonsterTurretFlying::State_Combat
================
*/
stateResult_t rvMonsterTurretFlying::State_Combat ( const stateParms_t& parms ) {
	// Special handling for not being on the ground
	if ( !move.fl.onGround ) {
		PostState ( "State_Fall", 0 );
		return SRESULT_DONE;
	}
	
	// Keep the enemy status up to date
	if ( !enemy.ent || enemy.fl.dead ) {
		enemy.fl.dead = false;
		CheckForEnemy ( true );
	}
			
	// try moving, if there was no movement run then just try and action instead
	UpdateAction ( );
		
	return SRESULT_WAIT;
}

/*
================
rvMonsterTurretFlying::State_Fall
================
*/
stateResult_t rvMonsterTurretFlying::State_Fall ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,			// Initialize fall stage
		STAGE_WAITIMPACT,	// Wait for the drop turret to hit the ground
		STAGE_IMPACT,		// Handle drop turret impact
		STAGE_WAITOPEN,		// Wait for drop turret to open up
		STAGE_OPENED,		// Drop turret opened and ready for combat
	};
	switch ( parms.stage ) {
		case STAGE_INIT:
			StopMove ( MOVE_STATUS_DONE );
			StartSound ( "snd_falling", SND_CHANNEL_VOICE, 0, false, NULL );
			PlayEffect ( "fx_droptrail", animator.GetJointHandle ( "origin" ), true );
			PlayCycle ( ANIMCHANNEL_TORSO, "idle_closed", 0 );
			return SRESULT_STAGE(STAGE_WAITIMPACT);
			
		case STAGE_WAITIMPACT:
			if ( move.fl.onGround ) {
				return SRESULT_STAGE(STAGE_IMPACT);
			}
			return SRESULT_WAIT;
			
		case STAGE_IMPACT:
			StopSound ( SND_CHANNEL_VOICE, false );
			StopEffect ( "fx_droptrail" );
			PlayEffect ( "fx_landing", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3() );
			PlayAnim ( ANIMCHANNEL_TORSO, "open", 2 );
			return SRESULT_STAGE ( STAGE_WAITOPEN );
		
		case STAGE_WAITOPEN:
			if ( AnimDone ( ANIMCHANNEL_TORSO, 0 ) ) {
				return SRESULT_STAGE ( STAGE_OPENED );
			}
			return SRESULT_WAIT;
		
		case STAGE_OPENED:		 
			// Activate shield
			fl.takedamage = true;
			health += shieldHealth;
			PlayEffect ( "fx_shieldOpen", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3() );
			SetAnimState ( ANIMCHANNEL_TORSO, "Torso_Idle", 2 );
			PostState ( "State_Combat" );
			return SRESULT_DONE;
	}
	return SRESULT_ERROR;
}

/*
================
rvMonsterTurretFlying::State_Killed
================
*/
stateResult_t rvMonsterTurretFlying::State_Killed ( const stateParms_t& parms ) {
	gameLocal.PlayEffect ( spawnArgs, "fx_death", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3() );
	gameLocal.ProjectDecal( GetPhysics()->GetOrigin(), GetPhysics()->GetGravity(), 128.0f, true, 96.0f, "textures/decals/genericdamage" );
	return idAI::State_Killed ( parms );
}
	
/*
================
rvMonsterTurretFlying::State_Torso_Idle
================
*/
stateResult_t rvMonsterTurretFlying::State_Torso_Idle ( const stateParms_t& parms ) {
	if ( move.fl.onGround ) {
		IdleAnim ( ANIMCHANNEL_TORSO, "idle_open", parms.blendFrames );
	} else {
		IdleAnim ( ANIMCHANNEL_TORSO, "idle_closed", parms.blendFrames );
	}
	return SRESULT_DONE;
}

/*
================
rvMonsterTurretFlying::State_Legs_Idle
================
*/
stateResult_t rvMonsterTurretFlying::State_Legs_Idle ( const stateParms_t& parms ) {
	return SRESULT_DONE;
}

/*
================
rvMonsterTurretFlying::State_Torso_BlasterAttack
================
*/
stateResult_t rvMonsterTurretFlying::State_Torso_BlasterAttack ( const stateParms_t& parms ) {
	enum { 
		STAGE_INIT,
		STAGE_FIRE,
		STAGE_WAIT,
	};
	switch ( parms.stage ) {
		case STAGE_INIT:
			DisableAnimState ( ANIMCHANNEL_LEGS );
			shots = (minShots + gameLocal.random.RandomInt(maxShots-minShots+1)) * combat.aggressiveScale;
			return SRESULT_STAGE ( STAGE_FIRE );
			
		case STAGE_FIRE:
			PlayAnim ( ANIMCHANNEL_TORSO, (shots&1)?"range_attack_top":"range_attack_bottom", 2 );
			return SRESULT_STAGE ( STAGE_WAIT );

		case STAGE_WAIT:
			if ( AnimDone ( ANIMCHANNEL_TORSO, 2 ) ) {
				if ( --shots <= 0 ) {
					return SRESULT_DONE;
				}
				return SRESULT_STAGE ( STAGE_FIRE );
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR; 
}
