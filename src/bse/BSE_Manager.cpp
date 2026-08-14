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
#include "BSE.h"
#include "BSE_Particle.h"
#include "../game/Game.h"
#include "../renderer/tr_local.h"

// Retail compilation unit: BSE_Manager.obj.

idCVar bse_enabled( "bse_enabled", "1", CVAR_BOOL, "set to false to disable all effects" );
idCVar bse_render( "bse_render", "1", CVAR_BOOL, "disable effect rendering" );
idCVar bse_debug( "bse_debug", "0", CVAR_INTEGER, "display debug info about effect" );
idCVar bse_showBounds( "bse_showBounds", "0", CVAR_INTEGER, "display debug bounding boxes effect" );
idCVar bse_physics( "bse_physics", "1", CVAR_BOOL, "disable effect physics" );
idCVar bse_debris( "bse_debris", "1", CVAR_BOOL, "disable effect debris" );
idCVar bse_scale( "bse_scale", "1", CVAR_FLOAT, "effect scalability amount" );
idCVar bse_singleEffect( "bse_singleEffect", "", 0, "set to the name of the effect that is only played" );
idCVar bse_maxParticles( "bse_maxParticles", "2048", CVAR_INTEGER, "max number of particles allowed per segment" );
static idCVar bse_rateLimit( "bse_rateLimit", "1.0", CVAR_ARCHIVE | CVAR_FLOAT, "rate limit for spawned effects" );
static idCVar bse_rateCost( "bse_rateCost", "1.0", CVAR_ARCHIVE | CVAR_FLOAT, "rate cost multiplier for spawned effects" );

idBlockAlloc<rvBSE, 256, MA_RENDER> rvBSEManagerLocal::effects;
idVec3 rvBSEManagerLocal::mCubeNormals[6] = {
	idVec3( -1.0f, 0.0f, 0.0f ), idVec3( 0.0f, -1.0f, 0.0f ), idVec3( 0.0f, 0.0f, -1.0f ),
	idVec3(  1.0f, 0.0f, 0.0f ), idVec3( 0.0f,  1.0f, 0.0f ), idVec3( 0.0f, 0.0f,  1.0f )
};
idMat3 rvBSEManagerLocal::mModelToBSE(
	idVec3( 0.0f, 1.0f, 0.0f ), idVec3( 0.0f, 0.0f, 1.0f ), idVec3( 1.0f, 0.0f, 0.0f ) );
idList<idTraceModel *> rvBSEManagerLocal::mTraceModels;
const char *rvBSEManagerLocal::mSegmentNames[SEG_COUNT] = {
	"None", "Effect", "Emitter", "Spawner", "Trail", "Sound", "Decal", "Light",
	"Delay", "DoubleVision", "ScreenShake", "TunnelVision"
};
int rvBSEManagerLocal::mPerfCounters[NUM_PERF_COUNTERS];
float rvBSEManagerLocal::mEffectRates[EC_MAX];
idCVar *rvBSEManagerLocal::g_decals = NULL;

class rvDeclEffectEditLocal : public rvDeclEffectEdit {
public:
	virtual void Finish( rvDeclEffect *edit ) { edit->Finish(); }
	virtual rvSegmentTemplate *GetSegmentTemplate( rvDeclEffect *edit, const char *name ) { return edit->GetSegmentTemplate( name ); }
	virtual rvSegmentTemplate *GetSegmentTemplate( rvDeclEffect *edit, int i ) { return edit->GetSegmentTemplate( i ); }
	virtual void CopyData( rvDeclEffect *edit, rvDeclEffect *copy ) { edit->CopyData( *copy ); }
	virtual int AddSegment( rvDeclEffect *edit, rvSegmentTemplate *add ) { return edit->AddSegment( *add ); }
	virtual void DeleteSegment( rvDeclEffect *edit, int index ) { edit->DeleteSegment( index ); }
	virtual void SwapSegments( rvSegmentTemplate *seg1, rvSegmentTemplate *seg2 ) {
		rvSegmentTemplate temp( *seg1 );
		*seg1 = *seg2;
		*seg2 = temp;
	}
	virtual void CreateEditorOriginal( rvDeclEffect *edit ) { edit->CreateEditorOriginal(); }
	virtual void DeleteEditorOriginal( rvDeclEffect *edit ) { if ( edit ) { edit->DeleteEditorOriginal(); } }
	virtual bool CompareToEditorOriginal( rvDeclEffect *edit ) { return edit->CompareToEditorOriginal(); }
	virtual void RevertToEditorOriginal( rvDeclEffect *edit ) { edit->Revert(); }
	virtual void Init( rvSegmentTemplate *edit, rvDeclEffect *effect ) { edit->Init( effect ); }
	virtual bool Parse( rvSegmentTemplate *edit, rvDeclEffect *effect, int type, idLexer *lexer ) { return edit->Parse( effect, type, lexer ); }
	virtual void Finish( rvSegmentTemplate *edit, rvDeclEffect *effect ) { edit->Finish( effect ); }
	virtual bool Compare( rvSegmentTemplate *edit, const rvSegmentTemplate *other ) const { return *edit == *other; }
	virtual void SetName( rvSegmentTemplate *edit, const char *name ) { edit->mSegmentName = name; }
	virtual void Finish( rvParticleTemplate *edit ) { edit->Finish(); }
	virtual bool Compare( rvParticleTemplate *edit, const rvParticleTemplate *other ) const { return *edit == *other; }
	virtual void Init( rvParticleTemplate *edit ) { edit->Init(); }
	virtual void FixupParms( rvParticleTemplate *edit, rvParticleParms *parms ) { edit->FixupParms( *parms ); }
	virtual void SetMaterialName( rvParticleTemplate *edit, const char *name ) { edit->mMaterialName = name; }
	virtual void SetModelName( rvParticleTemplate *edit, const char *name ) { edit->mModelName = name; }
	virtual void SetEntityDefName( rvParticleTemplate *edit, const char *name ) { edit->mEntityDefName = name; }
	virtual void SetTrailTypeName( rvParticleTemplate *edit, const char *name ) { edit->mTrailTypeName = name; }
	virtual void SetTrailMaterialName( rvParticleTemplate *edit, const char *name ) { edit->mTrailMaterialName = name; }
	virtual bool Compare( rvParticleParms *edit, const rvParticleParms *other ) const { return *edit == *other; }
	virtual void CalcRate( rvEnvParms *edit, float *rate, float duration, int count ) { edit->CalcRate( rate, duration, count ); }
	virtual void Evaluate3( rvEnvParms *edit, float time, const float *start, const float *rate, const float *end, float *dest ) {
		edit->Evaluate3( time, start, rate, end, dest );
	}
};

