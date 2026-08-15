/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

Quake 4 does not ship the Doom-era .qe4 project file.  Radiant derives its
small project dictionary from the active engine filesystem instead.

===========================================================================
*/

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "qe3.h"
#include "InspectorDialog.h"

bool QE_LoadQuake4Project( void ) {
	const char *gameCVar = cvarSystem->GetCVarString( "fs_game" );
	idStr game = ( gameCVar != NULL && gameCVar[0] != '\0' ) ? gameCVar : BASE_GAMEDIR;
	idStr baseRoot = cvarSystem->GetCVarString( "fs_basepath" );
	idStr devRoot = cvarSystem->GetCVarString( "fs_devpath" );
	if ( devRoot.IsEmpty() ) {
		devRoot = baseRoot;
	}

	idStr basePath = fileSystem->BuildOSPath( baseRoot, game, "" );
	idStr mapsPath = fileSystem->BuildOSPath( devRoot, game, "maps" );
	idStr autosave1 = fileSystem->BuildOSPath( devRoot, game, "maps/autosave.map" );
	idStr autosave2 = fileSystem->BuildOSPath( devRoot, game, "maps/autosave2.map" );

	g_qeglobals.d_project_entity = Entity_New();
	g_qeglobals.d_project_entity->brushes.onext = &g_qeglobals.d_project_entity->brushes;
	g_qeglobals.d_project_entity->brushes.oprev = &g_qeglobals.d_project_entity->brushes;
	SetKeyValue( g_qeglobals.d_project_entity, "basepath", basePath );
	SetKeyValue( g_qeglobals.d_project_entity, "mapspath", mapsPath );
	SetKeyValue( g_qeglobals.d_project_entity, "entitypath", "def" );
	SetKeyValue( g_qeglobals.d_project_entity, "texturepath", "textures" );
	SetKeyValue( g_qeglobals.d_project_entity, "autosave1", autosave1 );
	SetKeyValue( g_qeglobals.d_project_entity, "autosave2", autosave2 );
	SetKeyValue( g_qeglobals.d_project_entity, "brush_primit", "1" );
	SetKeyValue( g_qeglobals.d_project_entity, "bsp", "" );
	SetKeyValue( g_qeglobals.d_project_entity, "bsp -noLight", "" );
	SetKeyValue( g_qeglobals.d_project_entity, "bsp -noOptimize", "" );

	g_strProject = "Quake 4 filesystem";
	g_qeglobals.m_bBrushPrimitMode = true;
	Eclass_InitForSourceDirectory( "def" );
	g_Inspectors->FillClassList();
	Map_New();
	FillBSPMenu();
	common->Printf( "Radiant project: %s (%s)\n", game.c_str(), mapsPath.c_str() );
	return true;
}
