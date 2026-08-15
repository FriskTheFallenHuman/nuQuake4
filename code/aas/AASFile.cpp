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

#if defined( Q4_AAS_LEGACY_SEED )
#include "AASFile_legacy.inc"
#else

/*
===========================================================================

Quake 4 source reconstruction

The SDK exposes these methods through idAASFile but does not include their
engine implementation.  The matching PDB supplies the class layout and method
signatures; the retail Hex-Rays listing supplies the non-trivial behavior.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "AASFile.h"
#include "AASFile_local.h"

idAASFileLocal AASFileLocal;
idAASFile *AASFile = &AASFileLocal;

static bool Reachability_Write( idFile *file, const idReachability *reach ) {
	file->WriteFloatString( "\t\t%d %d (%f %f %f) (%f %f %f) %d %d",
		reach->travelType, reach->toAreaNum,
		reach->start.x, reach->start.y, reach->start.z,
		reach->end.x, reach->end.y, reach->end.z,
		reach->edgeNum, reach->travelTime );
	return true;
}

static bool Reachability_Read( Lexer &src, idReachability &reach ) {
	reach.travelType = src.ParseInt();
	reach.toAreaNum = src.ParseInt();
	if ( !src.Parse1DMatrix( 3, reach.start.ToFloatPtr() ) ||
		 !src.Parse1DMatrix( 3, reach.end.ToFloatPtr() ) ) {
		return false;
	}
	reach.edgeNum = src.ParseInt();
	reach.travelTime = src.ParseInt();
	return true;
}

static bool Reachability_Special_Write( idFile *file, const idReachability_Special *reach ) {
	file->WriteFloatString( "\n\t\t{\n" );
	for ( int i = 0; i < reach->dict.GetNumKeyVals(); i++ ) {
		const idKeyValue *kv = reach->dict.GetKeyVal( i );
		file->WriteFloatString( "\t\t\t\"%s\" \"%s\"\n", kv->GetKey().c_str(), kv->GetValue().c_str() );
	}
	file->WriteFloatString( "\t\t}" );
	return true;
}

static bool Reachability_Special_Read( Lexer &src, idReachability_Special &reach ) {
	idToken key;
	idToken value;
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	while ( src.ReadToken( &key ) ) {
		if ( key == "}" ) {
			return true;
		}
		if ( !src.ExpectTokenType( TT_STRING, 0, &value ) ) {
			return false;
		}
		reach.dict.Set( key, value );
	}
	return false;
}

void idReachability::CopyBase( idReachability &reach ) {
	travelType = reach.travelType;
	toAreaNum = reach.toAreaNum;
	start = reach.start;
	end = reach.end;
	edgeNum = reach.edgeNum;
	travelTime = reach.travelTime;
}

idAASSettings::idAASSettings() {
	numBoundingBoxes = 1;
	boundingBoxes[0] = idBounds( idVec3( -16, -16, 0 ), idVec3( 16, 16, 72 ) );
	usePatches = writeBrushMap = playerFlood = noOptimize = false;
	allowSwimReachabilities = allowFlyReachabilities = false;
	generateTacticalFeatures = false;
	iAASOnly = 0;
	fileExtension = "aas48";
	gravity.Set( 0, 0, -1066 );
	gravityDir = gravity;
	gravityValue = gravityDir.Normalize();
	invGravityDir = -gravityDir;
	maxStepHeight = 14.0f;
	maxBarrierHeight = 32.0f;
	maxWaterJumpHeight = 20.0f;
	maxFallHeight = 64.0f;
	minFloorCos = 0.7f;
	tt_barrierJump = tt_startCrouching = tt_waterJump = tt_startWalkOffLedge = 100;
	debugColor.Set( 1, 0, 0, 1 );
	debugDraw = true;
}

bool idAASSettings::WriteToFile( idFile *file ) const {
	file->WriteFloatString( "{\n" );
	file->WriteFloatString( "\tbboxes\n\t{\n" );
	for ( int i = 0; i < numBoundingBoxes; i++ ) {
		file->WriteFloatString( "\t\t(%f %f %f)-(%f %f %f)\n",
			boundingBoxes[i][0].x, boundingBoxes[i][0].y, boundingBoxes[i][0].z,
			boundingBoxes[i][1].x, boundingBoxes[i][1].y, boundingBoxes[i][1].z );
	}
	file->WriteFloatString( "\t}\n" );
	file->WriteFloatString( "\tusePatches = %d\n", usePatches );
	file->WriteFloatString( "\twriteBrushMap = %d\n", writeBrushMap );
	file->WriteFloatString( "\tplayerFlood = %d\n", playerFlood );
	file->WriteFloatString( "\tallowSwimReachabilities = %d\n", allowSwimReachabilities );
	file->WriteFloatString( "\tallowFlyReachabilities = %d\n", allowFlyReachabilities );
	file->WriteFloatString( "\tgenerateTacticalFeatures = %d\n", generateTacticalFeatures );
	file->WriteFloatString( "\tfileExtension = \"%s\"\n", fileExtension.c_str() );
	file->WriteFloatString( "\tgravity = (%f %f %f)\n", gravity.x, gravity.y, gravity.z );
	file->WriteFloatString( "\tmaxStepHeight = %f\n", maxStepHeight );
	file->WriteFloatString( "\tmaxBarrierHeight = %f\n", maxBarrierHeight );
	file->WriteFloatString( "\tmaxWaterJumpHeight = %f\n", maxWaterJumpHeight );
	file->WriteFloatString( "\tmaxFallHeight = %f\n", maxFallHeight );
	file->WriteFloatString( "\tminFloorCos = %f\n", minFloorCos );
	file->WriteFloatString( "\ttt_barrierJump = %d\n", tt_barrierJump );
	file->WriteFloatString( "\ttt_startCrouching = %d\n", tt_startCrouching );
	file->WriteFloatString( "\ttt_waterJump = %d\n", tt_waterJump );
	file->WriteFloatString( "\ttt_startWalkOffLedge = %d\n", tt_startWalkOffLedge );
	file->WriteFloatString( "}\n" );
	return true;
}

bool idAASSettings::ParseBool( Lexer &src, bool &value ) {
	if ( !src.ExpectTokenString( "=" ) ) return false;
	value = src.ParseBool();
	return true;
}

bool idAASSettings::ParseInt( Lexer &src, int &value ) {
	if ( !src.ExpectTokenString( "=" ) ) return false;
	value = src.ParseInt();
	return true;
}

bool idAASSettings::ParseFloat( Lexer &src, float &value ) {
	if ( !src.ExpectTokenString( "=" ) ) return false;
	value = src.ParseFloat();
	return true;
}

bool idAASSettings::ParseVector( Lexer &src, idVec3 &value ) {
	return src.ExpectTokenString( "=" ) && src.Parse1DMatrix( 3, value.ToFloatPtr() );
}

bool idAASSettings::ParseBBoxes( Lexer &src ) {
	idToken token;
	numBoundingBoxes = 0;
	if ( !src.ExpectTokenString( "{" ) ) return false;
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) return numBoundingBoxes > 0;
		if ( numBoundingBoxes >= MAX_AAS_BOUNDING_BOXES ) {
			src.Error( "more than %d AAS bounding boxes", MAX_AAS_BOUNDING_BOXES );
			return false;
		}
		src.UnreadToken( &token );
		idBounds bounds;
		if ( !src.Parse1DMatrix( 3, bounds[0].ToFloatPtr() ) ||
			 !src.ExpectTokenString( "-" ) ||
			 !src.Parse1DMatrix( 3, bounds[1].ToFloatPtr() ) ) return false;
		boundingBoxes[numBoundingBoxes++] = bounds;
	}
	return false;
}

bool idAASSettings::FromParser( Lexer &src ) {
	idToken token;
	if ( !src.ExpectTokenString( "{" ) ) return false;
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) return numBoundingBoxes > 0;
		if ( token == "bboxes" ) { if ( !ParseBBoxes( src ) ) return false; }
		else if ( token == "usePatches" ) { if ( !ParseBool( src, usePatches ) ) return false; }
		else if ( token == "writeBrushMap" ) { if ( !ParseBool( src, writeBrushMap ) ) return false; }
		else if ( token == "playerFlood" ) { if ( !ParseBool( src, playerFlood ) ) return false; }
		else if ( token == "noOptimize" ) { if ( !ParseBool( src, noOptimize ) ) return false; }
		else if ( token == "allowSwimReachabilities" ) { if ( !ParseBool( src, allowSwimReachabilities ) ) return false; }
		else if ( token == "allowFlyReachabilities" ) { if ( !ParseBool( src, allowFlyReachabilities ) ) return false; }
		else if ( token == "generateTacticalFeatures" ) { if ( !ParseBool( src, generateTacticalFeatures ) ) return false; }
		else if ( token == "iAASOnly" ) { if ( !ParseInt( src, iAASOnly ) ) return false; }
		else if ( token == "fileExtension" ) { if ( !src.ExpectTokenString( "=" ) || !src.ReadToken( &token ) ) return false; fileExtension = token; }
		else if ( token == "gravity" ) { if ( !ParseVector( src, gravity ) ) return false; gravityDir = gravity; gravityValue = gravityDir.Normalize(); invGravityDir = -gravityDir; }
		else if ( token == "maxStepHeight" ) { if ( !ParseFloat( src, maxStepHeight ) ) return false; }
		else if ( token == "maxBarrierHeight" ) { if ( !ParseFloat( src, maxBarrierHeight ) ) return false; }
		else if ( token == "maxWaterJumpHeight" ) { if ( !ParseFloat( src, maxWaterJumpHeight ) ) return false; }
		else if ( token == "maxFallHeight" ) { if ( !ParseFloat( src, maxFallHeight ) ) return false; }
		else if ( token == "minFloorCos" ) { if ( !ParseFloat( src, minFloorCos ) ) return false; }
		else if ( token == "tt_barrierJump" ) { if ( !ParseInt( src, tt_barrierJump ) ) return false; }
		else if ( token == "tt_startCrouching" ) { if ( !ParseInt( src, tt_startCrouching ) ) return false; }
		else if ( token == "tt_waterJump" ) { if ( !ParseInt( src, tt_waterJump ) ) return false; }
		else if ( token == "tt_startWalkOffLedge" ) { if ( !ParseInt( src, tt_startWalkOffLedge ) ) return false; }
		else if ( token == "debugDraw" ) { if ( !ParseBool( src, debugDraw ) ) return false; }
		else if ( token == "debugColor" ) { idVec3 rgb; if ( !ParseVector( src, rgb ) ) return false; debugColor.Set( rgb.x, rgb.y, rgb.z, 1 ); }
		else src.Warning( "unknown AAS setting '%s'", token.c_str() );
	}
	return false;
}

idAASFileLocal::idAASFileLocal() {
	planeList.SetGranularity( 4096 );
	vertices.SetGranularity( 4096 );
	edges.SetGranularity( 4096 );
	edgeIndex.SetGranularity( 4096 );
	faces.SetGranularity( 1024 );
	faceIndex.SetGranularity( 4096 );
	areas.SetGranularity( 1024 );
	nodes.SetGranularity( 1024 );
	portals.SetGranularity( 1024 );
	portalIndex.SetGranularity( 4096 );
	clusters.SetGranularity( 1024 );
	featureIndex.SetGranularity( 4096 );
	features.SetGranularity( 1024 );
	crc = 0;
	memset( isDummy, 0, sizeof( isDummy ) );
}

idAASFileLocal::~idAASFileLocal() {
	DeleteReachabilities();
}

void idAASFileLocal::Init() {
	aasEdge_t edge;
	aasFace_t face;
	aasArea_t area;
	aasNode_t node;
	memset( &edge, 0, sizeof( edge ) );
	memset( &face, 0, sizeof( face ) );
	memset( &area, 0, sizeof( area ) );
	memset( &node, 0, sizeof( node ) );
	edges.Append( edge );
	faces.Append( face );
	areas.Append( area );
	nodes.Append( node );
}

void idAASFileLocal::SetSizes( sizeEstimate_t size ) {
	planeList.Resize( size.numNodes / 2, 1024 );
	vertices.Resize( size.numEdgeIndexes / 3, 1024 );
	edges.Resize( size.numEdgeIndexes / 2, 1024 );
	edgeIndex.Resize( size.numEdgeIndexes, 4096 );
	faces.Resize( size.numFaceIndexes, 1024 );
	faceIndex.Resize( size.numFaceIndexes, 4096 );
	areas.Resize( size.numAreas, 1024 );
	nodes.Resize( size.numNodes, 1024 );
	featureIndex.Resize( 2048, 2048 );
	features.Resize( 2048, 2048 );
}

bool idAASFileLocal::ParseIndex( Lexer &src, idList<aasIndex_t> &indexes, int dummyIndex ) {
	const int count = src.ParseInt();
	indexes.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	for ( int i = 0; i < count; i++ ) {
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) {
			return false;
		}
		const aasIndex_t index = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) {
			return false;
		}
		indexes.Append( index );
	}
	if ( !src.ExpectTokenString( "}" ) ) {
		return false;
	}
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) {
		isDummy[dummyIndex] = true;
	}
	return true;
}

bool idAASFileLocal::ParsePlanes( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	planeList.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	for ( int i = 0; i < count; i++ ) {
		idVec4 value;
		src.ParseInt();
		if ( !src.Parse1DMatrix( 4, value.ToFloatPtr() ) ) {
			return false;
		}
		idPlane plane;
		plane.SetNormal( value.ToVec3() );
		plane.SetDist( value.w );
		planeList.Append( plane );
	}
	if ( !src.ExpectTokenString( "}" ) ) {
		return false;
	}
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) {
		isDummy[dummyIndex] = true;
	}
	return true;
}

bool idAASFileLocal::ParseVertices( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	vertices.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	for ( int i = 0; i < count; i++ ) {
		aasVertex_t vertex;
		src.ParseInt();
		if ( !src.Parse1DMatrix( 3, vertex.ToFloatPtr() ) ) {
			return false;
		}
		vertices.Append( vertex );
	}
	if ( !src.ExpectTokenString( "}" ) ) {
		return false;
	}
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) {
		isDummy[dummyIndex] = true;
	}
	return true;
}

bool idAASFileLocal::ParseEdges( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	edges.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	for ( int i = 0; i < count; i++ ) {
		aasEdge_t edge;
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		edge.vertexNum[0] = src.ParseInt();
		edge.vertexNum[1] = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		edges.Append( edge );
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	return true;
}

bool idAASFileLocal::ParseFaces( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	faces.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasFace_t face;
		memset( &face, 0, sizeof( face ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		face.planeNum = src.ParseInt();
		face.flags = src.ParseInt();
		face.areas[0] = src.ParseInt();
		face.areas[1] = src.ParseInt();
		face.firstEdge = src.ParseInt();
		face.numEdges = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		faces.Append( face );
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	return true;
}

bool idAASFileLocal::ParseReachabilities( Lexer &src, int areaNum ) {
	aasArea_t &area = areas[areaNum];
	const int count = src.ParseInt();
	if ( !src.ExpectTokenString( "{" ) ) return false;
	area.reach = NULL;
	area.rev_reach = NULL;
	area.travelFlags = AreaContentsTravelFlags( areaNum );
	for ( int i = 0; i < count; i++ ) {
		idReachability base;
		memset( &base, 0, sizeof( base ) );
		if ( !Reachability_Read( src, base ) ) return false;
		idReachability *reach;
		if ( base.travelType == TFL_SPECIAL ) {
			idReachability_Special *special = new idReachability_Special;
			if ( !Reachability_Special_Read( src, *special ) ) {
				delete special;
				return false;
			}
			reach = special;
		} else {
			reach = new idReachability;
		}
		memset( static_cast<void *>( reach ), 0, sizeof( idReachability ) );
		reach->CopyBase( base );
		reach->fromAreaNum = areaNum;
		reach->next = area.reach;
		area.reach = reach;
	}
	return src.ExpectTokenString( "}" ) != 0;
}

bool idAASFileLocal::ParseAreas( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	areas.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasArea_t area;
		memset( &area, 0, sizeof( area ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		area.flags = src.ParseInt();
		area.contents = src.ParseInt();
		area.firstFace = src.ParseInt();
		area.numFaces = src.ParseInt();
		area.cluster = src.ParseInt();
		area.clusterAreaNum = src.ParseInt();
		if ( version != "1.07" ) {
			area.numFeatures = src.ParseInt();
			area.firstFeature = src.ParseInt();
		}
		if ( !src.ExpectTokenString( ")" ) ) return false;
		areas.Append( area );
		if ( !ParseReachabilities( src, i ) ) return false;
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	LinkReversedReachability();
	return true;
}

bool idAASFileLocal::ParseNodes( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	nodes.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasNode_t node;
		memset( &node, 0, sizeof( node ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		node.planeNum = src.ParseInt();
		node.children[0] = src.ParseInt();
		node.children[1] = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		nodes.Append( node );
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	return true;
}

bool idAASFileLocal::ParsePortals( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	portals.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasPortal_t portal;
		memset( &portal, 0, sizeof( portal ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		portal.areaNum = src.ParseInt();
		portal.clusters[0] = src.ParseInt();
		portal.clusters[1] = src.ParseInt();
		portal.clusterAreaNum[0] = src.ParseInt();
		portal.clusterAreaNum[1] = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		portals.Append( portal );
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	return true;
}

bool idAASFileLocal::ParseClusters( Lexer &src, int dummyIndex ) {
	const int count = src.ParseInt();
	clusters.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasCluster_t cluster;
		memset( &cluster, 0, sizeof( cluster ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		cluster.numAreas = src.ParseInt();
		cluster.numReachableAreas = src.ParseInt();
		cluster.firstPortal = src.ParseInt();
		cluster.numPortals = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		clusters.Append( cluster );
	}
	if ( !src.ExpectTokenString( "}" ) ) return false;
	if ( count == 0 && dummyIndex >= 0 && dummyIndex < 11 ) isDummy[dummyIndex] = true;
	return true;
}

bool idAASFileLocal::ParseFeatures( Lexer &src ) {
	const int count = src.ParseInt();
	features.Resize( count );
	if ( !src.ExpectTokenString( "{" ) ) return false;
	for ( int i = 0; i < count; i++ ) {
		aasFeature_t feature;
		memset( &feature, 0, sizeof( feature ) );
		src.ParseInt();
		if ( !src.ExpectTokenString( "(" ) ) return false;
		feature.flags = src.ParseInt();
		feature.height = src.ParseInt();
		feature.normalx = src.ParseInt();
		feature.normaly = src.ParseInt();
		feature.x = src.ParseInt();
		feature.y = src.ParseInt();
		feature.z = src.ParseInt();
		if ( !src.ExpectTokenString( ")" ) ) return false;
		features.Append( feature );
	}
	return src.ExpectTokenString( "}" ) != 0;
}

bool idAASFileLocal::Load( const idStr &fileName, unsigned int mapFileCRC ) {
	Lexer src( LEXFL_NOFATALERRORS | LEXFL_NOSTRINGESCAPECHARS |
		LEXFL_NOSTRINGCONCAT | LEXFL_ALLOWPATHNAMES );
	idToken token;
	name = fileName;
	crc = mapFileCRC;
	common->Printf( "[Load AAS]\nloading %s\n", name.c_str() );
	if ( !src.LoadFile( name.c_str() ) ) {
		return false;
	}
	if ( !src.ExpectTokenString( AAS_FILEID ) ) {
		common->Warning( "Not an AAS file: '%s'", name.c_str() );
		return false;
	}
	if ( !src.ReadToken( &token ) ) {
		return false;
	}
	version = token;
	if ( version != AAS_FILEVERSION && version != "1.07" ) {
		common->Warning( "AAS file '%s' has version %s instead of %s", name.c_str(), version.c_str(), AAS_FILEVERSION );
	}
	if ( !src.ExpectTokenType( TT_NUMBER, TT_INTEGER, &token ) ) {
		common->Warning( "AAS file '%s' has no map file CRC", name.c_str() );
		return false;
	}
	const unsigned int fileCRC = token.GetUnsignedLongValue();
	if ( mapFileCRC && fileCRC != mapFileCRC ) {
		common->Warning( "AAS file '%s' is out of date", name.c_str() );
		return false;
	}
	Clear();
	while ( src.ReadToken( &token ) ) {
		bool parsed = false;
		if ( token == "settings" ) parsed = settings.FromParser( src );
		else if ( token == "planes" ) parsed = ParsePlanes( src, 0 );
		else if ( token == "vertices" ) parsed = ParseVertices( src, 1 );
		else if ( token == "edges" ) parsed = ParseEdges( src, 2 );
		else if ( token == "edgeIndex" ) parsed = ParseIndex( src, edgeIndex, 3 );
		else if ( token == "faces" ) parsed = ParseFaces( src, 4 );
		else if ( token == "faceIndex" ) parsed = ParseIndex( src, faceIndex, 5 );
		else if ( token == "areas" ) parsed = ParseAreas( src, 6 );
		else if ( token == "nodes" ) parsed = ParseNodes( src, 7 );
		else if ( token == "portals" ) parsed = ParsePortals( src, 8 );
		else if ( token == "portalIndex" ) parsed = ParseIndex( src, portalIndex, 9 );
		else if ( token == "clusters" ) parsed = ParseClusters( src, 10 );
		else if ( token == "featureIndex" ) parsed = ParseIndex( src, featureIndex, 11 );
		else if ( token == "features" ) parsed = ParseFeatures( src );
		else {
			src.Error( "idAASFileLocal::Load: bad token \"%s\"", token.c_str() );
			return false;
		}
		if ( !parsed ) {
			return false;
		}
	}
	FinishAreas();
	if ( !IsDummyFile( mapFileCRC ) ) {
		if ( !vertices.Num() || !edges.Num() || !faces.Num() ) {
			common->Warning( "error loading %s (invalid data)", fileName.c_str() );
			return false;
		}
		const int depth = MaxTreeDepth();
		if ( depth > MAX_AAS_TREE_DEPTH ) {
			common->Warning( "idAASFileLocal::Load: tree depth = %d", depth );
		}
		common->Printf( "done loading %s (size %d).\n", fileName.c_str(), MemorySize() );
	}
	return !src.HadError();
}

bool idAASFileLocal::Write( const idStr &fileName, unsigned int mapFileCRC ) {
	common->Printf( "[Write AAS]\nwriting %s\n", fileName.c_str() );
	name = fileName;
	crc = mapFileCRC;
	idFile *file = fileSystem->OpenFileWrite( fileName, "fs_devpath" );
	if ( !file ) {
		common->Warning( "Error opening %s", fileName.c_str() );
		return false;
	}
	file->WriteFloatString( "%s \"%s\"\n\n%u\n\n", AAS_FILEID, AAS_FILEVERSION, mapFileCRC );
	file->WriteFloatString( "settings\n" );
	settings.WriteToFile( file );
	file->WriteFloatString( "planes %d {\n", planeList.Num() );
	for ( int i = 0; i < planeList.Num(); i++ ) file->WriteFloatString( "\t%d ( %f %f %f %f )\n", i, planeList[i].Normal().x, planeList[i].Normal().y, planeList[i].Normal().z, planeList[i].Dist() );
	file->WriteFloatString( "}\nvertices %d {\n", vertices.Num() );
	for ( int i = 0; i < vertices.Num(); i++ ) file->WriteFloatString( "\t%d ( %f %f %f )\n", i, vertices[i].x, vertices[i].y, vertices[i].z );
	file->WriteFloatString( "}\nedges %d {\n", edges.Num() );
	for ( int i = 0; i < edges.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d )\n", i, edges[i].vertexNum[0], edges[i].vertexNum[1] );
	file->WriteFloatString( "}\nedgeIndex %d {\n", edgeIndex.Num() );
	for ( int i = 0; i < edgeIndex.Num(); i++ ) file->WriteFloatString( "\t%d ( %d )\n", i, edgeIndex[i] );
	file->WriteFloatString( "}\nfaces %d {\n", faces.Num() );
	for ( int i = 0; i < faces.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d %d %d %d %d )\n", i, faces[i].planeNum, faces[i].flags, faces[i].areas[0], faces[i].areas[1], faces[i].firstEdge, faces[i].numEdges );
	file->WriteFloatString( "}\nfaceIndex %d {\n", faceIndex.Num() );
	for ( int i = 0; i < faceIndex.Num(); i++ ) file->WriteFloatString( "\t%d ( %d )\n", i, faceIndex[i] );
	file->WriteFloatString( "}\nareas %d {\n", areas.Num() );
	for ( int i = 0; i < areas.Num(); i++ ) {
		int reachCount = 0;
		for ( idReachability *reach = areas[i].reach; reach; reach = reach->next ) reachCount++;
		file->WriteFloatString( "\t%d ( %d %d %d %d %d %d %d %d ) %d {\n", i, areas[i].flags, areas[i].contents, areas[i].firstFace, areas[i].numFaces, areas[i].cluster, areas[i].clusterAreaNum, areas[i].numFeatures, areas[i].firstFeature, reachCount );
		for ( idReachability *reach = areas[i].reach; reach; reach = reach->next ) {
			Reachability_Write( file, reach );
			if ( reach->travelType == TFL_SPECIAL ) Reachability_Special_Write( file, static_cast<idReachability_Special *>( reach ) );
			file->WriteFloatString( "\n" );
		}
		file->WriteFloatString( "\t}\n" );
	}
	file->WriteFloatString( "}\nnodes %d {\n", nodes.Num() );
	for ( int i = 0; i < nodes.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d %d )\n", i, nodes[i].planeNum, nodes[i].children[0], nodes[i].children[1] );
	file->WriteFloatString( "}\nportals %d {\n", portals.Num() );
	for ( int i = 0; i < portals.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d %d %d %d )\n", i, portals[i].areaNum, portals[i].clusters[0], portals[i].clusters[1], portals[i].clusterAreaNum[0], portals[i].clusterAreaNum[1] );
	file->WriteFloatString( "}\nportalIndex %d {\n", portalIndex.Num() );
	for ( int i = 0; i < portalIndex.Num(); i++ ) file->WriteFloatString( "\t%d ( %d )\n", i, portalIndex[i] );
	file->WriteFloatString( "}\nclusters %d {\n", clusters.Num() );
	for ( int i = 0; i < clusters.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d %d %d )\n", i, clusters[i].numAreas, clusters[i].numReachableAreas, clusters[i].firstPortal, clusters[i].numPortals );
	file->WriteFloatString( "}\n" );
	if ( features.Num() ) {
		file->WriteFloatString( "featureIndex %d {\n", featureIndex.Num() );
		for ( int i = 0; i < featureIndex.Num(); i++ ) file->WriteFloatString( "\t%d ( %d )\n", i, featureIndex[i] );
		file->WriteFloatString( "}\nfeatures %d {\n", features.Num() );
		for ( int i = 0; i < features.Num(); i++ ) file->WriteFloatString( "\t%d ( %d %d %d %d %d %d %d )\n", i, features[i].flags, features[i].height, features[i].normalx, features[i].normaly, features[i].x, features[i].y, features[i].z );
		file->WriteFloatString( "}\n" );
	}
	fileSystem->CloseFile( file );
	common->Printf( "done.\n" );
	return true;
}

int idAASFileLocal::MemorySize() const {
	return planeList.Size() + vertices.Size() + edges.Size() + edgeIndex.Size() +
		faces.Size() + faceIndex.Size() + areas.Size() + nodes.Size() + portals.Size() +
		portalIndex.Size() + clusters.Size() + featureIndex.Size() + features.Size() +
		sizeof( idReachability_Walk ) * NumReachabilities();
}

idAASFile *idAASFileLocal::CreateNew( void ) {
	return new idAASFileLocal;
}

idAASSettings *idAASFileLocal::CreateAASSettings( void ) {
	return new idAASSettings;
}

idReachability *idAASFileLocal::CreateReachability( int type ) {
	switch ( type ) {
		case RE_WALK:			return new idReachability_Walk;
		case RE_WALKOFFLEDGE:	return new idReachability_WalkOffLedge;
		case RE_FLY:			return new idReachability_Fly;
		case RE_SWIM:			return new idReachability_Swim;
		case RE_WATERJUMP:		return new idReachability_WaterJump;
		case RE_BARRIERJUMP:	return new idReachability_BarrierJump;
		case RE_SPECIAL:			return new idReachability_Special;
		default:					return NULL;
	}
}

bool idAASFileLocal::FromParser( idAASSettings *edit, Lexer &src ) {
	return edit->FromParser( src );
}

const char *idAASFileLocal::GetName( void ) const {
	return name.c_str();
}

unsigned int idAASFileLocal::GetCRC( void ) const {
	return crc;
}

int idAASFileLocal::GetNumPlanes( void ) const { return planeList.Num(); }
idPlane &idAASFileLocal::GetPlane( int index ) { return planeList[index]; }
int idAASFileLocal::FindPlane( const idPlane &plane, const float normalEps, const float distEps ) { return planeList.FindPlane( plane, normalEps, distEps ); }

int idAASFileLocal::GetNumVertices( void ) const { return vertices.Num(); }
aasVertex_t &idAASFileLocal::GetVertex( int index ) { return vertices[index]; }
int idAASFileLocal::AppendVertex( aasVertex_t &vertex ) { return vertices.Append( vertex ); }

int idAASFileLocal::GetNumEdges( void ) const { return edges.Num(); }
aasEdge_t &idAASFileLocal::GetEdge( int index ) { return edges[index]; }
int idAASFileLocal::AppendEdge( aasEdge_t &edge ) { return edges.Append( edge ); }

int idAASFileLocal::GetNumEdgeIndexes( void ) const { return edgeIndex.Num(); }
aasIndex_t &idAASFileLocal::GetEdgeIndex( int index ) { return edgeIndex[index]; }
int idAASFileLocal::AppendEdgeIndex( aasIndex_t &index ) { return edgeIndex.Append( index ); }

int idAASFileLocal::GetNumFaces( void ) const { return faces.Num(); }
aasFace_t &idAASFileLocal::GetFace( int index ) { return faces[index]; }
int idAASFileLocal::AppendFace( aasFace_t &face ) { return faces.Append( face ); }

int idAASFileLocal::GetNumFaceIndexes( void ) const { return faceIndex.Num(); }
aasIndex_t &idAASFileLocal::GetFaceIndex( int index ) { return faceIndex[index]; }
int idAASFileLocal::AppendFaceIndex( aasIndex_t &index ) { return faceIndex.Append( index ); }

int idAASFileLocal::GetNumAreas( void ) const { return areas.Num(); }
aasArea_t &idAASFileLocal::GetArea( int index ) { return areas[index]; }
int idAASFileLocal::AppendArea( aasArea_t &area ) { return areas.Append( area ); }

int idAASFileLocal::GetNumNodes( void ) const { return nodes.Num(); }
aasNode_t &idAASFileLocal::GetNode( int index ) { return nodes[index]; }
int idAASFileLocal::AppendNode( aasNode_t &node ) { return nodes.Append( node ); }
void idAASFileLocal::SetNumNodes( int num ) { nodes.SetNum( num ); }

int idAASFileLocal::GetNumPortals( void ) const { return portals.Num(); }
aasPortal_t &idAASFileLocal::GetPortal( int index ) { return portals[index]; }
int idAASFileLocal::AppendPortal( aasPortal_t &portal ) { return portals.Append( portal ); }

int idAASFileLocal::GetNumPortalIndexes( void ) const { return portalIndex.Num(); }
aasIndex_t &idAASFileLocal::GetPortalIndex( int index ) { return portalIndex[index]; }
int idAASFileLocal::AppendPortalIndex( aasIndex_t &index, int clusterNum ) {
	clusters[clusterNum].numPortals++;
	return portalIndex.Append( index );
}

int idAASFileLocal::GetNumClusters( void ) const { return clusters.Num(); }
aasCluster_t &idAASFileLocal::GetCluster( int index ) { return clusters[index]; }
int idAASFileLocal::AppendCluster( aasCluster_t &cluster ) { return clusters.Append( cluster ); }

void idAASFileLocal::ClearTactical( void ) {
	featureIndex.Clear();
	features.Clear();
}

int idAASFileLocal::GetNumFeatureIndexes( void ) const { return featureIndex.Num(); }
aasIndex_t &idAASFileLocal::GetFeatureIndex( int index ) { return featureIndex[index]; }
int idAASFileLocal::AppendFeatureIndex( aasIndex_t &index ) { return featureIndex.Append( index ); }

int idAASFileLocal::GetNumFeatures( void ) const { return features.Num(); }
aasFeature_t &idAASFileLocal::GetFeature( int index ) { return features[index]; }
int idAASFileLocal::AppendFeature( aasFeature_t &feature ) { return features.Append( feature ); }

idAASSettings &idAASFileLocal::GetSettings( void ) { return settings; }
void idAASFileLocal::SetSettings( const idAASSettings &in ) { settings = in; }

void idAASFileLocal::SetPortalMaxTravelTime( int index, int time ) { portals[index].maxAreaTravelTime = time; }
void idAASFileLocal::SetAreaTravelFlag( int index, int flag ) { areas[index].travelFlags |= flag; }
void idAASFileLocal::RemoveAreaTravelFlag( int index, int flag ) { areas[index].travelFlags &= ~flag; }

size_t idAASFileLocal::GetMemorySize( void ) {
	int numReachableAreas = 0;
	int routingMemory = 0;
	for ( int i = 0; i < clusters.Num(); i++ ) {
		numReachableAreas += clusters[i].numReachableAreas;
		routingMemory += Square( clusters[i].numReachableAreas );
	}
	return MemorySize() + routingMemory + 3 * numReachableAreas * portals.Num();
}

bool idAASFileLocal::IsDummyFile( unsigned int mapFileCRC ) {
	for ( int i = 0; i < 11; i++ ) {
		if ( !isDummy[i] ) {
			return false;
		}
	}
	return crc == mapFileCRC;
}

const idDict &idAASFileLocal::GetReachabilitySpecialDict( idReachability *reach ) const {
	return static_cast<idReachability_Special *>( reach )->dict;
}

void idAASFileLocal::SetReachabilitySpecialDictKeyValue( idReachability *reach, const char *key, const char *value ) {
	static_cast<idReachability_Special *>( reach )->dict.Set( key, value );
}

void idAASFileLocal::Clear() {
	DeleteReachabilities();
	planeList.Clear();
	vertices.Clear();
	edges.Clear();
	edgeIndex.Clear();
	faces.Clear();
	faceIndex.Clear();
	areas.Clear();
	nodes.Clear();
	portals.Clear();
	portalIndex.Clear();
	clusters.Clear();
	ClearTactical();
	memset( isDummy, 0, sizeof( isDummy ) );
}

void idAASFileLocal::LinkReversedReachability() {
	for ( int i = 0; i < areas.Num(); i++ ) {
		areas[i].rev_reach = NULL;
	}
	for ( int i = 0; i < areas.Num(); i++ ) {
		for ( idReachability *reach = areas[i].reach; reach; reach = reach->next ) {
			if ( reach->toAreaNum <= 0 || reach->toAreaNum >= areas.Num() ) {
				continue;
			}
			reach->rev_next = areas[reach->toAreaNum].rev_reach;
			areas[reach->toAreaNum].rev_reach = reach;
		}
	}
}

void idAASFileLocal::FinishAreas() {
	// Quake 4 stores the usable ceiling height in every AAS area.  The Doom 3
	// baseline only calculated center and bounds, which leaves the Raven field
	// uninitialized and breaks tactical cover queries in the game DLL.
	if ( areas.Num() < 2 ) {
		for ( int i = 0; i < areas.Num(); i++ ) {
			areas[i].center.Zero();
			areas[i].bounds.Clear();
			areas[i].ceiling = 0.0f;
		}
		return;
	}

	for ( int i = 0; i < areas.Num(); i++ ) {
		areas[i].center = AreaReachableGoal( i );
		areas[i].bounds = AreaBounds( i );
	}

	for ( int i = 0; i < areas.Num(); i++ ) {
		if ( areas[i].flags & AREA_FLOOR ) {
			int traceAreas[10];
			idVec3 tracePoints[10];
			aasTrace_t trace;
			trace.maxAreas = 10;
			trace.areas = traceAreas;
			trace.points = tracePoints;

			idVec3 end = areas[i].center;
			end.z += 500.0f;
			Trace( trace, areas[i].center, end );

			areas[i].ceiling = trace.endpos.z;
			for ( int j = 0; j < trace.numAreas; j++ ) {
				if ( traceAreas[j] != i ) {
					areas[i].ceiling = tracePoints[j].z;
				}
			}
		} else {
			idVec3 point( 0.0f, 0.0f, 131072.0f );
			PushPointIntoAreaNum( i, point );
			areas[i].ceiling = point.z;
		}
	}
}

int idAASFileLocal::NumReachabilities() const {
	int count = 0;
	for ( int i = 0; i < areas.Num(); i++ ) {
		for ( const idReachability *reach = areas[i].reach; reach; reach = reach->next ) {
			count++;
		}
	}
	return count;
}

void idAASFileLocal::PrintInfo() const {
	common->Printf( "%6d KB file size\n", MemorySize() >> 10 );
	common->Printf( "%6d areas\n", areas.Num() );
	common->Printf( "%6d max tree depth\n", MaxTreeDepth() );
	ReportRoutingEfficiency();
}

void idAASFileLocal::ReportRoutingEfficiency() const {
	int reachableAreas = 0;
	int total = 0;
	for ( int i = 0; i < clusters.Num(); i++ ) {
		const int count = clusters[i].numReachableAreas;
		reachableAreas += count;
		total += count * count;
	}
	total += reachableAreas * portals.Num();
	common->Printf( "%6d reachable areas\n", reachableAreas );
	common->Printf( "%6d reachabilities\n", NumReachabilities() );
	common->Printf( "%6d KB max routing cache\n", ( total * 3 ) >> 10 );
}

void idAASFileLocal::DeleteReachabilities() {
	for ( int i = 0; i < areas.Num(); i++ ) {
		idReachability *reach = areas[i].reach;
		while ( reach ) {
			idReachability *next = reach->next;
			delete reach;
			reach = next;
		}
		areas[i].reach = NULL;
		areas[i].rev_reach = NULL;
	}
}

void idAASFileLocal::DeleteClusters() {
	aasPortal_t portal;
	aasCluster_t cluster;
	memset( &portal, 0, sizeof( portal ) );
	memset( &cluster, 0, sizeof( cluster ) );
	portals.Clear();
	portalIndex.Clear();
	clusters.Clear();
	portals.Append( portal );
	clusters.Append( cluster );
}

#endif
