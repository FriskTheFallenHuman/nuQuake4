cmake_minimum_required(VERSION 3.25)

project(Quake4Reconstruction LANGUAGES C CXX)

get_filename_component(Q4_RUNTIME_DIR "${PROJECT_SOURCE_DIR}/.." ABSOLUTE)
set(Q4_BASE_GAMEDIR "base")

if(NOT WIN32)
    message(FATAL_ERROR "The initial reconstruction target is 32-bit Windows")
endif()

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 4)
    message(FATAL_ERROR "Configure with a Win32/x86 generator; the recovered ABI is 32-bit")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

option(Q4_BUILD_IDLIB "Build the Quake 4 SDK idlib seed" ON)
option(Q4_BUILD_ENGINE_SEED "Compile the PDB-proven Doom engine seed" ON)
option(Q4_BUILD_GAME_DLL "Build the Quake 4 single-player game DLL" ON)
option(Q4_BUILD_TOOLS_DLL "Build the reconstructed Quake 4 tools DLL" ON)
option(Q4_BUILD_RECON_TOOLS "Build reconstruction inventory tools" ON)

if(MSVC)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
    # The target was built by VC 7.1. Keep its language behavior while using a
    # current compiler; stricter conformance is enabled only after ABI parity.
    add_compile_options(/W3 /MP /permissive /Zc:strictStrings- /Zc:forScope-)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

# The build is intentionally defined in this file. CSV files under
# docs/reconstruction are provenance reports, not build inputs.
if(Q4_BUILD_IDLIB)
# This is the exact first-party idlib compiland set recorded in quake4.pdb.
# Additional SDK files remain in the tree for the game DLLs but are not linked
# into the reconstructed executable until evidence assigns them to the target.
set(Q4_IDLIB_SOURCES
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
    ${PROJECT_SOURCE_DIR}/idlib/hashing/MD5.cpp
)

add_library(q4_idlib STATIC ${Q4_IDLIB_SOURCES})

target_include_directories(q4_idlib
    PUBLIC
        ${PROJECT_SOURCE_DIR}
        ${PROJECT_SOURCE_DIR}/idlib
    PRIVATE
        "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
)

target_compile_definitions(q4_idlib
    PRIVATE
        WIN32
        _WINDOWS
        _LOAD_DLL
        _USE_32BIT_TIME_T
        Q4_NO_PUNKBUSTER
        Q4_RECON_SEED
        Q4_RECON_ENGINE_PRIVATE
        Q4_RECON_SDK_MSGQUEUE
        $<$<CONFIG:Debug>:_DEBUG>
        $<$<CONFIG:Release>:NDEBUG;_FINAL>
)

target_precompile_headers(q4_idlib PRIVATE ${PROJECT_SOURCE_DIR}/idlib/precompiled.h)

set_target_properties(q4_idlib PROPERTIES
    OUTPUT_NAME idlib
    FOLDER "Engine"
)

# The Quake 4 SDK builds idlib a second time with Q4SDK for gamex86.dll.
# Several public classes (notably the SIMD hierarchy) are macro-sensitive, so
# linking the engine-private idlib into the game DLL gives the DLL a different
# vtable layout than the one seen by its game translation units.
set(Q4_GAME_IDLIB_SOURCES
    ${Q4_IDLIB_SOURCES}
    ${PROJECT_SOURCE_DIR}/idlib/geometry/Winding2D.cpp
    ${PROJECT_SOURCE_DIR}/idlib/math/Lcp.cpp
    ${PROJECT_SOURCE_DIR}/idlib/math/Ode.cpp
)

add_library(q4_game_idlib STATIC ${Q4_GAME_IDLIB_SOURCES})

target_include_directories(q4_game_idlib
    PUBLIC
        ${PROJECT_SOURCE_DIR}
        ${PROJECT_SOURCE_DIR}/idlib
    PRIVATE
        "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
)

target_compile_definitions(q4_game_idlib
    PRIVATE
        WIN32
        _WINDOWS
        _USE_32BIT_TIME_T
        Q4SDK
        Q4_NO_PUNKBUSTER
        $<$<CONFIG:Debug>:_DEBUG>
        $<$<CONFIG:Release>:NDEBUG;_FINAL>
)

