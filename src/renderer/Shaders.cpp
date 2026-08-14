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

// Copyright (C) 2005 Raven Software

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "tr_local.h"
#include "Shaders.h"

extern idMat4 colorMatrix;

static const int MAX_SHADER_CONSTANTS = 36;
static const int MAX_GAUSSIAN_SAMPLES = 15;

static const char *shaderConstantNames[MAX_SHADER_CONSTANTS] = {
	"lightOrigin", "viewOrigin", "lightProject_s", "lightProject_t",
	"lightProject_q", "lightFalloff_s", "bumpMatrix_s", "bumpMatrix_t",
	"diffuseMatrix_s", "diffuseMatrix_t", "specularMatrix_s", "specularMatrix_t",
	"colorModulate", "colorAdd", "diffuseColor", "specularColor",
	"colorMatrix0", "colorMatrix1", "colorMatrix2", "projectionMatrix0",
	"projectionMatrix1", "projectionMatrix2", "projectionMatrix3", "modelMatrix0",
	"modelMatrix1", "modelMatrix2", "globalEyePos", "mvpMatrix0",
	"mvpMatrix1", "mvpMatrix2", "mvpMatrix3", "gaussianSampleOffsets",
	"gaussianSampleWeights", "gaussianSampleOffsetsHorizontal",
	"gaussianSampleOffsetsVertical", "gaussianSampleWeights2"
};

static const int shaderConstantsNumRegisters[MAX_SHADER_CONSTANTS] = {
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	16, 16, 16, 16, 16
};

static idVec4 gaussianSampleOffsets[16];
static idVec4 gaussianSampleWeights[16];
static idVec4 gaussianSampleWeights2[16];
static float gaussianSampleOffsetsVertical[16];
static float gaussianSampleOffsetsHorizontal[16];
static bool gaussianCoefficientsAlreadyComputed;
static float lastWidth;

rvShader *rvNewShaderStage::ShaderList[200];
int rvNewShaderStage::NumShaders;

rvShader::rvShader( unsigned int initTarget, const char *initName ) {
	target = initTarget;
	ident = rvNewShaderStage::NumShaders;
	idStr::Copynz( name, initName, sizeof( name ) );
}

bool rvNewShaderStage::AddShaderProgram( rvShader *shaderProgram ) {
	if ( shaderProgram == NULL || NumShaders >= 200 ) {
		return false;
	}
	ShaderList[NumShaders++] = shaderProgram;
	return shaderProgram->LoadProgram();
}

void rvNewShaderStage::UnBind() {
	if ( shaderProgram == NULL ) {
		return;
	}
	for ( int i = 0; i < 8 && textureParmNames[i][0] != '\0'; ++i ) {
		shaderProgram->UnBindTexture( textureParmLocations[i], i, textureParmImages[i] );
	}
	GL_SelectTexture( 0 );
	shaderProgram->UnBind();
}

void rvNewShaderStage::Shutdown() {
	shaderProgram = NULL;
}

void rvNewShaderStage::BindShaderTextureConstant( int slot, int bindingType, const drawInteraction_t *din ) {
	if ( din == NULL || shaderProgram == NULL ) {
		return;
	}
	idImage *image = NULL;
	if ( bindingType == 1 ) {
		image = din->lightFalloffImage;
	} else if ( bindingType == 2 ) {
		image = din->lightImage;
	}
	if ( image != NULL ) {
		shaderProgram->SetTexture( textureParmLocations[slot], slot, image );
	}
}

void rvNewShaderStage::SetTextureParm( const char *parmName, idImage *image ) {
	for ( int i = 0; i < 8; ++i ) {
		if ( idStr::Icmp( parmName, textureParmNames[i] ) == 0 ) {
			textureParmImages[i] = image;
			return;
		}
	}
}

int rvNewShaderStage::FindShaderParameter( const char *parmName ) {
	for ( int i = 0; i < 96; ++i ) {
		if ( idStr::Icmp( parmName, shaderParmNames[i] ) == 0 ) {
			return i;
		}
	}
	return -1;
}

