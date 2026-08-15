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

//----------------------------------------------------------------
// ClientEffect.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_CLIENT_EFFECT_H__
#define __GAME_CLIENT_EFFECT_H__

class rvClientEffect : public rvClientEntity {
public:

	CLASS_PROTOTYPE( rvClientEffect );

	rvClientEffect( void );
	rvClientEffect( const idDecl *effect );
	virtual ~rvClientEffect( void );

	virtual void		Think			( void );
	virtual void		DrawDebugInfo	( void ) const;
	virtual void		FreeEntityDef	( void );
	virtual void		UpdateBind		( void );

	bool				Play			( int startTime, bool loop = false, const idVec3& origin = vec3_origin );
	void				Stop			( bool destroyParticles = false );
	void				Restart			( void );	
	
	int					GetEffectIndex	( void );
	const char *		GetEffectName	( void );

	void				Attenuate		( float attenuation );

	float				GetDuration		( void ) const;
	renderEffect_t*		GetRenderEffect	( void ) { return &renderEffect; }

	void				SetEndOrigin	( const idVec3& endOrigin );
	void				SetEndOrigin	( jointHandle_t joint ) { endOriginJoint = joint; }
	
	void				SetGravity		( const idVec3& gravity ) { renderEffect.gravity = gravity; }

	void				SetColor		( const idVec4& color );
	void				SetBrightness	( float brightness ) { renderEffect.shaderParms[SHADERPARM_BRIGHTNESS] = brightness; }
	void				SetAmbient		( bool in ) { renderEffect.ambient = in; }

	void				Save			( idSaveGame *savefile ) const;
	void				Restore			( idRestoreGame *savefile );
protected:

	void				Init			( const idDecl *effect );
	void				FreeEffectDef	( void );

	renderEffect_t		renderEffect;
	int					effectDefHandle;
	jointHandle_t		endOriginJoint;
};

ID_INLINE void rvClientEffect::SetEndOrigin	( const idVec3& endOrigin ) {
	renderEffect.endOrigin = endOrigin;
	renderEffect.hasEndOrigin = !(endOrigin == vec3_origin);
}

ID_INLINE void rvClientEffect::SetColor ( const idVec4& color ) {
	renderEffect.shaderParms[SHADERPARM_RED] = color[0];
	renderEffect.shaderParms[SHADERPARM_GREEN] = color[1];
	renderEffect.shaderParms[SHADERPARM_BLUE] = color[2];
	renderEffect.shaderParms[SHADERPARM_ALPHA] = color[3];
}

//----------------------------------------------------------------
//						rvClientCrawlEffect
//----------------------------------------------------------------

class idAnimatedEntity;

class rvClientCrawlEffect : public rvClientEffect {
public:

	CLASS_PROTOTYPE( rvClientCrawlEffect );

	rvClientCrawlEffect				( void );
	rvClientCrawlEffect				( const idDecl *effect, idEntity* ent, int crawlTime, idList<jointHandle_t>* joints = NULL );
	~rvClientCrawlEffect			( void ) {}

	virtual void		Think		( void );

	void				Save		( idSaveGame *savefile ) const;
	void				Restore		( idRestoreGame *savefile );
	
protected:

	idList<jointHandle_t>			crawlJoints;
	int								crawlTime;
	int								nextCrawl;
	int								jointStart;
	int								jointEnd;
	int								crawlDir;
	idEntityPtr<idAnimatedEntity>	crawlEnt;
};

typedef rvClientEntityPtr<rvClientEffect>	rvClientEffectPtr;

#endif // __GAME_CLIENT_EFFECT_H__
