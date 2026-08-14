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
// Instance.h
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#ifndef __INSTANCE_H__
#define __INSTANCE_H__

#include "Game_local.h"

class rvInstance {
public:
	rvInstance( int id, bool deferPopulate = false );
	~rvInstance();

	void Populate( int serverChecksum = 0 );
	void PopulateFromMessage( const idBitMsg& msg );
	void Restart( void );
	
	void JoinInstance( idPlayer* player );
	int GetInstanceID( void );
	
	void SetSpawnInstanceID( int newInstance );

	void PrintMapNumbers( void );
	int	GetNumMapEntities( void ) { return numMapEntities; }
	unsigned short GetMapEntityNumber( int i ) { return mapEntityNumbers[ i ]; }

private:
	void					BuildInstanceMessage( void );

	int						instanceID;
	int						spawnInstanceID;
	unsigned short*			mapEntityNumbers;
	int						numMapEntities;
	int						initialSpawnCount;
	
	idBitMsg				mapEntityMsg;
	byte					mapEntityMsgBuf[ MAX_GAME_MESSAGE_SIZE ];
};

ID_INLINE int rvInstance::GetInstanceID( void ) {
	return instanceID;
}

#endif
