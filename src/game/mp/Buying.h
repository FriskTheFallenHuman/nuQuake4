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
// Buying.h
//
// Copyright 2005 Ritual Entertainment
//
// This file essentially serves as an extension to the Game DLL
// source files Multiplayer.h and Player.h, in an attempt
// to isolate, as much as possible, these changes from the main
// body of code (for merge simplification, etc).
//----------------------------------------------------------------

#ifndef __BUYING_H__
#define __BUYING_H__

#include "../Game_local.h"
#include "../MultiplayerGame.h"


class riBuyingManager
{
private:
	const idDeclEntityDef*	_buyingGameBalanceConstants;
	int						opponentKillCashAward;	// latch
	int						opponentKillFragCount;

public:
	riBuyingManager();
	~riBuyingManager();

	int GetIntValueForKey( const char* keyName, int defaultValue );
	int GetOpponentKillCashAward( void );

	void Reset( void ) { opponentKillFragCount = -1; }
};


#endif // __BUYING_H__
