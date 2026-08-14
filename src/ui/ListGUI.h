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

// Copyright (C) 2004 Id Software, Inc.
//

#ifndef __LISTGUI_H__
#define __LISTGUI_H__

/*
===============================================================================

	feed data to a listDef
	each item has an id and a display string

===============================================================================
*/

class idListGUI {
public:
	virtual				~idListGUI() { }

	virtual void		Config( idUserInterface *pGUI, const char *name ) = 0;
// RAVEN BEGIN
// shouchard:  added greyed support
	virtual void		Add( int id, const idStr& s, bool greyed = false ) = 0;
						// use the element count as index for the ids
	virtual void		Push( const idStr& s, bool greyed = false ) = 0;
// RAVEN END
	virtual bool		Del( int id ) = 0;
	virtual void		Clear( void ) = 0;
	virtual int			Num( void ) = 0;
	virtual int			GetSelection( char *s, int size, int sel = 0 ) const = 0; // returns the id, not the list index (or -1)
	virtual void		SetSelection( int sel ) = 0;
	virtual int			GetNumSelections() = 0;
	virtual bool		IsConfigured( void ) const = 0;
						// by default, any modification to the list will trigger a full GUI refresh immediately
	virtual void		SetStateChanges( bool enable ) = 0;
	virtual void		Shutdown( void ) = 0;
};

#endif /* !__LISTGUI_H__ */