void rvNewShaderStage::SetShaderParameter( int index, float *registers, const float *floatVector, int arraySize ) {
	if ( index < 0 || index >= 96 || registers == NULL || floatVector == NULL ) {
		return;
	}
	const int count = Min( arraySize, 4 * ( 96 - index ) );
	const int *parameterRegisters = &shaderParmRegisters[index][0];
	for ( int i = 0; i < count; ++i ) {
		const int registerIndex = parameterRegisters[i];
		if ( registerIndex >= 0 ) {
			registers[registerIndex] = floatVector[i];
		}
	}
}

void CalculateGaussianCoefficients( int width, int height, float multiplier ) {
	const float inverseWidth = 1.0f / Max( width, 1 );
	const float inverseHeight = 1.0f / Max( height, 1 );
	float total = 0.0f;
	int sample = 0;
	for ( int x = -2; x <= 2; ++x ) {
		for ( int y = -2; y <= 2; ++y ) {
			if ( abs( x ) + abs( y ) > 2 ) {
				continue;
			}
			gaussianSampleOffsets[sample].Set( x * inverseWidth, y * inverseHeight, 0.0f, 0.0f );
			const float weight = idMath::Exp( -0.5f * ( x * x + y * y ) ) / idMath::Sqrt( idMath::TWO_PI );
			gaussianSampleWeights[sample].Set( weight, weight, weight, weight );
			total += weight;
			++sample;
		}
	}
	const float scale = total > 0.0f ? multiplier / total : 0.0f;
	for ( int i = 0; i < sample; ++i ) {
		gaussianSampleWeights[i] *= scale;
	}
}

void CalculateGaussianCoefficients1D( int size, float multiplier, float deviation,
	float *sampleOffsets, idVec4 *sampleWeights ) {
	const int halfSamples = 8;
	const float inverseSize = 1.0f / Max( size, 1 );
	const float divisor = 2.0f * deviation * deviation;
	const float normalization = 1.0f / idMath::Sqrt( idMath::TWO_PI * deviation * deviation );

	for ( int i = 0; i < halfSamples; ++i ) {
		sampleOffsets[i] = i * inverseSize;
		if ( sampleWeights != NULL ) {
			const float weight = idMath::Exp( -( i * i ) / divisor ) * normalization * multiplier;
			sampleWeights[i].Set( weight, weight, weight, 1.0f );
		}
	}
	for ( int i = halfSamples; i < MAX_GAUSSIAN_SAMPLES; ++i ) {
		const int mirror = MAX_GAUSSIAN_SAMPLES - i;
		sampleOffsets[i] = -sampleOffsets[mirror];
		if ( sampleWeights != NULL ) {
			sampleWeights[i] = sampleWeights[mirror];
		}
	}
}

rvShader *rvNewShaderStage::FindShaderProgram( const char *program ) {
	idStr stripped = program;
	stripped.StripFileExtension();
	for ( int i = 0; i < NumShaders; ++i ) {
		idStr compare = ShaderList[i]->name;
		compare.StripFileExtension();
		if ( stripped.Icmp( compare ) == 0 ) {
			return ShaderList[i];
		}
	}
	if ( NumShaders >= 200 ) {
		common->Error( "R_FindShaderProgram: MAX_SHADER_PROGS" );
	}
	return NULL;
}

void rvNewShaderStage::R_Shaders_Init() {
	NumShaders = 0;
	const int materialCount = declManager->GetNumDecls( DECL_MATERIAL );
	for ( int i = 0; i < materialCount; ++i ) {
		const idMaterial *material = static_cast<const idMaterial *>( declManager->DeclByIndex( DECL_MATERIAL, i, false ) );
		for ( int stageIndex = 0; stageIndex < material->GetNumStages(); ++stageIndex ) {
			rvNewShaderStage *stage = material->GetStage( stageIndex )->newShaderStage;
			if ( stage != NULL ) {
				stage->Resolve();
			}
		}
	}
}

void rvNewShaderStage::R_Shaders_Shutdown() {
	for ( int i = 0; i < NumShaders; ++i ) {
		delete ShaderList[i];
		ShaderList[i] = NULL;
	}
	NumShaders = 0;

	const int materialCount = declManager->GetNumDecls( DECL_MATERIAL );
	for ( int i = 0; i < materialCount; ++i ) {
		const idMaterial *material = static_cast<const idMaterial *>( declManager->DeclByIndex( DECL_MATERIAL, i, false ) );
		for ( int stageIndex = 0; stageIndex < material->GetNumStages(); ++stageIndex ) {
			rvNewShaderStage *stage = material->GetStage( stageIndex )->newShaderStage;
			if ( stage != NULL ) {
				stage->Shutdown();
			}
		}
	}
}

