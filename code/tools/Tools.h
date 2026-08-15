/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

Retail tools API reconstructed from the matching Quake 4 executable and PDB.

===========================================================================
*/

#ifndef __TOOLS_H__
#define __TOOLS_H__

#include <stddef.h>

#if defined( _WIN32 )
#include <windows.h>
#else
typedef void *HDC;
struct tagMSG;
#endif

#define TOOLS_API_VERSION 2

class idAASFile;
class idCmdArgs;
class idCmdSystem;
class idCommon;
class idCVarSystem;
class idDeclManager;
class idDict;
class idFileSystem;
class idGameEdit;
class idImageManager;
class idInterpreter;
class idPlane;
class idProgram;
class idRenderModelManager;
class idRenderSystem;
class idSession;
class idSoundSystem;
class idSys;
class idUserInterfaceManager;
class idVec3;
class idVec4;
class idWindow;
class rvDeclAFEdit;
class rvDeclEffectEdit;
class rvDeclLipSyncEdit;
class rvDeclPlaybackEdit;
class rvISourceControl;
class rvMaterialEdit;
class rvSoundShaderEdit;
class rvVarEdit;
class rvWindowEdit;
struct srfTriangles_s;

struct indexRef_s {
	int frontCapStart;
	int rearCapStart;
	int silStart;
	int end;
};

struct SOOData_s {
	int numShadowIndexes;
	int firstShadowIndex;
	int numShadowVerts;
	int firstShadowVert;
	int indexFrustumNumber;
	idVec4 *shadowVerts;
	int *shadowIndexes;
	indexRef_s *indexRef;
};

typedef void *(*toolsAlloc_t)( size_t size );
typedef void (*toolsFree_t)( void *pointer );
typedef size_t (*toolsMSize_t)( void *pointer );

// The virtual order is recovered from rvToolsStub in quake4.pdb.  The FX
// entries remain in place for ABI compatibility even though this port uses
// BSE and intentionally does not import the Doom particle/FX editor.
class rvTools {
public:
	virtual void *			GetInstance( void ) const = 0;
	virtual void *			GetParentWindow( void ) const = 0;
	virtual void *			GetDC( void ) const = 0;
	virtual bool			IsParentWindowVisible( void ) = 0;
	virtual void			InitTool( int tool, const idDict *dict ) = 0;
	virtual void			ShutdownTool( int tool ) = 0;
	virtual int				IsToolActive( int tool ) = 0;
	virtual void			Frame( void ) = 0;
	virtual void			Shutdown( void ) = 0;
	virtual void			HandleToolPrint( const char *text ) = 0;
	virtual void			HandleMapChange( void ) = 0;
	virtual void			StartLevelLoad( void ) = 0;
	virtual void			EndLevelLoad( void ) = 0;
	virtual rvISourceControl *GetSourceControl( void ) = 0;
	virtual bool			MakeGameCurrent( void ) = 0;
	virtual void			SetDefaultState( void ) = 0;
	virtual void			Set2D( int width, int height ) = 0;
	virtual void			DoRBFDialog( const char *fileName ) = 0;
	virtual void			PlaybackEditorRefresh( void ) = 0;
	virtual void			ModViewShutdown( const char *reason ) = 0;
	virtual void			ModViewRun( void ) = 0;
	virtual int				ModViewGetJointStatus( int joint ) = 0;
	virtual bool			ModViewIsSurfaceSelected( const char *surface ) = 0;
	virtual bool			ModViewIsSurfaceHidden( const char *surface ) = 0;
	virtual const idVec4 *	ModViewGetBgrndColor( void ) = 0;

	virtual bool			FXEditorIsActive( void ) = 0;
	virtual void			FXEditorRefreshEffects( void ) = 0;
	virtual void			FXEditorPlayEffect( bool loop ) = 0;
	virtual void			FXEditorStopEffect( void ) = 0;
	virtual void			FXEditorRefreshMaterials( void ) = 0;

