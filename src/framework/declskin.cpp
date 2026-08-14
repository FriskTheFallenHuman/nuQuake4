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

#if defined(Q4_RECON_ENGINE_PRIVATE) && defined(_M_IX86)
static_assert( sizeof( idDeclSkin ) == 0x28, "retail idDeclSkin ABI drift" );
#endif

/*
=================
idDeclSkin::idDeclSkin
=================
*/
idDeclSkin::idDeclSkin( void ) {
}

/*
=================
idDeclSkin::Size
=================
*/
size_t idDeclSkin::Size( void ) const {
	return sizeof( idDeclSkin ) + mappings.Allocated() + associatedModels.Allocated();
}

/*
================
idDeclSkin::FreeData
================
*/
void idDeclSkin::FreeData( void ) {
	mappings.Clear();
}

/*
================
idDeclSkin::Parse
================
*/
bool idDeclSkin::Parse( const char *text, const int textLength, bool noCaching ) {
	idLexer src;
	idToken	token, token2;
	(void)noCaching;

	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( DECL_LEXER_FLAGS );
	src.SkipUntilString( "{" );

	associatedModels.Clear();

	while (1) {
		if ( !src.ReadToken( &token ) ) {
			break;
		}

		if ( !token.Icmp( "}" ) ) {
			break;
		}
		if ( !src.ReadToken( &token2 ) ) {
			src.Warning( "Unexpected end of file" );
			MakeDefault();
			return false;
		}

		if ( !token.Icmp( "model" ) ) {
			associatedModels.Append( token2 );
			continue;
		}

		skinMapping_t	map;

		if ( !token.Icmp( "*" ) ) {
			// wildcard
			map.from = NULL;
		} else {
			map.from = declManager->FindMaterial( token );
		}

		map.to = declManager->FindMaterial( token2 );

		mappings.Append( map );
	}

	return false;
}

/*
================
idDeclSkin::SetDefaultText
================
*/
bool idDeclSkin::SetDefaultText( void ) {
	// if there exists a material with the same name
	if ( declManager->FindType( DECL_MATERIAL, GetName() ) ) {
		char generated[2048];

		idStr::snPrintf( generated, sizeof( generated ),
						"skin %s // IMPLICITLY GENERATED\n"
						"{\n"
						"_default %s\n"
						"}\n", GetName(), GetName() );
		SetText( generated );
		return true;
	} else {
		return false;
	}
}

/*
================
idDeclSkin::DefaultDefinition
================
*/
const char *idDeclSkin::DefaultDefinition( void ) const {
	return
		"{\n"
	"\t"	"\"*\"\t\"_default\"\n"
		"}";
}

/*
================
idDeclSkin::Validate
================
*/
bool idDeclSkin::Validate( const char *text, int textLength, idStr &report ) const {
	idDecl *decl = declManager->AllocateDecl( DECL_SKIN );
	const bool valid = decl->Parse( text, textLength, false );
	decl->FreeData();
	delete decl->base;
	delete decl;
	(void)report;
	return valid;
}

/*
===============
RemapShaderBySkin
===============
*/
const idMaterial *idDeclSkin::RemapShaderBySkin( const idMaterial *shader ) const {
	int		i;

	if ( !shader ) {
		return NULL;
	}

	// never remap surfaces that were originally nodraw, like collision hulls
	if ( !shader->IsDrawn() ) {
		return shader;
	}

	for ( i = 0; i < mappings.Num() ; i++ ) {
		const skinMapping_t	*map = &mappings[i];

		// NULL = wildcard match
		if ( !map->from || map->from == shader ) {
			return map->to;
		}
	}

	// didn't find a match or wildcard, so stay the same
	return shader;
}
