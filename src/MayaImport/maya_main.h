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

#ifndef __MAYA_MAIN_H__
#define __MAYA_MAIN_H__

/*
==============================================================

	Maya Import

==============================================================
*/

// RAVEN BEGIN
// rhummer: unify allocation strategy to try to eliminate some of our crashes
#ifdef RV_UNIFIED_ALLOCATOR
typedef bool ( *exporterDLLEntry_t )( int version, idCommon *common, idSys *sys, void *(*allocator)(size_t size), void (*deallocator)(void *), size_t (*msize)(void *) );
#else
typedef bool ( *exporterDLLEntry_t )( int version, idCommon *common, idSys *sys );
#endif
// RAVEN END
// RAVEN BEGIN
// bdube: default src and dest ospath's
typedef const char *( *exporterInterface_t )( const char *src_ospath, const char* dst_ospath, const char *commandline );
// RAVEN END
typedef void ( *exporterShutdown_t )( void );

#endif /* !__MAYA_MAIN_H__ */