target_precompile_headers(q4_game_idlib PRIVATE ${PROJECT_SOURCE_DIR}/idlib/precompiled.h)

set_target_properties(q4_game_idlib PROPERTIES
    OUTPUT_NAME game_idlib
    FOLDER "Game"
)

endif()

if(Q4_BUILD_ENGINE_SEED)
function(q4_add_engine_object target)
    add_library(${target} OBJECT ${ARGN})
    target_include_directories(${target}
        PRIVATE
            ${PROJECT_SOURCE_DIR}
            ${PROJECT_SOURCE_DIR}/renderer/jpeg-6
            ${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg/include
            ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis/include
            "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
    )
    target_compile_definitions(${target}
        PRIVATE
            WIN32
            _WINDOWS
            _LOAD_DLL
            _USE_32BIT_TIME_T
            Q4_NO_PUNKBUSTER
            Q4_RECON_SEED
            Q4_DISABLE_TOOLS
            Q4_DISABLE_GL_LOGGING
            Q4_DISABLE_TASKKEY_HOOK
            $<$<CONFIG:Debug>:_DEBUG>
            $<$<CONFIG:Release>:NDEBUG;_FINAL>
    )
    set_target_properties(${target} PROPERTIES FOLDER "Engine/Seed")
endfunction()

file(GLOB_RECURSE Q4_AAS_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/aas/*.cpp
)
set(Q4_AAS_FILE_SOURCE ${PROJECT_SOURCE_DIR}/aas/AASFile.cpp)
set(Q4_AAS_COMPILER_SOURCES
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
list(REMOVE_ITEM Q4_AAS_SOURCES ${Q4_AAS_COMPILER_SOURCES})

file(GLOB_RECURSE Q4_CM_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/cm/*.cpp
)
set(Q4_CM_MODEL_SOURCE ${PROJECT_SOURCE_DIR}/cm/CollisionModel.cpp)
set(Q4_CM_LOAD_SOURCE ${PROJECT_SOURCE_DIR}/cm/collisionmodel_load.cpp)
set(Q4_CM_CONTACTS_SOURCE ${PROJECT_SOURCE_DIR}/cm/collisionmodel_contacts.cpp)
set(Q4_CM_CONTENTS_SOURCE ${PROJECT_SOURCE_DIR}/cm/collisionmodel_contents.cpp)
set(Q4_CM_TRACE_SOURCE ${PROJECT_SOURCE_DIR}/cm/collisionmodel_trace.cpp)
set(Q4_CM_TRANSLATE_SOURCE ${PROJECT_SOURCE_DIR}/cm/collisionmodel_translate.cpp)
list(REMOVE_ITEM Q4_CM_SOURCES ${Q4_CM_MODEL_SOURCE})

file(GLOB Q4_FRAMEWORK_TOP_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/framework/*.cpp)
set(Q4_FRAMEWORK_PLAYER_MODEL_SOURCE ${PROJECT_SOURCE_DIR}/framework/DeclPlayerModel.cpp)
set(Q4_FRAMEWORK_ENGINE_TOP_SOURCES ${Q4_FRAMEWORK_TOP_SOURCES})
# DeclPlayerModel is owned by gamex86.dll in the retail PDB.  Keep it out of
# darkgame.exe so the reconstructed compiland and its allocator live in the same
# module that registers DECL_PLAYER_MODEL.
list(REMOVE_ITEM Q4_FRAMEWORK_ENGINE_TOP_SOURCES ${Q4_FRAMEWORK_PLAYER_MODEL_SOURCE})
set(Q4_FRAMEWORK_SESSION_SOURCES
    ${PROJECT_SOURCE_DIR}/framework/common.cpp
    ${PROJECT_SOURCE_DIR}/framework/session.cpp
    ${PROJECT_SOURCE_DIR}/framework/session_menu.cpp
)
set(Q4_FRAMEWORK_EDITFIELD_SOURCE ${PROJECT_SOURCE_DIR}/framework/editfield.cpp)
set(Q4_FRAMEWORK_CONSOLE_SOURCE ${PROJECT_SOURCE_DIR}/framework/console.cpp)
set(Q4_FRAMEWORK_USERCMD_SOURCE ${PROJECT_SOURCE_DIR}/framework/usercmdgen.cpp)
set(Q4_FRAMEWORK_CONSOLE_SOURCES
    ${Q4_FRAMEWORK_EDITFIELD_SOURCE}
    ${Q4_FRAMEWORK_CONSOLE_SOURCE}
    ${Q4_FRAMEWORK_USERCMD_SOURCE}
)
file(GLOB Q4_FRAMEWORK_ASYNC_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/framework/async/*.cpp)
set(Q4_FRAMEWORK_MSGCHANNEL_SOURCE ${PROJECT_SOURCE_DIR}/framework/async/msgchannel.cpp)
list(REMOVE_ITEM Q4_FRAMEWORK_ASYNC_SOURCES ${Q4_FRAMEWORK_MSGCHANNEL_SOURCE})
set(Q4_FRAMEWORK_CORE_SOURCES ${Q4_FRAMEWORK_ENGINE_TOP_SOURCES})
list(REMOVE_ITEM Q4_FRAMEWORK_CORE_SOURCES
    ${Q4_FRAMEWORK_SESSION_SOURCES}
    ${Q4_FRAMEWORK_CONSOLE_SOURCES}
)

file(GLOB_RECURSE Q4_UI_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/ui/*.cpp
)

# Retail quake4.exe renderer compilation units.  Keep this explicit: the PDB
# records one object for each entry and the list doubles as a boundary audit.
set(Q4_RENDERER_SOURCES
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
    ${PROJECT_SOURCE_DIR}/renderer/VertexCache.cpp
)

# Retail BSE object boundaries recovered from quake4.pdb.
set(Q4_BSE_SOURCES
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
    ${PROJECT_SOURCE_DIR}/bse/BSE_SpawnDomains.cpp
)
file(GLOB Q4_JPEG_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/renderer/jpeg-6/*.c)

file(GLOB_RECURSE Q4_SOUND_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/sound/*.cpp)
file(GLOB_RECURSE Q4_OGGVORBIS_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/*.c
)

file(GLOB_RECURSE Q4_SYS_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/sys/*.cpp
)

q4_add_engine_object(q4_engine_aas_file ${Q4_AAS_FILE_SOURCE})
q4_add_engine_object(q4_engine_aas ${Q4_AAS_SOURCES})
target_compile_definitions(q4_engine_aas PRIVATE Q4_AAS_LEGACY_SEED)
q4_add_engine_object(q4_engine_cm_model ${Q4_CM_MODEL_SOURCE})
target_compile_definitions(q4_engine_cm_model PRIVATE Q4_CM_MODEL_ONLY)
q4_add_engine_object(q4_engine_cm_load ${Q4_CM_LOAD_SOURCE})
q4_add_engine_object(q4_engine_cm_contacts ${Q4_CM_CONTACTS_SOURCE})
q4_add_engine_object(q4_engine_cm_contents ${Q4_CM_CONTENTS_SOURCE})
q4_add_engine_object(q4_engine_cm_trace ${Q4_CM_TRACE_SOURCE})
q4_add_engine_object(q4_engine_cm_translate ${Q4_CM_TRANSLATE_SOURCE})
q4_add_engine_object(q4_engine_cm_seed ${Q4_CM_SOURCES})
target_compile_definitions(q4_engine_cm_seed PRIVATE Q4_CM_LEGACY_SEED)
set(Q4_FRAMEWORK_CORE_TARGETS)
foreach(source IN LISTS Q4_FRAMEWORK_CORE_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_framework_core_${stem})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_FRAMEWORK_CORE_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_framework_core DEPENDS ${Q4_FRAMEWORK_CORE_TARGETS})
set_target_properties(q4_engine_framework_core PROPERTIES FOLDER "Engine/Seed")
q4_add_engine_object(q4_engine_framework_editfield ${Q4_FRAMEWORK_EDITFIELD_SOURCE})
q4_add_engine_object(q4_engine_framework_console_impl ${Q4_FRAMEWORK_CONSOLE_SOURCE})
q4_add_engine_object(q4_engine_framework_usercmd ${Q4_FRAMEWORK_USERCMD_SOURCE})
add_custom_target(q4_engine_framework_console
    DEPENDS
        q4_engine_framework_editfield
        q4_engine_framework_console_impl
        q4_engine_framework_usercmd
)
set_target_properties(q4_engine_framework_console PROPERTIES FOLDER "Engine/Seed")
set(Q4_FRAMEWORK_ASYNC_TARGETS)
foreach(source IN LISTS Q4_FRAMEWORK_ASYNC_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_framework_async_${stem})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_FRAMEWORK_ASYNC_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_framework_async DEPENDS ${Q4_FRAMEWORK_ASYNC_TARGETS})
set_target_properties(q4_engine_framework_async PROPERTIES FOLDER "Engine/Seed")
q4_add_engine_object(q4_engine_framework_msgchannel ${Q4_FRAMEWORK_MSGCHANNEL_SOURCE})
target_compile_definitions(q4_engine_framework_msgchannel PRIVATE Q4_RECON_SDK_MSGQUEUE)
q4_add_engine_object(q4_engine_framework_session ${Q4_FRAMEWORK_SESSION_SOURCES})
foreach(target q4_engine_framework_editfield q4_engine_framework_console_impl q4_engine_framework_usercmd q4_engine_framework_session)
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
endforeach()
set(Q4_UI_TARGETS)
foreach(source IN LISTS Q4_UI_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_ui_${stem})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_UI_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_ui DEPENDS ${Q4_UI_TARGETS})
set_target_properties(q4_engine_ui PROPERTIES FOLDER "Engine/Seed")

set(Q4_RENDERER_TARGETS)
foreach(source IN LISTS Q4_RENDERER_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_renderer_${stem})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_RENDERER_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_renderer DEPENDS ${Q4_RENDERER_TARGETS})
set_target_properties(q4_engine_renderer PROPERTIES FOLDER "Engine/Seed")
set(Q4_BSE_TARGETS)
foreach(source IN LISTS Q4_BSE_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    string(TOLOWER ${stem} stem_lower)
    set(target q4_engine_bse_${stem_lower})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_BSE_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_bse DEPENDS ${Q4_BSE_TARGETS})
set_target_properties(q4_engine_bse PROPERTIES FOLDER "Engine/Seed")
q4_add_engine_object(q4_bse_abi ${PROJECT_SOURCE_DIR}/tests/abi/BSE_ABI.cpp)
target_compile_definitions(q4_bse_abi PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
set_target_properties(q4_bse_abi PROPERTIES FOLDER "Reconstruction/ABI")
q4_add_engine_object(q4_renderer_raven_abi ${PROJECT_SOURCE_DIR}/tests/abi/RendererRaven_ABI.cpp)
target_compile_definitions(q4_renderer_raven_abi PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
set_target_properties(q4_renderer_raven_abi PROPERTIES FOLDER "Reconstruction/ABI")
q4_add_engine_object(q4_thirdparty_jpeg ${Q4_JPEG_SOURCES})
target_include_directories(q4_thirdparty_jpeg PRIVATE ${PROJECT_SOURCE_DIR}/renderer/jpeg-6)
set_target_properties(q4_thirdparty_jpeg PROPERTIES FOLDER "ThirdParty")
set(Q4_SOUND_TARGETS)
foreach(source IN LISTS Q4_SOUND_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_sound_${stem})
    q4_add_engine_object(${target} ${source})
    target_include_directories(${target} PRIVATE ${PROJECT_SOURCE_DIR}/sound ${PROJECT_SOURCE_DIR}/sys/win32)
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE Q4_RECONSTRUCTED_SOUND)
    list(APPEND Q4_SOUND_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_sound DEPENDS ${Q4_SOUND_TARGETS})
set_target_properties(q4_engine_sound PROPERTIES FOLDER "Engine/Seed")
q4_add_engine_object(q4_thirdparty_oggvorbis ${Q4_OGGVORBIS_SOURCES})
target_include_directories(q4_thirdparty_oggvorbis PRIVATE
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbissrc
)
set_target_properties(q4_thirdparty_oggvorbis PROPERTIES FOLDER "ThirdParty")
set(Q4_SYS_TARGETS)
foreach(source IN LISTS Q4_SYS_SOURCES)
    get_filename_component(stem ${source} NAME_WE)
    set(target q4_engine_sys_${stem})
    q4_add_engine_object(${target} ${source})
    target_compile_definitions(${target} PRIVATE Q4_RECON_ENGINE_PRIVATE Q4_RECON_SDK_MSGQUEUE)
    list(APPEND Q4_SYS_TARGETS ${target})
endforeach()
add_custom_target(q4_engine_sys DEPENDS ${Q4_SYS_TARGETS})
set_target_properties(q4_engine_sys PROPERTIES FOLDER "Engine/Seed")

add_custom_target(q4_engine_seed
    DEPENDS
        q4_engine_aas
        q4_engine_aas_file
        q4_engine_cm_model
        q4_engine_cm_load
        q4_engine_cm_contacts
        q4_engine_cm_contents
        q4_engine_cm_trace
        q4_engine_cm_translate
        q4_engine_cm_seed
        q4_engine_framework_core
        q4_engine_framework_console
        q4_engine_framework_async
        q4_engine_framework_msgchannel
        q4_engine_framework_session
        q4_engine_ui
        q4_engine_renderer
        q4_engine_bse
        q4_thirdparty_jpeg
        q4_engine_sound
        q4_thirdparty_oggvorbis
        q4_engine_sys
)
set_target_properties(q4_engine_seed PROPERTIES FOLDER "Engine")

add_custom_target(q4_reconstruction_foundation
    DEPENDS
        q4_idlib
        q4_engine_aas
        q4_engine_aas_file
        q4_engine_cm_model
        q4_engine_cm_load
        q4_engine_cm_contacts
        q4_engine_cm_contents
        q4_engine_cm_trace
        q4_engine_cm_translate
        q4_engine_cm_seed
        q4_engine_framework_console
        q4_engine_framework_core_cmdsystem
        q4_engine_framework_core_compressor
        q4_engine_framework_core_cvarsystem
        q4_engine_framework_core_declaf
        q4_engine_framework_core_declentitydef
        q4_engine_framework_core_declmanager
        q4_engine_framework_core_declpda
        q4_engine_framework_core_declskin
        q4_engine_framework_core_decltable
        q4_engine_framework_core_demofile
        q4_engine_framework_core_eventloop
        q4_engine_framework_core_file
        q4_engine_framework_core_filesystem
        q4_engine_framework_core_keyinput
        q4_engine_framework_core_unzip
        q4_engine_framework_async_asyncnetwork
        q4_engine_framework_async_networksystem
        q4_engine_framework_msgchannel
		q4_engine_ui
        q4_thirdparty_jpeg
        q4_thirdparty_oggvorbis
)
set_target_properties(q4_reconstruction_foundation PROPERTIES FOLDER "Reconstruction")

# Full reconstructed Win32 engine integration target.  The per-compiland
# object targets above remain the source-ownership/ABI audit surface; this
# target compiles the same recovered sources into a runnable executable.
# The editor and compilers live in the external q4_tools target and cross the
# reconstructed retail Tools API rather than being compiled into the engine.
# CURL remains disabled at this reconstruction frontier.
set(Q4_OPENAL_LOADER_SOURCES
    ${PROJECT_SOURCE_DIR}/openal/idal.cpp
)

add_executable(darkgame WIN32
    ${PROJECT_SOURCE_DIR}/sys/win32/rc/Quake4.rc
    ${Q4_AAS_SOURCES}
    ${Q4_CM_MODEL_SOURCE}
    ${Q4_CM_SOURCES}
    ${Q4_FRAMEWORK_ENGINE_TOP_SOURCES}
    ${Q4_FRAMEWORK_ASYNC_SOURCES}
    ${Q4_FRAMEWORK_MSGCHANNEL_SOURCE}
    ${Q4_UI_SOURCES}
    ${Q4_RENDERER_SOURCES}
    ${Q4_BSE_SOURCES}
    ${Q4_JPEG_SOURCES}
    ${Q4_SOUND_SOURCES}
    ${Q4_OGGVORBIS_SOURCES}
    ${Q4_OPENAL_LOADER_SOURCES}
    ${Q4_SYS_SOURCES}
)

target_include_directories(darkgame PRIVATE
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/renderer/jpeg-6
    ${PROJECT_SOURCE_DIR}/sound
    ${PROJECT_SOURCE_DIR}/sys/win32
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/ogg/include
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbis/include
    ${PROJECT_SOURCE_DIR}/sound/OggVorbis/vorbissrc
    "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
)

target_compile_definitions(darkgame PRIVATE
    WIN32
    _WINDOWS
    _LOAD_DLL
    __DOOM_DLL__
    _USE_32BIT_TIME_T
    Q4_NO_PUNKBUSTER
    Q4_RECON_SEED
    Q4_RECON_ENGINE_PRIVATE
    Q4_RECON_SDK_MSGQUEUE
    Q4_DISABLE_TASKKEY_HOOK
    Q4_DISABLE_TOOLS
    Q4_DISABLE_GL_LOGGING
    Q4_RECONSTRUCTED_SOUND
    ID_ENABLE_CURL=0
    $<$<CONFIG:Debug>:_DEBUG>
    $<$<CONFIG:Release>:NDEBUG;_FINAL>
)

target_link_directories(darkgame PRIVATE
    "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Lib/x86"
    ${PROJECT_SOURCE_DIR}/openal/lib
)

target_link_libraries(darkgame PRIVATE
    q4_idlib
    opengl32
    winmm
    ws2_32
    iphlpapi
    dbghelp
    comctl32
    dinput8
    dsound
    dxguid
    version
)

if(MSVC)
    # Keep an address map and symbols beside the reconstructed executable so
    # retail-startup crashes can be resolved without enabling the tools DLL.
    target_compile_options(darkgame PRIVATE /Zi)
    target_link_options(darkgame PRIVATE
        /DEBUG:FULL
        /PDB:${Q4_RUNTIME_DIR}/darkgame.pdb
        /MAP:${Q4_RUNTIME_DIR}/darkgame.map
        /STACK:16777216,4096
    )
endif()

set_target_properties(darkgame PROPERTIES
    OUTPUT_NAME darkgame
    RUNTIME_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}"
    RUNTIME_OUTPUT_DIRECTORY_DEBUG "${Q4_RUNTIME_DIR}"
    RUNTIME_OUTPUT_DIRECTORY_RELEASE "${Q4_RUNTIME_DIR}"
    PDB_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}"
    FOLDER "Engine"
)

endif()

if(Q4_BUILD_GAME_DLL)
file(GLOB_RECURSE Q4_GAME_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/game/*.cpp
)

# Callbacks.cpp is generated-style source text included by gamesys/Class.cpp;
# it is not a standalone translation unit in the Quake 4 SDK project.
list(REMOVE_ITEM Q4_GAME_SOURCES
    ${PROJECT_SOURCE_DIR}/game/gamesys/Callbacks.cpp
)

add_library(gamex86 SHARED
    ${Q4_GAME_SOURCES}
    ${PROJECT_SOURCE_DIR}/framework/DeclPlayerModel.cpp
)

target_include_directories(gamex86 PRIVATE
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/game
    "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
)

target_compile_definitions(gamex86 PRIVATE
    WIN32
    _WINDOWS
    _LOAD_DLL
    _USE_32BIT_TIME_T
    GAME_DLL
    Q4SDK
	Q4_RECON_RETAIL_UI_MANAGER_ABI
    Q4_NO_PUNKBUSTER
    $<$<CONFIG:Debug>:_DEBUG>
    $<$<CONFIG:Release>:NDEBUG;_FINAL>
)

target_link_libraries(gamex86 PRIVATE q4_game_idlib winmm)

if(MSVC)
    target_compile_options(gamex86 PRIVATE /Zi)
    target_link_options(gamex86 PRIVATE
        /DEF:${PROJECT_SOURCE_DIR}/game/game.def
        /DEBUG:FULL
        /PDB:${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}/gamex86.pdb
    )
endif()

set_target_properties(gamex86 PROPERTIES
    OUTPUT_NAME gamex86
    PREFIX ""
    RUNTIME_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    RUNTIME_OUTPUT_DIRECTORY_DEBUG "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    RUNTIME_OUTPUT_DIRECTORY_RELEASE "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    LIBRARY_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    ARCHIVE_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    PDB_OUTPUT_DIRECTORY "${Q4_RUNTIME_DIR}/${Q4_BASE_GAMEDIR}"
    FOLDER "Game"
)

endif()

if(Q4_BUILD_ENGINE_SEED AND Q4_BUILD_GAME_DLL)
    add_custom_target(q4_runtime
        DEPENDS
            darkgame
            gamex86
    )
    set_target_properties(q4_runtime PROPERTIES FOLDER "Runtime")
endif()

if(Q4_BUILD_TOOLS_DLL)
file(GLOB Q4_RADIANT_SOURCES CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/tools/radiant/*.cpp
    ${PROJECT_SOURCE_DIR}/tools/common/*.cpp
    ${PROJECT_SOURCE_DIR}/tools/comafx/*.cpp
)
set_source_files_properties(${Q4_RADIANT_SOURCES} PROPERTIES
    COMPILE_OPTIONS "/FI${PROJECT_SOURCE_DIR}/tools/comafx/StdAfx.h"
)

add_library(q4_tools SHARED
    ${PROJECT_SOURCE_DIR}/tools/ToolsStub.cpp
    ${PROJECT_SOURCE_DIR}/tools/ToolRenderAdapters.cpp
    ${PROJECT_SOURCE_DIR}/tools/Toolsx86.def
    ${PROJECT_SOURCE_DIR}/sys/win32/rc/Radiant.rc
    ${PROJECT_SOURCE_DIR}/sys/win32/rc/Common.rc
    ${PROJECT_SOURCE_DIR}/sys/win32/rc/PropTree.rc
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
    ${Q4_RADIANT_SOURCES}
)

if(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION)
    target_include_directories(q4_tools BEFORE PRIVATE
        "C:/Program Files (x86)/Windows Kits/10/Include/${CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION}/shared"
    )
endif()

target_include_directories(q4_tools PRIVATE
    ${PROJECT_SOURCE_DIR}
    "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include"
)

target_compile_definitions(q4_tools PRIVATE
    WIN32
    _WINDOWS
    ID_GL_HARDLINK
    _LOAD_DLL
    Q4_NO_PUNKBUSTER
    Q4_RECON_ENGINE_PRIVATE
    Q4_RECON_SDK_MSGQUEUE
    $<$<CONFIG:Debug>:_DEBUG>
    $<$<CONFIG:Release>:NDEBUG;_FINAL>
)

target_link_libraries(q4_tools PRIVATE
    q4_idlib
    user32
    gdi32
    comctl32
    comdlg32
    shell32
    opengl32
    glu32
    ws2_32
)

set_target_properties(q4_tools PROPERTIES
    OUTPUT_NAME Toolsx86
    PREFIX ""
    FOLDER "Tools"
    MFC_FLAG 2
)

# Keep the 2005 retail Toolsx86.dll intact for binary comparison.  The
# reconstructed engine deliberately loads this non-conflicting runtime alias.
add_custom_command(TARGET q4_tools POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:q4_tools>
        "${Q4_RUNTIME_DIR}/ToolsReconstructedx86.dll"
)

endif()

if(Q4_BUILD_RECON_TOOLS)
add_custom_target(reconstruction_manifests SOURCES
    ${PROJECT_SOURCE_DIR}/tools/reconstruction/Export-EvidenceManifest.ps1
    ${PROJECT_SOURCE_DIR}/tools/reconstruction/Export-ReconstructionLedger.ps1
    ${PROJECT_SOURCE_DIR}/tools/reconstruction/Seed-DoomImplementations.ps1
    ${PROJECT_SOURCE_DIR}/tools/reconstruction/Seed-DoomHeaders.ps1
)

set_target_properties(reconstruction_manifests PROPERTIES FOLDER "Reconstruction")

if(MSVC)
    set(DIA_SDK_ROOT "${CMAKE_GENERATOR_INSTANCE}/DIA SDK")
    if(EXISTS "${DIA_SDK_ROOT}/include/dia2.h")
        add_executable(q4_pdb_inventory
            ${PROJECT_SOURCE_DIR}/tools/reconstruction/pdb_inventory.cpp
        )
        target_include_directories(q4_pdb_inventory PRIVATE "${DIA_SDK_ROOT}/include")
        target_link_directories(q4_pdb_inventory PRIVATE "${DIA_SDK_ROOT}/lib")
        target_link_libraries(q4_pdb_inventory PRIVATE diaguids ole32 oleaut32)
        target_compile_definitions(q4_pdb_inventory PRIVATE UNICODE _UNICODE)
        set_target_properties(q4_pdb_inventory PROPERTIES FOLDER "Reconstruction")
    else()
        message(WARNING "DIA SDK not found; q4_pdb_inventory will not be built")
    endif()
endif()

endif()

enable_testing()
