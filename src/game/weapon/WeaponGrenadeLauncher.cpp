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

class rvWeaponGrenadeLauncher : public rvWeapon {
public:

	CLASS_PROTOTYPE( rvWeaponGrenadeLauncher );

	rvWeaponGrenadeLauncher ( void );

	virtual void			Spawn				( void );
	void					PreSave				( void );
	void					PostSave			( void );

#ifdef _XENON
	virtual bool		AllowAutoAim			( void ) const { return false; }
#endif

private:

	stateResult_t		State_Idle		( const stateParms_t& parms );
	stateResult_t		State_Fire		( const stateParms_t& parms );
	stateResult_t		State_Reload	( const stateParms_t& parms );

	const char*			GetFireAnim() const { return (!AmmoInClip()) ? "fire_empty" : "fire"; }
	const char*			GetIdleAnim() const { return (!AmmoInClip()) ? "idle_empty" : "idle"; }
	
	CLASS_STATES_PROTOTYPE ( rvWeaponGrenadeLauncher );
};

CLASS_DECLARATION( rvWeapon, rvWeaponGrenadeLauncher )
END_CLASS

/*
================
rvWeaponGrenadeLauncher::rvWeaponGrenadeLauncher
================
*/
rvWeaponGrenadeLauncher::rvWeaponGrenadeLauncher ( void ) {
}

/*
================
rvWeaponGrenadeLauncher::Spawn
================
*/
void rvWeaponGrenadeLauncher::Spawn ( void ) {
	SetState ( "Raise", 0 );	
}

/*
================
rvWeaponGrenadeLauncher::PreSave
================
*/
void rvWeaponGrenadeLauncher::PreSave ( void ) {
}

/*
================
rvWeaponGrenadeLauncher::PostSave
================
*/
void rvWeaponGrenadeLauncher::PostSave ( void ) {
}

/*
===============================================================================

	States 

===============================================================================
*/

CLASS_STATES_DECLARATION ( rvWeaponGrenadeLauncher )
	STATE ( "Idle",		rvWeaponGrenadeLauncher::State_Idle)
	STATE ( "Fire",		rvWeaponGrenadeLauncher::State_Fire )
	STATE ( "Reload",	rvWeaponGrenadeLauncher::State_Reload )
END_CLASS_STATES

/*
================
rvWeaponGrenadeLauncher::State_Idle
================
*/
stateResult_t rvWeaponGrenadeLauncher::State_Idle( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( !AmmoAvailable ( ) ) {
				SetStatus ( WP_OUTOFAMMO );
			} else {
				SetStatus ( WP_READY );
			}
		
			PlayCycle( ANIMCHANNEL_ALL, GetIdleAnim(), parms.blendFrames );
			return SRESULT_STAGE ( STAGE_WAIT );
		
		case STAGE_WAIT:			
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}		
			if ( !clipSize ) {
				if ( wsfl.attack && AmmoAvailable ( ) ) {
					SetState ( "Fire", 0 );
					return SRESULT_DONE;
				}
			} else { 
				if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoInClip ( ) ) {
					SetState ( "Fire", 0 );
					return SRESULT_DONE;
				}  
						
				if ( wsfl.attack && AutoReload() && !AmmoInClip ( ) && AmmoAvailable () ) {
					SetState ( "Reload", 4 );
					return SRESULT_DONE;			
				}
				if ( wsfl.netReload || (wsfl.reload && AmmoInClip() < ClipSize() && AmmoAvailable()>AmmoInClip()) ) {
					SetState ( "Reload", 4 );
					return SRESULT_DONE;			
				}
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
rvWeaponGrenadeLauncher::State_Fire
================
*/
stateResult_t rvWeaponGrenadeLauncher::State_Fire ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			nextAttackTime = gameLocal.time + (fireRate * owner->PowerUpModifier ( PMOD_FIRERATE ));
			Attack ( false, 1, spread, 0, 1.0f );
			PlayAnim ( ANIMCHANNEL_ALL, GetFireAnim(), 0 );	
			return SRESULT_STAGE ( STAGE_WAIT );
	
		case STAGE_WAIT:		
			if ( wsfl.attack && gameLocal.time >= nextAttackTime && AmmoInClip() && !wsfl.lowerWeapon ) {
				SetState ( "Fire", 0 );
				return SRESULT_DONE;
			}
			if ( AnimDone ( ANIMCHANNEL_ALL, 0 ) ) {
				SetState ( "Idle", 0 );
				return SRESULT_DONE;
			}		
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
rvWeaponGrenadeLauncher::State_Reload
================
*/
stateResult_t rvWeaponGrenadeLauncher::State_Reload ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( wsfl.netReload ) {
				wsfl.netReload = false;
			} else {
				NetReload ( );
			}
			
			SetStatus ( WP_RELOAD );
			PlayAnim ( ANIMCHANNEL_ALL, "reload", parms.blendFrames );
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
	}
	return SRESULT_ERROR;
}
			
