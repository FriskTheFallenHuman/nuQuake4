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
// Icon.h
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef	__ICON_H__
#define	__ICON_H__

class rvIcon {
public:
	rvIcon();
	~rvIcon();
	void		UpdateIcon( const idVec3 &origin, const idMat3 &axis );
	qhandle_t	CreateIcon( const char *mtr, int suppressViewID = 0 );
	void		FreeIcon( void );
	qhandle_t	GetHandle( void ) const;

	int			GetHeight( void ) const;
	int			GetWidth( void ) const;
private:
	void	Draw( jointHandle_t joint );
	void	Draw( const idVec3 &origin );

	renderEntity_t		renderEnt;
	qhandle_t			iconHandle;
};

ID_INLINE qhandle_t rvIcon::GetHandle( void ) const {
	return iconHandle;
}

#endif	/* !_ICON_H_ */

