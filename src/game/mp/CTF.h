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
// CTF.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __CTF_H__
#define __CTF_H__

#include "../Game_local.h"
#include "../MultiplayerGame.h"

/*
===============================================================================

rvCTF_AssaultPoint

===============================================================================
*/

class rvCTF_AssaultPoint : public idEntity {
public:
	CLASS_PROTOTYPE( rvCTF_AssaultPoint );
	void	Spawn( void );

	rvCTF_AssaultPoint();
	~rvCTF_AssaultPoint();

	int GetOwner( void ); 
	int GetIndex( void ); 
	
	void SetOwnerColor ( void );
	void SetOwner ( int newOwner );
	void Reset ( void );

private:
	void	Event_Touch( idEntity *activator, trace_t *trace );
	void    Event_InitializeLinks( void );
	void	ResetSpawns( int team );	
	
	void	ResetIndices( void );
    
	// these could be maintained as lists to allow multiple AP paths
	// the assault point one step closer to the Strogg base
	idEntityPtr<idEntity>	toStrogg;
	// the assault point one step closer to the Marine base
	idEntityPtr<idEntity>	toMarine;

	// who currently owns this assault point
	int	owner;
	int index;
	bool linked;

	idClipModel* trigger;
};

ID_INLINE int rvCTF_AssaultPoint::GetOwner( void ) {
	return owner;
}

ID_INLINE int rvCTF_AssaultPoint::GetIndex( void ) {
	return index;
}

/*
===============================================================================

rvCTFAssaultPlayerStart

===============================================================================
*/
class rvCTFAssaultPlayerStart : public idPlayerStart {
public:
	CLASS_PROTOTYPE( rvCTFAssaultPlayerStart );

	void				Spawn( void );

	int					GetTeam( void );
private:
	void				Event_Activate( idEntity *activator );
	int					team;
};

#endif
