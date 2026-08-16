cmake_minimum_required(VERSION 3.25)

project(nuQuake4 LANGUAGES C CXX)

get_filename_component(Q4_RUNTIME_DIR "${PROJECT_SOURCE_DIR}/.." ABSOLUTE)

if(NOT WIN32)
	message(FATAL_ERROR "Non Windows builds are not supported yet")
endif()

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 4)
	message(FATAL_ERROR "x64 Builds are not supported yet")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

option(BUILD_GAMEDLL "Build the game DLL" ON)
option(BUILD_MPGAMEDLL "Build the multiplayer game DLL" ON)
option(BUILD_TOOLS_DLL "Build the tools DLL" ON)

#
# Common flags for all targets
#
add_library(commonFlags INTERFACE)

target_include_directories(commonFlags INTERFACE
	${PROJECT_SOURCE_DIR}
	${PROJECT_SOURCE_DIR}/idlib
	${PROJECT_SOURCE_DIR}/renderer/jpeg-6
	${PROJECT_SOURCE_DIR}/sound/OggVorbis
	${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg
	${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg/include
	${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis
	${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis/include
	${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbissrc
	${PROJECT_SOURCE_DIR}/directxSDK/Include)

target_link_directories(commonFlags INTERFACE
	${PROJECT_SOURCE_DIR}/directxSDK/Lib/x86
	${PROJECT_SOURCE_DIR}/openal/lib)

if(WIN32)
	target_compile_definitions(commonFlags INTERFACE WIN32 _WINDOWS)
	target_link_libraries(commonFlags INTERFACE
		opengl32
		user32
		gdi32
		winmm
		ws2_32
		iphlpapi
		dbghelp
		comctl32
		comdlg32
		shell32
		glu32
		dinput8
		dsound
		dxguid)
endif()

target_compile_definitions(commonFlags INTERFACE
	_LOAD_DLL
	__DOOM__
	__DOOM_DLL__
	Q4_NO_PUNKBUSTER
	$<$<CONFIG:Debug>:_DEBUG>
	$<$<CONFIG:Release>:NDEBUG;_FINAL>
	ID_ENABLE_CURL=0)

if(MSVC)
	target_compile_definitions(commonFlags INTERFACE _CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)

	# The target was built by VC 7.1. Keep its language behavior while using a
	# current compiler; stricter conformance is enabled only after ABI parity.
	target_compile_options(commonFlags INTERFACE /MP /permissive /Zc:strictStrings- /Zc:forScope-)
	set_target_properties(commonFlags PROPERTIES INTERFACE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

	# Keep debugging symbols for crash analysis (no forced PDB path).
	target_compile_options(commonFlags INTERFACE /Zi)
	target_link_options(commonFlags INTERFACE /STACK:16777216,4096)
endif()

#
# idlib static library
#
set(IDLIB_SOURCES
	${PROJECT_SOURCE_DIR}/idlib/BitMsg.cpp
	${PROJECT_SOURCE_DIR}/idlib/CmdArgs.cpp
	${PROJECT_SOURCE_DIR}/idlib/Dict.cpp
	${PROJECT_SOURCE_DIR}/idlib/Heap.cpp
	${PROJECT_SOURCE_DIR}/idlib/LangDict.cpp
	${PROJECT_SOURCE_DIR}/idlib/Lexer.cpp
	${PROJECT_SOURCE_DIR}/idlib/LexerFactory.cpp
	${PROJECT_SOURCE_DIR}/idlib/Lib.cpp
	${PROJECT_SOURCE_DIR}/idlib/mapfile.cpp
	${PROJECT_SOURCE_DIR}/idlib/Parser.cpp
	${PROJECT_SOURCE_DIR}/idlib/Str.cpp
	${PROJECT_SOURCE_DIR}/idlib/Timer.cpp
	${PROJECT_SOURCE_DIR}/idlib/Token.cpp
	${PROJECT_SOURCE_DIR}/idlib/bv/Bounds.cpp
	${PROJECT_SOURCE_DIR}/idlib/bv/Box.cpp
	${PROJECT_SOURCE_DIR}/idlib/bv/Frustum.cpp
	${PROJECT_SOURCE_DIR}/idlib/bv/Sphere.cpp
	${PROJECT_SOURCE_DIR}/idlib/containers/HashIndex.cpp
	${PROJECT_SOURCE_DIR}/idlib/geometry/JointTransform.cpp
	${PROJECT_SOURCE_DIR}/idlib/geometry/Surface.cpp
	${PROJECT_SOURCE_DIR}/idlib/geometry/Surface_Patch.cpp
	${PROJECT_SOURCE_DIR}/idlib/geometry/TraceModel.cpp
	${PROJECT_SOURCE_DIR}/idlib/geometry/Winding.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Angles.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Math.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Matrix.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Plane.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Polynomial.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Quat.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Radians.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Rotation.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_3DNow.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_generic.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_MMX.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_SSE.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_SSE2.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Simd_SSE3.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Vector.cpp
	${PROJECT_SOURCE_DIR}/idlib/hashing/CRC32.cpp
	${PROJECT_SOURCE_DIR}/idlib/hashing/MD4.cpp
	${PROJECT_SOURCE_DIR}/idlib/hashing/MD5.cpp)

source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${IDLIB_SOURCES})

add_library(idlib STATIC ${IDLIB_SOURCES})
target_link_libraries(idlib PRIVATE commonFlags)
target_compile_definitions(idlib
	PRIVATE
		Q4_RECON_SEED
		Q4_RECON_ENGINE_PRIVATE
		Q4_RECON_SDK_MSGQUEUE
)

target_precompile_headers(idlib PRIVATE ${PROJECT_SOURCE_DIR}/idlib/precompiled.h)

#
# gameLib static library
#

# The Quake 4 SDK builds idlib a second time with Q4SDK for gamex86.dll.
# Several public classes (notably the SIMD hierarchy) are macro-sensitive, so
# linking the engine-private idlib into the game DLL gives the DLL a different
# vtable layout than the one seen by its game translation units.
set(GAMEIDLIB_SOURCES
	${IDLIB_SOURCES}
	${PROJECT_SOURCE_DIR}/idlib/geometry/Winding2D.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Lcp.cpp
	${PROJECT_SOURCE_DIR}/idlib/math/Ode.cpp)

source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${GAMEIDLIB_SOURCES})

add_library(gameLib STATIC ${GAMEIDLIB_SOURCES})
target_compile_definitions(gameLib PRIVATE Q4SDK)
target_precompile_headers(gameLib PRIVATE ${PROJECT_SOURCE_DIR}/idlib/precompiled.h)

#
# Quake4 executable project
#

file(GLOB_RECURSE AAS_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/aas/*.cpp)

set(AAS_COMPILER_SOURCES
	${PROJECT_SOURCE_DIR}/aas/AASSettingsTools.cpp
	${PROJECT_SOURCE_DIR}/aas/AASTactical.cpp
	${PROJECT_SOURCE_DIR}/aas/AASBuild.cpp
	${PROJECT_SOURCE_DIR}/aas/AASBuild_file.cpp
	${PROJECT_SOURCE_DIR}/aas/AASBuild_gravity.cpp
	${PROJECT_SOURCE_DIR}/aas/AASBuild_ledge.cpp
	${PROJECT_SOURCE_DIR}/aas/AASBuild_merge.cpp
	${PROJECT_SOURCE_DIR}/aas/AASCluster.cpp
	${PROJECT_SOURCE_DIR}/aas/AASReach.cpp
	${PROJECT_SOURCE_DIR}/aas/Brush.cpp
	${PROJECT_SOURCE_DIR}/aas/BrushBSP.cpp
)
list(REMOVE_ITEM AAS_SOURCES ${AAS_COMPILER_SOURCES})

file(GLOB_RECURSE CM_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/cm/*.cpp)

file(GLOB FRAMEWORK_TOP_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/framework/*.cpp)
set(FRAMEWORK_PLAYER_MODEL_SOURCE ${PROJECT_SOURCE_DIR}/framework/DeclPlayerModel.cpp)
set(FRAMEWORK_ENGINE_TOP_SOURCES ${FRAMEWORK_TOP_SOURCES})

# DeclPlayerModel is owned by gamex86.dll in the retail PDB.  Keep it out of
# Quake4.exe so the reconstructed compiland and its allocator live in the same
# module that registers DECL_PLAYER_MODEL.
list(REMOVE_ITEM FRAMEWORK_ENGINE_TOP_SOURCES ${FRAMEWORK_PLAYER_MODEL_SOURCE})
file(GLOB FRAMEWORK_ASYNC_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/framework/async/*.cpp)

file(GLOB_RECURSE UI_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/ui/*.cpp)

# Retail Quake4.exe renderer compilation units.  Keep this explicit: the PDB
# records one object for each entry and the list doubles as a boundary audit.
set(RENDERER_SOURCES
	${PROJECT_SOURCE_DIR}/renderer/Cinematic.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_arb.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_arb2.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_common.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_nv10.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_nv20.cpp
	${PROJECT_SOURCE_DIR}/renderer/draw_r200.cpp
	${PROJECT_SOURCE_DIR}/renderer/GuiModel.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_files.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_init.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_load.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_process.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_program.cpp
	${PROJECT_SOURCE_DIR}/renderer/Image_stats.cpp
	${PROJECT_SOURCE_DIR}/renderer/Interaction.cpp
	${PROJECT_SOURCE_DIR}/renderer/Material.cpp
	${PROJECT_SOURCE_DIR}/renderer/MegaTexture.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model.cpp
	${PROJECT_SOURCE_DIR}/renderer/ModelDecal.cpp
	${PROJECT_SOURCE_DIR}/renderer/ModelManager.cpp
	${PROJECT_SOURCE_DIR}/renderer/ModelOverlay.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_ase.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_beam.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_liquid.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_lwo.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_ma.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_md3.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_md5.cpp
	${PROJECT_SOURCE_DIR}/renderer/Model_sprite.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderEntity.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderSystem.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderSystem_init.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderWorld.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderWorld_demo.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderWorld_load.cpp
	${PROJECT_SOURCE_DIR}/renderer/RenderWorld_portals.cpp
	${PROJECT_SOURCE_DIR}/renderer/Shaders.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvGLSLShader.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvIndexBuffer.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvMesh.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvPrimBatch.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvRenderModelMD5R.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvSpecial.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvTexRenderTarget.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvVertexBuffer.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvVertexBufferCopy.cpp
	${PROJECT_SOURCE_DIR}/renderer/rvVertexFormat.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_backend.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_deform.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_font.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_guisurf.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_light.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_lightrun.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_main.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_orderIndexes.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_polytope.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_render.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_rendertools.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_shadowbounds.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_stencilshadow.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_subview.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_trace.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_trisurf.cpp
	${PROJECT_SOURCE_DIR}/renderer/tr_turboshadow.cpp
	${PROJECT_SOURCE_DIR}/renderer/VertexCache.cpp)

# Retail BSE object boundaries recovered from quake4.pdb.
set(BSE_SOURCES
	${PROJECT_SOURCE_DIR}/bse/BSE_Bounds.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Effect.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_EffectTemplate.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Electricity.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Envelopes.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Light.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Manager.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_ParseParticle2.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Particle.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Render.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_Segment.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_SegmentTemplate.cpp
	${PROJECT_SOURCE_DIR}/bse/BSE_SpawnDomains.cpp)

file(GLOB JPEG_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/renderer/jpeg-6/*.c)
file(GLOB_RECURSE SOUND_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/sound/*.cpp)
file(GLOB_RECURSE OGGVORBIS_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/sound/OggVorbis/*.c)
set(OPENAL_LOADER_SOURCES ${PROJECT_SOURCE_DIR}/openal/idal.cpp)

file(GLOB_RECURSE SYS_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/sys/*.cpp ${PROJECT_SOURCE_DIR}/sys/win32/rc/Quake4.rc)

set(ENGINE_SOURCES
	${AAS_SOURCES}
	${CM_SOURCES}
	${FRAMEWORK_ENGINE_TOP_SOURCES}
	${FRAMEWORK_ASYNC_SOURCES}
	${UI_SOURCES}
	${RENDERER_SOURCES}
	${BSE_SOURCES}
	${JPEG_SOURCES}
	${SOUND_SOURCES}
	${OGGVORBIS_SOURCES}
	${OPENAL_LOADER_SOURCES}
	${SYS_SOURCES})

source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${ENGINE_SOURCES})

add_executable(Quake4 WIN32 ${ENGINE_SOURCES})

target_include_directories(Quake4 PRIVATE
	${PROJECT_SOURCE_DIR}/sound
	${PROJECT_SOURCE_DIR}/sys/win32)

target_compile_definitions(Quake4 PRIVATE
	Q4_RECON_SEED
	Q4_RECON_ENGINE_PRIVATE
	Q4_RECON_SDK_MSGQUEUE
	Q4_DISABLE_TASKKEY_HOOK
	Q4_DISABLE_TOOLS
	Q4_DISABLE_GL_LOGGING
	Q4_RECONSTRUCTED_SOUND)

target_link_libraries(Quake4 PRIVATE commonFlags idlib)

set_target_properties(Quake4 PROPERTIES
	OUTPUT_NAME Quake4
	RUNTIME_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}"
	LIBRARY_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}"
	LINK_FLAGS "/MAP:\"${Q4_RUNTIME_DIR}/Quake4.map\""
	VS_STARTUP_PROJECT Quake4
	VS_DEBUGGER_WORKING_DIRECTORY ${Q4_RUNTIME_DIR}
	VS_DEBUGGER_COMMAND_ARGUMENTS "+set r_fullscreen 0 +set win_viewlog 1 +set developer 1")

#
# single player gamex86 dll project
#
if(BUILD_GAMEDLL)
	file(GLOB_RECURSE GAME_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/game/*.cpp ${PROJECT_SOURCE_DIR}/framework/DeclPlayerModel.cpp)

	source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${GAME_SOURCES})

	# Callbacks.cpp is generated-style source text included by gamesys/Class.cpp;
	# it is not a standalone translation unit in the Quake 4 SDK project.
	list(REMOVE_ITEM GAME_SOURCES ${PROJECT_SOURCE_DIR}/game/gamesys/Callbacks.cpp)

	add_library(gamex86 SHARED ${GAME_SOURCES})

	target_include_directories(gamex86 PRIVATE ${PROJECT_SOURCE_DIR}/game)
	target_compile_definitions(gamex86 PRIVATE GAME_DLL	Q4SDK Q4_RECON_RETAIL_UI_MANAGER_ABI)
	target_link_libraries(gamex86 PRIVATE commonFlags gameLib)

	if(MSVC)
		target_link_options(gamex86 PRIVATE /DEF:${PROJECT_SOURCE_DIR}/game/game.def)
	endif()

	set_target_properties(gamex86 PROPERTIES
		OUTPUT_NAME gamex86
		PREFIX ""
		RUNTIME_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}/q4base"
		LIBRARY_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}/q4base"
		LINK_FLAGS "/MAP:\"${Q4_RUNTIME_DIR}/q4base/gamex86.map\"")
endif()

#
# multiplayer player gamex86 dll project
#
if(BUILD_MPGAMEDLL)
	file(GLOB_RECURSE MPGAME_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/mpgame/*.cpp ${PROJECT_SOURCE_DIR}/framework/DeclPlayerModel.cpp)

	source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${MPGAME_SOURCES})

	# Callbacks.cpp is generated-style source text included by gamesys/Class.cpp;
	# it is not a standalone translation unit in the Quake 4 SDK project.
	list(REMOVE_ITEM MPGAME_SOURCES ${PROJECT_SOURCE_DIR}/mpgame/gamesys/Callbacks.cpp)

	add_library(mpgamex86 SHARED ${MPGAME_SOURCES})

	target_include_directories(mpgamex86 PRIVATE ${PROJECT_SOURCE_DIR}/mpgame)
	target_compile_definitions(mpgamex86 PRIVATE GAME_DLL	GAME_MPAPI Q4SDK Q4_RECON_RETAIL_UI_MANAGER_ABI)
	target_link_libraries(mpgamex86 PRIVATE commonFlags gameLib)

	if(MSVC)
		target_link_options(mpgamex86 PRIVATE /DEF:${PROJECT_SOURCE_DIR}/mpgame/mpgame.def)
	endif()

	set_target_properties(mpgamex86 PROPERTIES
		OUTPUT_NAME gamex86 # needs to be name gamex86
		PREFIX ""
		RUNTIME_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}/q4mp"
		LIBRARY_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}/q4mp"
		LINK_FLAGS "/MAP:\"${Q4_RUNTIME_DIR}/q4mp/gamex86.map\"")
endif()

if(BUILD_TOOLS_DLL)
	file(GLOB RADIANT_SOURCES CONFIGURE_DEPENDS
		${PROJECT_SOURCE_DIR}/tools/radiant/*.cpp
		${PROJECT_SOURCE_DIR}/tools/common/*.cpp
		${PROJECT_SOURCE_DIR}/tools/comafx/*.cpp)

	set_source_files_properties(${RADIANT_SOURCES} PROPERTIES COMPILE_OPTIONS "/FI${PROJECT_SOURCE_DIR}/tools/comafx/StdAfx.h")

	set(TOOLS_SOURCES
		${PROJECT_SOURCE_DIR}/tools/ToolsStub.cpp
		${PROJECT_SOURCE_DIR}/tools/ToolRenderAdapters.cpp
		${PROJECT_SOURCE_DIR}/tools/rc/Radiant.rc
		${PROJECT_SOURCE_DIR}/tools/rc/Common.rc
		${PROJECT_SOURCE_DIR}/tools/rc/PropTree.rc
		${PROJECT_SOURCE_DIR}/idlib/geometry/Surface_SweptSpline.cpp
		${PROJECT_SOURCE_DIR}/aas/AASSettingsTools.cpp
		${PROJECT_SOURCE_DIR}/aas/AASTactical.cpp
		${PROJECT_SOURCE_DIR}/aas/AASBuild.cpp
		${PROJECT_SOURCE_DIR}/aas/AASBuild_file.cpp
		${PROJECT_SOURCE_DIR}/aas/AASBuild_gravity.cpp
		${PROJECT_SOURCE_DIR}/aas/AASBuild_ledge.cpp
		${PROJECT_SOURCE_DIR}/aas/AASBuild_merge.cpp
		${PROJECT_SOURCE_DIR}/aas/AASCluster.cpp
		${PROJECT_SOURCE_DIR}/aas/AASReach.cpp
		${PROJECT_SOURCE_DIR}/aas/Brush.cpp
		${PROJECT_SOURCE_DIR}/aas/BrushBSP.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/dmap.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/facebsp.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/gldraw.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/glfile.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/leakfile.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/map.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/optimize.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/optimize_gcc.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/output.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/portals.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/shadowopt3.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/tritjunction.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/tritools.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/ubrush.cpp
		${PROJECT_SOURCE_DIR}/tools/compilers/dmap/usurface.cpp
		${RADIANT_SOURCES})

	source_group(TREE ${PROJECT_SOURCE_DIR} PREFIX src FILES ${TOOLS_SOURCES})

	add_library(tools SHARED ${TOOLS_SOURCES})

	if(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION)
		target_include_directories(tools BEFORE PRIVATE
			"C:/Program Files (x86)/Windows Kits/10/Include/${CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION}/shared"
		)
	endif()

	target_compile_definitions(tools PRIVATE
		_AFXDLL
		ID_GL_HARDLINK
		Q4_RECON_ENGINE_PRIVATE
		Q4_RECON_SDK_MSGQUEUE)

	target_link_libraries(tools PRIVATE commonFlags idlib)

	if(MSVC)
		target_link_options(tools PRIVATE /DEF:${PROJECT_SOURCE_DIR}/tools/Toolsx86.def)
	endif()

	set_target_properties(tools PROPERTIES
		OUTPUT_NAME Toolsx86
		PREFIX ""
		RUNTIME_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}"
		LIBRARY_OUTPUT_DIRECTORY "$<1:>${Q4_RUNTIME_DIR}"
		LINK_FLAGS "/MAP:\"${Q4_RUNTIME_DIR}/Toolsx86.map\""
		MFC_FLAG 2)
endif()