	virtual void			GEAllocateWindowWrapper( idWindow *window ) = 0;
	virtual void			GEDeallocateWindowWrapper( idWindow *window ) = 0;
	virtual void			GEFinish( idWindow *window ) = 0;
	virtual void			GEAddScript( idWindow *window, const char *name, const char *script ) = 0;
	virtual void			GEVariableDictSet( idWindow *window, const char *name, const char *value ) = 0;
	virtual void			GESetStateKey( idWindow *window, const char *name, const char *value, bool update ) = 0;
	virtual void			GEMessage( const char *format, ... ) = 0;
	virtual void			DebuggerPrint( const char *text ) = 0;
	virtual void			DebuggerCheckBreakpoint( idInterpreter *interpreter, idProgram *program, int instructionPointer ) = 0;
	virtual void			DmapCleanupOptimizedShadowTris( int numTris, srfTriangles_s *triangles ) = 0;
	virtual bool			DmapSuperOptimizeOccluders( SOOData_s *data, idVec4 *planes, int *indexes, int numIndexes, idPlane plane, idVec3 origin ) = 0;
	virtual void			DmapOutputString( const char *text ) = 0;
	virtual void			SetListenerArea( int area ) = 0;
	virtual int				GetListenerArea( void ) const = 0;
	virtual void			PhonemeGen( const idCmdArgs &args ) = 0;
	virtual void			ShakesGen( const idCmdArgs &args ) = 0;
	virtual void			RoQFileEncode( const idCmdArgs &args ) = 0;
	virtual void			Renderbump( const idCmdArgs &args ) = 0;
	virtual void			RenderbumpFlat( const idCmdArgs &args ) = 0;
	virtual void			Dmap( const idCmdArgs &args ) = 0;
	virtual void			RunAAS( const idCmdArgs &args ) = 0;
	virtual void			RunAASDir( const idCmdArgs &args ) = 0;
	virtual void			RunReach( const idCmdArgs &args ) = 0;
	virtual void			RunAASTactical( const idCmdArgs &args ) = 0;
	virtual void			LocaliseGuis( const idCmdArgs &args ) = 0;
	virtual void			LocaliseLipsyncs( const idCmdArgs &args ) = 0;
	virtual void			LocaliseMaps( const idCmdArgs &args ) = 0;
	virtual void			LocaliseValidateLipsyncs( const idCmdArgs &args ) = 0;
	virtual void			LocaliseValidateStrings( const idCmdArgs &args ) = 0;
	virtual bool			HandleMessage( tagMSG *message ) = 0;
	virtual int				SetupPixelFormat( HDC dc ) = 0;
	virtual bool			MakeCurrent( HDC dc ) = 0;
	virtual					~rvTools() {}
};

