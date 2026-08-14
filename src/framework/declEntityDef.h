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

// Copyright (C) 2004 Id Software, Inc.
//

#ifndef __DECLENTITYDEF_H__
#define __DECLENTITYDEF_H__

/*
===============================================================================

	idDeclEntityDef

===============================================================================
*/

// RAVEN BEGIN
// jsinger: added to support serialization/deserialization of binary decls
#ifdef RV_BINARYDECLS
class idDeclEntityDef : public idDecl, public Serializable<'DED '> {
public:
	virtual void			AddReferences() const;
	virtual void			Write(SerialOutputStream &stream) const;
							idDeclEntityDef(SerialInputStream &stream);
#else
class idDeclEntityDef : public idDecl {
#endif
// RAVEN END
public:
							idDeclEntityDef();
	idDict					dict;

	virtual size_t			Size( void ) const;
	virtual const char *	DefaultDefinition() const;
	virtual bool			Parse( const char *text, const int textLength, bool noCaching );
	virtual void			FreeData( void );
	virtual void			Print( void );

// RAVEN BEGIN
// jscott: to prevent a recursive crash
	virtual	bool			RebuildTextSource( void ) { return( false ); }
// scork: for detailed error-reporting
	virtual bool			Validate( const char *psText, int iTextLength, idStr &strReportTo ) const;
// RAVEN END

};

#endif /* !__DECLENTITYDEF_H__ */
