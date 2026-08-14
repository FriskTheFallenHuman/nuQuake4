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

/* Quake 4 voice-communication compiland (snd_voice.obj). */

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "snd_local.h"

void idSoundSystemLocal::InitVoiceComms() { voiceCommInit = true; }
void idSoundSystemLocal::ShutdownVoiceComms() { voiceCommInit = false; }
void idSoundSystemLocal::HandleVoiceComms() {}
bool idSoundSystemLocal::EnableRecording( bool enable, bool test, float &micLevel ) { micLevel = 0.0f; return false; }
int idSoundSystemLocal::GetVoiceData( byte *buffer, int maxSize ) { return 0; }
void idSoundSystemLocal::PlayVoiceData( int clientNum, const byte *buffer, int bytes ) {}
void idSoundSystemLocal::BufferVoiceData() {}
void idSoundSystemLocal::MixVoiceData( float *finalMixBuffer, int numSpeakers, int newTime ) {}
int idSoundSystemLocal::GetCommClientNum( int channel ) const { return -1; }
int idSoundSystemLocal::GetNumVoiceChannels() const { return 0; }
