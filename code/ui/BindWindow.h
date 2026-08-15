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
#ifndef __BINDWINDOW_H
#define __BINDWINDOW_H

class idUserInterfaceLocal;
class idBindWindow : public idWindow {
public:
	idBindWindow(idUserInterfaceLocal *gui);
	idBindWindow(idDeviceContext *d, idUserInterfaceLocal *gui);
	virtual ~idBindWindow();

	virtual const char *HandleEvent(const sysEvent_t *event, bool *updateVisuals);
	virtual void PostParse();
	virtual void Draw(int time, float x, float y);
	virtual size_t Allocated(){return idWindow::Allocated();};
// 
//  
	virtual idWinVar *GetWinVarByName(const char *_name, bool winLookup = false, drawWin_t** owner = NULL );
// 
	virtual void Activate( bool activate, idStr &act );
	
private:
	void CommonInit();
	idWinStr bindName;
	bool waitingOnKey;
};

#endif // __BINDWINDOW_H
