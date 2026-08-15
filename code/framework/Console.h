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

#ifndef __CONSOLE_H__
#define __CONSOLE_H__

/*
===============================================================================

	The console is strictly for development and advanced users. It should
	never be used to convey actual game information to the user, which should
	always be done through a GUI.

	The force options are for the editor console display window, which
	doesn't respond to pull up / pull down

===============================================================================
*/

class idConsole {
public:
	virtual			~idConsole( void ) {}

	virtual void	Init( void ) = 0;
	virtual void	Shutdown( void ) = 0;

	// can't be combined with Init, because Init happens before renderer is started
	virtual void	LoadGraphics() = 0;

	virtual bool	ProcessEvent( const struct sysEvent_s *event, bool forceAccept ) = 0;

	// the system code can release the mouse pointer when the console is active
	virtual bool	Active( void ) = 0;

	// clear the timers on any recent prints that are displayed in the notify lines
	virtual void	ClearNotifyLines( void ) = 0;

	// some console commands, like timeDemo, will force the console closed before they start
	virtual void	Close( void ) = 0;

	virtual void	Draw( bool forceFullScreen ) = 0;
	virtual void	Print( const char *text ) = 0;
};

extern idConsole *	console;	// statically initialized to an idConsoleLocal

#endif /* !__CONSOLE_H__ */
