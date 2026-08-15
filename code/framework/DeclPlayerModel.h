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

//----------------------------------------------------------------
// DeclPlayerModel.h
//
// Copyright 2002-2006 Raven Software
//----------------------------------------------------------------

#ifndef __DECLPLAYERMODEL_H__
#define __DECLPLAYERMODEL_H__

/*
===============================================================================

rvDeclPlayerModel

===============================================================================
*/

class rvDeclPlayerModel : public idDecl {
public:
	rvDeclPlayerModel();

	idStr					model;
	idStr					head;
	idVec3					headOffset;
	idStr					uiHead;
	idStr					team;
	idStr					skin;
	idStr					description;
	idDict					sounds;

	virtual size_t			Size( void ) const;
	virtual const char *	DefaultDefinition() const;
	virtual bool			Parse( const char *text, const int textLength, bool noCaching );
	virtual void			FreeData( void );
	virtual void			Print( void );

	virtual	bool			RebuildTextSource( void ) { return( false ); }
	virtual bool			Validate( const char *psText, int iTextLength, idStr &strReportTo ) const;
};

#endif 
