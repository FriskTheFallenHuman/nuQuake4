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
// VehicleController.cpp
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "VehicleController.h"
#include "Vehicle.h"

/*
=====================
rvVehicleController::rvVehicleController
=====================
*/
rvVehicleController::rvVehicleController ( void ) {
	mVehicle  = NULL;
	//mDriver   = NULL;
	mPosition = 0;
}

/*
=====================
rvVehicleController::Save
=====================
*/
void rvVehicleController::Save ( idSaveGame *savefile ) const {
	mVehicle.Save ( savefile );
	savefile->WriteInt ( mPosition );
}

/*
=====================
rvVehicleController::Restore
=====================
*/
void rvVehicleController::Restore ( idRestoreGame *savefile ) {
	mVehicle.Restore ( savefile );
	savefile->ReadInt ( mPosition );
}

/*
=====================
rvVehicleController::Drive
=====================
*/
bool rvVehicleController::Drive ( rvVehicle* vehicle, idActor* driver ) {
	assert ( vehicle && driver );

	// Flip the vehicle back over?
	if ( vehicle->IsFlipped ( ) ) {
		vehicle->AutoRight ( vehicle );
		return false;
	}
		
	// Add the driver to the vehicle and cache the position it was added.
	if ( -1 == (mPosition = vehicle->AddDriver ( 0, driver ) ) ) {
		return false;
	}
	
	mVehicle = vehicle;	

	//twhitaker: for scripted callback events
	vehicle->OnEnter();
	
	if ( driver->IsType( idPlayer::GetClassType() ) ) {
		idPlayer * player = static_cast< idPlayer *>( driver );

		if ( player->GetHud() ) {
			GetHud()->Activate( true, gameLocal.time );
			GetHud()->HandleNamedEvent( "showExitmessage" );
		}
	}

	return true;
}

/*
=====================
rvVehicleController::Eject
=====================
*/
bool rvVehicleController::Eject ( bool force ) {
	if ( !GetVehicle() ) {
		return true;
	}
	
	if ( GetDriver()->IsType( idPlayer::GetClassType() ) ) {
		idPlayer * player = static_cast< idPlayer *>( GetDriver() );

		if ( player->GetHud() ) {
			GetHud()->HandleNamedEvent( "hideExitmessage" );
		}
	}

	if ( mVehicle->RemoveDriver ( GetPosition(), force ) ) {
		mVehicle->OnExit();
		mVehicle = NULL;

		return true;
	}
	
	return false;
}

/*
=====================
rvVehicleController::FindClearExitPoint
=====================
*/
bool rvVehicleController::FindClearExitPoint( idVec3& origin, idMat3& axis ) const {
	return GetVehicle()->FindClearExitPoint( mPosition, origin, axis );
}

/*
=====================
rvVehicleController::KillVehicles
=====================
*/
void rvVehicleController::KillVehicles ( void ) {
	KillEntities( idCmdArgs(), rvVehicle::GetClassType() );
}

/*
=====================
rvVehicleController::DrawHUD
=====================
*/
void rvVehicleController::DrawHUD ( void ) {
	assert ( mVehicle );

	if ( GetDriver() && GetDriver()->IsType( idPlayer::GetClassType() ) ) {
		idPlayer * player = static_cast<idPlayer*>( GetDriver() );
		rvVehicleWeapon * weapon = mVehicle->GetPosition( mPosition )->GetActiveWeapon();
		if ( weapon ) {
			if ( weapon->CanZoom() && player->IsZoomed() && player == gameLocal.GetLocalPlayer() ) {
				weapon->GetZoomGui()->Redraw( gameLocal.time );			
			}
//            if ( mVehicle->GetHud() ) {
//				mVehicle->GetHud()->SetStateFloat( "tram_heatpct", weapon->GetOverheatPercent());
//	 			mVehicle->GetHud()->SetStateFloat( "tram_overheat", weapon->GetOverheatState());
//			}
		}
	}

	mVehicle->DrawHUD ( mPosition );
}

