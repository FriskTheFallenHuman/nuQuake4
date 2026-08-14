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
#include "tr_local.h"
#include "Shaders.h"

// Retail compilation unit: rvGLSLShader.obj.

rvShader::~rvShader() {
}

bool rvShader::LoadProgram() {
	return false;
}

unsigned int rvShader::GetVariablePosition( const char *variableName ) {
	return static_cast<unsigned int>( -1 );
}

void rvShader::Bind() {
}

void rvShader::SetTexture( int position, int unit, idImage *image ) {
}

void rvShader::UnBindTexture( int position, int unit, idImage *image ) {
}

void rvShader::UnBind() {
}

void rvNewShaderStage::Resolve() {
}

bool rvNewShaderStage::IsValid() {
	return !invalidShader;
}

static void ErrorWithInfoLog( unsigned int object, const char *name ) {
	int infoLength = 0;
	int charsWritten = 0;
	int objectSubtype = 0;
	qglGetObjectParameterivARB( object, GL_OBJECT_INFO_LOG_LENGTH_ARB, &infoLength );
	char *info = infoLength > 0 ? static_cast<char *>( _alloca( infoLength + 1 ) ) : NULL;
	if ( info != NULL ) {
		info[0] = '\0';
		qglGetInfoLogARB( object, infoLength, &charsWritten, info );
		info[infoLength] = '\0';
	}
	qglGetObjectParameterivARB( object, GL_OBJECT_SUBTYPE_ARB, &objectSubtype );
	const char *subtype = objectSubtype == GL_VERTEX_SHADER_ARB ? "vertex" :
		( objectSubtype == GL_FRAGMENT_SHADER_ARB ? "fragment" : "unknown" );
	if ( common->IsInitialized() ) {
		common->Warning( "Failed to compile %s shader %s:\n%s", subtype, name, info != NULL ? info : "Unknown error" );
	} else {
		common->FatalError( "Failed to compile %s shader %s:\n%s", subtype, name, info != NULL ? info : "Unknown error" );
	}
}

rvGLSLShader::~rvGLSLShader() {
	qglDetachObjectARB( program, vertexShader );
	qglDetachObjectARB( program, fragmentShader );
	qglDeleteObjectARB( vertexShader );
	qglDeleteObjectARB( fragmentShader );
	qglDeleteObjectARB( program );
}

unsigned int rvGLSLShader::GetVariablePosition( const char *variableName ) {
	return qglGetUniformLocationARB( program, variableName );
}

void rvGLSLShader::Bind() {
	qglUseProgramObjectARB( program );
}

void rvGLSLShader::SetTexture( int position, int unit, idImage *image ) {
	GL_SelectTexture( unit );
	image->Bind();
	qglUniform1iARB( position, unit );
}

void rvGLSLShader::UnBindTexture( int position, int unit, idImage *image ) {
	GL_SelectTexture( unit );
	if ( image != NULL ) {
		image->UnBind();
	}
	globalImages->BindNull();
}

void rvGLSLShader::UnBind() {
	qglUseProgramObjectARB( 0 );
}

rvGLSLShaderStage::rvGLSLShaderStage() {
	shaderName[0] = '\0';
	memset( shaderParmNames, 0, sizeof( shaderParmNames ) );
	memset( shaderParmLocations, 0, sizeof( shaderParmLocations ) );
	memset( shaderParmRegisters, 0xFF, sizeof( shaderParmRegisters ) );
	memset( shaderParmNumRegisters, 0, sizeof( shaderParmNumRegisters ) );
	memset( textureParmNames, 0, sizeof( textureParmNames ) );
	for ( int i = 0; i < 8; ++i ) {
		textureParmLocations[i] = -1;
		textureParmImages[i] = NULL;
	}
	shaderProgram = NULL;
	invalidShader = false;
}

rvGLSLShaderStage::~rvGLSLShaderStage() {
}

bool rvGLSLShaderStage::IsSupported() {
	return glConfig.GLSLProgramAvailable;
}

