/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

===========================================================================
*/

/*
===============================================================================

	Tools-DLL copy of idAASSettings.

	The retail executable and Toolsx86.dll each contain the settings methods
	they use.  Keep this implementation in the tools target only: it combines
	the Quake 4 PDB/decompiler behavior with the tool-only FromDict and
	ValidEntity routines evidenced by the retail Toolsx86.dll strings.

===============================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "AASFile.h"

#if defined( _M_IX86 )
static_assert( sizeof( idAASSettings ) == 240, "Quake 4 idAASSettings ABI drift" );
#endif

idAASSettings::idAASSettings( void ) {
	numBoundingBoxes = 1;
	boundingBoxes[0] = idBounds( idVec3( -16, -16, 0 ), idVec3( 16, 16, 72 ) );
	usePatches = false;
	writeBrushMap = false;
	playerFlood = false;
	noOptimize = false;
	allowSwimReachabilities = false;
	allowFlyReachabilities = false;
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
	tt_barrierJump = 100;
	tt_startCrouching = 100;
	tt_waterJump = 100;
	tt_startWalkOffLedge = 100;
	debugColor.Set( 1, 0, 0, 1 );
	debugDraw = true;
}

bool idAASSettings::ParseBool( Lexer &src, bool &value ) {
	if ( !src.ExpectTokenString( "=" ) ) {
		return false;
	}
	value = src.ParseBool();
	return true;
}

bool idAASSettings::ParseInt( Lexer &src, int &value ) {
	if ( !src.ExpectTokenString( "=" ) ) {
		return false;
	}
	value = src.ParseInt();
	return true;
}

bool idAASSettings::ParseFloat( Lexer &src, float &value ) {
	if ( !src.ExpectTokenString( "=" ) ) {
		return false;
	}
	value = src.ParseFloat();
	return true;
}

bool idAASSettings::ParseVector( Lexer &src, idVec3 &value ) {
	return src.ExpectTokenString( "=" ) && src.Parse1DMatrix( 3, value.ToFloatPtr() );
}

bool idAASSettings::ParseBBoxes( Lexer &src ) {
	idToken token;
	idBounds bounds;

	numBoundingBoxes = 0;
	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			return numBoundingBoxes > 0;
		}
		if ( numBoundingBoxes >= MAX_AAS_BOUNDING_BOXES ) {
			src.Error( "more than %d AAS bounding boxes", MAX_AAS_BOUNDING_BOXES );
			return false;
		}
		src.UnreadToken( &token );
		if ( !src.Parse1DMatrix( 3, bounds[0].ToFloatPtr() ) ||
			 !src.ExpectTokenString( "-" ) ||
			 !src.Parse1DMatrix( 3, bounds[1].ToFloatPtr() ) ) {
			return false;
		}
		boundingBoxes[numBoundingBoxes++] = bounds;
	}
	return false;
}

bool idAASSettings::FromParser( Lexer &src ) {
	idToken token;

	if ( !src.ExpectTokenString( "{" ) ) {
		return false;
	}
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			break;
		}
		if ( token == "bboxes" ) { if ( !ParseBBoxes( src ) ) return false; }
		else if ( token == "usePatches" ) { if ( !ParseBool( src, usePatches ) ) return false; }
		else if ( token == "writeBrushMap" ) { if ( !ParseBool( src, writeBrushMap ) ) return false; }
		else if ( token == "playerFlood" ) { if ( !ParseBool( src, playerFlood ) ) return false; }
		else if ( token == "allowSwimReachabilities" ) { if ( !ParseBool( src, allowSwimReachabilities ) ) return false; }
		else if ( token == "allowFlyReachabilities" ) { if ( !ParseBool( src, allowFlyReachabilities ) ) return false; }
		else if ( token == "generateTacticalFeatures" ) { if ( !ParseBool( src, generateTacticalFeatures ) ) return false; }
		else if ( token == "fileExtension" ) {
			if ( !src.ExpectTokenString( "=" ) || !src.ExpectTokenType( TT_STRING, 0, &token ) ) return false;
			fileExtension = token;
		}
		else if ( token == "gravity" ) {
			if ( !ParseVector( src, gravity ) ) return false;
			gravityDir = gravity;
			gravityValue = gravityDir.Normalize();
			invGravityDir = -gravityDir;
		}
		else if ( token == "maxStepHeight" ) { if ( !ParseFloat( src, maxStepHeight ) ) return false; }
		else if ( token == "maxBarrierHeight" ) { if ( !ParseFloat( src, maxBarrierHeight ) ) return false; }
		else if ( token == "maxWaterJumpHeight" ) { if ( !ParseFloat( src, maxWaterJumpHeight ) ) return false; }
		else if ( token == "maxFallHeight" ) { if ( !ParseFloat( src, maxFallHeight ) ) return false; }
		else if ( token == "minFloorCos" ) { if ( !ParseFloat( src, minFloorCos ) ) return false; }
		else if ( token == "tt_barrierJump" ) { if ( !ParseInt( src, tt_barrierJump ) ) return false; }
		else if ( token == "tt_startCrouching" ) { if ( !ParseInt( src, tt_startCrouching ) ) return false; }
		else if ( token == "tt_waterJump" ) { if ( !ParseInt( src, tt_waterJump ) ) return false; }
		else if ( token == "tt_startWalkOffLedge" ) { if ( !ParseInt( src, tt_startWalkOffLedge ) ) return false; }
		else {
			src.Error( "invalid token '%s'", token.c_str() );
			return false;
		}
	}

	if ( numBoundingBoxes <= 0 ) {
		src.Error( "no valid bounding box" );
		return false;
	}

	const idDict *aasDef = gameEdit ? gameEdit->FindEntityDefDict( fileExtension, false ) : NULL;
	if ( aasDef ) {
		idVec3 color;
		if ( aasDef->GetVector( "debugColor", "1.0 0.0 0.0", color ) ) {
			debugColor.Set( color.x, color.y, color.z, 1.0f );
		}
		aasDef->GetBool( "debugDraw", "1", debugDraw );
		aasDef->GetBool( "generateTacticalFeatures", "0", generateTacticalFeatures );
	}
	return true;
}

bool idAASSettings::FromFile( const idStr &fileName ) {
	Lexer src( LEXFL_ALLOWPATHNAMES | LEXFL_NOSTRINGESCAPECHARS | LEXFL_NOSTRINGCONCAT );
	common->Printf( "loading %s\n", fileName.c_str() );
	if ( !src.LoadFile( fileName.c_str() ) ) {
		common->Warning( "couldn't load %s", fileName.c_str() );
		return false;
	}
	if ( !src.ExpectTokenString( "settings" ) ) {
		common->Warning( "%s is not a settings file", fileName.c_str() );
		return false;
	}
	return FromParser( src );
}

bool idAASSettings::FromDict( const char *name, const idDict *dict ) {
	idBounds bounds;
	idVec3 color;

	if ( !dict->GetVector( "mins", "0 0 0", bounds[0] ) ) common->Error( "Missing 'mins' in entityDef '%s'", name );
	if ( !dict->GetVector( "maxs", "0 0 0", bounds[1] ) ) common->Error( "Missing 'maxs' in entityDef '%s'", name );
	numBoundingBoxes = 1;
	boundingBoxes[0] = bounds;

	if ( !dict->GetBool( "usePatches", "0", usePatches ) ) common->Error( "Missing 'usePatches' in entityDef '%s'", name );
	if ( !dict->GetBool( "writeBrushMap", "0", writeBrushMap ) ) common->Error( "Missing 'writeBrushMap' in entityDef '%s'", name );
	if ( !dict->GetBool( "playerFlood", "0", playerFlood ) ) common->Error( "Missing 'playerFlood' in entityDef '%s'", name );
	if ( !dict->GetBool( "allowSwimReachabilities", "0", allowSwimReachabilities ) ) common->Error( "Missing 'allowSwimReachabilities' in entityDef '%s'", name );
	if ( !dict->GetBool( "allowFlyReachabilities", "0", allowFlyReachabilities ) ) common->Error( "Missing 'allowFlyReachabilities' in entityDef '%s'", name );
	if ( !dict->GetString( "fileExtension", "", fileExtension ) ) common->Error( "Missing 'fileExtension' in entityDef '%s'", name );
	if ( !dict->GetVector( "gravity", "0 0 -1066", gravity ) ) common->Error( "Missing 'gravity' in entityDef '%s'", name );
	gravityDir = gravity;
	gravityValue = gravityDir.Normalize();
	invGravityDir = -gravityDir;
	if ( !dict->GetFloat( "maxStepHeight", "0", maxStepHeight ) ) common->Error( "Missing 'maxStepHeight' in entityDef '%s'", name );
	if ( !dict->GetFloat( "maxBarrierHeight", "0", maxBarrierHeight ) ) common->Error( "Missing 'maxBarrierHeight' in entityDef '%s'", name );
	if ( !dict->GetFloat( "maxWaterJumpHeight", "0", maxWaterJumpHeight ) ) common->Error( "Missing 'maxWaterJumpHeight' in entityDef '%s'", name );
	if ( !dict->GetFloat( "maxFallHeight", "0", maxFallHeight ) ) common->Error( "Missing 'maxFallHeight' in entityDef '%s'", name );
	if ( !dict->GetFloat( "minFloorCos", "0", minFloorCos ) ) common->Error( "Missing 'minFloorCos' in entityDef '%s'", name );
	if ( !dict->GetInt( "tt_barrierJump", "0", tt_barrierJump ) ) common->Error( "Missing 'tt_barrierJump' in entityDef '%s'", name );
	if ( !dict->GetInt( "tt_startCrouching", "0", tt_startCrouching ) ) common->Error( "Missing 'tt_startCrouching' in entityDef '%s'", name );
	if ( !dict->GetInt( "tt_waterJump", "0", tt_waterJump ) ) common->Error( "Missing 'tt_waterJump' in entityDef '%s'", name );
	if ( !dict->GetInt( "tt_startWalkOffLedge", "0", tt_startWalkOffLedge ) ) common->Error( "Missing 'tt_startWalkOffLedge' in entityDef '%s'", name );
	if ( dict->GetVector( "debugColor", "1.0 0.0 0.0", color ) ) debugColor.Set( color.x, color.y, color.z, 1.0f );
	dict->GetBool( "debugDraw", "1", debugDraw );
	dict->GetBool( "generateTacticalFeatures", "0", generateTacticalFeatures );
	return true;
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

bool idAASSettings::ValidForBounds( const idBounds &bounds ) const {
	for ( int i = 0; i < 3; i++ ) {
		if ( bounds[0][i] < boundingBoxes[0][0][i] || bounds[1][i] > boundingBoxes[0][1][i] ) {
			return false;
		}
	}
	return true;
}

bool idAASSettings::ValidEntity( const char *classname, bool *needFlyReachabilities ) const {
	if ( needFlyReachabilities ) {
		*needFlyReachabilities = false;
	}
	if ( playerFlood && ( !idStr::Cmp( classname, "info_player_start" ) ||
			!idStr::Cmp( classname, "info_player_deathmatch" ) ||
			!idStr::Cmp( classname, "func_teleporter" ) ) ) {
		return true;
	}

	const idDict *dict = gameEdit ? gameEdit->FindEntityDefDict( classname, false ) : NULL;
	idStr useAAS;
	if ( !dict || !dict->GetString( "use_aas", NULL, useAAS ) || fileExtension.Icmp( useAAS ) ) {
		return false;
	}

	idBounds bounds;
	idVec3 size;
	bounds.Zero();
	if ( dict->GetVector( "mins", NULL, bounds[0] ) ) {
		dict->GetVector( "maxs", NULL, bounds[1] );
	} else if ( dict->GetVector( "size", NULL, size ) ) {
		bounds[0].Set( size.x * -0.5f, size.y * -0.5f, 0.0f );
		bounds[1].Set( size.x * 0.5f, size.y * 0.5f, size.z );
	}
	if ( !ValidForBounds( bounds ) ) {
		common->Error( "%s cannot use %s\n", classname, fileExtension.c_str() );
	}
	if ( needFlyReachabilities ) {
		dict->GetBool( "flying", "0", *needFlyReachabilities );
	}
	return true;
}

float idAASSettings::Radius( float scale ) const {
	const idBounds &bounds = boundingBoxes[0];
	float radius = idMath::Fabs( bounds[0].x );
	if ( idMath::Fabs( bounds[1].x ) > radius ) radius = idMath::Fabs( bounds[1].x );
	if ( idMath::Fabs( bounds[0].y ) > radius ) radius = idMath::Fabs( bounds[0].y );
	if ( idMath::Fabs( bounds[1].y ) > radius ) radius = idMath::Fabs( bounds[1].y );
	return radius * scale;
}
