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

#ifndef __DECLTABLE_H__
#define __DECLTABLE_H__

/*
===============================================================================

	tables are used to map a floating point input value to a floating point
	output value, with optional wrap / clamp and interpolation

===============================================================================
*/

// RAVEN BEGIN
// jsinger: allow support for serialization/deserialization of binary decls
#ifdef RV_BINARYDECLS
class idDeclTable : public idDecl, public Serializable<'DTAB'> {
public:
// jsinger: allow exporting of this decl type in a preparsed form
	virtual void			Write( SerialOutputStream &stream) const;
	virtual void			AddReferences() const;
							idDeclTable( SerialInputStream &stream);
#else
class idDeclTable : public idDecl {
#endif
public:
							idDeclTable();
	virtual size_t			Size( void ) const;
	virtual const char *	DefaultDefinition( void ) const;
	virtual bool			Parse( const char *text, const int textLength, bool noCaching );
	virtual void			FreeData( void );

// RAVEN BEGIN
// jscott: for BSE
			float			GetMaxValue( void ) const { return( maxValue ); }
			float			GetMinValue( void ) const { return( minValue ); }
// bdube: made virtual so it can be accessed in game
	virtual float			TableLookup( float index ) const;
// jscott: to prevent a recursive crash
	virtual	bool			RebuildTextSource( void ) { return( false ); }
// scork: for detailed error-reporting
	virtual	bool			Validate( const char *psText, int iTextLength, idStr &strReportTo ) const;
// RAVEN END

private:
	bool					clamp;
	bool					snap;
// RAVEN BEGIN
// jscott: for BSE
	float					minValue;
	float					maxValue;
// RAVEN END
	idList<float>			values;
};

#endif /* !__DECLTABLE_H__ */
