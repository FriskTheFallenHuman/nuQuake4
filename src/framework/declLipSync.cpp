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

  Quake 4 lip-sync declaration implementation.
  Function ownership and public ABI are recovered from quake4.pdb
  (declLipSync.obj); behavior follows the retail Hex-Rays listing.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "declLipSync.h"

class rvDeclLipSyncEditLocal : public rvDeclLipSyncEdit {
public:
	virtual void SetLipSyncDescription( rvDeclLipSync *edit, const char *desc ) {
		edit->SetDescription( desc );
	}
	virtual void SetLipSyncTranscribeText( rvDeclLipSync *edit, const char *text ) {
		edit->SetTranscribeText( text );
	}
	virtual void SetLipSyncData( rvDeclLipSync *edit, const char *lsd, const char *lang ) {
		edit->SetLipSyncData( lsd, lang );
	}
};

static rvDeclLipSyncEditLocal declLipSyncEditLocal;
rvDeclLipSyncEdit *declLipSyncEdit = &declLipSyncEditLocal;

const char *rvDeclLipSync::DefaultDefinition( void ) const {
	return "{ description \"<DEFAULTED>\" }";
}

bool rvDeclLipSync::Validate( const char *text, int textLength, idStr &report ) const {
	idDecl *decl = declManager->AllocateDecl( DECL_LIPSYNC );
	const bool valid = decl->Parse( text, textLength, false );
	decl->FreeData();
	delete decl;
	return valid;
}

void rvDeclLipSync::FreeData( void ) {
	mDescription.Clear();
	mTranscribeText.Clear();
	mHMM.Clear();
	mLipSyncData.Clear();
}

void rvDeclLipSync::SetLipSyncData( const char *lsd, const char *lang ) {
	if ( strchr( lsd, '%' ) ) {
		common->Warning( "SetLipSyncData: language %s for lipsync '%s' has invalid character %% in it", lang, GetName() );
		return;
	}
	mLipSyncData.Set( lang, lsd );
}

bool rvDeclLipSync::Parse( const char *text, const int textLength, bool noCaching ) {
	idLexer src;
	idToken token;
	idToken lang;

	src.LoadMemory( text, textLength, GetFileName(), GetLineNum() );
	src.SetFlags( 6300 );
	if ( !src.SkipUntilString( "{" ) ) {
		return false;
	}

	mHMM = "male";
	while ( src.ReadToken( &token ) ) {
		if ( token == "}" ) {
			return true;
		}
		if ( !token.Icmp( "description" ) ) {
			if ( !src.ReadToken( &token ) ) {
				return false;
			}
			mDescription = token;
		} else if ( !token.Icmp( "text" ) ) {
			if ( !src.ReadToken( &token ) ) {
				return false;
			}
			mTranscribeText = token;
		} else if ( !token.Icmp( "hmm" ) ) {
			if ( !src.ReadToken( &token ) ) {
				return false;
			}
			mHMM = token;
		} else if ( !token.Icmp( "visemes" ) ) {
			if ( !src.ReadToken( &lang ) || !src.ReadToken( &token ) ) {
				return false;
			}
			SetLipSyncData( token.c_str(), lang.c_str() );
		}
	}
	return false;
}

bool rvDeclLipSync::RebuildTextSource( void ) {
	idFile_Memory file;
	file.WriteFloatString( "\r\nlipSync %s\r\n{\r\n", GetName() );
	if ( mDescription.Length() ) {
		file.WriteFloatString( "\tdescription\t\"%s\"\r\n", mDescription.c_str() );
	}
	if ( mTranscribeText.Length() ) {
		file.WriteFloatString( "\ttext\t\t\"%s\"\r\n", mTranscribeText.c_str() );
	}
	if ( mHMM.Icmp( "male" ) ) {
		file.WriteFloatString( "\thmm\t\t\"%s\"\r\n", mHMM.c_str() );
	}
	for ( int i = 0; i < mLipSyncData.GetNumKeyVals(); i++ ) {
		const idKeyValue *keyValue = mLipSyncData.GetKeyVal( i );
		file.WriteFloatString( "\tvisemes\t\"%s\"\t\"%s\"\r\n", keyValue->GetKey().c_str(), keyValue->GetValue().c_str() );
	}
	file.WriteFloatString( "}\r\n\r\n" );
	SetText( file.GetDataPtr() );
	return true;
}

size_t rvDeclLipSync::Size( void ) const {
	return sizeof( *this ) + mDescription.Allocated() + mTranscribeText.Allocated() + mHMM.Allocated() + mLipSyncData.Allocated();
}

#if defined( _WIN32 ) && !defined( RV_BINARYDECLS )
static_assert( sizeof( rvDeclLipSync ) == 148, "rvDeclLipSync ABI drift" );
#endif
