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

#include "snd_local.h"

#ifdef Q4_RECONSTRUCTED_SOUND

static rvCommonSample *SoundShaderSampleForIndex( const idSoundShader *shader, int index ) {
	if ( shader == NULL || index < 0 ) return NULL;
	if ( index < shader->GetNumEntries() ) return shader->GetEntry( index );
	return NULL;
}

void idSoundShader::Init() {
	memset( &parms, 0, sizeof( parms ) );
	parms.minDistance = 1.0f;
	parms.maxDistance = 10.0f;
	parms.volume = 1.0f;
	parms.attenuatedVolume = 1.0f;
	parms.frequencyShift = 1.0f;
	parms.wetLevel = 0.0f;
	parms.dryLevel = 1.0f;
	altSound = NULL;
	desc = "<no description>";
	errorDuringParse = false;
	noShakes = false;
	frequentlyUsed = false;
	leadinVolume = 1.0f;
	memset( leadins, 0, sizeof( leadins ) );
	numLeadins = 0;
	memset( entries, 0, sizeof( entries ) );
	shakes.Clear();
	numEntries = 0;
	minFrequencyShift = 1.0f;
	maxFrequencyShift = 1.0f;
	playCount = 0;
}

size_t idSoundShader::Size() const { return sizeof( *this ); }

void idSoundShader::FreeData() {
	Purge( false );
	memset( leadins, 0, sizeof( leadins ) );
	memset( entries, 0, sizeof( entries ) );
	numLeadins = numEntries = 0;
	shakes.Clear();
}

const char *idSoundShader::DefaultDefinition() const { return "{\n\tsound/_default.wav\n}"; }

bool idSoundShader::SetDefaultText() {
	idStr wavName = GetName();
	wavName.DefaultFileExtension( ".wav" );
	SetText( va( "sound %s // IMPLICITLY GENERATED\n{\n\t%s\n}\n", GetName(), wavName.c_str() ) );
	return true;
}

bool idSoundShader::Validate( const char *text, int textLength, idStr &report ) const {
	report.Clear();
	if ( text == NULL || textLength <= 0 ) { report = "empty sound shader"; return false; }
	if ( idStr::FindChar( text, '{', 0, textLength ) < 0 || idStr::FindChar( text, '}', 0, textLength ) < 0 ) {
		report = "sound shader requires matching braces";
		return false;
	}
	return true;
}

bool idSoundShader::Parse( const char *text, int textLength, bool noCaching ) {
	idLexer src;
	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( DECL_LEXER_FLAGS );
	if ( !src.SkipUntilString( "{" ) ) return false;
	FreeData();
	Init();
	if ( !ParseShader( src ) || errorDuringParse ) {
		MakeDefault();
		return false;
	}
	if ( !noCaching ) LoadSampleData();
	return true;
}

