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

#ifndef _ALU_H_
#define _ALU_H_

#define ALUAPI
#define ALUAPIENTRY __cdecl

#define BUFFERSIZE 48000
#define FRACTIONBITS 14
#define FRACTIONMASK ((1L<<FRACTIONBITS)-1)
#define OUTPUTCHANNELS 2

#include "altypes.h"

#ifdef __cplusplus
extern "C" {
#endif

ALUAPI ALint	ALUAPIENTRY aluF2L(ALfloat value);
ALUAPI ALshort	ALUAPIENTRY aluF2S(ALfloat value);
ALUAPI ALvoid	ALUAPIENTRY aluCrossproduct(ALfloat *inVector1,ALfloat *inVector2,ALfloat *outVector);
ALUAPI ALfloat	ALUAPIENTRY aluDotproduct(ALfloat *inVector1,ALfloat *inVector2);
ALUAPI ALvoid	ALUAPIENTRY aluNormalize(ALfloat *inVector);
ALUAPI ALvoid	ALUAPIENTRY aluMatrixVector(ALfloat matrix[3][3],ALfloat *vector);
ALUAPI ALvoid	ALUAPIENTRY aluCalculateSourceParameters(ALuint source,ALuint channels,ALfloat *drysend,ALfloat *wetsend,ALfloat *pitch);
ALUAPI ALvoid	ALUAPIENTRY aluMixData(ALvoid *context,ALvoid *buffer,ALsizei size,ALenum format);
ALUAPI ALvoid	ALUAPIENTRY aluSetReverb(ALvoid *Reverb,ALuint Environment);
ALUAPI ALvoid	ALUAPIENTRY aluReverb(ALvoid *Reverb,ALfloat Buffer[][2],ALsizei BufferSize);

#ifdef __cplusplus
}
#endif

#endif

