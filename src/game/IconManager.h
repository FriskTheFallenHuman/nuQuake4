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
// IconManager.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __ICONMANAGER_H__
#define __ICONMANAGER_H__

#include "Icon.h"

const int ICON_STAY_TIME = 2000;

class rvIconManager {
public:
	void				AddIcon( int clientNum, const char* iconName );
	void				UpdateIcons( void );
	void				UpdateTeamIcons( void );
	void				UpdateChatIcons( void );
	void				Shutdown( void );

private:
	idList<rvPair<rvIcon*, int> >	icons[ MAX_CLIENTS ];
	rvIcon							teamIcons[ MAX_CLIENTS ];
	rvIcon							chatIcons[ MAX_CLIENTS ];
};

extern rvIconManager*	iconManager;

#endif