bool idSoundShader::ParseShader( idLexer &src ) {
	idToken token;

	memset( &parms, 0, sizeof( parms ) );
	parms.minDistance = 40.0f;
	parms.maxDistance = 400.0f;
	parms.volume = 1.0f;
	parms.frequencyShift = 1.0f;
	minFrequencyShift = 1.0f;
	maxFrequencyShift = 1.0f;
	altSound = NULL;
	memset( leadins, 0, sizeof( leadins ) );
	memset( entries, 0, sizeof( entries ) );
	numLeadins = 0;
	numEntries = 0;

	int maxSamples = idSoundSystemLocal::s_maxSoundsPerShader.GetInteger();
	if ( com_makingBuild.GetBool() || maxSamples <= 0 || maxSamples > SOUND_MAX_LIST_WAVS ) {
		maxSamples = SOUND_MAX_LIST_WAVS;
	}

	while ( src.ExpectAnyToken( &token ) ) {
		if ( token == "}" ) {
			if ( !soundSystem->GetInsideLevelLoad() ) {
				soundSystem->ValidateSoundShader( this );
			}
			return true;
		}
		if ( !token.Icmp( "minSamples" ) ) {
			maxSamples = idMath::ClampInt( src.ParseInt(), SOUND_MAX_LIST_WAVS, maxSamples );
			continue;
		}
		if ( !token.Icmp( "frequencyshift" ) ) {
			minFrequencyShift = src.ParseFloat();
			if ( !src.ExpectTokenString( "," ) ) {
				src.FreeSource();
				return false;
			}
			maxFrequencyShift = src.ParseFloat();
			continue;
		}
		if ( !token.Icmp( "description" ) ) { if ( src.ReadTokenOnLine( &token ) ) desc = token; continue; }
		if ( !token.Icmp( "mindistance" ) ) { parms.minDistance = src.ParseFloat(); continue; }
		if ( !token.Icmp( "maxdistance" ) ) { parms.maxDistance = src.ParseFloat(); continue; }
		if ( !token.Icmp( "volumeDb" ) ) {
			float volumeDb = src.ParseFloat();
			if ( volumeDb > 10.0f ) {
				common->Warning( "Clamping volume of '%s' to +10dB (3 times louder)", GetName() );
				volumeDb = 10.0f;
			}
			parms.volume = idMath::dBToScale( volumeDb );
			continue;
		}
		if ( !token.Icmp( "leadinVolume" ) ) { leadinVolume = src.ParseFloat(); continue; }
		if ( !token.Icmp( "soundClass" ) ) {
			parms.soundClass = src.ParseInt();
			if ( parms.soundClass < 0 || parms.soundClass >= SOUND_MAX_CLASSES ) {
				src.Warning( "SoundClass out of range" );
				return false;
			}
			continue;
		}
		if ( !token.Icmp( "shakes" ) ) {
			if ( src.ExpectAnyToken( &token ) ) {
				if ( token.type == TT_NUMBER ) parms.shakes = token.GetFloatValue(); else { parms.shakes = 1.0f; src.UnreadToken( &token ); }
			}
			continue;
		}
		if ( !token.Icmp( "shakeData" ) ) {
			if ( !src.ExpectAnyToken( &token ) ) return false;
			const int shakeIndex = atoi( token.c_str() );
			if ( !src.ExpectAnyToken( &token ) ) return false;
			SetShakeData( shakeIndex, token.c_str() );
			continue;
		}
		if ( !token.Icmp( "altSound" ) ) { if ( src.ReadToken( &token ) ) altSound = declManager->FindSound( token ); continue; }
		if ( !token.Icmp( "frequentlyUsed" ) ) { frequentlyUsed = true; continue; }
		if ( !token.Icmp( "no_shakes" ) ) { noShakes = true; continue; }
		if ( !token.Icmp( "no_dups" ) ) { parms.soundShaderFlags |= SSF_NO_DUPS; continue; }
		if ( !token.Icmp( "no_flicker" ) ) { parms.soundShaderFlags |= SSF_NO_FLICKER; continue; }
		if ( !token.Icmp( "looping" ) ) { parms.soundShaderFlags |= SSF_LOOPING; continue; }
		if ( !token.Icmp( "no_occlusion" ) ) { parms.soundShaderFlags |= SSF_NO_OCCLUSION; continue; }
		if ( !token.Icmp( "private" ) ) { parms.soundShaderFlags |= SSF_PRIVATE_SOUND; continue; }
		if ( !token.Icmp( "antiPrivate" ) ) { parms.soundShaderFlags |= SSF_ANTI_PRIVATE_SOUND; continue; }
		if ( !token.Icmp( "playonce" ) ) { parms.soundShaderFlags |= SSF_PLAY_ONCE; continue; }
		if ( !token.Icmp( "global" ) ) { parms.soundShaderFlags |= SSF_GLOBAL; continue; }
		if ( !token.Icmp( "unclamped" ) ) { parms.soundShaderFlags |= SSF_UNCLAMPED; continue; }
		if ( !token.Icmp( "omnidirectional" ) ) { parms.soundShaderFlags |= SSF_OMNIDIRECTIONAL; continue; }
		if ( !token.Icmp( "useDoppler" ) ) { parms.soundShaderFlags |= SSF_USEDOPPLER; continue; }
		if ( !token.Icmp( "noRandomStart" ) ) { parms.soundShaderFlags |= SSF_NO_RANDOMSTART; continue; }
		if ( !token.Icmp( "voForPlayer" ) ) { parms.soundShaderFlags |= SSF_VO_FOR_PLAYER; continue; }
		if ( !token.Icmp( "onDemand" ) ) continue;

		if ( !token.Icmp( "leadin" ) ) {
			if ( !src.ReadToken( &token ) ) return false;
			if ( soundSystem->HasCache() && numLeadins < maxSamples ) {
				leadins[numLeadins++] = soundSystem->FindSample( token );
			}
			continue;
		}

		// In Quake 4 every otherwise-unrecognized token is a sample name.  The
		// retail assets intentionally omit .wav/.ogg on many VO and shake rows.
		if ( soundSystem->HasCache() && numEntries < maxSamples ) {
			rvCommonSample *sample = soundSystem->FindSample( token );
			if ( sample != NULL ) {
				entries[numEntries++] = sample;
			}
		}
	}
	return false;
}

