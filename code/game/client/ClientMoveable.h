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
// ClientMoveable.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_CLIENT_MOVEABLE_H__
#define __GAME_CLIENT_MOVEABLE_H__

class rvClientMoveable : public rvClientEntity {
public:

	CLASS_PROTOTYPE( rvClientMoveable );

	rvClientMoveable ( void );
	virtual ~rvClientMoveable ( void );
	
	virtual void			Spawn			( void );
	virtual void			Think			( void );
	virtual idPhysics*		GetPhysics		( void ) const;	
	virtual bool			Collide			( const trace_t &collision, const idVec3 &velocity );
	
	renderEntity_t*			GetRenderEntity	( void );

	void					Save			( idSaveGame *savefile ) const;
	void					Restore			( idRestoreGame *savefile );
	
	static void				SpawnClientMoveables ( idEntity* ent, const char *type, idList<rvClientMoveable *>* list );

	virtual void			FreeEntityDef	( void );

	void					SetOwner		( idEntity* ent );

	void					SetOrigin		( const idVec3& origin );
	void					SetAxis			( const idMat3& axis );
protected:
	renderEntity_t			renderEntity;
	int						entityDefHandle;

	rvClientEffectPtr		trailEffect;
	float					trailAttenuateSpeed;
		
	idPhysics_RigidBody		physicsObj;
	
	int						bounceSoundTime;
	const idSoundShader*	bounceSoundShader;
	bool					mPlayBounceSoundOnce;
	bool					mHasBounced;

	idInterpolate<float>	scale;
	
private:
	
	void					Event_FadeOut			( int duration );
	void					Event_ClearDepthHack	( void );
};

ID_INLINE renderEntity_t* rvClientMoveable::GetRenderEntity ( void ) {
	return &renderEntity;
}

extern const idEventDef CL_FadeOut;
extern const idEventDef CL_ClearDepthHack;

#define SIMPLE_TRI_NAME		"simpletri"

extern idVec3 simpleTri[3];


#endif // __GAME_CLIENT_MOVEABLE_H__
