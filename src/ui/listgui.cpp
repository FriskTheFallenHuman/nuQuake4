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

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "ListGUILocal.h"

/*
====================
idListGUILocal::StateChanged
====================
*/
void idListGUILocal::StateChanged() {
	int i;

	if ( !m_stateUpdates ) {
		return;
	}

	const int count = Num();
	if ( count > 0 && m_pGUI->GetStateInt( va( "%s_sel_0", m_name.c_str() ), "0" ) >= count ) {
		m_pGUI->SetStateInt( va( "%s_sel_0", m_name.c_str() ), count - 1 );
	}

	for( i = 0; i < count; i++ ) {
		m_pGUI->SetStateString( va( "%s_item_%i", m_name.c_str(), i ), (*this)[i].c_str() ); 
	}
	for( i = count; i < m_water; i++ ) {
		m_pGUI->SetStateString( va( "%s_item_%i", m_name.c_str(), i ), "" );
	}
	for ( i = 0; i < count; i++ ) {
		const char *greyedName = va( "%s_item_%i_greyed", m_name.c_str(), i );
		if ( m_greyed[i] ) {
			m_pGUI->SetStateBool( greyedName, true );
		} else {
			m_pGUI->DeleteStateVar( greyedName );
		}
	}
	m_water = count;
	m_pGUI->StateChanged( com_frameTime );
}

/*
====================
idListGUILocal::GetNumSelections
====================
*/
int idListGUILocal::GetNumSelections() {
	return m_pGUI->State().GetInt( va( "%s_numsel", m_name.c_str() ) );
}

/*
====================
idListGUILocal::GetSelection
====================
*/
int idListGUILocal::GetSelection( char *s, int size, int _sel ) const {
	if ( s ) {		
		s[ 0 ] = '\0';
	}
	int sel = m_pGUI->State().GetInt( va( "%s_sel_%i", m_name.c_str(), _sel ), "-1" );
	if ( sel == -1 || sel >= m_ids.Num() ) {
		return -1;
	}
	if ( s ) {
		idStr::snPrintf( s, size, m_pGUI->State().GetString( va( "%s_item_%i", m_name.c_str(), sel ), "" ) );
	}
	// don't let overflow
	if ( sel >= m_ids.Num() ) {
		sel = 0;
	}
	m_pGUI->SetStateInt( va( "%s_selid_0", m_name.c_str() ), m_ids[ sel ] ); 
	return m_ids[ sel ];
}

/*
====================
idListGUILocal::SetSelection
====================
*/
void idListGUILocal::SetSelection( int sel ) {
	m_pGUI->SetStateInt( va( "%s_sel_0", m_name.c_str() ), sel );
	StateChanged();
}

/*
====================
idListGUILocal::Add
====================
*/
void idListGUILocal::Add( int id, const idStr &s, bool greyed ) {
	int i = m_ids.FindIndex( id );
	if ( i == -1 ) {
		Append( s );
		m_ids.Append( id );
		m_greyed.Append( greyed );
	} else {
		(*this)[ i ] = s;
	}
	StateChanged();
}

/*
====================
idListGUILocal::Push
====================
*/
void idListGUILocal::Push( const idStr& s, bool greyed ) {
	Append( s );
	m_ids.Append( m_ids.Num() );
	m_greyed.Append( greyed );
	StateChanged();
}

/*
====================
idListGUILocal::Del
====================
*/
bool idListGUILocal::Del(int id) {
	int i = m_ids.FindIndex(id);
	if ( i == -1 ) {
		return false;
	}
	m_ids.RemoveIndex( i );
	m_greyed.RemoveIndex( i );
	this->RemoveIndex( i );
	StateChanged();
	return true;
}

/*
====================
idListGUILocal::Clear
====================
*/
void idListGUILocal::Clear() {
	m_ids.Clear();
	m_greyed.Clear();
	idList<idStr>::Clear();
	if ( m_pGUI ) {
		// will clear all the GUI variables and will set m_water back to 0
		StateChanged();
	}
}

/*
====================
idListGUILocal::IsConfigured
====================
*/
bool idListGUILocal::IsConfigured( void ) const {
	return m_pGUI != NULL;
}

/*
====================
idListGUILocal::SetStateChanges
====================
*/
void idListGUILocal::SetStateChanges( bool enable ) {
	m_stateUpdates = enable;
	StateChanged();
}

/*
====================
idListGUILocal::Shutdown
====================
*/
void idListGUILocal::Shutdown( void ) {
	m_pGUI = NULL;
	m_name.Clear();
	Clear();
}