void idSoundShader::SetReferencedThisLevel() {
	for ( int i = 0; i < numLeadins; ++i ) if ( leadins[i] ) leadins[i]->SetReferencedThisLevel();
	for ( int i = 0; i < numEntries; ++i ) if ( entries[i] ) entries[i]->SetReferencedThisLevel();
}

float idSoundShader::GetTimeLength() const {
	float length = 0.0f;
	for ( int i = 0; i < numLeadins; ++i ) if ( leadins[i] ) length = Max( length, leadins[i]->GetDuration() );
	for ( int i = 0; i < numEntries; ++i ) if ( entries[i] ) length = Max( length, entries[i]->GetDuration() );
	return length;
}

void idSoundShader::Purge( bool freeBaseBlocks ) {
	for ( int i = 0; i < numLeadins; ++i ) if ( leadins[i] ) leadins[i]->PurgeSoundSample();
	for ( int i = 0; i < numEntries; ++i ) if ( entries[i] ) entries[i]->PurgeSoundSample();
}
void idSoundShader::LoadSampleData( int langIndex ) {
	for ( int i = 0; i < numLeadins; ++i ) if ( leadins[i] ) leadins[i]->Load( langIndex );
	for ( int i = 0; i < numEntries; ++i ) if ( entries[i] ) entries[i]->Load( langIndex );
}
void idSoundShader::ExpandSmallOggs( bool force ) {
	for ( int i = 0; i < numLeadins; ++i ) if ( leadins[i] ) leadins[i]->Expand( force );
	for ( int i = 0; i < numEntries; ++i ) if ( entries[i] ) entries[i]->Expand( force );
}

const char *idSoundShader::GetShakeData( int index ) const { return index >= 0 && index < shakes.Num() ? shakes[index].c_str() : ""; }
void idSoundShader::SetShakeData( int index, const char *ampData ) { if ( index < 0 ) return; shakes.SetNum( index + 1 ); shakes[index] = ampData != NULL ? ampData : ""; }

const char *idSoundShader::GetSampleName( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->name.c_str() : ""; }
int idSoundShader::GetSamplesPerSec( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->GetSampleRate() : 0; }
int idSoundShader::GetNumChannels( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->GetNumChannels() : 0; }
int idSoundShader::GetNumSamples( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->GetNumSamples() : 0; }
int idSoundShader::GetMemorySize( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->GetMemoryUsed() : 0; }
const byte *idSoundShader::GetNonCacheData( int index ) const { rvCommonSample *sample = SoundShaderSampleForIndex( this, index ); return sample ? sample->GetSampleData() : NULL; }

bool idSoundShader::HasDefaultSound() const { for ( int i = 0; i < numEntries; ++i ) if ( entries[i] && entries[i]->defaultSound ) return true; return false; }
int idSoundShader::GetNumSounds() const { return numLeadins + numEntries; }
const char *idSoundShader::GetSound( int index ) const {
	if ( index < 0 ) return "";
	if ( index < numLeadins ) return leadins[index] ? leadins[index]->name.c_str() : "";
	index -= numLeadins;
	return index < numEntries && entries[index] ? entries[index]->name.c_str() : "";
}

