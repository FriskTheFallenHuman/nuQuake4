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

#include "../idlib/precompiled.h"
#pragma hdrstop

/*
===============
idFreeView::~idFreeView
===============
*/
idFreeView::~idFreeView() {
	if ( physics ) {
		delete physics;
		physics = NULL;
	}
}

/*
===============
idFreeView::SetFreeView
===============
*/
void idFreeView::SetFreeView( int clientNum ) {
	trace_t		trace;
	idPlayer	*p;
	idVec3		start, end;
	idClip		*clipWorld;

	if ( !physics ) {
		Setup();
	}
	p = static_cast<idPlayer*>( gameLocal.entities[ clientNum ] );
	if ( !p ) {
		PickRandomSpawn();
		return;
	}
	start = p->GetEyePosition();
	end = start; end[2] += 20.0f;
	clipWorld = gameLocal.GetEntityClipWorld( p );
	if ( clipWorld ) {
		clipWorld->Translation( trace, start, end, physics->GetClipModel(), mat3_identity, MASK_PLAYERSOLID, NULL, NULL );
		physics->SetOrigin( trace.endpos );
	} else {
		assert( false );
		physics->SetOrigin( start );
	}
	viewAngles = p->viewAngles;
	viewAngles[2] = 0.0f;
	snapAngle = true;
}

/*
===============
idFreeView::PickRandomSpawn
===============
*/
void idFreeView::PickRandomSpawn( void ) {
	if ( !physics ) {
		Setup();
	}
	idPlayerStart *start = gameLocal.RandomSpawn();
	physics->SetOrigin( start->GetPhysics()->GetOrigin() + idVec3( 0.0f, 0.0f, pm_normalheight.GetFloat() ) );
	viewAngles = start->GetPhysics()->GetAxis().ToAngles();
	snapAngle = true;
}
	
/*
===============
idFreeView::Fly
===============
*/
void idFreeView::Fly( const usercmd_t &ucmd ) {
	idAngles	src;

	assert( physics );

	src[0] = SHORT2ANGLE( ucmd.angles[0] );
	src[1] = SHORT2ANGLE( ucmd.angles[1] );
	src[2] = 0.0f;

	if ( snapAngle ) {
		viewAngleOffset = viewAngles - src;
		snapAngle = false;
	}
	
	viewAngles = src + viewAngleOffset;
	
	physics->SetPlayerInput( ucmd, viewAngles );
	physics->Evaluate( gameLocal.time - gameLocal.previousTime, gameLocal.time );	
}

/*
===============
idFreeView::Draw
===============
*/
void idFreeView::Draw( void ) {

	assert( physics );

	view.vieworg = physics->PlayerGetOrigin();
	view.viewaxis = viewAngles.ToMat3();
	view.time = gameLocal.time;
	gameLocal.CalcFov( g_fov.GetFloat(), view.fov_x, view.fov_y );

	// free flying demo client rendering
	gameLocal.mpGame.SetShaderParms( &view );
	// FIXME: player hud? draw scoreboard?
	soundSystem->PlaceListener( view.vieworg, view.viewaxis, 0, gameLocal.time, "Undefined" );
	// from idPlayerView::SingleView
	idCamera *portalSky = gameLocal.GetPortalSky();
	if ( portalSky ) {
		renderView_t portalSkyView = view;
		portalSky->GetViewParms( &portalSkyView );
		gameRenderWorld->RenderScene( &portalSkyView, RF_DEFER_COMMAND_SUBMIT | RF_PORTAL_SKY );
	}
	gameRenderWorld->RenderScene( &view, RF_PRIMARY_VIEW );
}

/*
===============
idFreeView::Setup
===============
*/
void idFreeView::Setup( void ) {
	idClipModel	*clip;
	idBounds	b;

	assert( !physics );

	memset( &view, 0, sizeof( view ) );
	view.viewID = 0;
	view.x = view.y = 0;
	view.width = 640;
	view.height = 480;
	gameLocal.CalcFov( g_fov.GetFloat(), view.fov_x, view.fov_y );
	view.cramZNear = false;

	b = idBounds( vec3_origin ).Expand( pm_spectatebbox.GetFloat() * 0.5f );
	clip = new idClipModel( idTraceModel( b ), declManager->FindMaterial( "textures/flesh_boundingbox" ) );
	physics = new idPhysics_Player();
	physics->SetSpeed( pm_spectatespeed.GetFloat(), pm_crouchspeed.GetFloat() );
	physics->SetClipModelNoLink( clip );
	physics->SetClipMask( MASK_PLAYERSOLID );
	physics->SetMovementType( PM_SPECTATOR );	
}

/*
===============
idFreeView::Shutdown
===============
*/
void idFreeView::Shutdown( void ) {
	if ( physics ) {
		delete physics;
		physics = NULL;
	}
}

/*
===============
idFreeView::GetOrigin
===============
*/
const idVec3 &idFreeView::GetOrigin( void ) {
	return view.vieworg;
}