class rvToolsStub : public rvTools {
public:
	virtual void *			GetInstance( void ) const;
	virtual void *			GetParentWindow( void ) const;
	virtual void *			GetDC( void ) const;
	virtual bool			IsParentWindowVisible( void );
	virtual void			InitTool( int tool, const idDict *dict );
	virtual void			ShutdownTool( int tool );
	virtual int				IsToolActive( int tool );
	virtual void			Frame( void );
	virtual void			Shutdown( void );
	virtual void			HandleToolPrint( const char *text );
	virtual void			HandleMapChange( void );
	virtual void			StartLevelLoad( void );
	virtual void			EndLevelLoad( void );
	virtual rvISourceControl *GetSourceControl( void );
	virtual bool			MakeGameCurrent( void );
	virtual void			SetDefaultState( void );
	virtual void			Set2D( int width, int height );
	virtual void			DoRBFDialog( const char *fileName );
	virtual void			PlaybackEditorRefresh( void );
	virtual void			ModViewShutdown( const char *reason );
	virtual void			ModViewRun( void );
	virtual int				ModViewGetJointStatus( int joint );
	virtual bool			ModViewIsSurfaceSelected( const char *surface );
	virtual bool			ModViewIsSurfaceHidden( const char *surface );
	virtual const idVec4 *	ModViewGetBgrndColor( void );
	virtual bool			FXEditorIsActive( void );
	virtual void			FXEditorRefreshEffects( void );
	virtual void			FXEditorPlayEffect( bool loop );
	virtual void			FXEditorStopEffect( void );
	virtual void			FXEditorRefreshMaterials( void );
	virtual void			GEAllocateWindowWrapper( idWindow *window );
	virtual void			GEDeallocateWindowWrapper( idWindow *window );
	virtual void			GEFinish( idWindow *window );
	virtual void			GEAddScript( idWindow *window, const char *name, const char *script );
	virtual void			GEVariableDictSet( idWindow *window, const char *name, const char *value );
	virtual void			GESetStateKey( idWindow *window, const char *name, const char *value, bool update );
	virtual void			GEMessage( const char *format, ... );
	virtual void			DebuggerPrint( const char *text );
	virtual void			DebuggerCheckBreakpoint( idInterpreter *interpreter, idProgram *program, int instructionPointer );
	virtual void			DmapCleanupOptimizedShadowTris( int numTris, srfTriangles_s *triangles );
	virtual bool			DmapSuperOptimizeOccluders( SOOData_s *data, idVec4 *planes, int *indexes, int numIndexes, idPlane plane, idVec3 origin );
	virtual void			DmapOutputString( const char *text );
	virtual void			SetListenerArea( int area );
	virtual int				GetListenerArea( void ) const;
	virtual void			PhonemeGen( const idCmdArgs &args );
	virtual void			ShakesGen( const idCmdArgs &args );
	virtual void			RoQFileEncode( const idCmdArgs &args );
	virtual void			Renderbump( const idCmdArgs &args );
	virtual void			RenderbumpFlat( const idCmdArgs &args );
	virtual void			Dmap( const idCmdArgs &args );
	virtual void			RunAAS( const idCmdArgs &args );
	virtual void			RunAASDir( const idCmdArgs &args );
	virtual void			RunReach( const idCmdArgs &args );
	virtual void			RunAASTactical( const idCmdArgs &args );
	virtual void			LocaliseGuis( const idCmdArgs &args );
	virtual void			LocaliseLipsyncs( const idCmdArgs &args );
	virtual void			LocaliseMaps( const idCmdArgs &args );
	virtual void			LocaliseValidateLipsyncs( const idCmdArgs &args );
	virtual void			LocaliseValidateStrings( const idCmdArgs &args );
	virtual bool			HandleMessage( tagMSG *message );
	virtual int				SetupPixelFormat( HDC dc );
	virtual bool			MakeCurrent( HDC dc );
	virtual					~rvToolsStub() {}
};

struct toolsImport_t {
	int						version;
	int						instance;
	void *					ownerWnd;
	void *					ownerDC;
	void *					hGLRC;
	void *					pfd;
	idSys *					sys;
	idCommon *				common;
	idCmdSystem *			cmdSystem;
	idCVarSystem *			cvarSystem;
	idFileSystem *			fileSystem;
	idRenderSystem *			renderSystem;
	idSoundSystem *			soundSystem;
	idRenderModelManager *	renderModelManager;
	idUserInterfaceManager *uiManager;
	idDeclManager *			declManager;
	idAASFile *				AASFile;
	class idCollisionModelManager *collisionModelManager;
	idGameEdit *				gameEdit;
	rvMaterialEdit *			materialEdit;
	rvSoundShaderEdit *		soundShaderEdit;
	rvDeclAFEdit *				declAFEdit;
	rvDeclPlaybackEdit *		declPlaybackEdit;
	rvDeclEffectEdit *			declEffectEdit;
	rvDeclLipSyncEdit *		declLipSyncEdit;
	rvWindowEdit *				windowEdit;
	rvVarEdit *				varEdit;
	idSession *				session;
	idImageManager *			globalImages;
	class idConsole *			console;
};

struct toolsExport_t {
	int			version;
	rvTools *	tools;
};

typedef toolsExport_t *(*GetToolsAPI_t)(
	toolsImport_t *imports,
	toolsAlloc_t allocator,
	toolsFree_t deallocator,
	toolsMSize_t msize
);

#if defined( _WIN32 ) && !defined( _WIN64 )
static_assert( sizeof( toolsImport_t ) == 120, "retail toolsImport_t ABI drift" );
static_assert( sizeof( toolsExport_t ) == 8, "retail toolsExport_t ABI drift" );
static_assert( sizeof( SOOData_s ) == 32, "retail SOOData_s ABI drift" );
static_assert( sizeof( indexRef_s ) == 16, "retail indexRef_s ABI drift" );
#endif

extern rvToolsStub toolsStub;
extern rvTools *tools;

#endif /* !__TOOLS_H__ */