bool idSoundShader::RebuildTextSource() { return false; }
void idSoundShader::List() const { common->Printf( "%4i: %s (%d samples)\n", Index(), GetName(), GetNumSounds() ); }

const char *rvSoundShaderEditLocal::GetSampleName( const idSoundShader *sound, int index ) const { return sound ? sound->GetSampleName( index ) : ""; }
int rvSoundShaderEditLocal::GetSamplesPerSec( const idSoundShader *sound, int index ) const { return sound ? sound->GetSamplesPerSec( index ) : 0; }
int rvSoundShaderEditLocal::GetNumChannels( const idSoundShader *sound, int index ) const { return sound ? sound->GetNumChannels( index ) : 0; }
int rvSoundShaderEditLocal::GetMemorySize( const idSoundShader *sound, int index ) const { return sound ? sound->GetMemorySize( index ) : 0; }
const byte *rvSoundShaderEditLocal::GetNonCacheData( const idSoundShader *sound, int index ) const { return sound ? sound->GetNonCacheData( index ) : NULL; }
void rvSoundShaderEditLocal::LoadSampleData( idSoundShader *sound, int langIndex ) { if ( sound ) sound->LoadSampleData( langIndex ); }
void rvSoundShaderEditLocal::Purge( idSoundShader *sound, bool freeBaseBlocks ) { if ( sound ) sound->Purge( freeBaseBlocks ); }
void rvSoundShaderEditLocal::ExpandSmallOggs( idSoundShader *sound, bool force ) { if ( sound ) sound->ExpandSmallOggs( force ); }
const char *rvSoundShaderEditLocal::GetShakeData( idSoundShader *sound, int index ) { return sound ? sound->GetShakeData( index ) : ""; }
void rvSoundShaderEditLocal::SetShakeData( idSoundShader *sound, int index, const char *ampData ) { if ( sound ) sound->SetShakeData( index, ampData ); }

static rvSoundShaderEditLocal soundShaderEditLocal;
rvSoundShaderEdit *soundShaderEdit = &soundShaderEditLocal;

#else


/*
===============
idSoundShader::Init
===============
*/
void idSoundShader::Init( void ) {
	desc = "<no description>";
	errorDuringParse = false;
	onDemand = false;
	numEntries = 0;
	numLeadins = 0;
	leadinVolume = 0;
	altSound = NULL;
}

/*
===============
idSoundShader::idSoundShader
===============
*/
idSoundShader::idSoundShader( void ) {
	Init();
}

/*
===============
idSoundShader::~idSoundShader
===============
*/
idSoundShader::~idSoundShader( void ) {
}

/*
=================
idSoundShader::Size
=================
*/
size_t idSoundShader::Size( void ) const {
	return sizeof( idSoundShader );
}

/*
===============
idSoundShader::idSoundShader::FreeData
===============
*/
void idSoundShader::FreeData() {
	numEntries = 0;
	numLeadins = 0;
}

/*
===================
idSoundShader::SetDefaultText
===================
*/
bool idSoundShader::SetDefaultText( void ) {
	idStr wavname;

	wavname = GetName();
	wavname.DefaultFileExtension( ".wav" );		// if the name has .ogg in it, that will stay

	// if there exists a wav file with the same name
	if ( 1 ) { //fileSystem->ReadFile( wavname, NULL ) != -1 ) {
		char generated[2048];
		idStr::snPrintf( generated, sizeof( generated ), 
						"sound %s // IMPLICITLY GENERATED\n"
						"{\n"
						"%s\n"
						"}\n", GetName(), wavname.c_str() );
		SetText( generated );
		return true;
	} else {
		return false;
	}
}

/*
===================
DefaultDefinition
===================
*/
const char *idSoundShader::DefaultDefinition() const {
	return
		"{\n"
	"\t"	"_default.wav\n"
		"}";
}

