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
#include "../Weapon.h"

const int SHOTGUN_MOD_AMMO = BIT(0);

class rvWeaponShotgun : public rvWeapon {
public:

	CLASS_PROTOTYPE( rvWeaponShotgun );

	rvWeaponShotgun ( void );

	virtual void			Spawn				( void );
	void					Save				( idSaveGame *savefile ) const;
	void					Restore				( idRestoreGame *savefile );
	void					PreSave				( void );
	void					PostSave			( void );

protected:
	int						hitscans;

private:

	stateResult_t		State_Idle		( const stateParms_t& parms );
	stateResult_t		State_Fire		( const stateParms_t& parms );
	stateResult_t		State_Reload	( const stateParms_t& parms );
	
	CLASS_STATES_PROTOTYPE( rvWeaponShotgun );
};

CLASS_DECLARATION( rvWeapon, rvWeaponShotgun )
END_CLASS

/*
================
rvWeaponShotgun::rvWeaponShotgun
================
*/
rvWeaponShotgun::rvWeaponShotgun( void ) {
}

/*
================
rvWeaponShotgun::Spawn
================
*/
void rvWeaponShotgun::Spawn( void ) {
	hitscans   = spawnArgs.GetFloat( "hitscans" );
	
	SetState( "Raise", 0 );	
}

/*
================
rvWeaponShotgun::Save
================
*/
void rvWeaponShotgun::Save( idSaveGame *savefile ) const {
}

/*
================
rvWeaponShotgun::Restore
================
*/
void rvWeaponShotgun::Restore( idRestoreGame *savefile ) {
	hitscans   = spawnArgs.GetFloat( "hitscans" );
}

/*
================
rvWeaponShotgun::PreSave
================
*/
void rvWeaponShotgun::PreSave ( void ) {
}

/*
================
rvWeaponShotgun::PostSave
================
*/
void rvWeaponShotgun::PostSave ( void ) {
}


/*
===============================================================================

	States 

===============================================================================
*/

CLASS_STATES_DECLARATION( rvWeaponShotgun )
	STATE( "Idle",				rvWeaponShotgun::State_Idle)
	STATE( "Fire",				rvWeaponShotgun::State_Fire )
	STATE( "Reload",			rvWeaponShotgun::State_Reload )
END_CLASS_STATES

