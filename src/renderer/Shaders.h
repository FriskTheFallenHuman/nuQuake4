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
//
// Quake 4 renderer shader-stage declarations reconstructed from quake4.pdb.

#ifndef __RENDERER_SHADERS_H__
#define __RENDERER_SHADERS_H__

class idImage;
class idLexer;
class idMaterial;
struct drawInteraction_s;
typedef struct drawInteraction_s drawInteraction_t;

class rvShader {
public:
					rvShader( unsigned int initTarget, const char *initName );
	virtual			~rvShader();

	virtual bool	LoadProgram();
	virtual unsigned int GetVariablePosition( const char *variableName );
	virtual void	Bind();
	virtual void	SetTexture( int position, int unit, idImage *image );
	virtual void	UnBindTexture( int position, int unit, idImage *image );
	virtual void	UnBind();

	unsigned int	target;
	unsigned int	ident;
	char			name[64];
};

class rvNewShaderStage {
public:
	virtual			~rvNewShaderStage() {}

	// Keep this declaration order synchronized with the retail vtable at
	// 0x102BAAA0.  Material startup calls Resolve through slot one.
	virtual void	Resolve();
	virtual void	UpdateShaderParms( const float *registers, const drawInteraction_t *din );
	virtual void	Bind( const float *registers, const drawInteraction_t *din );
	virtual void	UnBind();
	virtual void	Shutdown();
	virtual bool	ParseProgram( idLexer &src, idMaterial *material );
	virtual bool	ParseShaderParm( idLexer &src, idMaterial *material );
	virtual bool	ParseTextureParm( idLexer &src, idMaterial *material, textureRepeat_t defaultRepeat );
	virtual bool	IsSupported() = 0;
	virtual bool	IsValid();
	virtual void	BindShaderParameter( int slot, int numParms, const float *floatVector, int arraySize ) = 0;

	void			BindShaderTextureConstant( int slot, int bindingType, const drawInteraction_t *din );
	void			BindShaderParameterConstant( int slot, int bindingType, const drawInteraction_t *din );
	void			SetTextureParm( const char *name, idImage *image );
	int				FindShaderParameter( const char *name );
	void			SetShaderParameter( int index, float *registers, const float *floatVector, int arraySize );

	static bool		AddShaderProgram( rvShader *shaderProgram );
	static rvShader *FindShaderProgram( const char *program );
	static void		R_Shaders_Init();
	static void		R_Shaders_Shutdown();

	static rvShader *ShaderList[200];
	static int		NumShaders;

protected:
	char			shaderName[256];
	char			shaderParmNames[96][32];
	int				shaderParmRegisters[96][4];
	int				shaderParmNumRegisters[96];
	char			textureParmNames[8][32];
	idImage *		textureParmImages[8];
	int				textureParmLocations[8];
	rvShader *		shaderProgram;
	bool			invalidShader;
};

class rvGLSLShader : public rvShader {
public:
					rvGLSLShader( unsigned int initTarget, const char *initName ) : rvShader( initTarget, initName ) {}
	virtual			~rvGLSLShader();

	virtual bool	LoadProgram();
	virtual unsigned int GetVariablePosition( const char *variableName );
	virtual void	Bind();
	virtual void	SetTexture( int position, int unit, idImage *image );
	virtual void	UnBindTexture( int position, int unit, idImage *image );
	virtual void	UnBind();

private:
	unsigned int	vertexShader;
	unsigned int	fragmentShader;
	unsigned int	program;
};

class rvGLSLShaderStage : public rvNewShaderStage {
public:
					rvGLSLShaderStage();
	virtual			~rvGLSLShaderStage();

	virtual void	Resolve();
	virtual bool	IsSupported();
	virtual void	BindShaderParameter( int slot, int numParms, const float *floatVector, int arraySize );

private:
	int				shaderParmLocations[96];
};

void CalculateGaussianCoefficients( int width, int height, float multiplier );
void CalculateGaussianCoefficients1D( int size, float multiplier, float deviation,
	float *sampleOffsets, idVec4 *sampleWeights );

#endif
