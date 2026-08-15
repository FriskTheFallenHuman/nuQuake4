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

#ifndef __LISTGUILOCAL_H__
#define __LISTGUILOCAL_H__

/*
===============================================================================

	feed data to a listDef
	each item has an id and a display string

===============================================================================
*/

class idListGUILocal : protected idList<idStr>, public idListGUI {
public:
						idListGUILocal() { m_pGUI = NULL; m_water = 0; m_stateUpdates = true; }

	// idListGUI interface
	void				Config( idUserInterface *pGUI, const char *name ) { m_pGUI = pGUI; m_name = name; }
	void				Add( int id, const idStr& s, bool greyed = false );
						// use the element count as index for the ids
	void				Push( const idStr& s, bool greyed = false );
	bool				Del( int id );
	void				Clear( void );
	int					Num( void ) { return idList<idStr>::Num(); }
	int					GetSelection( char *s, int size, int sel = 0 ) const; // returns the id, not the list index (or -1)
	void				SetSelection( int sel );
	int					GetNumSelections();
	bool				IsConfigured( void ) const;
	void				SetStateChanges( bool enable );
	void				Shutdown( void );

private:
	idUserInterface *	m_pGUI;
	idStr				m_name;
	int					m_water;
	idList<int>			m_ids;
	idList<bool>			m_greyed;
	bool				m_stateUpdates;

	void				StateChanged();
};

#if defined( _WIN32 ) && defined( Q4_RECON_ENGINE_PRIVATE )
static_assert( sizeof( idListGUILocal ) == 0x60, "idListGUILocal ABI drift" );
#endif

#endif /* !__LISTGUILOCAL_H__ */
