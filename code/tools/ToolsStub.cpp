/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

Bootstrap implementation of the retail Toolsx86 API.  Compiler and editor
front-ends replace these placeholders incrementally as their Doom baselines
are reconciled with Quake 4.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Tools.h"
#include "ToolsStub.inl"
#include "compilers/dmap/dmap.h"
#include "../sys/win32/win_local.h"

static toolsImport_t toolsImports;
static toolsAlloc_t toolsAllocator;
static toolsFree_t toolsDeallocator;
static toolsMSize_t toolsAllocationSize;

// Tool translation units use the same global interface names as the engine.
// In the DLL they are aliases for the pointers supplied through toolsImport_t.
idSys *sys = NULL;
idCommon *common = NULL;
idCmdSystem *cmdSystem = NULL;
idCVarSystem *cvarSystem = NULL;
idFileSystem *fileSystem = NULL;
idRenderSystem *renderSystem = NULL;
idSoundSystem *soundSystem = NULL;
idRenderModelManager *renderModelManager = NULL;
idUserInterfaceManager *uiManager = NULL;
idDeclManager *declManager = NULL;
idAASFile *AASFile = NULL;
idCollisionModelManager *collisionModelManager = NULL;
idGameEdit *gameEdit = NULL;
rvMaterialEdit *materialEdit = NULL;
rvSoundShaderEdit *soundShaderEdit = NULL;
rvDeclAFEdit *declAFEdit = NULL;
rvDeclPlaybackEdit *declPlaybackEdit = NULL;
rvDeclEffectEdit *declEffectEdit = NULL;
rvDeclLipSyncEdit *declLipSyncEdit = NULL;
rvWindowEdit *windowEdit = NULL;
rvVarEdit *varEdit = NULL;
idSession *session = NULL;
idImageManager *globalImages = NULL;
idConsole *console = NULL;
idCVar *idCVar::staticVars = NULL;

// The retail tools module owns a mirror of the engine's Win32 state.  Editor
// code only consumes the parent window and shared OpenGL context fields; those
// are supplied explicitly by toolsImport_t instead of reaching into quake4.exe.
Win32Vars_t win32;

// Doom compiler sources call these engine globals directly.  The tools DLL
// owns its editor mask and routes timing through the imported Quake 4 idSys.
int com_editors = 0;
bool com_editorActive = false;
HWND com_hwndMsg = NULL;
bool com_outputMsg = false;
int Sys_Milliseconds( void ) {
	return sys ? sys->Milliseconds() : 0;
}
void Sys_GrabMouseCursor( bool grabIt ) {
	if ( sys != NULL ) {
		sys->GrabMouseCursor( grabIt );
	}
}
void Com_WriteConfigToFile( const char *filename ) {
	if ( common != NULL ) {
		common->WriteConfigToFile( filename );
	}
}
void Sys_Error( const char *error, ... ) {
	char buffer[4096];
	va_list args;
	va_start( args, error );
	_vsnprintf_s( buffer, sizeof( buffer ), _TRUNCATE, error, args );
	va_end( args );
	if ( common != NULL ) {
		common->Error( "%s", buffer );
	}
}

void RunAAS_f( const idCmdArgs &args );
void RunAASDir_f( const idCmdArgs &args );
void RunReach_f( const idCmdArgs &args );
void RunAASTactical_f( const idCmdArgs &args );
void Dmap_f( const idCmdArgs &args );
void RadiantInit( void );
void RadiantRun( void );
void RadiantShutdown( void );
void RadiantPrint( const char *text );
void LightEditorInit( const idDict *spawnArgs );
void LightEditorRun( void );
void LightEditorShutdown( void );
int WINAPI QEW_SetupPixelFormat( HDC hDC, bool zbuffer );
optimizedShadow_t SuperOptimizeOccluders( idVec4 *verts, glIndex_t *indexes, int numIndexes,
	idPlane projectionPlane, idVec3 projectionOrigin );
void CleanupOptimizedShadowTris( srfTriangles_t *tri );

class rvToolsLocal : public rvToolsStub {
public:
	rvToolsLocal() : activeTools( 0 ), listenerArea( -1 ) {}