bool rvNewShaderStage::ParseProgram( idLexer &src, idMaterial *material ) {
	idToken token;
	if ( !src.ReadToken( &token ) ) {
		return false;
	}
	idStr::Copynz( shaderName, token.c_str(), sizeof( shaderName ) );
	return IsSupported();
}

bool rvNewShaderStage::ParseShaderParm( idLexer &src, idMaterial *material ) {
	int slot;
	for ( slot = 0; slot < 96 && shaderParmNames[slot][0] != '\0'; ++slot ) {
	}
	if ( slot >= 96 ) {
		return false;
	}

	idToken token;
	if ( !src.ReadToken( &token ) ) {
		return false;
	}
	idStr::Copynz( shaderParmNames[slot], token.c_str(), sizeof( shaderParmNames[slot] ) );

	int count = 0;
	for ( ; count < 4; ++count ) {
		const int expression = material->ParseExpression( src );
		shaderParmRegisters[slot][count] = expression;
		if ( count == 0 && expression < 0 ) {
			const int constant = -expression - 1;
			if ( constant < 0 || constant >= MAX_SHADER_CONSTANTS ) {
				return false;
			}
			const int extraRegisters = shaderConstantsNumRegisters[constant] - 1;
			if ( slot + extraRegisters >= 96 ) {
				common->Warning( "Shader constant takes more registers than are allowed." );
				return false;
			}
			for ( int i = 1; i <= extraRegisters; ++i ) {
				idStr::Copynz( shaderParmNames[slot + i], "x", sizeof( shaderParmNames[slot + i] ) );
			}
			count = 1;
			break;
		}
		if ( count == 3 || !src.ReadToken( &token ) ) {
			++count;
			break;
		}
		if ( token != "," ) {
			src.UnreadToken( &token );
			++count;
			break;
		}
	}
	shaderParmNumRegisters[slot] = count;
	return true;
}

bool rvNewShaderStage::ParseTextureParm( idLexer &src, idMaterial *material, textureRepeat_t defaultRepeat ) {
	int slot;
	for ( slot = 0; slot < 8 && textureParmNames[slot][0] != '\0'; ++slot ) {
	}
	if ( slot >= 8 ) {
		return false;
	}

	idToken token;
	if ( !src.ReadToken( &token ) ) {
		return false;
	}
	idStr::Copynz( textureParmNames[slot], token.c_str(), sizeof( textureParmNames[slot] ) );

	textureFilter_t filter = TF_DEFAULT;
	textureRepeat_t repeat = defaultRepeat;
	textureDepth_t depth = TD_DEFAULT;
	bool allowPicmip = true;
	cubeFiles_t cubeMap = CF_2D;

	while ( src.ReadTokenOnLine( &token ) ) {
		if ( !token.Icmp( "nearest" ) ) { filter = TF_NEAREST; continue; }
		if ( !token.Icmp( "linear" ) ) { filter = TF_LINEAR; continue; }
		if ( !token.Icmp( "clamp" ) ) { repeat = TR_CLAMP; continue; }
		if ( !token.Icmp( "noclamp" ) ) { repeat = TR_REPEAT; continue; }
		if ( !token.Icmp( "zeroclamp" ) ) { repeat = TR_CLAMP_TO_ZERO; continue; }
		if ( !token.Icmp( "alphazeroclamp" ) ) { repeat = TR_CLAMP_TO_ZERO_ALPHA; continue; }
		if ( !token.Icmp( "mirroredrepeat" ) ) { repeat = TR_MIRRORED_REPEAT; continue; }
		if ( !token.Icmp( "uncompressed" ) || !token.Icmp( "highquality" ) ) {
			if ( !globalImages->image_ignoreHighQuality.GetBool() ) { depth = TD_HIGH_QUALITY; }
			continue;
		}
		if ( !token.Icmp( "forceHighQuality" ) ) { depth = TD_HIGH_QUALITY; continue; }
		if ( !token.Icmp( "nopicmip" ) ) { allowPicmip = false; continue; }
		if ( !token.Icmp( "cubeMap" ) ) { cubeMap = CF_NATIVE; continue; }
		if ( !token.Icmp( "cameraCubeMap" ) ) { cubeMap = CF_CAMERA; continue; }
		if ( !token.Icmp( "nomips" ) ) { continue; }
		break;
	}

	if ( !token.Icmp( "lightfalloffImage" ) ) {
		textureParmLocations[slot] = -1;
		textureParmImages[slot] = NULL;
	} else if ( !token.Icmp( "lightImage" ) ) {
		textureParmLocations[slot] = -2;
		textureParmImages[slot] = NULL;
	} else if ( !token.Icmp( "ambientNormalMap" ) ) {
		textureParmLocations[slot] = -3;
		textureParmImages[slot] = globalImages->ambientNormalMap;
	} else if ( !token.Icmp( "normalCubeMap" ) ) {
		textureParmLocations[slot] = -4;
		textureParmImages[slot] = globalImages->normalCubeMapImage;
	} else if ( !token.Icmp( "specularTableImage" ) ) {
		textureParmLocations[slot] = -5;
		textureParmImages[slot] = globalImages->specularTableImage;
	} else {
		src.UnreadToken( &token );
		const char *imageName = R_ParsePastImageProgram( src );
		textureParmImages[slot] = globalImages->ImageFromFile( imageName, filter, allowPicmip, repeat, depth, cubeMap );
		if ( textureParmImages[slot] == NULL ) {
			textureParmImages[slot] = globalImages->defaultImage;
		}
	}
	return true;
}