/*
===============
idSoundShader::Parse

  this is called by the declManager
===============
*/
bool idSoundShader::Parse( const char *text, const int textLength ) {
	idLexer	src;

	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( DECL_LEXER_FLAGS );
	src.SkipUntilString( "{" );

	// deeper functions can set this, which will cause MakeDefault() to be called at the end
	errorDuringParse = false;

	if ( !ParseShader( src ) || errorDuringParse ) {
		MakeDefault();
		return false;
	}
	return true;
}

/*
===============
idSoundShader::ParseShader
===============
*/
bool idSoundShader::ParseShader( idLexer &src ) {
	int			i;
	idToken		token;

	parms.minDistance = 1;
	parms.maxDistance = 10;
	parms.volume = 1;
	parms.shakes = 0;
	parms.soundShaderFlags = 0;
	parms.soundClass = 0;

	speakerMask = 0;
	altSound = NULL;

	for( i = 0; i < SOUND_MAX_LIST_WAVS; i++ ) {
		leadins[i] = NULL;
		entries[i] = NULL;
	}
	numEntries = 0;
	numLeadins = 0;

	int	maxSamples = idSoundSystemLocal::s_maxSoundsPerShader.GetInteger();
	if ( com_makingBuild.GetBool() || maxSamples <= 0 || maxSamples > SOUND_MAX_LIST_WAVS ) {
		maxSamples = SOUND_MAX_LIST_WAVS;
	}

	while ( 1 ) {
		if ( !src.ExpectAnyToken( &token ) ) {
			return false;
		}
		// end of definition
		else if ( token == "}" ) {
			break;
		}
		// minimum number of sounds
		else if ( !token.Icmp( "minSamples" ) ) {
			maxSamples = idMath::ClampInt( src.ParseInt(), SOUND_MAX_LIST_WAVS, maxSamples );
		}
		// description
		else if ( !token.Icmp( "description" ) ) {
			src.ReadTokenOnLine( &token );
			desc = token.c_str();
		}
		// mindistance
		else if ( !token.Icmp( "mindistance" ) ) {
			parms.minDistance = src.ParseFloat();
		}
		// maxdistance
		else if ( !token.Icmp( "maxdistance" ) ) {
			parms.maxDistance = src.ParseFloat();
		}
		// shakes screen
		else if ( !token.Icmp( "shakes" ) ) {
			src.ExpectAnyToken( &token );
			if ( token.type == TT_NUMBER ) {
				parms.shakes = token.GetFloatValue();
			} else {
				src.UnreadToken( &token );
				parms.shakes = 1.0f;
			}
		}
		// reverb
		else if ( !token.Icmp( "reverb" ) ) {
			int reg0 = src.ParseFloat();
			if ( !src.ExpectTokenString( "," ) ) {
				src.FreeSource();
				return false;
			}
			int reg1 = src.ParseFloat();
			// no longer supported
		}
		// volume
		else if ( !token.Icmp( "volume" ) ) {
			parms.volume = src.ParseFloat();
		}
		// leadinVolume is used to allow light breaking leadin sounds to be much louder than the broken loop
		else if ( !token.Icmp( "leadinVolume" ) ) {
			leadinVolume = src.ParseFloat();
		}
		// speaker mask
		else if ( !token.Icmp( "mask_center" ) ) {
			speakerMask |= 1<<SPEAKER_CENTER;
		}
		// speaker mask
		else if ( !token.Icmp( "mask_left" ) ) {
			speakerMask |= 1<<SPEAKER_LEFT;
		}
		// speaker mask
		else if ( !token.Icmp( "mask_right" ) ) {
			speakerMask |= 1<<SPEAKER_RIGHT;
		}
		// speaker mask
		else if ( !token.Icmp( "mask_backright" ) ) {
			speakerMask |= 1<<SPEAKER_BACKRIGHT;
		}
		// speaker mask
		else if ( !token.Icmp( "mask_backleft" ) ) {
			speakerMask |= 1<<SPEAKER_BACKLEFT;
		}
		// speaker mask
		else if ( !token.Icmp( "mask_lfe" ) ) {
			speakerMask |= 1<<SPEAKER_LFE;
		}
		// soundClass
		else if ( !token.Icmp( "soundClass" ) ) {
			parms.soundClass = src.ParseInt();
			if ( parms.soundClass < 0 || parms.soundClass >= SOUND_MAX_CLASSES ) {
				src.Warning( "SoundClass out of range" );
				return false;
			}
		}
		// altSound
		else if ( !token.Icmp( "altSound" ) ) {
			if ( !src.ExpectAnyToken( &token ) ) {
				return false;
			}
			altSound = declManager->FindSound( token.c_str() );
		}
		// ordered
		else if ( !token.Icmp( "ordered" ) ) {
			// no longer supported
		}
		// no_dups
		else if ( !token.Icmp( "no_dups" ) ) {
			parms.soundShaderFlags |= SSF_NO_DUPS;
		}
		// no_flicker
		else if ( !token.Icmp( "no_flicker" ) ) {
			parms.soundShaderFlags |= SSF_NO_FLICKER;
		}
		// plain
		else if ( !token.Icmp( "plain" ) ) {	
			// no longer supported
		}
		// looping
		else if ( !token.Icmp( "looping" ) ) {
			parms.soundShaderFlags |= SSF_LOOPING;
		}
		// no occlusion
		else if ( !token.Icmp( "no_occlusion" ) ) {
			parms.soundShaderFlags |= SSF_NO_OCCLUSION;
		}
		// private
		else if ( !token.Icmp( "private" ) ) {
			parms.soundShaderFlags |= SSF_PRIVATE_SOUND;
		}
		// antiPrivate
		else if ( !token.Icmp( "antiPrivate" ) ) {
			parms.soundShaderFlags |= SSF_ANTI_PRIVATE_SOUND;
		}
		// once
		else if ( !token.Icmp( "playonce" ) ) {
			parms.soundShaderFlags |= SSF_PLAY_ONCE;
		}
		// global
		else if ( !token.Icmp( "global" ) ) {
			parms.soundShaderFlags |= SSF_GLOBAL;
		}
		// unclamped
		else if ( !token.Icmp( "unclamped" ) ) {
			parms.soundShaderFlags |= SSF_UNCLAMPED;
		}
		// omnidirectional
		else if ( !token.Icmp( "omnidirectional" ) ) {
			parms.soundShaderFlags |= SSF_OMNIDIRECTIONAL;
		}
		// onDemand can't be a parms, because we must track all references and overrides would confuse it
		else if ( !token.Icmp( "onDemand" ) ) {
			// no longer loading sounds on demand
			//onDemand = true;
		}

		// the wave files
		else if ( !token.Icmp( "leadin" ) ) {
			// add to the leadin list
			if ( !src.ReadToken( &token ) ) {
				src.Warning( "Expected sound after leadin" );
				return false;
			}
			if ( soundSystemLocal.soundCache && numLeadins < maxSamples ) {
				leadins[ numLeadins ] = soundSystemLocal.soundCache->FindSound( token.c_str(), onDemand );
				numLeadins++;
			}
		} else if ( token.Find( ".wav", false ) != -1 || token.Find( ".ogg", false ) != -1 ) {
			// add to the wav list
			if ( soundSystemLocal.soundCache && numEntries < maxSamples ) {
				token.BackSlashesToSlashes();
				idStr lang = cvarSystem->GetCVarString( "sys_lang" );
				if ( lang.Icmp( "english" ) != 0 && token.Find( "sound/vo/", false ) >= 0 ) {
					idStr work = token;
					work.ToLower();
					work.StripLeading( "sound/vo/" );
					work = va( "sound/vo/%s/%s", lang.c_str(), work.c_str() );
					if ( fileSystem->ReadFile( work, NULL, NULL ) > 0 ) {
						token = work;
					} else {
						// also try to find it with the .ogg extension
						work.SetFileExtension( ".ogg" );
						if ( fileSystem->ReadFile( work, NULL, NULL ) > 0 ) {
							token = work;
						}
					}
				} 					
				entries[ numEntries ] = soundSystemLocal.soundCache->FindSound( token.c_str(), onDemand );
				numEntries++;
			}
		} else {
			src.Warning( "unknown token '%s'", token.c_str() );
			return false;
		}
	}

	if ( parms.shakes > 0.0f ) {
		CheckShakesAndOgg();
	}

	return true;
}

