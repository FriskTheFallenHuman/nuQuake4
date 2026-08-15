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

#ifndef __DECLLIPSYNC_H__
#define __DECLLIPSYNC_H__

// A way of cross referencing strings and sound shaders
// RAVEN BEGIN
// jsinger: added to support serialization/deserialization of binary decls
#ifdef RV_BINARYDECLS
class rvDeclLipSync : public idDecl, public Serializable<'RDLS'>
{
public:
	virtual void		Write( SerialOutputStream &stream ) const;
	virtual void		AddReferences() const;
						rvDeclLipSync( SerialInputStream &stream );
#else
class rvDeclLipSync : public idDecl
{
#endif
// RAVEN END
public:
						rvDeclLipSync( void ) {}
						~rvDeclLipSync( void ) {}

	void				SetDescription( const char *desc ) { mDescription = desc; }
	const idStr			&GetDescription( void ) const { return( mDescription ); }

	void				SetHMM( idStr &hmm ) { mHMM = hmm; }
	const idStr			&GetHMM( void ) const { return( mHMM ); }

	void				SetTranscribeText( const char *text ) { mTranscribeText = text; }
	const char			*GetTranscribeText( int langIndex = -1 ) const { return( common->GetLocalizedString( mTranscribeText, langIndex ) ); }
	const char			*GetRawTranscribeText( void ) const { return( mTranscribeText.c_str() ); }

	void				SetLipSyncData( const char *lsd, const char *lang );
	const char			*GetLipSyncData( int langIdx = -1 ) const;

	virtual const char	*DefaultDefinition( void ) const;
	virtual bool		Parse( const char *text, const int textLength, bool noCaching );
	virtual void		FreeData( void );
	virtual	bool		RebuildTextSource( void );
	virtual size_t		Size( void ) const;

	// scork: for detailed error-reporting
	virtual bool		Validate( const char *psText, int iTextLength, idStr &strReportTo ) const;

private:
	idStr				mDescription;
	idStr				mTranscribeText;
	idStr				mHMM;
	idDict				mLipSyncData;
};

ID_INLINE const char *rvDeclLipSync::GetLipSyncData( int langIdx ) const 
{ 
	if( common->LanguageHasVO( langIdx ) )
	{
		return( mLipSyncData.GetString( common->GetLanguage( langIdx ) ) ); 
	}

	return( mLipSyncData.GetString( "english" ) ); 
}

class rvDeclLipSyncEdit
{
public:
	virtual ~rvDeclLipSyncEdit() { }
	virtual void			SetLipSyncDescription( rvDeclLipSync *edit, const char *desc ) = 0;
	virtual void			SetLipSyncTranscribeText( rvDeclLipSync *edit, const char *text ) = 0;
	virtual void			SetLipSyncData( rvDeclLipSync *edit, const char *lsd, const char *lang ) = 0;
};

extern rvDeclLipSyncEdit	*declLipSyncEdit;

#endif // __DECLLIPSYNC_H__