void rvNewShaderStage::Bind( const float *registers, const drawInteraction_t *din ) {
	if ( shaderProgram == NULL ) {
		Resolve();
	}
	if ( shaderProgram == NULL || invalidShader ) {
		return;
	}
	shaderProgram->Bind();
	UpdateShaderParms( registers, din );
	for ( int i = 0; i < 8 && textureParmNames[i][0] != '\0'; ++i ) {
		if ( textureParmLocations[i] >= 0 || textureParmImages[i] != NULL ) {
			shaderProgram->SetTexture( textureParmLocations[i], i, textureParmImages[i] );
		} else {
			BindShaderTextureConstant( i, -textureParmLocations[i], din );
		}
	}
}

static void BuildGaussianConstants() {
	const int width = tr.viewDef != NULL ? tr.viewDef->viewport.x2 - tr.viewDef->viewport.x1 + 1 : glConfig.vidWidth;
	const int height = tr.viewDef != NULL ? tr.viewDef->viewport.y2 - tr.viewDef->viewport.y1 + 1 : glConfig.vidHeight;
	if ( gaussianCoefficientsAlreadyComputed && lastWidth == width ) {
		return;
	}
	gaussianCoefficientsAlreadyComputed = true;
	lastWidth = static_cast<float>( width );
	CalculateGaussianCoefficients( width, height, 1.0f );
	CalculateGaussianCoefficients1D( width, 1.0f, 3.0f, gaussianSampleOffsetsHorizontal, gaussianSampleWeights2 );
	CalculateGaussianCoefficients1D( width, 1.0f, 3.0f, gaussianSampleOffsetsVertical, NULL );
}