/*
===============
idSoundShader::CheckShakesAndOgg
===============
*/
bool idSoundShader::CheckShakesAndOgg( void ) const {
	int i;
	bool ret = false;

	for ( i = 0; i < numLeadins; i++ ) {
		if ( leadins[ i ]->objectInfo.wFormatTag == WAVE_FORMAT_TAG_OGG ) {
			common->Warning( "sound shader '%s' has shakes and uses OGG file '%s'",
								GetName(), leadins[ i ]->name.c_str() );
			ret = true;
		}
	}
	for ( i = 0; i < numEntries; i++ ) {
		if ( entries[ i ]->objectInfo.wFormatTag == WAVE_FORMAT_TAG_OGG ) {
			common->Warning( "sound shader '%s' has shakes and uses OGG file '%s'",
								GetName(), entries[ i ]->name.c_str() );
			ret = true;
		}
	}
	return ret;
}

/*
===============
idSoundShader::List
===============
*/
void idSoundShader::List() const {
	idStrList	shaders;

	common->Printf( "%4i: %s\n", Index(), GetName() );
	if ( idStr::Icmp( GetDescription(), "<no description>" ) != 0 ) {
		common->Printf( "      description: %s\n", GetDescription() );
	}
	for( int k = 0; k < numLeadins ; k++ ) {
		const idSoundSample *objectp = leadins[k];
		if ( objectp ) {
			common->Printf( "      %5dms %4dKb %s (LEADIN)\n", soundSystemLocal.SamplesToMilliseconds(objectp->LengthIn44kHzSamples()), (objectp->objectMemSize/1024)
				,objectp->name.c_str() );
		}
	}
	for( int k = 0; k < numEntries; k++ ) {
		const idSoundSample *objectp = entries[k];
		if ( objectp ) {
			common->Printf( "      %5dms %4dKb %s\n", soundSystemLocal.SamplesToMilliseconds(objectp->LengthIn44kHzSamples()), (objectp->objectMemSize/1024)
				,objectp->name.c_str() );
		}
	}
}