/*
================
rvWeaponShotgun::State_Idle
================
*/
stateResult_t rvWeaponShotgun::State_Idle( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( !AmmoAvailable( ) ) {
				SetStatus( WP_OUTOFAMMO );
			} else {
				SetStatus( WP_READY );
			}
		
			PlayCycle( ANIMCHANNEL_ALL, "idle", parms.blendFrames );
			return SRESULT_STAGE ( STAGE_WAIT );
		
		case STAGE_WAIT:			
			if ( wsfl.lowerWeapon ) {
				SetState( "Lower", 4 );
				return SRESULT_DONE;
			}		
			if ( !clipSize ) {
				if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoAvailable ( ) ) {
					SetState( "Fire", 0 );
					return SRESULT_DONE;
				}  
			} else {				
				if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoInClip ( ) ) {
					SetState( "Fire", 0 );
					return SRESULT_DONE;
				}  
				if ( wsfl.attack && AutoReload() && !AmmoInClip ( ) && AmmoAvailable () ) {
					SetState( "Reload", 4 );
					return SRESULT_DONE;			
				}
				if ( wsfl.netReload || (wsfl.reload && AmmoInClip() < ClipSize() && AmmoAvailable()>AmmoInClip()) ) {
					SetState( "Reload", 4 );
					return SRESULT_DONE;			
				}				
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
rvWeaponShotgun::State_Fire
================
*/
stateResult_t rvWeaponShotgun::State_Fire( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			nextAttackTime = gameLocal.time + (fireRate * owner->PowerUpModifier ( PMOD_FIRERATE ));
			Attack( false, hitscans, spread, 0, 1.0f );
			PlayAnim( ANIMCHANNEL_ALL, "fire", 0 );	
			return SRESULT_STAGE( STAGE_WAIT );
	
		case STAGE_WAIT:
			if ( (!gameLocal.isMultiplayer && (wsfl.lowerWeapon || AnimDone( ANIMCHANNEL_ALL, 0 )) ) || AnimDone( ANIMCHANNEL_ALL, 0 ) ) {
				SetState( "Idle", 0 );
				return SRESULT_DONE;
			}									
			if ( wsfl.attack && gameLocal.time >= nextAttackTime && AmmoInClip() ) {
				SetState( "Fire", 0 );
				return SRESULT_DONE;
			}
			if ( clipSize ) {
				if ( (wsfl.netReload || (wsfl.reload && AmmoInClip() < ClipSize() && AmmoAvailable()>AmmoInClip())) ) {
					SetState( "Reload", 4 );
					return SRESULT_DONE;			
				}				
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
rvWeaponShotgun::State_Reload
================
*/
stateResult_t rvWeaponShotgun::State_Reload ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
		STAGE_RELOADSTARTWAIT,
		STAGE_RELOADLOOP,
		STAGE_RELOADLOOPWAIT,
		STAGE_RELOADDONE,
		STAGE_RELOADDONEWAIT
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( wsfl.netReload ) {
				wsfl.netReload = false;
			} else {
				NetReload ( );
			}
			
			SetStatus ( WP_RELOAD );
			
			if ( mods & SHOTGUN_MOD_AMMO ) {				
				PlayAnim ( ANIMCHANNEL_ALL, "reload_clip", parms.blendFrames );
			} else {
				PlayAnim ( ANIMCHANNEL_ALL, "reload_start", parms.blendFrames );
				return SRESULT_STAGE ( STAGE_RELOADSTARTWAIT );
			}
			return SRESULT_STAGE ( STAGE_WAIT );
			
		case STAGE_WAIT:
			if ( AnimDone ( ANIMCHANNEL_ALL, 4 ) ) {
				AddToClip ( ClipSize() );
				SetState ( "Idle", 4 );
				return SRESULT_DONE;
			}
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
			return SRESULT_WAIT;
			
		case STAGE_RELOADSTARTWAIT:
			if ( AnimDone ( ANIMCHANNEL_ALL, 0 ) ) {
				return SRESULT_STAGE ( STAGE_RELOADLOOP );
			}
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
			return SRESULT_WAIT;
			
		case STAGE_RELOADLOOP:		
			if ( (wsfl.attack && AmmoInClip() ) || AmmoAvailable ( ) <= AmmoInClip ( ) || AmmoInClip() == ClipSize() ) {
				return SRESULT_STAGE ( STAGE_RELOADDONE );
			}
			PlayAnim ( ANIMCHANNEL_ALL, "reload_loop", 0 );
			return SRESULT_STAGE ( STAGE_RELOADLOOPWAIT );
			
		case STAGE_RELOADLOOPWAIT:
			if ( (wsfl.attack && AmmoInClip() ) || wsfl.netEndReload ) {
				return SRESULT_STAGE ( STAGE_RELOADDONE );
			}
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
			if ( AnimDone ( ANIMCHANNEL_ALL, 0 ) ) {
				AddToClip( 1 );
				return SRESULT_STAGE ( STAGE_RELOADLOOP );
			}
			return SRESULT_WAIT;
		
		case STAGE_RELOADDONE:
			NetEndReload ( );
			PlayAnim ( ANIMCHANNEL_ALL, "reload_end", 0 );
			return SRESULT_STAGE ( STAGE_RELOADDONEWAIT );

		case STAGE_RELOADDONEWAIT:
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
			if ( wsfl.attack && AmmoInClip ( ) && gameLocal.time > nextAttackTime ) {
				SetState ( "Fire", 0 );
				return SRESULT_DONE;
			}
			if ( AnimDone ( ANIMCHANNEL_ALL, 4 ) ) {
				SetState ( "Idle", 4 );
				return SRESULT_DONE;
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;	
}
			
