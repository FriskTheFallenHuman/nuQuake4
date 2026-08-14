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
 
#ifndef __AASCLUSTER_H__
#define __AASCLUSTER_H__

#include "AASCompilerFile.h"

/*
===============================================================================

	Area Clustering

===============================================================================
*/

class idAASCluster {

public:
	bool					Build( idAASCompilerFile *file );
	bool					BuildSingleCluster( idAASCompilerFile *file );

private:
	idAASCompilerFile *		file;
	bool					noFaceFlood;

private:
	bool					UpdatePortal( int areaNum, int clusterNum );
	bool					FloodClusterAreas_r( int areaNum, int clusterNum );
	void					RemoveAreaClusterNumbers( void );
	void					NumberClusterAreas( int clusterNum );
	bool					FindClusters( void );
	void					CreatePortals( void );
	bool					TestPortals( void );
	void					ReportEfficiency( void );
	void					RemoveInvalidPortals( void );
};

#endif /* !__AASCLUSTER_H__ */