	virtual void *GetInstance( void ) const { return reinterpret_cast<void *>( toolsImports.instance ); }
	virtual void *GetParentWindow( void ) const { return toolsImports.ownerWnd; }
	virtual void *GetDC( void ) const { return toolsImports.ownerDC; }
	virtual bool IsParentWindowVisible( void ) {
		return toolsImports.ownerWnd != NULL && ::IsWindowVisible( static_cast<HWND>( toolsImports.ownerWnd ) ) != FALSE;
	}
	virtual void InitTool( int tool, const idDict *dict ) {
		if ( tool & EDITOR_RADIANT ) {
			RadiantInit();
			activeTools |= EDITOR_RADIANT;
		}
		if ( tool & EDITOR_LIGHT ) {
			LightEditorInit( dict );
			activeTools |= EDITOR_LIGHT;
		}
		const int supported = EDITOR_RADIANT | EDITOR_LIGHT;
		if ( tool & ~supported ) {
			Unavailable( "requested editor front-end" );
		}
	}
	virtual void ShutdownTool( int tool ) {
		const int closing = tool == -1 ? activeTools : tool;
		if ( closing & EDITOR_LIGHT ) {
			LightEditorShutdown();
		}
		if ( closing & EDITOR_RADIANT ) {
			RadiantShutdown();
		}
		activeTools = tool == -1 ? 0 : ( activeTools & ~tool );
	}
	virtual int IsToolActive( int tool ) {
		return tool == -1 ? activeTools : ( activeTools & tool );
	}
	virtual void Frame( void ) {
		if ( activeTools & EDITOR_RADIANT ) {
			RadiantRun();
		} else if ( activeTools & EDITOR_LIGHT ) {
			LightEditorRun();
		}
	}
	virtual void Shutdown( void ) { ShutdownTool( -1 ); }
	virtual void HandleToolPrint( const char *text ) { RadiantPrint( text ); }
	virtual int SetupPixelFormat( HDC dc ) { return QEW_SetupPixelFormat( dc, true ); }
	virtual bool MakeCurrent( HDC dc ) { return qwglMakeCurrent( dc, win32.hGLRC ) != FALSE; }
	virtual void SetListenerArea( int area ) { listenerArea = area; }
	virtual int GetListenerArea( void ) const { return listenerArea; }
	virtual void DmapCleanupOptimizedShadowTris( int numTris, srfTriangles_s *triangles ) {
		(void)numTris;
		CleanupOptimizedShadowTris( triangles );
	}
	virtual bool DmapSuperOptimizeOccluders( SOOData_s *data, idVec4 *verts, int *indexes,
			int numIndexes, idPlane plane, idVec3 origin ) {
		optimizedShadow_t optimized = SuperOptimizeOccluders( verts, indexes, numIndexes, plane, origin );
		if ( !optimized.verts || !optimized.indexes ) {
			return true;
		}

		const int firstVertex = data->firstShadowVert;
		const int firstIndex = data->firstShadowIndex;
		if ( firstVertex + optimized.numVerts > 0x18000 || firstIndex + optimized.totalIndexes > 0x18000 ) {
			Mem_Free( optimized.verts );
			Mem_Free( optimized.indexes );
			return true;
		}

		for ( int i = 0; i < optimized.numVerts; i++ ) {
			data->shadowVerts[firstVertex + i].Set( optimized.verts[i].x, optimized.verts[i].y, optimized.verts[i].z, 1.0f );
		}
		for ( int i = 0; i < optimized.totalIndexes; i++ ) {
			data->shadowIndexes[firstIndex + i] = firstVertex + optimized.indexes[i];
		}

		indexRef_s &ref = data->indexRef[data->indexFrustumNumber++];
		ref.frontCapStart = firstIndex;
		ref.rearCapStart = ref.frontCapStart + optimized.numFrontCapIndexes;
		ref.silStart = ref.rearCapStart + optimized.numRearCapIndexes;
		ref.end = ref.silStart + optimized.numSilPlaneIndexes;
		data->numShadowVerts = firstVertex + optimized.numVerts;
		data->numShadowIndexes = firstIndex + optimized.totalIndexes;

		Mem_Free( optimized.verts );
		Mem_Free( optimized.indexes );
		return false;
	}

