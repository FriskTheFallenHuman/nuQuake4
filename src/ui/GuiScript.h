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
#ifndef __GUISCRIPT_H
#define __GUISCRIPT_H

#include "Window.h"
#include "Winvar.h"

struct idGSWinVar {
	idGSWinVar() {
		var = NULL;
		own = false;
	}
	idWinVar* var;
	bool own;
};

class idGuiScriptList;

class idGuiScript {
	friend class idGuiScriptList;
	friend class idWindow;

public:
	idGuiScript();
	~idGuiScript();

	bool Parse(idParser *src);
	void Execute(idWindow *win) {
		if (handler) {
			handler(win, &parms);
		}
	}
	void FixupParms(idWindow *win);
	size_t Size() {
		int sz = sizeof(*this);
		for (int i = 0; i < parms.Num(); i++) {
			sz += parms[i].var->Size();
		}
		return sz;
	}

	void WriteToSaveGame( idFile *savefile );
	void ReadFromSaveGame( idFile *savefile );

protected:
	int conditionReg;
	idGuiScriptList *ifList;
	idGuiScriptList *elseList;
	idList<idGSWinVar> parms;
	void (*handler) (idWindow *window, idList<idGSWinVar> *src);

};


class idGuiScriptList {
	idList<idGuiScript*> list;
public:
	idGuiScriptList() { list.SetGranularity( 4 ); };
	~idGuiScriptList() { list.DeleteContents(true); };
	void Execute(idWindow *win);
	void Append(idGuiScript* gs) {
		list.Append(gs);
	}
	size_t Size() {
		int sz = sizeof(*this);
		for (int i = 0; i < list.Num(); i++) {
			sz += list[i]->Size();
		}
		return sz;
	}
	void FixupParms(idWindow *win);
	void ReadFromDemoFile( class idDemoFile *f ) {};
	void WriteToDemoFile( class idDemoFile *f ) {};

	void WriteToSaveGame( idFile *savefile );
	void ReadFromSaveGame( idFile *savefile );
};

#endif // __GUISCRIPT_H