static rvBSEManagerLocal bseLocal;
static rvDeclEffectEditLocal declEffectEditLocal;
rvBSEManager *bse = &bseLocal;
rvDeclEffectEdit *declEffectEdit = &declEffectEditLocal;

static void BSE_Stats_f( const idCmdArgs &args ) {
	bseLocal.Stats( args );
}

void rvDeclEffect::DeleteSegment( int index ) {
	if ( index >= 0 && index < mSegmentTemplates.Num() ) {
		mSegmentTemplates.RemoveIndex( index );
	}
}

int rvDeclEffect::AddSegment( rvSegmentTemplate &segment ) {
	return mSegmentTemplates.Append( segment );
}

bool rvBSEManagerLocal::Init() {
	common->Printf( "----------------- BSE Init ------------------\n" );
	declManager->FindEffect( "_default" );
	declManager->FindMaterial( "_default" );
	declManager->FindMaterial( "gfx/effects/particles_shapes/motionblur" );
	declManager->FindType( DECL_TABLE, "halfsintable" );
	renderModelManager->FindModel( "_default" );
	g_decals = cvarSystem->Find( "g_decals" );
	memset( mEffectRates, 0, sizeof( mEffectRates ) );
	cmdSystem->AddCommand( "bseStats", BSE_Stats_f, 0,
		"Dumps the stats of every registered effect - use all to force parse every effect" );
	common->Printf( "--------- BSE Created Successfully ----------\n" );
	return true;
}

bool rvBSEManagerLocal::Shutdown() {
	common->Printf( "--------------- BSE Shutdown ----------------\n" );
	for ( int i = 0; i < mTraceModels.Num(); ++i ) {
		delete mTraceModels[i];
	}
	mTraceModels.Clear();
	effects.Shutdown();
	memset( mEffectRates, 0, sizeof( mEffectRates ) );
	common->Printf( "---------------------------------------------\n" );
	return true;
}

bool rvBSEManagerLocal::PlayEffect( rvRenderEffectLocal *def, float time ) {
	if ( !def || !def->parms.declEffect || !bse_enabled.GetBool() ) {
		return false;
	}
	const rvDeclEffect *decl = static_cast<const rvDeclEffect *>( def->parms.declEffect );
	if ( Filtered( decl->GetName(), EC_IGNORE ) ) {
		return false;
	}
	decl->IncPlayCount();
	def->effect = effects.Alloc();
	def->effect->Init( const_cast<rvDeclEffect *>( decl ), &def->parms, time );
	return true;
}

bool rvBSEManagerLocal::ServiceEffect( rvRenderEffectLocal *def, float time ) {
	if ( !def || !def->effect ) {
		return true;
	}
	const char *name = def->parms.declEffect ? def->parms.declEffect->GetName() : "";
	if ( Filtered( name, EC_IGNORE ) || def->effect->Service( &def->parms, time ) ) {
		return true;
	}
	def->referenceBounds = def->effect->GetCurrentLocalBounds();
	if ( com_debugHudActive ) {
		++mPerfCounters[PERF_NUM_BSE];
	}
	if ( bse_debug.GetInteger() ) {
		def->effect->EvaluateCost();
	}
	return false;
}

void rvBSEManagerLocal::StopEffect( rvRenderEffectLocal *def ) {
	if ( def && def->index >= 0 && def->effect ) {
		def->effect->SetStopped( true );
	}
}

