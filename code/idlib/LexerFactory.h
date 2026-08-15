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

#ifndef __LEXERFACTORY_H__
#define __LEXERFACTORY_H__

class LexerFactory
{
public:

	static Lexer *MakeLexer( int flags );
	static Lexer *MakeLexer( char const * const filename, int flags = 0, bool OSPath = false );
	static Lexer *MakeLexer( char const * const ptr, int length, char const * const name, int flags = 0 );

private:
	static int GetReadBinary();
	static int GetWriteBinary();

	// disallow default constructor
	LexerFactory();
	~LexerFactory();
};

#endif