void rvNewShaderStage::BindShaderParameterConstant( int slot, int bindingType, const drawInteraction_t *din ) {
	static const float zero[4] = { 0, 0, 0, 0 };
	static const float one[4] = { 1, 1, 1, 1 };
	static const float negOne[4] = { -1, -1, -1, -1 };
	float value[4];

	if ( bindingType >= 0 && bindingType <= 11 ) {
		if ( din == NULL ) { return; }
		const idVec4 *constants[] = {
			&din->localLightOrigin, &din->localViewOrigin,
			&din->lightProjection[0], &din->lightProjection[1], &din->lightProjection[2], &din->lightProjection[3],
			&din->bumpMatrix[0], &din->bumpMatrix[1], &din->diffuseMatrix[0], &din->diffuseMatrix[1],
			&din->specularMatrix[0], &din->specularMatrix[1]
		};
		BindShaderParameter( slot, 4, constants[bindingType]->ToFloatPtr(), 1 );
		return;
	}

	switch ( bindingType ) {
		case 12:
			if ( din != NULL ) {
				const float *color = din->vertexColor == SVC_IGNORE ? one : ( din->vertexColor == SVC_MODULATE ? zero : negOne );
				BindShaderParameter( slot, 4, color, 1 );
			}
			break;
		case 13:
			if ( din != NULL ) {
				const float *color = din->vertexColor == SVC_IGNORE ? zero : one;
				BindShaderParameter( slot, 4, color, 1 );
			}
			break;
		case 14: if ( din != NULL ) { BindShaderParameter( slot, 4, din->diffuseColor.ToFloatPtr(), 1 ); } break;
		case 15: if ( din != NULL ) { BindShaderParameter( slot, 4, din->specularColor.ToFloatPtr(), 1 ); } break;
		case 16: BindShaderParameter( slot, 4, colorMatrix[0].ToFloatPtr(), 1 ); break;
		case 17: BindShaderParameter( slot, 4, colorMatrix[1].ToFloatPtr(), 1 ); break;
		case 18: BindShaderParameter( slot, 4, colorMatrix[2].ToFloatPtr(), 1 ); break;
		case 19: case 20: case 21: case 22:
			if ( backEnd.viewDef != NULL ) {
				const int column = bindingType - 19;
				for ( int row = 0; row < 4; ++row ) { value[row] = backEnd.viewDef->projectionMatrix[column + row * 4]; }
				BindShaderParameter( slot, 4, value, 1 );
			}
			break;
		case 23: case 24: case 25:
			if ( backEnd.currentSpace != NULL ) {
				const int column = bindingType - 23;
				for ( int row = 0; row < 4; ++row ) { value[row] = backEnd.currentSpace->modelMatrix[column + row * 4]; }
				BindShaderParameter( slot, 4, value, 1 );
			}
			break;
		case 26:
			if ( backEnd.viewDef != NULL ) {
				value[0] = backEnd.viewDef->renderView.vieworg[0]; value[1] = backEnd.viewDef->renderView.vieworg[1];
				value[2] = backEnd.viewDef->renderView.vieworg[2]; value[3] = 1.0f;
				BindShaderParameter( slot, 4, value, 1 );
			}
			break;
		case 27: case 28: case 29: case 30:
			BindShaderParameter( slot, 4, &backEnd.modelViewProjection[( bindingType - 27 ) * 4], 1 );
			break;
		case 31:
		case 32:
		case 33:
		case 34:
		case 35: {
			BuildGaussianConstants();
			if ( bindingType == 31 ) { BindShaderParameter( slot, 4, gaussianSampleOffsets[0].ToFloatPtr(), 15 ); }
			else if ( bindingType == 32 ) { BindShaderParameter( slot, 4, gaussianSampleWeights[0].ToFloatPtr(), 15 ); }
			else if ( bindingType == 35 ) { BindShaderParameter( slot, 4, gaussianSampleWeights2[0].ToFloatPtr(), 15 ); }
			else {
				idVec4 samples[16];
				for ( int i = 0; i < 15; ++i ) {
					samples[i].Zero();
					if ( bindingType == 33 ) { samples[i][0] = gaussianSampleOffsetsHorizontal[i]; }
					else { samples[i][1] = gaussianSampleOffsetsVertical[i]; }
				}
				BindShaderParameter( slot, 4, samples[0].ToFloatPtr(), 15 );
			}
			break;
		}
	}
}

void rvNewShaderStage::UpdateShaderParms( const float *registers, const drawInteraction_t *din ) {
	for ( int slot = 0; slot < 96 && shaderParmNames[slot][0] != '\0'; ++slot ) {
		if ( shaderParmRegisters[slot][0] < 0 ) {
			BindShaderParameterConstant( slot, -shaderParmRegisters[slot][0] - 1, din );
			continue;
		}
		float data[4] = { 0, 0, 0, 0 };
		const int count = Min( shaderParmNumRegisters[slot], 4 );
		for ( int i = 0; i < count; ++i ) {
			data[i] = registers[shaderParmRegisters[slot][i]];
		}
		BindShaderParameter( slot, count, data, 1 );
	}
}
