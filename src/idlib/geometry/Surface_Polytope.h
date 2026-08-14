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

#ifndef __SURFACE_POLYTOPE_H__
#define __SURFACE_POLYTOPE_H__

/*
===============================================================================

	Polytope surface.

	NOTE: vertexes are not duplicated for texture coordinates.

===============================================================================
*/

class idSurface_Polytope : public idSurface {
public:
						idSurface_Polytope( void );

	void				FromPlanes( const idPlane *planes, const int numPlanes );

	void				SetupTetrahedron( const idBounds &bounds );
	void				SetupHexahedron( const idBounds &bounds );
	void				SetupOctahedron( const idBounds &bounds );
	void				SetupDodecahedron( const idBounds &bounds );
	void				SetupIcosahedron( const idBounds &bounds );
	void				SetupCylinder( const idBounds &bounds, const int numSides );
	void				SetupCone( const idBounds &bounds, const int numSides );

	int					SplitPolytope( const idPlane &plane, const float epsilon, idSurface_Polytope **front, idSurface_Polytope **back ) const;

protected:

};

/*
====================
idSurface_Polytope::idSurface_Polytope
====================
*/
ID_INLINE idSurface_Polytope::idSurface_Polytope( void ) {
}

#endif /* !__SURFACE_POLYTOPE_H__ */