	virtual void PhonemeGen( const idCmdArgs &args ) { Unavailable( "phoneme generator" ); }
	virtual void ShakesGen( const idCmdArgs &args ) { Unavailable( "shake generator" ); }
	virtual void RoQFileEncode( const idCmdArgs &args ) { Unavailable( "RoQ encoder" ); }
	virtual void Renderbump( const idCmdArgs &args ) { Unavailable( "renderbump" ); }
	virtual void RenderbumpFlat( const idCmdArgs &args ) { Unavailable( "renderbumpFlat" ); }
	virtual void Dmap( const idCmdArgs &args ) { Dmap_f( args ); }
	virtual void RunAAS( const idCmdArgs &args ) { RunAAS_f( args ); }
	virtual void RunAASDir( const idCmdArgs &args ) { RunAASDir_f( args ); }
	virtual void RunReach( const idCmdArgs &args ) { RunReach_f( args ); }
	virtual void RunAASTactical( const idCmdArgs &args ) { RunAASTactical_f( args ); }

private:
	void Unavailable( const char *name ) {
		if ( toolsImports.common != NULL ) {
			toolsImports.common->Printf( "Toolsx86 bootstrap: %s is not connected yet.\n", name );
		}
	}

	int activeTools;
	int listenerArea;
};

static rvToolsLocal toolsLocal;
static toolsExport_t toolsExport;

extern "C" __declspec( dllexport ) toolsExport_t * __cdecl GetToolsAPI(
	toolsImport_t *imports,
	toolsAlloc_t allocator,
	toolsFree_t deallocator,
	toolsMSize_t msize ) {

	memset( &toolsImports, 0, sizeof( toolsImports ) );
	toolsAllocator = allocator;
	toolsDeallocator = deallocator;
	toolsAllocationSize = msize;

	toolsExport.version = 0;
	toolsExport.tools = NULL;
	if ( imports == NULL || imports->version != TOOLS_API_VERSION ) {
		return &toolsExport;
	}

	toolsImports = *imports;
	memset( &win32, 0, sizeof( win32 ) );
	win32.hWnd = static_cast<HWND>( imports->ownerWnd );
	win32.hInstance = reinterpret_cast<HINSTANCE>( imports->instance );
	win32.hDC = static_cast<HDC>( imports->ownerDC );
	win32.hGLRC = static_cast<HGLRC>( imports->hGLRC );
	if ( imports->pfd != NULL ) {
		win32.pfd = *static_cast<PIXELFORMATDESCRIPTOR *>( imports->pfd );
	}
	sys = imports->sys;
	common = imports->common;
	cmdSystem = imports->cmdSystem;
	cvarSystem = imports->cvarSystem;
	idCVar::RegisterStaticVars();
	fileSystem = imports->fileSystem;
	renderSystem = imports->renderSystem;
	soundSystem = imports->soundSystem;
	renderModelManager = imports->renderModelManager;
	uiManager = imports->uiManager;
	declManager = imports->declManager;
	AASFile = imports->AASFile;
	collisionModelManager = imports->collisionModelManager;
	gameEdit = imports->gameEdit;
	materialEdit = imports->materialEdit;
	soundShaderEdit = imports->soundShaderEdit;
	declAFEdit = imports->declAFEdit;
	declPlaybackEdit = imports->declPlaybackEdit;
	declEffectEdit = imports->declEffectEdit;
	declLipSyncEdit = imports->declLipSyncEdit;
	windowEdit = imports->windowEdit;
	varEdit = imports->varEdit;
	session = imports->session;
	globalImages = imports->globalImages;
	console = imports->console;
	idLib::sys = sys;
	idLib::common = common;
	idLib::cvarSystem = cvarSystem;
	idLib::fileSystem = fileSystem;
	Memory::InitAllocator( allocator, deallocator, msize );
	toolsExport.version = TOOLS_API_VERSION;
	toolsExport.tools = &toolsLocal;
	return &toolsExport;
}
