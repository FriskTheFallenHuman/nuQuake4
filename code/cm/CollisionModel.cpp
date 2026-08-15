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
===========================================================================

Quake 4 source reconstruction

This translation unit is reconstructed from the matching retail PDB and the
Hex-Rays listing for quake4.exe.  Function RVAs in the retail image:

    0x10001000  idCollisionModelLocal::GetContents
    0x10001050  idCollisionModelLocal::GetBounds
    0x10001080  idCollisionModelLocal::GetVertex
    0x100010D0  idCollisionModelLocal::GetEdge
    0x100011C0  idCollisionModelLocal::GetPolygon
    0x10039510  idCollisionModelLocal::GetName

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

const char *idCollisionModelLocal::GetName( void ) const {
	return name.c_str();
}

bool idCollisionModelLocal::GetBounds( idBounds &modelBounds ) const {
	modelBounds = bounds;
	return true;
}

bool idCollisionModelLocal::GetContents( int &modelContents ) const {
	modelContents = contents;
	return true;
}

bool idCollisionModelLocal::GetVertex( int vertexNum, idVec3 &vertex ) const {
	if ( vertexNum < 0 || vertexNum >= numVertices ) {
		common->Printf( "idCollisionModelLocal::GetModelVertex: invalid vertex number\n" );
		return false;
	}

	vertex = vertices[vertexNum].p;
	return true;
}

bool idCollisionModelLocal::GetEdge( int edgeNum, idVec3 &start, idVec3 &end ) const {
	const int absoluteEdgeNum = abs( edgeNum );
	if ( absoluteEdgeNum >= numEdges ) {
		common->Printf( "idCollisionModelLocal::GetModelEdge: invalid edge number\n" );
		return false;
	}

	start = vertices[edges[absoluteEdgeNum].vertexNum[0]].p;
	end = vertices[edges[absoluteEdgeNum].vertexNum[1]].p;
	return true;
}

bool idCollisionModelLocal::GetPolygon( int polygonNum, idFixedWinding &winding ) const {
	const cm_polygon_t &polygon = polygons[polygonNum];

	winding.Clear();
	for ( int i = 0; i < polygon.numEdges; i++ ) {
		const int edgeNum = polygon.edges[i];
		const int vertexNum = edges[abs( edgeNum )].vertexNum[INTSIGNBITSET( edgeNum )];
		winding += vertices[vertexNum].p;
	}

	return true;
}
