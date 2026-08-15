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

#include "precompiled.h"
#pragma hdrstop
#include "LexerFactory.h"

LexerFactory::~LexerFactory()
{
}

Lexer *LexerFactory::MakeLexer(char const * const filename, int flags, bool OSPath)
{
	return new Lexer(filename, flags | GetReadBinary() | GetWriteBinary(), OSPath);
}

Lexer *LexerFactory::MakeLexer(int flags)
{
	return new Lexer(flags | GetReadBinary() | GetWriteBinary());
}

Lexer *LexerFactory::MakeLexer( char const * const ptr, int length, char const * const name, int flags)
{
	return new Lexer(ptr, length, name, flags | GetWriteBinary() | GetReadBinary());
}

int LexerFactory::GetReadBinary() 
{ 
	if(cvarSystem->GetCVarBool("com_binaryRead")) 
	{
		return LEXFL_READBINARY; 
	}
	else 
	{
		return 0; 
	}
}

int LexerFactory::GetWriteBinary() 
{ 
	int ret=0;
	int writeBinary = cvarSystem->GetCVarInteger("com_binaryWrite");
	switch(writeBinary)
	{
	case 0:
		break;
	case 1:
		ret = LEXFL_WRITEBINARY;
		break;
	case 2:
		ret = LEXFL_WRITEBINARY | LEXFL_BYTESWAP;
		break;
	}

	return ret;
}
