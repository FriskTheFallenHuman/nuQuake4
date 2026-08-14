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
// VehicleController.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_VEHICLECONTROLLER_H__
#define __GAME_VEHICLECONTROLLER_H__

class rvVehicle;
class rvVehiclePosition;

class rvVehicleController {
public:

	rvVehicleController ( void );

	void			Save				( idSaveGame *savefile ) const;
	void			Restore				( idRestoreGame *savefile );

	bool			Drive				( rvVehicle* vehicle, idActor* driver );
	bool			Eject				( bool force = false );

	bool			FindClearExitPoint	( idVec3& origin, idMat3& axis ) const;

	bool			IsDriving			( void ) const;

	rvVehicle*		GetVehicle			( void ) const;
	idActor*		GetDriver			( void ) const;
	int				GetPosition			( void ) const;
	
	void			SetInput			( const usercmd_t& cmd, const idAngles &newAngles );
	void			GetInput			( usercmd_t& cmd, idAngles &newAngles ) const;
	
	idUserInterface* GetHud				( void );
	const idUserInterface* GetHud		( void ) const;
	void			DrawHUD				( void );
	void			UpdateCursorGUI		( idUserInterface* ui );
	
	void			StartRadioChatter	( void );
	void			StopRadioChatter	( void );
	
	void			Give				( const char* statname, const char* value );
	void			GetEyePosition		( idVec3& origin, idMat3& axis ) const;
	void			GetDriverPosition	( idVec3& origin, idMat3& axis ) const;

	static void		KillVehicles		( void );

	void			WriteToSnapshot		( idBitMsgDelta &msg ) const;
	void			ReadFromSnapshot	( const idBitMsgDelta &msg );
		
	void			SelectWeapon		( int weapon );

protected:

	idEntityPtr<rvVehicle>	mVehicle;
	int						mPosition;
};

ID_INLINE bool rvVehicleController::IsDriving ( void ) const {
	return mVehicle.IsValid ( );
}

ID_INLINE int rvVehicleController::GetPosition ( void ) const {
	return mPosition;
}

#endif // __GAME_VEHICLECONTROLLER_H__