/*
===============
idSoundShader::GetAltSound
===============
*/
const idSoundShader *idSoundShader::GetAltSound( void ) const {
	return altSound;
}

/*
===============
idSoundShader::GetMinDistance
===============
*/
float idSoundShader::GetMinDistance() const {
	return parms.minDistance;
}

/*
===============
idSoundShader::GetMaxDistance
===============
*/
float idSoundShader::GetMaxDistance() const {
	return parms.maxDistance;
}

/*
===============
idSoundShader::GetDescription
===============
*/
const char *idSoundShader::GetDescription() const {
	return desc;
}

/*
===============
idSoundShader::HasDefaultSound
===============
*/
bool idSoundShader::HasDefaultSound() const {
	for ( int i = 0; i < numEntries; i++ ) {
		if ( entries[i] && entries[i]->defaultSound ) {
			return true;
		}
	}
	return false;
}

/*
===============
idSoundShader::GetParms
===============
*/
const soundShaderParms_t *idSoundShader::GetParms() const {
	return &parms;
}

/*
===============
idSoundShader::GetNumSounds
===============
*/
int idSoundShader::GetNumSounds() const {
	return numLeadins + numEntries;
}

/*
===============
idSoundShader::GetSound
===============
*/
const char *idSoundShader::GetSound( int index ) const {
	if ( index >= 0 ) {
		if ( index < numLeadins ) {
			return leadins[index]->name.c_str();
		}
		index -= numLeadins;
		if ( index < numEntries ) {
			return entries[index]->name.c_str();
		}
	}
	return "";
}

#endif // Q4_RECONSTRUCTED_SOUND
