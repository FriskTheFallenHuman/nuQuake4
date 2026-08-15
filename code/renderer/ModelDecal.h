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

#ifndef __MODELDECAL_H__
#define __MODELDECAL_H__

/*
===============================================================================

	Decals are lightweight primitives for bullet / blood marks.
	Decals with common materials will be merged together, but additional
	decals will be allocated as needed. The material should not be
	one that receives lighting, because no interactions are generated
	for these lightweight surfaces.

	FIXME:	Decals on models in portalled off areas do not get freed
			until the area becomes visible again.

===============================================================================
*/

const int NUM_DECAL_BOUNDING_PLANES = 6;

typedef struct decalProjectionInfo_s {
	idVec3						projectionOrigin;
	idBounds					projectionBounds;
	idPlane						boundingPlanes[6];
	idPlane						fadePlanes[2];
	idPlane						textureAxis[2];
	const idMaterial *			material;
	bool						parallel;
	float						fadeDepth;
	int							startTime;
	float						maxAngle;
	bool						force;
} decalProjectionInfo_t;


class idRenderModelDecal {
friend class rvPrimBatch;
public:
								idRenderModelDecal( void ) {
									memset( &tri, 0, sizeof( tri ) );
									tri.verts = verts;
									tri.indexes = indexes;
									material = NULL;
									nextDecal = NULL;
								}
								~idRenderModelDecal( void ) {}

	static idRenderModelDecal *	Alloc( void );
	static void					Free( idRenderModelDecal *decal );

								// Creates decal projection info.
	static bool					CreateProjectionInfo( decalProjectionInfo_t &info, const idFixedWinding &winding, const idVec3 &projectionOrigin, const bool parallel, const float fadeDepth, const idMaterial *material, const int startTime );

								// Transform the projection info from global space to local.
	static void					GlobalProjectionInfoToLocal( decalProjectionInfo_t &localInfo, const decalProjectionInfo_t &info, const idVec3 &origin, const idMat3 &axis );

								// Creates a deal on the given model.
	void						CreateDecal( const idRenderModel *model, const decalProjectionInfo_t &localInfo );

								// Remove decals that are completely faded away.
	static idRenderModelDecal *	RemoveFadedDecals( idRenderModelDecal *decals, int time );

								// Updates the vertex colors, removing any faded indexes,
								// then copy the verts to temporary vertex cache and adds a drawSurf.
	void						AddDecalDrawSurf( struct viewEntity_s *space );

								// Returns the next decal in the chain.
	idRenderModelDecal *		Next( void ) const { return nextDecal; }

	void						ReadFromDemoFile( class idDemoFile *f ) { (void)f; }
	void						WriteToDemoFile( class idDemoFile *f ) const { (void)f; }

private:
	static const int			MAX_DECAL_VERTS = 40;
	static const int			MAX_DECAL_INDEXES = 60;
	static int					allocatedDecalCount;

	const idMaterial *			material;
	srfTriangles_t				tri;
	idDrawVert					verts[MAX_DECAL_VERTS];
	float						vertDepthFade[MAX_DECAL_VERTS];
	glIndex_t					indexes[MAX_DECAL_INDEXES];
	float						indexStartTime[MAX_DECAL_INDEXES];
	float						vertLifeSpan[MAX_DECAL_VERTS];
	idRenderModelDecal *		nextDecal;

								// Adds the winding triangles to the appropriate decal in the
								// chain, creating a new one if necessary.
	void						AddWinding( const idWinding &w, const idMaterial *decalMaterial, const idPlane fadePlanes[2], float fadeDepth, int startTime );

								// Adds depth faded triangles for the winding to the appropriate
								// decal in the chain, creating a new one if necessary.
								// The part of the winding at the front side of both fade planes is not faded.
								// The parts at the back sides of the fade planes are faded with the given depth.
	void						AddDepthFadedWinding( const idWinding &w, const idMaterial *decalMaterial, const idPlane fadePlanes[2], float fadeDepth, int startTime );
};

#endif /* !__MODELDECAL_H__ */
