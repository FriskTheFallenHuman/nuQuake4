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

  Quake 4 material-type declaration implementation.
  Function ownership and ABI are recovered from quake4.pdb
  (declMatType.obj).

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "declMatType.h"

extern void R_LoadImage( const char *name, byte **pic, int *width, int *height, ID_TIME_T *timestamp, bool makePowerOf2 );
extern void R_StaticFree( void *data );

static idCVar mat_useHitMaterials( "mat_useHitMaterials", "1", CVAR_RENDERER | CVAR_BOOL, "use prebuilt .hit material lookup images" );
static idCVar mat_writeHitMaterials( "mat_writeHitMaterials", "0", CVAR_RENDERER | CVAR_BOOL, "write generated .hit material lookup images" );

static const rvDeclMatType *MT_FindMaterialTypeByTint( unsigned int tint ) {
	const int count = declManager->GetNumDecls( DECL_MATERIALTYPE );
	for ( int i = 0; i < count; i++ ) {
		const rvDeclMatType *materialType = declManager->MaterialTypeByIndex( i, true );
		if ( materialType && static_cast<unsigned int>( materialType->GetTint() ) == tint ) {
			return materialType;
		}
	}
	return NULL;
}

static const rvDeclMatType *MT_FindMaterialTypeByClosestTint( unsigned int tint ) {
	const byte *wanted = reinterpret_cast<const byte *>( &tint );
	const rvDeclMatType *best = NULL;
	int bestDistance = 0x01000001;
	const int count = declManager->GetNumDecls( DECL_MATERIALTYPE );
	for ( int i = 0; i < count; i++ ) {
		const rvDeclMatType *candidate = declManager->MaterialTypeByIndex( i, true );
		if ( !candidate ) {
			continue;
		}
		const unsigned int candidateTint = static_cast<unsigned int>( candidate->GetTint() );
		const byte *current = reinterpret_cast<const byte *>( &candidateTint );
		const int red = static_cast<int>( wanted[0] ) - current[0];
		const int green = static_cast<int>( wanted[1] ) - current[1];
		const int blue = static_cast<int>( wanted[2] ) - current[2];
		const int distance = red * red + green * green + blue * blue;
		if ( distance < bestDistance ) {
			bestDistance = distance;
			best = candidate;
		}
	}
	return best;
}

const char *rvDeclMatType::DefaultDefinition( void ) const {
	return "{ description \"<DEFAULTED>\" rgb 0,0,0 }";
}

bool rvDeclMatType::Validate( const char *text, int textLength, idStr &report ) const {
	idDecl *decl = declManager->AllocateDecl( DECL_MATERIALTYPE );
	const bool valid = decl->Parse( text, textLength, false );
	decl->FreeData();
	delete decl;
	return valid;
}

void rvDeclMatType::FreeData( void ) {
	mDescription.Clear();
}

size_t rvDeclMatType::Size( void ) const {
	return sizeof( *this ) + mDescription.Allocated();
}

bool rvDeclMatType::Parse( const char *text, const int textLength, bool noCaching ) {
	idLexer src;
	idToken token;
	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( 6300 );
	if ( !src.SkipUntilString( "{" ) ) {
		return false;
	}

	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			return true;
		}
		if ( !token.Icmp( "rgb" ) ) {
			mTint[0] = static_cast<byte>( src.ParseInt() );
			src.ExpectTokenString( "," );
			mTint[1] = static_cast<byte>( src.ParseInt() );
			src.ExpectTokenString( "," );
			mTint[2] = static_cast<byte>( src.ParseInt() );
			mTint[3] = 255;
		} else if ( !token.Icmp( "description" ) ) {
			if ( !src.ReadToken( &token ) ) {
				return false;
			}
			mDescription = token;
		}
	}
	return false;
}

byte *MT_GetMaterialTypeArray( idStr image, int &width, int &height ) {
	if ( mat_useHitMaterials.GetBool() ) {
		image.SetFileExtension( ".hit" );
		idFile *file = fileSystem->OpenFileRead( image );
		if ( file ) {
			file->ReadInt( height );
			file->ReadInt( width );
			const int byteCount = width * height;
			byte *array = static_cast<byte *>( Mem_ClearedAlloc( byteCount, MA_MATERIAL ) );
			file->Read( array, byteCount );
			fileSystem->CloseFile( file );
			return array;
		}
		image.StripFileExtension();
	}

	byte *pixels = NULL;
	R_LoadImage( image, &pixels, &width, &height, NULL, false );
	if ( !pixels ) {
		common->Warning( "Failed to load hit material image %s", image.c_str() );
		return NULL;
	}

	const int pixelCount = width * height;
	byte *array = static_cast<byte *>( Mem_ClearedAlloc( pixelCount, MA_MATERIAL ) );
	for ( int i = 0; i < pixelCount; i++ ) {
		const unsigned int tint = reinterpret_cast<unsigned int *>( pixels )[i];
		const rvDeclMatType *materialType = MT_FindMaterialTypeByTint( tint );
		if ( !materialType ) {
			materialType = MT_FindMaterialTypeByClosestTint( tint );
		}
		array[i] = materialType ? static_cast<byte>( materialType->Index() ) : 0;
	}
	R_StaticFree( pixels );

	if ( mat_writeHitMaterials.GetBool() ) {
		image.SetFileExtension( ".hit" );
		idFile *file = fileSystem->OpenFileWrite( image );
		if ( file ) {
			file->WriteInt( height );
			file->WriteInt( width );
			file->Write( array, pixelCount );
			fileSystem->CloseFile( file );
		}
	}
	return array;
}

#if defined( _WIN32 ) && !defined( RV_BINARYDECLS )
static_assert( sizeof( rvDeclMatType ) == 44, "rvDeclMatType ABI drift" );
#endif
