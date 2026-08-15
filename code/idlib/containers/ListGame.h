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

#ifndef __LIST_GAME_H__
#define __LIST_GAME_H__

// GCC 4 compiles templates when they are encountered in a source file,
// not when they are used. Therefore all references, must be resolved.
// RemoveContents() from idLib\List.h references global variables only
// available in the GAME DLL.

/*
================
idList<type>::RemoveContents
================
*/
template< class type >
ID_INLINE void idList<type>::RemoveContents( bool clear ) {
	RemoveNull();

	for( int ix = Num() - 1; ix >= 0; --ix ) {
		list[ ix ]->PostEventMS( &EV_Remove, 0 );
		list[ ix ] = NULL;
	}

	if ( clear ) {
		Clear();
	} else {
		memset( list, 0, Allocated() );
	}
}

#endif // __LIST_GAME_H__
