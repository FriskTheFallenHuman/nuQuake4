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

/*
===============================================================================

	Preprocessor settings for compiling different versions.

===============================================================================
*/

// useful for network debugging, turns off 'LAN' checks, all IPs are classified 'internet'
#ifndef ID_NOLANADDRESS
	#define ID_NOLANADDRESS 0
#endif

// let .dds be loaded from FS without altering pure state. only for developement.
#ifndef ID_PURE_ALLOWDDS
	#define ID_PURE_ALLOWDDS 0
#endif

// build an exe with no CVAR_CHEAT controls
#ifndef ID_ALLOW_CHEATS
	#define ID_ALLOW_CHEATS 0
#endif

#ifndef ID_ENABLE_CURL
	#if !defined( _XENON )
		#define ID_ENABLE_CURL 1
	#else
		#define ID_ENABLE_CURL 0
	#endif
#endif

// fake a pure client. useful to connect an all-debug client to a server
#ifndef ID_FAKE_PURE
	#define ID_FAKE_PURE 0
#endif

// don't do backtraces in release builds.
// atm, we have no useful way to reconstruct the trace, so let's leave it off
#define ID_BT_STUB
#ifndef ID_BT_STUB
	#if defined( __linux__ )
		#if defined( _DEBUG )
			#define ID_BT_STUB
		#endif
	#else
		#define ID_BT_STUB
	#endif
#endif

#ifndef ID_ENFORCE_KEY
#	if !defined( ID_DEDICATED ) && !defined( ID_DEMO_BUILD )
#		define ID_ENFORCE_KEY 0
#	else
// twhitaker: just leave it undefined
// TTimo: that breaks the ability to control it from command line settings with !win32 builds, but I can live with it
//#		define ID_ENFORCE_KEY 0
#	endif
#endif

// verify checksums in clientinfo traffic
// NOTE: this makes the network protocol incompatible
#ifndef ID_CLIENTINFO_TAGS
	#define ID_CLIENTINFO_TAGS 0
#endif

// if this is defined, the executable positively won't work with any paks other
// than the demo pak, even if productid is present.
//#define ID_DEMO_BUILD

#if !defined( _WIN32 )
	// DOA? didn't see the pbuffer code used at all through the code
	#define TMP_PBUFFSTUB
#endif
