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

#ifndef _BSE_INTERFACE_H_INC_
#define _BSE_INTERFACE_H_INC_

#define	BSE_EFFECT_EXTENSION		"fx"

enum
{
	VIEWEFFECT_DOUBLEVISION = 0,
	VIEWEFFECT_SHAKE,
	VIEWEFFECT_TUNNEL
};

typedef enum {
	EC_IGNORE = 0,
	EC_IMPACT,
	EC_IMPACT_PARTICLES,

	EC_MAX,
} effectCategory_t;

extern	idCVar				bse_enabled;
extern	idCVar				bse_render;
extern	idCVar				bse_debug;
extern	idCVar				bse_showBounds;
extern	idCVar				bse_physics;
extern	idCVar				bse_debris;
extern	idCVar				bse_scale;
extern	idCVar				bse_singleEffect;
extern	idCVar				bse_maxParticles;

// Interface to the effects system

class rvBSEManager
{
public:
	virtual						~rvBSEManager( void ) {}	

	virtual	bool				Init( void ) = 0;
	virtual	bool				Shutdown( void ) = 0;

	virtual	bool				PlayEffect( class rvRenderEffectLocal *def, float time ) = 0;
	virtual	bool				ServiceEffect( class rvRenderEffectLocal *def, float time ) = 0;
	virtual	void				StopEffect( rvRenderEffectLocal *def ) = 0;
	virtual	void				FreeEffect( rvRenderEffectLocal *def ) = 0;
	virtual	float				EffectDuration( const rvRenderEffectLocal *def ) = 0;

	virtual	bool				CheckDefForSound( const renderEffect_t *def ) = 0;

	virtual	void				BeginLevelLoad( void ) = 0;
	virtual	void				EndLevelLoad( void ) = 0;

	virtual	void				StartFrame( void ) = 0;
	virtual	void				EndFrame( void ) = 0;
	virtual bool				Filtered( const char *name, effectCategory_t category ) = 0;

	virtual void				UpdateRateTimes( void ) = 0;
	virtual bool				CanPlayRateLimited( effectCategory_t category ) = 0;
};

extern	rvBSEManager			*bse;

class rvDeclEffectEdit
{
public:
	virtual ~rvDeclEffectEdit() {}
	virtual void 					Finish( class rvDeclEffect *edit ) = 0;
	virtual class rvSegmentTemplate	*GetSegmentTemplate( class rvDeclEffect *edit, const char *name ) = 0;
	virtual class rvSegmentTemplate	*GetSegmentTemplate( class rvDeclEffect *edit, int i ) = 0;
	virtual void					CopyData( class rvDeclEffect *edit, class rvDeclEffect *copy ) = 0;
	virtual int						AddSegment( class rvDeclEffect *edit, class rvSegmentTemplate *add ) = 0;
	virtual void					DeleteSegment( class rvDeclEffect *edit, int index ) = 0;
	virtual void					SwapSegments( class rvSegmentTemplate *seg1, class rvSegmentTemplate *seg2 ) = 0;

	virtual void					CreateEditorOriginal( class rvDeclEffect *edit ) = 0;
	virtual void					DeleteEditorOriginal( class rvDeclEffect *edit ) = 0;
	virtual bool					CompareToEditorOriginal( class rvDeclEffect *edit ) = 0;
	virtual void					RevertToEditorOriginal( class rvDeclEffect *edit ) = 0;

	virtual void 					Init( class rvSegmentTemplate *edit, class rvDeclEffect *effect ) = 0;
	virtual bool 					Parse( class rvSegmentTemplate *edit, class rvDeclEffect *effect, int type, class idLexer *lexer ) = 0;
	virtual void 					Finish( class rvSegmentTemplate *edit, class rvDeclEffect *effect ) = 0;
	virtual bool					Compare( class rvSegmentTemplate *edit, const class rvSegmentTemplate *other ) const = 0;
	virtual void					SetName( class rvSegmentTemplate *edit, const char *name ) = 0;

	virtual void 					Finish( class rvParticleTemplate *edit ) = 0;
	virtual bool					Compare( class rvParticleTemplate *edit, const class rvParticleTemplate *other ) const = 0;
	virtual void					Init( class rvParticleTemplate *edit ) = 0;
	virtual	void					FixupParms( class rvParticleTemplate *edit, class rvParticleParms *parms ) = 0;
	virtual void					SetMaterialName( class rvParticleTemplate *edit, const char *name ) = 0;
	virtual void					SetModelName( class rvParticleTemplate *edit, const char *name ) = 0;
	virtual void					SetEntityDefName( class rvParticleTemplate *edit, const char *name ) = 0;
	virtual void					SetTrailTypeName( class rvParticleTemplate *edit, const char *name ) = 0;
	virtual void					SetTrailMaterialName( class rvParticleTemplate *edit, const char *name ) = 0;

	virtual bool					Compare( class rvParticleParms *edit, const class rvParticleParms *other ) const = 0;

	virtual void					CalcRate( class rvEnvParms *edit, float *rate, float duration, int count ) = 0;
	virtual void					Evaluate3( class rvEnvParms *edit, float time, const float *start, const float *rate, const float *end, float *dest ) = 0;
};

extern rvDeclEffectEdit		*declEffectEdit;

#endif // _BSE_INTERFACE_H_INC_
