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

/*
===========================================================================

  Quake 4 playback declaration implementation.
  Function ownership and ABI are recovered from quake4.pdb
  (declPlayback.obj); parsing and playback behavior follow the retail dump.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "declPlayback.h"

class rvDeclPlaybackEditLocal : public rvDeclPlaybackEdit {
public:
	virtual bool Finish( rvDeclPlayback *edit, float desiredDuration ) {
		return edit->Finish( desiredDuration );
	}
	virtual void SetOrigin( rvDeclPlayback *edit ) {
		edit->SetOrigin();
	}
	virtual void SetOrigin( rvDeclPlayback *edit, idVec3 &origin ) {
		edit->SetOrigin( origin );
	}
	virtual void Copy( rvDeclPlayback *edit, rvDeclPlayback *copy ) {
		edit->Copy( copy );
	}
};

static rvDeclPlaybackEditLocal declPlaybackEditLocal;
rvDeclPlaybackEdit *declPlaybackEdit = &declPlaybackEditLocal;

rvDeclPlayback::rvDeclPlayback( void ) {
	flags = 0;
	frameRate = 15.0f;
	duration = 0.0f;
	origin.Zero();
	bounds.Clear();
	points.SetOrder( 4 );
	angles.SetOrder( 4 );
}

rvDeclPlayback::~rvDeclPlayback( void ) {
	FreeData();
}

const char *rvDeclPlayback::DefaultDefinition( void ) const {
	return "{ sequence { } data { } }";
}

bool rvDeclPlayback::Validate( const char *text, int textLength, idStr &report ) const {
	idDecl *decl = declManager->AllocateDecl( DECL_PLAYBACK );
	const bool valid = decl->Parse( text, textLength, false );
	decl->FreeData();
	delete decl;
	return valid;
}

void rvDeclPlayback::FreeData( void ) {
	points.Clear();
	angles.Clear();
	buttons.Clear();
}

void rvDeclPlayback::ParseSample( idLexer *src, idVec3 &pos, idAngles &ang ) {
	idToken token;
	while ( src->ReadToken( &token ) ) {
		if ( token == "}" ) {
			return;
		}
		if ( !token.Icmp( "pos" ) ) {
			pos.x = src->ParseFloat();
			src->ExpectTokenString( "," );
			pos.y = src->ParseFloat();
			src->ExpectTokenString( "," );
			pos.z = src->ParseFloat();
		} else if ( !token.Icmp( "ang" ) ) {
			ang.pitch = src->ParseFloat();
			src->ExpectTokenString( "," );
			ang.yaw = src->ParseFloat();
			ang.roll = 0.0f;
		} else if ( !token.Icmp( "rotate" ) ) {
			ang.pitch = src->ParseFloat();
			src->ExpectTokenString( "," );
			ang.yaw = src->ParseFloat();
			src->ExpectTokenString( "," );
			ang.roll = src->ParseFloat();
		} else if ( !token.Icmp( "down" ) || !token.Icmp( "up" ) || !token.Icmp( "impulse" ) ) {
			src->ParseInt();
		}
	}
}

bool rvDeclPlayback::ParseSequence( idLexer *src ) {
	idToken token;
	src->ExpectTokenString( "sequence" );
	src->ExpectTokenString( "{" );
	while ( src->ReadToken( &token ) ) {
		if ( token == "}" ) {
			return true;
		}
		if ( !token.Icmp( "destination" ) ) {
			idStr ignored;
			src->ParseRestOfLine( ignored );
		} else if ( !token.Icmp( "origin" ) ) {
			origin.x = src->ParseFloat();
			src->ExpectTokenString( "," );
			origin.y = src->ParseFloat();
			src->ExpectTokenString( "," );
			origin.z = src->ParseFloat();
		} else if ( !token.Icmp( "framerate" ) ) {
			frameRate = src->ParseFloat();
		} else {
			src->Error( "Invalid token %s in file %s.\n", token.c_str(), GetName() );
		}
	}
	return false;
}

bool rvDeclPlayback::ParseData( idLexer *src ) {
	idToken token;
	float time = 0.0f;
	idVec3 pos = vec3_origin;
	idAngles ang = ang_zero;
	if ( !src->ExpectTokenString( "{" ) ) {
		return false;
	}
	while ( src->ReadToken( &token ) ) {
		if ( token == "}" ) {
			duration = time;
			return true;
		}
		if ( token == "{" ) {
			ParseSample( src, pos, ang );
			points.AddValue( time, pos );
			angles.AddValue( time, ang );
			time += ( frameRate > 0.0f ) ? 1.0f / frameRate : 0.0f;
		}
	}
	return false;
}

void rvDeclPlayback::ParseButton( idLexer *src, byte &button, rvButtonState &state ) {
	idToken token;
	const float time = src->ParseFloat();
	byte impulse = 0;
	while ( src->ReadToken( &token ) ) {
		if ( token == "}" ) {
			break;
		}
		if ( !token.Icmp( "down" ) ) {
			button |= static_cast<byte>( src->ParseInt() );
		} else if ( !token.Icmp( "up" ) ) {
			button &= ~static_cast<byte>( src->ParseInt() );
		} else if ( !token.Icmp( "impulse" ) ) {
			impulse = static_cast<byte>( src->ParseInt() );
		}
	}
	state.Init( time, button, impulse );
}

bool rvDeclPlayback::ParseButtons( idLexer *src ) {
	idToken token;
	byte button = 0;
	if ( !src->ExpectTokenString( "{" ) ) {
		return false;
	}
	while ( src->ReadToken( &token ) ) {
		if ( token == "}" ) {
			return true;
		}
		if ( token == "{" ) {
			rvButtonState state;
			ParseButton( src, button, state );
			buttons.Append( state );
		}
	}
	return false;
}

bool rvDeclPlayback::Parse( const char *text, const int textLength, bool noCaching ) {
	idLexer src;
	idToken token;
	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( 6300 );
	if ( !src.SkipUntilString( "{" ) || !ParseSequence( &src ) ) {
		return false;
	}
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			SetOrigin();
			return true;
		}
		if ( !token.Icmp( "data" ) ) {
			if ( !ParseData( &src ) ) {
				return false;
			}
		} else if ( !token.Icmp( "buttons" ) ) {
			if ( !ParseButtons( &src ) ) {
				return false;
			}
		}
	}
	return false;
}

void rvDeclPlayback::WriteSequence( idFile_Memory &file ) {
	file.WriteFloatString( "\tsequence\n\t{\n" );
	file.WriteFloatString( "\t\torigin\t\t%.1f,%.1f,%.1f\n", origin.x, origin.y, origin.z );
	file.WriteFloatString( "\t\tframeRate\t%.1f\n", frameRate );
	file.WriteFloatString( "\t}\n" );
}

void rvDeclPlayback::WriteData( idFile_Memory &file ) {
	const int count = Max( points.GetNumValues(), angles.GetNumValues() );
	if ( count == 0 || !( flags & ( PBFL_GET_POSITION | PBFL_GET_ANGLES ) ) ) {
		return;
	}
	file.WriteFloatString( "\tdata\n\t{\n" );
	idVec3 oldPos = vec3_origin;
	idAngles oldAng = ang_zero;
	for ( int i = 0; i < count; i++ ) {
		file.WriteFloatString( "\t\t{ " );
		if ( ( flags & PBFL_GET_POSITION ) && i < points.GetNumValues() ) {
			const idVec3 pos = points.GetValue( i );
			if ( ( pos - oldPos ).LengthSqr() > Square( 0.0625f ) ) {
				file.WriteFloatString( "pos %.1f,%.1f,%.1f ", pos.x, pos.y, pos.z );
				oldPos = pos;
			}
		}
		if ( ( flags & PBFL_GET_ANGLES ) && i < angles.GetNumValues() ) {
			const idAngles ang = angles.GetValue( i );
			const idAngles delta = ang - oldAng;
			if ( delta.pitch * delta.pitch + delta.yaw * delta.yaw + delta.roll * delta.roll > Square( 0.0625f ) ) {
				if ( ang.roll == 0.0f ) {
					file.WriteFloatString( "ang %.1f,%.1f ", ang.pitch, ang.yaw );
				} else {
					file.WriteFloatString( "rotate %.1f,%.1f,%.1f ", ang.pitch, ang.yaw, ang.roll );
				}
				oldAng = ang;
			}
		}
		file.WriteFloatString( "}\n" );
	}
	file.WriteFloatString( "\t}\n" );
}

void rvDeclPlayback::WriteButtons( idFile_Memory &file ) {
	if ( buttons.Num() == 0 || !( flags & PBFL_GET_BUTTONS ) ) {
		return;
	}
	file.WriteFloatString( "\tbuttons\n\t{\n" );
	byte previous = 0;
	for ( int i = 0; i < buttons.Num(); i++ ) {
		const rvButtonState &state = buttons[i];
		const byte changed = previous ^ state.state;
		if ( !changed && !state.impulse ) {
			continue;
		}
		file.WriteFloatString( "\t\t{ %.3g ", state.time );
		if ( state.state & changed ) {
			file.WriteFloatString( "down %d ", state.state & changed );
		}
		if ( previous & changed ) {
			file.WriteFloatString( "up %d ", previous & changed );
		}
		if ( state.impulse ) {
			file.WriteFloatString( "impulse %d ", state.impulse );
		}
		file.WriteFloatString( "}\n" );
		previous = state.state;
	}
	file.WriteFloatString( "\t}\n" );
}

bool rvDeclPlayback::RebuildTextSource( void ) {
	idFile_Memory file;
	file.WriteFloatString( "\nplayback %s\n{\n", GetName() );
	WriteSequence( file );
	WriteData( file );
	WriteButtons( file );
	file.WriteFloatString( "}\n\n" );
	SetText( file.GetDataPtr() );
	return true;
}

void rvDeclPlayback::SetOrigin( void ) {
	if ( points.GetNumValues() == 0 ) {
		bounds.Clear();
		return;
	}
	const idVec3 first = points.GetValue( 0 );
	origin += first;
	bounds.Clear();
	for ( int i = 0; i < points.GetNumValues(); i++ ) {
		const idVec3 local = points.GetValue( i ) - first;
		points.SetValue( i, local );
		bounds.AddPoint( local );
	}
}

void rvDeclPlayback::Start( void ) {
	origin.Zero();
	bounds.Clear();
	duration = 0.0f;
	points.Clear();
	angles.Clear();
	buttons.Clear();
	points.SetGranularity( 60 );
	angles.SetGranularity( 60 );
	buttons.SetGranularity( 60 );
}

void rvDeclPlayback::Copy( rvDeclPlayback *playback ) {
	if ( !playback ) {
		return;
	}
	flags = playback->flags & ~PBFL_ED_MASK;
	frameRate = playback->frameRate;
	duration = playback->duration;
	origin = playback->origin;
	bounds = playback->bounds;
	points = playback->points;
	angles = playback->angles;
	buttons = playback->buttons;
}

bool rvDeclPlayback::SetCurrentData( float localTime, int control, rvDeclPlaybackData *data ) {
	if ( !data ) {
		return false;
	}
	if ( control & PBFL_GET_POSITION ) {
		points.AddValue( localTime, data->GetPosition() );
	}
	if ( control & PBFL_GET_ANGLES ) {
		angles.AddValue( localTime, data->GetAngles() );
	}
	if ( control & PBFL_GET_BUTTONS ) {
		rvButtonState state;
		state.Init( localTime, data->GetButtons(), data->GetImpulse() );
		buttons.Append( state );
	}
	duration = Max( duration, localTime );
	return true;
}

bool rvDeclPlayback::GetCurrentOffset( float localTime, idVec3 &pos ) const {
	if ( points.GetNumValues() == 0 ) {
		pos.Zero();
		return false;
	}
	pos = points.GetCurrentValue( localTime );
	return true;
}

bool rvDeclPlayback::GetCurrentAngles( float localTime, idAngles &ang ) const {
	if ( angles.GetNumValues() == 0 ) {
		ang.Zero();
		return false;
	}
	ang = angles.GetCurrentValue( localTime );
	return true;
}

bool rvDeclPlayback::GetCurrentData( int control, float localTime, float lastTime, rvDeclPlaybackData *data ) const {
	if ( !data || points.GetNumValues() == 0 ) {
		return true;
	}
	if ( control & PBFL_GET_POSITION ) {
		data->SetPosition( points.GetCurrentValue( localTime ) + origin );
	}
	if ( control & ( PBFL_GET_VELOCITY | PBFL_GET_ANGLES_FROM_VEL ) ) {
		data->SetVelocity( points.GetCurrentFirstDerivative( localTime ) );
	}
	if ( control & PBFL_GET_ACCELERATION ) {
		data->SetAcceleration( points.GetCurrentSecondDerivative( localTime ) );
	}
	if ( control & PBFL_GET_ANGLES ) {
		data->SetAngles( angles.GetCurrentValue( localTime ) );
	} else if ( control & PBFL_GET_ANGLES_FROM_VEL ) {
		data->SetAngles( data->GetVelocity().ToAngles() );
	}
	if ( control & PBFL_GET_BUTTONS ) {
		byte previous = 0;
		for ( int i = 0; i < buttons.Num(); i++ ) {
			const rvButtonState &state = buttons[i];
			if ( state.time > localTime ) {
				break;
			}
			if ( state.time > lastTime ) {
				const byte changed = previous ^ state.state;
				if ( state.state & changed ) {
					data->SetChanged( state.state & changed );
					data->CallCallback( PBCB_BUTTON_DOWN, state.time );
				}
				if ( previous & changed ) {
					data->SetChanged( previous & changed );
					data->CallCallback( PBCB_BUTTON_UP, state.time );
				}
				if ( state.impulse ) {
					data->SetImpulse( state.impulse );
					data->CallCallback( PBCB_IMPULSE, state.time );
				}
			}
			previous = state.state;
		}
		data->SetButtons( previous );
	}
	return localTime > duration;
}

bool rvDeclPlayback::Finish( float desiredDuration ) {
	SetOrigin();
	rvDeclPlayback source;
	source.Copy( this );
	FreeData();
	flags = source.flags;
	frameRate = source.frameRate;
	origin = source.origin;
	bounds = source.bounds;
	const float timeScale = ( desiredDuration >= 0.0f && desiredDuration > 0.0f ) ? source.duration / desiredDuration : 1.0f;
	duration = ( desiredDuration >= 0.0f ) ? desiredDuration : source.duration;

	byte previous = 0;
	for ( int i = 0; i < source.buttons.Num(); i++ ) {
		const rvButtonState &oldState = source.buttons[i];
		if ( oldState.state != previous || oldState.impulse ) {
			rvButtonState newState = oldState;
			newState.time /= timeScale;
			buttons.Append( newState );
			previous = oldState.state;
		}
	}

	if ( frameRate <= 0.0f ) {
		return false;
	}
	const float step = 1.0f / frameRate;
	for ( float newTime = 0.0f; newTime <= duration + step * 0.5f; newTime += step ) {
		const float oldTime = Min( source.duration, newTime * timeScale );
		if ( source.points.GetNumValues() ) {
			points.AddValue( newTime, source.points.GetCurrentValue( oldTime ) );
		}
		if ( source.angles.GetNumValues() ) {
			angles.AddValue( newTime, source.angles.GetCurrentValue( oldTime ) );
		}
	}
	return true;
}

size_t rvDeclPlayback::Size( void ) const {
	return sizeof( *this ) + buttons.Allocated() + sizeof( idVec3 ) * points.GetNumValues() + sizeof( idAngles ) * angles.GetNumValues();
}

#if defined( _WIN32 ) && !defined( RV_BINARYDECLS )
static_assert( sizeof( rvDeclPlaybackData ) == 60, "rvDeclPlaybackData ABI drift" );
static_assert( sizeof( rvDeclPlayback ) == 184, "rvDeclPlayback ABI drift" );
#endif
