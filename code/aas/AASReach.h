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

#ifndef __AASREACH_H__
#define __AASREACH_H__

#include "AASCompilerFile.h"

/*
===============================================================================

	Reachabilities

===============================================================================
*/

class idAASReach {

public:
	bool					Build( const idMapFile *mapFile, idAASCompilerFile *file );

private:
	const idMapFile *		mapFile;
	idAASCompilerFile *		file;
	int						numReachabilities;
	bool					allowSwimReachabilities;
	bool					allowFlyReachabilities;

private:	// reachability
	void					FlagReachableAreas( idAASCompilerFile *file );
	bool					ReachabilityExists( int fromAreaNum, int toAreaNum );
	bool					CanSwimInArea( int areaNum );
	bool					AreaHasFloor( int areaNum );
	bool					AreaIsClusterPortal( int areaNum );
	void					AddReachabilityToArea( idReachability *reach, int areaNum );
	void					Reachability_Fly( int areaNum );
	void					Reachability_Swim( int areaNum );
	void					Reachability_EqualFloorHeight( int areaNum );
	bool					Reachability_Step_Barrier_WaterJump_WalkOffLedge( int fromAreaNum, int toAreaNum );
	void					Reachability_WalkOffLedge( int areaNum );

};

#endif /* !__AASREACH_H__ */
