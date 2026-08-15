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
// Effect.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_EFFECT_H__
#define __GAME_EFFECT_H__

class rvEffect : public idEntity
{
public:

	CLASS_PROTOTYPE( rvEffect );

	rvEffect ( void );

	const bool		GetEndOrigin				( idVec3 &result ) const;
	void			SetEndOrigin				( const idVec3 &origin );

	void			Spawn						( void );
	void			Think						( void );
	void			Save						( idSaveGame *savefile ) const;
	void			Restore						( idRestoreGame *savefile );

	bool			Play						( void );
	void			Stop						( bool destroyParticles = false );			
	void			Restart						( void );
			
	void			Attenuate					( float attenuation );
			
	float			GetBrightness				( void ) const;
		
	bool			IsLooping					( void ) { return( loop ); }
		
	virtual void	UpdateChangeableSpawnArgs	( const idDict *source );
	virtual void	ShowEditingDialog			( void );

	virtual void	WriteToSnapshot				( idBitMsgDelta &msg ) const;
	virtual void	ReadFromSnapshot			( const idBitMsgDelta &msg );
	void			ClientPredictionThink		( void );
	virtual void	InstanceLeave				( void );
	virtual void	InstanceJoin				( void );
						
protected:

	bool								loop;
	bool								lookAtTarget;
	const idDecl						*effect;
	idVec3								endOrigin;
	rvClientEntityPtr<rvClientEffect>	clientEffect;
			
private:

	void			Event_Activate		( idEntity *activator );
	void			Event_LookAtTarget	( void );
	void			Event_EarthQuake	( float requiresLOS );
	
	void			Event_Start			( void );
	void			Event_Stop			( void );

	void			Event_Attenuate		( float attenuation );
	void			Event_IsActive		( void );
};

#endif // __GAME_EFFECT_H__
