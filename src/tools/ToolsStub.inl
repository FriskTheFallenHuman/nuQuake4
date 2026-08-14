/* Shared no-op rvTools implementation used before the tools DLL is loaded. */

inline void *rvToolsStub::GetInstance( void ) const { return NULL; }
inline void *rvToolsStub::GetParentWindow( void ) const { return NULL; }
inline void *rvToolsStub::GetDC( void ) const { return NULL; }
inline bool rvToolsStub::IsParentWindowVisible( void ) { return false; }
inline void rvToolsStub::InitTool( int tool, const idDict *dict ) {}
inline void rvToolsStub::ShutdownTool( int tool ) {}
inline int rvToolsStub::IsToolActive( int tool ) { return 0; }
inline void rvToolsStub::Frame( void ) {}
inline void rvToolsStub::Shutdown( void ) {}
inline void rvToolsStub::HandleToolPrint( const char *text ) {}
inline void rvToolsStub::HandleMapChange( void ) {}
inline void rvToolsStub::StartLevelLoad( void ) {}
inline void rvToolsStub::EndLevelLoad( void ) {}
inline rvISourceControl *rvToolsStub::GetSourceControl( void ) { return NULL; }
inline bool rvToolsStub::MakeGameCurrent( void ) { return false; }
inline void rvToolsStub::SetDefaultState( void ) {}
inline void rvToolsStub::Set2D( int width, int height ) {}
inline void rvToolsStub::DoRBFDialog( const char *fileName ) {}
inline void rvToolsStub::PlaybackEditorRefresh( void ) {}
inline void rvToolsStub::ModViewShutdown( const char *reason ) {}
inline void rvToolsStub::ModViewRun( void ) {}
inline int rvToolsStub::ModViewGetJointStatus( int joint ) { return 0; }
inline bool rvToolsStub::ModViewIsSurfaceSelected( const char *surface ) { return false; }
inline bool rvToolsStub::ModViewIsSurfaceHidden( const char *surface ) { return false; }
inline const idVec4 *rvToolsStub::ModViewGetBgrndColor( void ) { return NULL; }
inline bool rvToolsStub::FXEditorIsActive( void ) { return false; }
inline void rvToolsStub::FXEditorRefreshEffects( void ) {}
inline void rvToolsStub::FXEditorPlayEffect( bool loop ) {}
inline void rvToolsStub::FXEditorStopEffect( void ) {}
inline void rvToolsStub::FXEditorRefreshMaterials( void ) {}
inline void rvToolsStub::GEAllocateWindowWrapper( idWindow *window ) {}
inline void rvToolsStub::GEDeallocateWindowWrapper( idWindow *window ) {}
inline void rvToolsStub::GEFinish( idWindow *window ) {}
inline void rvToolsStub::GEAddScript( idWindow *window, const char *name, const char *script ) {}
inline void rvToolsStub::GEVariableDictSet( idWindow *window, const char *name, const char *value ) {}
inline void rvToolsStub::GESetStateKey( idWindow *window, const char *name, const char *value, bool update ) {}
inline void rvToolsStub::GEMessage( const char *format, ... ) {}
inline void rvToolsStub::DebuggerPrint( const char *text ) {}
inline void rvToolsStub::DebuggerCheckBreakpoint( idInterpreter *interpreter, idProgram *program, int instructionPointer ) {}
inline void rvToolsStub::DmapCleanupOptimizedShadowTris( int numTris, srfTriangles_s *triangles ) {}
inline bool rvToolsStub::DmapSuperOptimizeOccluders( SOOData_s *data, idVec4 *planes, int *indexes, int numIndexes, idPlane plane, idVec3 origin ) { return false; }
inline void rvToolsStub::DmapOutputString( const char *text ) {}
inline void rvToolsStub::SetListenerArea( int area ) {}
inline int rvToolsStub::GetListenerArea( void ) const { return -1; }
inline void rvToolsStub::PhonemeGen( const idCmdArgs &args ) {}
inline void rvToolsStub::ShakesGen( const idCmdArgs &args ) {}
inline void rvToolsStub::RoQFileEncode( const idCmdArgs &args ) {}
inline void rvToolsStub::Renderbump( const idCmdArgs &args ) {}
inline void rvToolsStub::RenderbumpFlat( const idCmdArgs &args ) {}
inline void rvToolsStub::Dmap( const idCmdArgs &args ) {}
inline void rvToolsStub::RunAAS( const idCmdArgs &args ) {}
inline void rvToolsStub::RunAASDir( const idCmdArgs &args ) {}
inline void rvToolsStub::RunReach( const idCmdArgs &args ) {}
inline void rvToolsStub::RunAASTactical( const idCmdArgs &args ) {}
inline void rvToolsStub::LocaliseGuis( const idCmdArgs &args ) {}
inline void rvToolsStub::LocaliseLipsyncs( const idCmdArgs &args ) {}
inline void rvToolsStub::LocaliseMaps( const idCmdArgs &args ) {}
inline void rvToolsStub::LocaliseValidateLipsyncs( const idCmdArgs &args ) {}
inline void rvToolsStub::LocaliseValidateStrings( const idCmdArgs &args ) {}
inline bool rvToolsStub::HandleMessage( tagMSG *message ) { return false; }
inline int rvToolsStub::SetupPixelFormat( HDC dc ) { return 0; }
inline bool rvToolsStub::MakeCurrent( HDC dc ) { return false; }
