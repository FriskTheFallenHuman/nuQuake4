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

#include "Window.h"
#include "Winvar.h"
#include "UserInterfaceLocal.h"

idWinVar::idWinVar() { 
	guiDict = NULL; 
	name = NULL; 
	eval = true;
}

idWinVar::~idWinVar() { 
	delete name;
	name = NULL;
}

void idWinVar::SetGuiInfo(idDict *gd, const char *_name) { 
	guiDict = gd; 
	SetName(_name); 
}


void idWinVar::Init(const char *_name, idWindow *win) {
	idStr key = _name;
	guiDict = NULL;
	int len = key.Length();
	if (len > 5 && key[0] == 'g' && key[1] == 'u' && key[2] == 'i' && key[3] == ':') {
		key = key.Right(len - VAR_GUIPREFIX_LEN);
		SetGuiInfo( win->GetGui()->GetStateDict(), key );
		win->AddUpdateVar(this);
	} else {
		Set(_name);
	}
}

void idMultiWinVar::Set( const char *val ) {
	for ( int i = 0; i < Num(); i++ ) {
		(*this)[i]->Set( val );
	}
}

void idMultiWinVar::Update( void ) {
	for ( int i = 0; i < Num(); i++ ) {
		(*this)[i]->Update();
	}
}

void idMultiWinVar::SetGuiInfo( idDict *dict ) {
	for ( int i = 0; i < Num(); i++ ) {
		(*this)[i]->SetGuiInfo( dict, (*this)[i]->c_str() );
	}
}

