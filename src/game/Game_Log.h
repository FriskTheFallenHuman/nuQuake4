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

#ifndef __GAME_LOG_H__
#define	__GAME_LOG_H__

//============================================================================

class rvGameLogLocal : public rvGameLog {
public:

	rvGameLogLocal ( void );

	virtual void		Init		( void );
	virtual void		Shutdown	( void );

	virtual void		BeginFrame	( int time );
	virtual void		EndFrame	( void );

	virtual	void		Set			( const char* keyword, int value );
	virtual void		Set			( const char* keyword, float value );
	virtual void		Set			( const char* keyword, const char* value );
	virtual void		Set			( const char* keyword, bool value );
	
	virtual void		Add			( const char* keyword, int value );
	virtual void		Add			( const char* keyword, float value );

protected:

	int			lastTime;
	int			indexCount;
	idStrList	index;
	idStrList	frame;
	idStrList	oldframe;
	idFile*		file;
	bool		initialized;
	idTimer		timer_fps;
};

extern rvGameLogLocal		gameLogLocal;

#endif	// __GAME_LOG_H__