void rvBSEManagerLocal::FreeEffect( rvRenderEffectLocal *def ) {
	if ( def && def->effect ) {
		def->effect->Destroy();
		effects.Free( def->effect );
		def->effect = NULL;
	}
}

float rvBSEManagerLocal::EffectDuration( const rvRenderEffectLocal *def ) {
	return ( def && def->index >= 0 && def->effect ) ? def->effect->GetDuration() : 0.0f;
}

bool rvBSEManagerLocal::CheckDefForSound( const renderEffect_t *def ) {
	const rvDeclEffect *decl = def ? static_cast<const rvDeclEffect *>( def->declEffect ) : NULL;
	return decl && decl->GetHasSound();
}

void rvBSEManagerLocal::BeginLevelLoad() {
}

void rvBSEManagerLocal::EndLevelLoad() {
	memset( mEffectRates, 0, sizeof( mEffectRates ) );
}

void rvBSEManagerLocal::StartFrame() {
	if ( com_debugHudActive ) {
		memset( mPerfCounters, 0, sizeof( mPerfCounters ) );
	}
}

void rvBSEManagerLocal::EndFrame() {
	if ( com_debugHudActive && game ) {
		game->DebugSetInt( "fx_num_active", mPerfCounters[PERF_NUM_BSE] );
		game->DebugSetInt( "fx_num_particles", mPerfCounters[PERF_NUM_PARTICLES] );
		game->DebugSetInt( "fx_num_traces", mPerfCounters[PERF_NUM_TRACES] );
		game->DebugSetFloat( "fx_num_texels", mPerfCounters[PERF_NUM_TEXELS] / ( 1024.0f * 1024.0f ) );
		game->DebugSetInt( "fx_num_segments", mPerfCounters[PERF_NUM_SEGMENTS] );
	}
}

bool rvBSEManagerLocal::Filtered( const char *name, effectCategory_t category ) {
	const char *single = bse_singleEffect.GetString();
	if ( single[0] && ( !name || !strstr( name, single ) ) ) {
		return true;
	}
	return !CanPlayRateLimited( category );
}

void rvBSEManagerLocal::UpdateRateTimes() {
	for ( int i = 0; i < EC_MAX; ++i ) {
		mEffectRates[i] = Max( 0.0f, mEffectRates[i] - 0.1f );
	}
}

bool rvBSEManagerLocal::CanPlayRateLimited( effectCategory_t category ) {
	static const float effectCosts[EC_MAX] = { 0.0f, 0.1f, 0.1f };
	const float limit = bse_rateLimit.GetFloat();
	if ( category == EC_IGNORE || limit <= 0.1f ) {
		return true;
	}
	float &rate = mEffectRates[category];
	const float cost = effectCosts[category] * bse_rateCost.GetFloat();
	if ( limit * 0.5f < rate && cost + rate > rvRandom::flrand( 0.0f, limit ) ) {
		return false;
	}
	rate += cost;
	return true;
}

void rvBSEManagerLocal::SetDoubleVisionParms( float time, float scale ) {
	if ( game ) { game->StartViewEffect( VIEWEFFECT_DOUBLEVISION, time, scale ); }
}

void rvBSEManagerLocal::SetShakeParms( float time, float scale ) {
	if ( game ) { game->StartViewEffect( VIEWEFFECT_SHAKE, time, scale ); }
}

void rvBSEManagerLocal::SetTunnelParms( float time, float scale ) {
	if ( game ) { game->StartViewEffect( VIEWEFFECT_TUNNEL, time, scale ); }
}

void rvBSEManagerLocal::Stats( const idCmdArgs &args ) {
	const bool loadAll = args.Argc() > 1 && !idStr::Icmp( args.Argv( 1 ), "all" );
	int loaded = 0;
	int neverReferenced = 0;
	int segments = 0;
	int particleSegments = 0;
	int particles = 0;
	const int numEffects = declManager->GetNumDecls( DECL_EFFECT );
	common->Printf( "... processing %d registered effects\n", numEffects );
	for ( int i = 1; i < numEffects; ++i ) {
		const rvDeclEffect *effect = static_cast<const rvDeclEffect *>( declManager->DeclByIndex( DECL_EFFECT, i, loadAll ) );
		if ( !effect ) { continue; }
		++loaded;
		if ( effect->GetState() != DS_PARSED ) { ++neverReferenced; }
		for ( int j = 0; j < effect->GetNumSegmentTemplates(); ++j ) {
			const rvSegmentTemplate *segment = effect->GetSegmentTemplate( j );
			++segments;
			if ( segment->GetHasParticles() ) {
				++particleSegments;
				particles += idMath::Ftoi( segment->GetMaxCount() );
			}
		}
	}
	common->Printf( "%d segments in %d loaded effects (%d never referenced)\n", segments, loaded, neverReferenced );
	common->Printf( "%.2f segments per effect\n", loaded ? (float)segments / loaded : 0.0f );
	common->Printf( "%.2f of segments have particles\n", segments ? (float)particleSegments / segments : 0.0f );
	common->Printf( "%.2f particles per segment with particles\n", particleSegments ? (float)particles / particleSegments : 0.0f );
}
