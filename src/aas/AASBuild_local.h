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

#ifndef __AASBUILD_LOCAL_H__
#define __AASBUILD_LOCAL_H__

#include "AASFile.h"
#include "AASCompilerFile.h"

#include "Brush.h"
#include "BrushBSP.h"
#include "AASReach.h"
#include "AASCluster.h"


//===============================================================
//
//	idAASBuild
//
//===============================================================

typedef struct aasProcNode_s {
	idPlane plane;
	int children[2];		// negative numbers are (-1 - areaNumber), 0 = solid
} aasProcNode_t;


class idLedge {

public:
	idVec3					start;
	idVec3					end;
	idBrushBSPNode *		node;
	int						numExpandedPlanes;
	int						numSplitPlanes;
	int						numPlanes;
	idPlane					planes[8];

public:
							idLedge( void );
							idLedge( const idVec3 &v1, const idVec3 &v2, const idVec3 &gravityDir, idBrushBSPNode *n );
	void					AddPoint( const idVec3 &v );
	void					CreateBevels( const idVec3 &gravityDir );
	void					Expand( const idBounds &bounds, float maxStepHeight );
	idWinding *				ChopWinding( const idWinding *winding ) const;
	bool					PointBetweenBounds( const idVec3 &v ) const;
};


class idAASBuild {

public:
							idAASBuild( void );
							~idAASBuild( void );
	bool					Build( const idStr &fileName, const idAASSettings *settings );
	bool					BuildReachability( const idStr &fileName, const idAASSettings *settings );
	void					Shutdown( void );

private:
	const idAASSettings *	aasSettings;
	idAASCompilerFile *		file;
	aasProcNode_t *			procNodes;
	int						numProcNodes;
	int						numGravitationalSubdivisions;
	int						numMergedLeafNodes;
	int						numLedgeSubdivisions;
	idList<idLedge>			ledgeList;
	idBrushMap *			ledgeMap;

private:	// map loading
	void					ParseProcNodes( idLexer *src );
	bool					LoadProcBSP( const char *name, ID_TIME_T minFileTime );
	void					DeleteProcBSP( void );
	bool					ChoppedAwayByProcBSP( int nodeNum, idFixedWinding *w, const idVec3 &normal, const idVec3 &origin, const float radius );
	void					ClipBrushSidesWithProcBSP( idBrushList &brushList );
	int						ContentsForAAS( int contents );
	idBrushList				AddBrushesForMapBrush( const idMapBrush *mapBrush, const idVec3 &origin, const idMat3 &axis, int entityNum, int primitiveNum, idBrushList brushList );
	idBrushList				AddBrushesForMapPatch( const idMapPatch *mapPatch, const idVec3 &origin, const idMat3 &axis, int entityNum, int primitiveNum, idBrushList brushList );
	idBrushList				AddBrushesForMapEntity( const idMapEntity *mapEnt, int entityNum, idBrushList brushList );
	idBrushList				AddBrushesForMapFile( const idMapFile * mapFile, idBrushList brushList );
	bool					CheckForEntities( const idMapFile *mapFile, idStrList &entityClassNames ) const;
	void					ChangeMultipleBoundingBoxContents_r( idBrushBSPNode *node, int mask );

private:	// gravitational subdivision
	void					SetPortalFlags_r( idBrushBSPNode *node );
	bool					PortalIsGap( idBrushBSPPortal *portal, int side );
	void					GravSubdivLeafNode( idBrushBSPNode *node );
	void					GravSubdiv_r( idBrushBSPNode *node );
	void					GravitationalSubdivision( idBrushBSP &bsp );

private:	// ledge subdivision
	void					LedgeSubdivFlood_r( idBrushBSPNode *node, const idLedge *ledge );
	void					LedgeSubdivLeafNodes_r( idBrushBSPNode *node, const idLedge *ledge );
	void					LedgeSubdiv( idBrushBSPNode *root );
	bool					IsLedgeSide_r( idBrushBSPNode *node, idFixedWinding *w, const idPlane &plane, const idVec3 &normal, const idVec3 &origin, const float radius );
	void					AddLedge( const idVec3 &v1, const idVec3 &v2, idBrushBSPNode *node );
	void					FindLeafNodeLedges( idBrushBSPNode *root, idBrushBSPNode *node );
	void					FindLedges_r( idBrushBSPNode *root, idBrushBSPNode *node );
	void					LedgeSubdivision( idBrushBSP &bsp );
	void					WriteLedgeMap( const idStr &fileName, const idStr &ext );

private:	// merging
	bool					AllGapsLeadToOtherNode( idBrushBSPNode *nodeWithGaps, idBrushBSPNode *otherNode );
	bool					MergeWithAdjacentLeafNodes( idBrushBSP &bsp, idBrushBSPNode *node );
	void					MergeLeafNodes_r( idBrushBSP &bsp, idBrushBSPNode *node );
	void					MergeLeafNodes( idBrushBSP &bsp );

private:	// storing file
	void					SetupHash( void );
	void					ShutdownHash( void );
	void					ClearHash( const idBounds &bounds );
	int						HashVec( const idVec3 &vec );
	bool					GetVertex( const idVec3 &v, int *vertexNum );
	bool					GetEdge( const idVec3 &v1, const idVec3 &v2, int *edgeNum, int v1num );
	bool					GetFaceForPortal( idBrushBSPPortal *portal, int side, int *faceNum );
	bool					GetAreaForLeafNode( idBrushBSPNode *node, int *areaNum );
	int						StoreTree_r( idBrushBSPNode *node );
	void					GetSizeEstimate_r( idBrushBSPNode *parent, idBrushBSPNode *node, struct sizeEstimate_s &size );
	void					SetSizeEstimate( const idBrushBSP &bsp, idAASCompilerFile *file );
	bool					StoreFile( const idBrushBSP &bsp );

};

#endif /* !__AASBUILD_LOCAL_H__ */
