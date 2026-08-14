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
// StatWindow.h
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#ifndef __STATWINDOW_H__
#define __STATWINDOW_H__

/*
===============================================================================

Stat selection window

===============================================================================
*/

class rvStatWindow {
public:
	rvStatWindow();
	void						SetupStatWindow( idUserInterface* statHud, bool useSpectator = false );
	void						SelectPlayer( int clientNum );
	int							ClientNumFromSelection( int selectionIndex, int selectionTeam );
	void						ClearWindow( void );
	int							GetSelectedClientNum( int* selectionIndexOut, int* selectionTeamOut );
private:
	idList<idPlayer*>			stroggPlayers;
	idList<idPlayer*>			marinePlayers;
	idList<idPlayer*>			players;
	idList<idPlayer*>			spectators;
	
	idUserInterface*			statHud;
};


#endif
