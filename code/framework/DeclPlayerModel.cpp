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

  Quake 4 player-model declaration implementation.

  This declaration is part of the SDK-facing framework contract and is
  registered by game code as DECL_PLAYER_MODEL.  It does not appear in the
  retail executable PDB because its concrete owner lives on the game side of
  that boundary; the implementation remains here beside its SDK header.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "DeclPlayerModel.h"

rvDeclPlayerModel::rvDeclPlayerModel() {
	headOffset.Zero();
}

const char *rvDeclPlayerModel::DefaultDefinition( void ) const {
	return "{ model \"\" head \"\" headOffset ( 0 0 0 ) uiHead \"\" team \"\" skin \"\" description \"<DEFAULTED>\" sounds { } }";
}

void rvDeclPlayerModel::FreeData( void ) {
	model.Clear();
	head.Clear();
	headOffset.Zero();
	uiHead.Clear();
	team.Clear();
	skin.Clear();
	description.Clear();
	sounds.Clear();
}

static bool ParsePlayerModelString( idLexer &src, idStr &value ) {
	idToken token;
	if ( !src.ReadToken( &token ) ) {
		return false;
	}
	value = token;
	return true;
}

static bool ParsePlayerModelOffset( idLexer &src, idVec3 &offset ) {
	if ( src.CheckTokenString( "(" ) ) {
		offset.x = src.ParseFloat();
		offset.y = src.ParseFloat();
		offset.z = src.ParseFloat();
		return src.ExpectTokenString( ")" ) != 0;
	}
	offset.x = src.ParseFloat();
	src.CheckTokenString( "," );
	offset.y = src.ParseFloat();
	src.CheckTokenString( "," );
	offset.z = src.ParseFloat();
	return true;
}

bool rvDeclPlayerModel::Parse( const char *text, const int textLength, bool noCaching ) {
	idLexer src;
	idToken token;
	const char *fileName = base ? GetFileName() : "*playerModel validation*";
	const int lineNumber = base ? GetLineNum() : 1;
	src.LoadMemory( text, textLength, fileName, lineNumber );
	src.SetFlags( DECL_LEXER_FLAGS );
	if ( !src.SkipUntilString( "{" ) ) {
		return false;
	}

	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			return !src.HadError();
		}
		if ( !token.Icmp( "model" ) ) {
			if ( !ParsePlayerModelString( src, model ) ) return false;
		} else if ( !token.Icmp( "head" ) ) {
			if ( !ParsePlayerModelString( src, head ) ) return false;
		} else if ( !token.Icmp( "headOffset" ) ) {
			if ( !ParsePlayerModelOffset( src, headOffset ) ) return false;
		} else if ( !token.Icmp( "uiHead" ) ) {
			if ( !ParsePlayerModelString( src, uiHead ) ) return false;
		} else if ( !token.Icmp( "team" ) ) {
			if ( !ParsePlayerModelString( src, team ) ) return false;
		} else if ( !token.Icmp( "skin" ) ) {
			if ( !ParsePlayerModelString( src, skin ) ) return false;
		} else if ( !token.Icmp( "description" ) ) {
			if ( !ParsePlayerModelString( src, description ) ) return false;
		} else if ( !token.Icmp( "sound" ) ) {
			idToken key;
			idToken value;
			if ( !src.ReadToken( &key ) || !src.ReadToken( &value ) ) return false;
			sounds.Set( key, value );
		} else if ( !token.Icmp( "sounds" ) ) {
			if ( !src.ExpectTokenString( "{" ) ) return false;
			idToken key;
			while ( src.ReadToken( &key ) && key != "}" ) {
				idToken value;
				if ( !src.ReadToken( &value ) ) return false;
				sounds.Set( key, value );
			}
		} else {
			src.Warning( "unknown playerModel parameter '%s'", token.c_str() );
			idStr ignored;
			src.ParseRestOfLine( ignored );
		}
	}
	return false;
}

size_t rvDeclPlayerModel::Size( void ) const {
	return sizeof( *this ) + model.Allocated() + head.Allocated() + uiHead.Allocated() + team.Allocated() + skin.Allocated() + description.Allocated() + sounds.Allocated();
}

void rvDeclPlayerModel::Print( void ) {
	common->Printf( "model:       %s\n", model.c_str() );
	common->Printf( "head:        %s\n", head.c_str() );
	common->Printf( "headOffset:  %s\n", headOffset.ToString() );
	common->Printf( "uiHead:      %s\n", uiHead.c_str() );
	common->Printf( "team:        %s\n", team.c_str() );
	common->Printf( "skin:        %s\n", skin.c_str() );
	common->Printf( "description: %s\n", description.c_str() );
	sounds.Print();
}

bool rvDeclPlayerModel::Validate( const char *text, int textLength, idStr &report ) const {
	rvDeclPlayerModel validation;
	const bool valid = validation.Parse( text, textLength, false );
	if ( !valid ) {
		report = "playerModel declaration did not parse";
	}
	return valid;
}

#if defined( _WIN32 )
static_assert( sizeof( rvDeclPlayerModel ) == 256, "rvDeclPlayerModel ABI drift" );
#endif