/*
=====================
rvVehicleController::StartRadioChatter
=====================
*/
void rvVehicleController::StartRadioChatter	( void ) {
	assert ( mVehicle );
	if ( mVehicle->GetHud () ) {
		mVehicle->GetHud ()->HandleNamedEvent( "radioChatterUp" );
	}
}

/*
=====================
rvVehicleController::StopRadioChatter
=====================
*/
void rvVehicleController::StopRadioChatter ( void ) {
	assert ( mVehicle );
	if ( mVehicle->GetHud () ) {
		mVehicle->GetHud ()->HandleNamedEvent( "radioChatterDown" );
	}
}

/*
=====================
rvVehicleController::Give
=====================
*/
void rvVehicleController::Give ( const char* statname, const char* value ) {
	if( mVehicle.IsValid() ) {
		mVehicle->Give ( statname, value );
	}
}

/*
=====================
rvVehicleController::GetEyePosition
=====================
*/
void rvVehicleController::GetEyePosition ( idVec3& origin, idMat3& axis ) const {
	if( mVehicle.IsValid() ) {
		mVehicle->GetEyePosition ( mPosition, origin, axis );
	}
}

/*
=====================
rvVehicleController::GetDriverPosition
=====================
*/
void rvVehicleController::GetDriverPosition ( idVec3& origin, idMat3& axis ) const {
	if( mVehicle.IsValid() ) {
		mVehicle->GetDriverPosition ( mPosition, origin, axis );
	}
}

/*
=====================
rvVehicleController::GetVehicle
=====================
*/
rvVehicle* rvVehicleController::GetVehicle ( void ) const {
	return mVehicle;
}

idActor* rvVehicleController::GetDriver ( void ) const {
	return (GetVehicle()) ? GetVehicle()->GetPosition(GetPosition())->GetDriver() : NULL;
}

/*
=====================
rvVehicleController::SetInput
=====================
*/
void rvVehicleController::SetInput ( const usercmd_t& cmd, const idAngles &angles ) {
	if( mVehicle.IsValid() ) {
		mVehicle->SetInput ( mPosition, cmd, angles );
	}
}

/*
=====================
rvVehicleController::GetInput
=====================
*/
void rvVehicleController::GetInput( usercmd_t& cmd, idAngles &newAngles ) const {
	if( mVehicle.IsValid() ) {
		mVehicle->GetInput( mPosition, cmd, newAngles );
	}
}

/*
================
rvVehicleController::GetHud
================
*/
idUserInterface* rvVehicleController::GetHud( void ) {
	return (IsDriving()) ? mVehicle->GetHud() : NULL;
}

/*
================
rvVehicleController::GetHud
================
*/
const idUserInterface* rvVehicleController::GetHud( void ) const {
	return (IsDriving()) ? mVehicle->GetHud() : NULL;
}

/*
================
rvVehicleController::WriteToSnapshot
================
*/
void rvVehicleController::WriteToSnapshot ( idBitMsgDelta &msg ) const {
	msg.WriteLong ( mPosition );
	msg.WriteLong ( mVehicle.GetSpawnId ( ) );
}

/*
================
rvVehicleController::ReadFromSnapshot
================
*/
void rvVehicleController::ReadFromSnapshot ( const idBitMsgDelta &msg ) {
	mPosition = msg.ReadLong ( );
	mVehicle.SetSpawnId ( msg.ReadLong ( ) );
}

/*
================
rvVehicleController::UpdateCursorGUI
================
*/
void rvVehicleController::UpdateCursorGUI ( idUserInterface* ui ) {
	assert ( mVehicle );
	mVehicle->UpdateCursorGUI ( mPosition, ui );
}

/*
================
rvVehicleController::SelectWeapon
================
*/
void rvVehicleController::SelectWeapon ( int weapon ) {
	if( mVehicle.IsValid() ) {
		mVehicle->GetPosition( mPosition )->SelectWeapon( weapon );
	}
}
