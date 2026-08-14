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
#ifndef __FIELDWINDOW_H
#define __FIELDWINDOW_H

#include "Window.h"


class idFieldWindow : public idWindow {
public:
	idFieldWindow(idUserInterfaceLocal *gui);
	idFieldWindow(idDeviceContext *d, idUserInterfaceLocal *gui);
	virtual ~idFieldWindow();

	virtual void Draw(int time, float x, float y);
	
private:
	virtual bool ParseInternalVar(const char *name, idParser *src);
	void CommonInit();
	void CalcPaintOffset(int len);
	int cursorPos;
	int lastTextLength;
	int lastCursorPos;
	int paintOffset;
	bool showCursor;
	idStr cursorVar;
};

#endif // __FIELDWINDOW_H
