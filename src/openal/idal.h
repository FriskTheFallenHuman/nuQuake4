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

// generated header. do not edit
// C:\Python23\Lib\idlelib\idle.pyw
// Mon Mar 28 12:31:26 2005

extern ALenum ( ALAPIENTRY * idalGetError )( ALvoid );
extern ALvoid ( ALAPIENTRY * idalGenBuffers )( ALsizei, ALuint * );
extern ALboolean ( ALAPIENTRY * idalIsSource )( ALuint );
extern ALvoid ( ALAPIENTRY * idalSourceStop )( ALuint );
extern ALvoid ( ALAPIENTRY * idalGetSourcei )( ALuint, ALenum, ALint * );
extern ALint ( ALAPIENTRY * idalGetInteger )( ALenum );
extern ALCvoid ( ALAPIENTRY * idalcSuspendContext )( ALCcontext * );
extern ALCboolean ( ALAPIENTRY * idalcMakeContextCurrent )( ALCcontext * );
extern ALCvoid ( ALAPIENTRY * idalcProcessContext )( ALCcontext * );
extern ALCvoid ( ALAPIENTRY * idalcDestroyContext )( ALCcontext * );
extern ALCubyte * ( ALAPIENTRY * idalcGetString )( ALCdevice *, ALCenum );
extern ALvoid ( ALAPIENTRY * idalBufferData )( ALuint, ALenum, ALvoid *, ALsizei, ALsizei );
extern ALvoid ( ALAPIENTRY * idalDeleteBuffers )( ALsizei, ALuint * );
extern ALboolean ( ALAPIENTRY * idalIsExtensionPresent )( ALubyte * );
extern ALvoid ( ALAPIENTRY * idalDeleteSources )( ALsizei, ALuint * );
extern ALenum ( ALAPIENTRY * idalGetEnumValue )( ALubyte * );
extern ALvoid * ( ALAPIENTRY * idalGetProcAddress )( ALubyte * );
extern ALCcontext * ( ALAPIENTRY * idalcCreateContext )( ALCdevice *, ALCint * );
extern ALCdevice * ( ALAPIENTRY * idalcOpenDevice )( ALubyte * );
extern ALvoid ( ALAPIENTRY * idalListenerfv )( ALenum, ALfloat* );
extern ALvoid ( ALAPIENTRY * idalSourceQueueBuffers )( ALuint, ALsizei, ALuint * );
extern ALvoid ( ALAPIENTRY * idalSourcei )( ALuint, ALenum, ALint );
extern ALvoid ( ALAPIENTRY * idalListenerf )( ALenum, ALfloat );
extern ALCvoid ( ALAPIENTRY * idalcCloseDevice )( ALCdevice * );
extern ALboolean ( ALAPIENTRY * idalIsBuffer )( ALuint );
extern ALvoid ( ALAPIENTRY * idalSource3f )( ALuint, ALenum, ALfloat, ALfloat, ALfloat );
extern ALvoid ( ALAPIENTRY * idalGenSources )( ALsizei, ALuint * );
extern ALvoid ( ALAPIENTRY * idalSourcef )( ALuint, ALenum, ALfloat );
extern ALvoid ( ALAPIENTRY * idalSourceUnqueueBuffers )( ALuint, ALsizei, ALuint * );
extern ALvoid ( ALAPIENTRY * idalSourcePlay )( ALuint );

#define alGetError idalGetError
#define alGenBuffers idalGenBuffers
#define alIsSource idalIsSource
#define alSourceStop idalSourceStop
#define alGetSourcei idalGetSourcei
#define alGetInteger idalGetInteger
#define alcSuspendContext idalcSuspendContext
#define alcMakeContextCurrent idalcMakeContextCurrent
#define alcProcessContext idalcProcessContext
#define alcDestroyContext idalcDestroyContext
#define alcGetString idalcGetString
#define alBufferData idalBufferData
#define alDeleteBuffers idalDeleteBuffers
#define alIsExtensionPresent idalIsExtensionPresent
#define alDeleteSources idalDeleteSources
#define alGetEnumValue idalGetEnumValue
#define alGetProcAddress idalGetProcAddress
#define alcCreateContext idalcCreateContext
#define alcOpenDevice idalcOpenDevice
#define alListenerfv idalListenerfv
#define alSourceQueueBuffers idalSourceQueueBuffers
#define alSourcei idalSourcei
#define alListenerf idalListenerf
#define alcCloseDevice idalcCloseDevice
#define alIsBuffer idalIsBuffer
#define alSource3f idalSource3f
#define alGenSources idalGenSources
#define alSourcef idalSourcef
#define alSourceUnqueueBuffers idalSourceUnqueueBuffers
#define alSourcePlay idalSourcePlay
