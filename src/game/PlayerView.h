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

// RAVEN BEGIN
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 07/07/2004

#ifndef __GAME_PLAYERVIEW_H__
#define __GAME_PLAYERVIEW_H__

/*
===============================================================================

  Player view.

===============================================================================
*/

// screenBlob_t are for the on-screen damage claw marks, etc
typedef struct {
	const idMaterial *	material;
	float				x, y, w, h;
	float				s1, t1, s2, t2;
	int					finishTime;
	int					startFadeTime;
	float				driftAmount;
} screenBlob_t;

#define	MAX_SCREEN_BLOBS	8

class idPlayerView {
public:
						idPlayerView();

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				SetPlayerEntity( class idPlayer *playerEnt );

	void				ClearEffects( void );

// RAVEN BEGIN
// jnewquist: Controller rumble
	void				DamageImpulse( idVec3 localKickDir, const idDict *damageDef, int damage );
// RAVEN END

	void				WeaponFireFeedback( const idDict *weaponDef );

	idAngles			AngleOffset( void ) const;			// returns the current kick angle

// RAVEN BEGIN
// jnewquist: Controller rumble
	float				CalculateShake( idAngles &shakeAngleOffset ) const;
// RAVEN END

// RAVEN BEGIN
// jscott: for screen shake
	void				ShakeOffsets( idVec3 &shakeOffset, idAngles &shakeAngleOffset, const idBounds bounds ) const;
// RAVEN END

	// adds little entities to the renderer for local blood blobs, etc

	// this may involve rendering to a texture and displaying
	// that with a warp model or in double vision mode
	void				RenderPlayerView( idUserInterface *hud );

	void				Fade( idVec4 color, int time );

	void				Flash( idVec4 color, int time );

	void				AddBloodSpray( float duration );

	// temp for view testing
	void				EnableBFGVision( bool b ) { bfgVision = b; };

// RAVEN BEGIN
// jscott: accessors required for the fx system
	void				SetDoubleVisionParms( float time, float scale ) { dvFinishTime = SEC2MS( time ); dvScale = scale; }
	void				SetShakeParms( float time, float scale ) { shakeFinishTime = SEC2MS( time ); shakeScale = scale; }
	void				SetTunnelParms( float time, float scale ) { tvStartTime = gameLocal.time; tvFinishTime = tvStartTime + time; tvScale = 1.0f / scale; }
// RAVEN END

private:
// RAVEN BEGIN
// AReis: Modified SingleView() signature to include renderFlags variable.
	void				SingleView( idUserInterface *hud, const renderView_t *view, int renderFlags = RF_NORMAL );
// RAVEN END
	void				DoubleVision( idUserInterface *hud, const renderView_t *view, int offset );
	void				BerserkVision( idUserInterface *hud, const renderView_t *view );
	void				InfluenceVision( idUserInterface *hud, const renderView_t *view );
	void				ScreenFade();

	screenBlob_t *		GetScreenBlob();

	screenBlob_t		screenBlobs[MAX_SCREEN_BLOBS];

	int					dvFinishTime;		// double vision will be stopped at this time
	const idMaterial *	dvMaterial;			// material to take the double vision screen shot
// RAVEN BEGIN
// jscott: to make double vision work with alpha components
	const idMaterial *	dvMaterialBlend;
// jscott: for effects
	float				dvScale;
// RAVEN END

	int					kickFinishTime;		// view kick will be stopped at this time
	idAngles			kickAngles;			

	bool				bfgVision;			// 

	const idMaterial *	tunnelMaterial;		// health tunnel vision
	const idMaterial *	armorMaterial;		// armor damage view effect
// RAVEN BEGIN
// bdube: not using these
//	const idMaterial *	berserkMaterial;	// berserk effect
//	const idMaterial *	irGogglesMaterial;	// ir effect
	const idMaterial *	bloodSprayMaterial; // blood spray
//	const idMaterial *	bfgMaterial;		// when targeted with BFG
// RAVEN END
	const idMaterial *	lagoMaterial;		// lagometer drawing

	float				lastDamageTime;		// accentuate the tunnel effect for a while

// RAVEN BEGIN
// jscott: for effects
	float				shakeFinishTime;
	float				shakeScale;
	float				tvScale;
	int					tvFinishTime;
	int					tvStartTime;
// RAVEN END

	idVec4				fadeColor;			// fade color
	idVec4				fadeToColor;		// color to fade to
	idVec4				fadeFromColor;		// color to fade from
	float				fadeRate;			// fade rate
	int					fadeTime;			// fade time

	idPlayer *			player;
	renderView_t		view;
};

#endif /* !__GAME_PLAYERVIEW_H__ */

// RAVEN END
