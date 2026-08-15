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

/* Quake 4 area-reverb compiland (snd_reverb.obj). */

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "snd_local.h"

const char *idSoundSystemLocal::GetReverbName( int reverb ) { return reverb == 0 ? "default" : ""; }
int idSoundSystemLocal::GetReverb( int area ) { return area >= 0 && area < areaReverbs.Num() ? areaReverbs[area] : 0; }
bool idSoundSystemLocal::SetReverb( int area, const char *reverbName, const char *fileName ) {
	if ( area < 0 ) return false;
	while ( areaReverbs.Num() <= area ) areaReverbs.Append( 0 );
	areaReverbs[area] = 0;
	return true;
}
void idSoundSystemLocal::LoadReverbData( const char *mapName ) { areaReverbs.Clear(); }
