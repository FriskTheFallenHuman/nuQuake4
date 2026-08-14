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

#ifndef __DECLMATTYPE_H__
#define __DECLMATTYPE_H__

// Defines a material type - such as concrete, metal, glass etc
#ifdef RV_BINARYDECLS
class rvDeclMatType : public idDecl, public Serializable<'RDMT'>
{
public:
// jsinger: allow exporting of this decl type in a preparsed form
	virtual void		Write( SerialOutputStream &stream ) const;
	virtual void		AddReferences() const;
						rvDeclMatType( SerialInputStream &stream );
#else
class rvDeclMatType : public idDecl
{
public:
#endif
						rvDeclMatType( void ) { *( ulong *)mTint = 0; }
						~rvDeclMatType( void ) {}

	void				SetDescription( idStr &desc ) { mDescription = desc; }
	const idStr			&GetDescription( void ) const { return( mDescription ); }

	void				SetTint( byte tint[4] ) { *( ulong *)mTint = *( ulong *)tint; }
	int					GetTint( void ) const { return( *( int *)mTint ); }

	float				GetRed( void ) const { return( mTint[0] / 255.0f ); }
	float				GetGreen( void ) const { return( mTint[1] / 255.0f ); }
	float				GetBlue( void ) const { return( mTint[2] / 255.0f ); }

	virtual const char	*DefaultDefinition( void ) const;
	virtual bool		Parse( const char *text, const int textLength, bool noCaching );
	virtual void		FreeData( void );
	virtual size_t		Size( void ) const;

// RAVEN BEGIN
// jscott: to prevent a recursive crash
	virtual	bool		RebuildTextSource( void ) { return( false ); }
// scork: for detailed error-reporting
	virtual bool		Validate( const char *psText, int iTextLength, idStr &strReportTo ) const;
// RAVEN END


private:

	idStr				mDescription;
	byte				mTint[4];
};

byte *MT_GetMaterialTypeArray( idStr image, int &width, int &height );

#endif // __DECLMATTYPE_H__