void rvGLSLShaderStage::Resolve() {
	if ( !IsSupported() ) {
		shaderProgram = NULL;
		invalidShader = true;
		return;
	}
	shaderProgram = FindShaderProgram( shaderName );
	if ( shaderProgram == NULL ) {
		rvShader *newShader = new rvGLSLShader( 0, shaderName );
		shaderProgram = newShader;
		if ( !AddShaderProgram( newShader ) ) {
			common->Warning( "Invalid GLSL shader '%s'\n", shaderName );
			invalidShader = true;
			return;
		}
	}
	invalidShader = false;
	for ( int i = 0; i < 96 && shaderParmNames[i][0] != '\0'; ++i ) {
		shaderParmLocations[i] = shaderProgram->GetVariablePosition( shaderParmNames[i] );
	}
	for ( int i = 0; i < 8 && textureParmNames[i][0] != '\0'; ++i ) {
		textureParmLocations[i] = shaderProgram->GetVariablePosition( textureParmNames[i] );
	}
}

void rvGLSLShaderStage::BindShaderParameter( int slot, int numParms, const float *floatVector, int arraySize ) {
	switch ( numParms ) {
		case 1: qglUniform1fvARB( shaderParmLocations[slot], arraySize, floatVector ); break;
		case 2: qglUniform2fvARB( shaderParmLocations[slot], arraySize, floatVector ); break;
		case 3: qglUniform3fvARB( shaderParmLocations[slot], arraySize, floatVector ); break;
		case 4: qglUniform4fvARB( shaderParmLocations[slot], arraySize, floatVector ); break;
	}
}

bool rvGLSLShader::LoadProgram() {
	idStr basePath = "glprogs/";
	basePath += name;
	idStr vertexName = basePath + "vp";
	idStr fragmentName = basePath + "fp";
	char *vertexBuffer = NULL;
	char *fragmentBuffer = NULL;
	const int vertexLength = fileSystem->ReadFile( vertexName, reinterpret_cast<void **>( &vertexBuffer ) );
	if ( vertexBuffer == NULL ) {
		common->Printf( ": File not found\n" );
		return false;
	}
	const int fragmentLength = fileSystem->ReadFile( fragmentName, reinterpret_cast<void **>( &fragmentBuffer ) );
	if ( fragmentBuffer == NULL ) {
		fileSystem->FreeFile( vertexBuffer );
		common->Printf( ": File not found\n" );
		return false;
	}

	vertexShader = qglCreateShaderObjectARB( GL_VERTEX_SHADER_ARB );
	fragmentShader = qglCreateShaderObjectARB( GL_FRAGMENT_SHADER_ARB );
	const char *vertexSource = vertexBuffer;
	const char *fragmentSource = fragmentBuffer;
	qglShaderSourceARB( vertexShader, 1, &vertexSource, vertexLength != 0 ? &vertexLength : NULL );
	qglShaderSourceARB( fragmentShader, 1, &fragmentSource, fragmentLength != 0 ? &fragmentLength : NULL );
	fileSystem->FreeFile( vertexBuffer );
	fileSystem->FreeFile( fragmentBuffer );

	int status = 0;
	qglGetError();
	qglCompileShaderARB( vertexShader );
	unsigned int error = qglGetError();
	qglGetObjectParameterivARB( vertexShader, GL_OBJECT_COMPILE_STATUS_ARB, &status );
	if ( error != GL_NO_ERROR || !status ) {
		ErrorWithInfoLog( vertexShader, name );
		return false;
	}

	qglCompileShaderARB( fragmentShader );
	error = qglGetError();
	qglGetObjectParameterivARB( fragmentShader, GL_OBJECT_COMPILE_STATUS_ARB, &status );
	if ( error != GL_NO_ERROR || !status ) {
		ErrorWithInfoLog( fragmentShader, name );
		return false;
	}

	program = qglCreateProgramObjectARB();
	qglAttachObjectARB( program, vertexShader );
	qglAttachObjectARB( program, fragmentShader );
	qglLinkProgramARB( program );
	error = qglGetError();
	qglGetObjectParameterivARB( program, GL_OBJECT_LINK_STATUS_ARB, &status );
	if ( error != GL_NO_ERROR || !status ) {
		ErrorWithInfoLog( program, name );
		return false;
	}
	return true;
}
