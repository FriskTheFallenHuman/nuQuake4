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

#include "../idlib/precompiled.h"
#pragma hdrstop
#include "BSE.h"
#include "BSE_Particle.h"

/*
===============================================================================

	Quake 4 BSE spawn domains

	Compilation-unit boundary and signatures are taken from
	BSE_SpawnDomains.obj in quake4.pdb.  The domain equations follow the retail
	Hex-Rays control flow at RVAs 0x001B8C00 through 0x001BA45A.

===============================================================================
*/

TSpawnFunc rvParticleParms::spawnFunctions[SPF_COUNT] = {
	SpawnStub, SpawnNone1, SpawnNone2, SpawnNone3,
	SpawnStub, SpawnOne1, SpawnOne2, SpawnOne3,
	SpawnStub, SpawnPoint1, SpawnPoint2, SpawnPoint3,
	SpawnStub, SpawnLinear1, SpawnLinear2, SpawnLinear3,
	SpawnStub, SpawnBox1, SpawnBox2, SpawnBox3,
	SpawnStub, SpawnSurfaceBox1, SpawnSurfaceBox2, SpawnSurfaceBox3,
	SpawnStub, SpawnSphere1, SpawnSphere2, SpawnSphere3,
	SpawnStub, SpawnSurfaceSphere1, SpawnSurfaceSphere2, SpawnSurfaceSphere3,
	SpawnStub, SpawnStub, SpawnStub, SpawnCylinder3,
	SpawnStub, SpawnStub, SpawnStub, SpawnSurfaceCylinder3,
	SpawnStub, SpawnStub, SpawnSpiral2, SpawnSpiral3,
	SpawnStub, SpawnStub, SpawnStub, SpawnModel3
};

bool rvParticleParms::Compare( const rvParticleParms &comp ) const {
	return mSpawnType == comp.mSpawnType && mFlags == comp.mFlags &&
		mMins.Compare( comp.mMins, 0.001f ) && mMaxs.Compare( comp.mMaxs, 0.001f );
}

void SpawnGetNormal( idVec3 *normal, idVec3 &result, const idVec3 *centre ) {
	if ( normal == NULL ) {
		return;
	}
	*normal = centre != NULL ? result - *centre : result;
	normal->Normalize();
}

void SpawnStub( float *, const rvParticleParms &, idVec3 *, const idVec3 * ) {
}

void SpawnNone1( float *result, const rvParticleParms &, idVec3 *, const idVec3 * ) {
	result[0] = 0.0f;
}

void SpawnNone2( float *result, const rvParticleParms &, idVec3 *, const idVec3 * ) {
	result[0] = result[1] = 0.0f;
}

void SpawnNone3( float *result, const rvParticleParms &, idVec3 *normal, const idVec3 *centre ) {
	result[0] = result[1] = result[2] = 0.0f;
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnOne1( float *result, const rvParticleParms &, idVec3 *, const idVec3 * ) {
	result[0] = 1.0f;
}

void SpawnOne2( float *result, const rvParticleParms &, idVec3 *, const idVec3 * ) {
	result[0] = result[1] = 1.0f;
}

void SpawnOne3( float *result, const rvParticleParms &, idVec3 *normal, const idVec3 *centre ) {
	result[0] = result[1] = result[2] = 1.0f;
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnPoint1( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = parms.mMins[0];
}

void SpawnPoint2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = parms.mMins[0];
	result[1] = parms.mMins[1];
}

void SpawnPoint3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	*reinterpret_cast<idVec3 *>( result ) = parms.mMins;
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnLinear1( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] );
}

void SpawnLinear2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	const float fraction = ( parms.mFlags & PPFLAG_LINEARSPACING ) ? result[0] : rvRandom::flrand( 0.0f, 1.0f );
	result[0] = parms.mMins[0] + ( parms.mMaxs[0] - parms.mMins[0] ) * fraction;
	result[1] = parms.mMins[1] + ( parms.mMaxs[1] - parms.mMins[1] ) * fraction;
}

void SpawnLinear3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const float fraction = ( parms.mFlags & PPFLAG_LINEARSPACING ) ? result[0] : rvRandom::flrand( 0.0f, 1.0f );
	for ( int i = 0; i < 3; ++i ) {
		result[i] = parms.mMins[i] + ( parms.mMaxs[i] - parms.mMins[i] ) * fraction;
	}
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnBox1( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] );
}

void SpawnBox2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] );
	result[1] = rvRandom::flrand( parms.mMins[1], parms.mMaxs[1] );
}

void SpawnBox3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	for ( int i = 0; i < 3; ++i ) {
		result[i] = rvRandom::flrand( parms.mMins[i], parms.mMaxs[i] );
	}
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnSurfaceBox1( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = rvRandom::irand( 0, 1 ) == 0 ? parms.mMins[0] : parms.mMaxs[0];
}

void SpawnSurfaceBox2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	const int side = rvRandom::irand( 0, 3 );
	result[0] = ( side & 1 ) ? rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] ) : ( side == 0 ? parms.mMins[0] : parms.mMaxs[0] );
	result[1] = ( side & 1 ) ? ( side == 1 ? parms.mMins[1] : parms.mMaxs[1] ) : rvRandom::flrand( parms.mMins[1], parms.mMaxs[1] );
}

void SpawnSurfaceBox3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const int side = rvRandom::irand( 0, 5 );
	for ( int i = 0; i < 3; ++i ) {
		result[i] = rvRandom::flrand( parms.mMins[i], parms.mMaxs[i] );
	}
	const int axis = side % 3;
	result[axis] = side < 3 ? parms.mMins[axis] : parms.mMaxs[axis];
	if ( normal != NULL ) {
		if ( centre != NULL ) {
			*normal = rvBSEManagerLocal::mCubeNormals[side];
		} else {
			*normal = *reinterpret_cast<idVec3 *>( result );
			normal->Normalize();
		}
	}
}

void SpawnSphere1( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	SpawnBox1( result, parms, normal, centre );
}

static idVec3 RandomDirection( int dimensions ) {
	idVec3 direction( rvRandom::flrand( -1.0f, 1.0f ), rvRandom::flrand( -1.0f, 1.0f ),
		dimensions == 3 ? rvRandom::flrand( -1.0f, 1.0f ) : 0.0f );
	direction.Normalize();
	return direction;
}

void SpawnSphere2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	const idVec3 direction = RandomDirection( 2 );
	for ( int i = 0; i < 2; ++i ) {
		const float origin = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f;
		const float radius = ( parms.mMaxs[i] - parms.mMins[i] ) * 0.5f;
		result[i] = origin + direction[i] * rvRandom::flrand( 0.0f, radius );
	}
}

void SpawnSphere3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const idVec3 direction = RandomDirection( 3 );
	for ( int i = 0; i < 3; ++i ) {
		const float origin = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f;
		const float radius = ( parms.mMaxs[i] - parms.mMins[i] ) * 0.5f;
		result[i] = origin + direction[i] * rvRandom::flrand( 0.0f, radius );
	}
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnSurfaceSphere1( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	SpawnSurfaceBox1( result, parms, normal, centre );
}

void SpawnSurfaceSphere2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	const idVec3 direction = RandomDirection( 2 );
	for ( int i = 0; i < 2; ++i ) {
		result[i] = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f +
			direction[i] * ( parms.mMaxs[i] - parms.mMins[i] ) * 0.5f;
	}
}

void SpawnSurfaceSphere3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const idVec3 direction = RandomDirection( 3 );
	for ( int i = 0; i < 3; ++i ) {
		result[i] = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f +
			direction[i] * ( parms.mMaxs[i] - parms.mMins[i] ) * 0.5f;
	}
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnCylinder3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const idVec3 direction = RandomDirection( 2 );
	const float length = parms.mMaxs[0] - parms.mMins[0];
	const float along = rvRandom::flrand( 0.0f, length );
	const float taper = length != 0.0f && ( parms.mFlags & PPFLAG_CONE ) ? along / length : 1.0f;
	result[0] = parms.mMins[0] + along;
	for ( int i = 1; i < 3; ++i ) {
		const float origin = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f;
		const float radius = ( parms.mMaxs[i] - parms.mMins[i] ) * 0.5f * taper;
		result[i] = origin + direction[i - 1] * rvRandom::flrand( 0.0f, radius );
	}
	SpawnGetNormal( normal, *reinterpret_cast<idVec3 *>( result ), centre );
}

void SpawnSurfaceCylinder3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	const idVec3 direction = RandomDirection( 2 );
	const float length = parms.mMaxs[0] - parms.mMins[0];
	const float along = rvRandom::flrand( 0.0f, length );
	const float taper = length != 0.0f && ( parms.mFlags & PPFLAG_CONE ) ? along / length : 1.0f;
	result[0] = parms.mMins[0] + along;
	result[1] = ( parms.mMins[1] + parms.mMaxs[1] ) * 0.5f + direction[0] * ( parms.mMaxs[1] - parms.mMins[1] ) * 0.5f * taper;
	result[2] = ( parms.mMins[2] + parms.mMaxs[2] ) * 0.5f + direction[1] * ( parms.mMaxs[2] - parms.mMins[2] ) * 0.5f * taper;
	if ( normal != NULL ) {
		if ( centre == NULL ) {
			*normal = *reinterpret_cast<idVec3 *>( result );
		} else if ( taper == 1.0f ) {
			normal->Set( 0.0f, direction[0], direction[1] );
		} else if ( length == 0.0f ) {
			normal->Set( 1.0f, 0.0f, 0.0f );
		} else {
			normal->Set( -1.0f / length, direction[0], direction[1] );
		}
		normal->Normalize();
	}
}

void SpawnSpiral2( float *result, const rvParticleParms &parms, idVec3 *, const idVec3 * ) {
	result[0] = ( parms.mFlags & PPFLAG_LINEARSPACING )
		? parms.mMins[0] + ( parms.mMaxs[0] - parms.mMins[0] ) * result[0]
		: rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] );
	result[1] = cosf( idMath::TWO_PI * result[0] / parms.mRange ) * rvRandom::flrand( parms.mMins[1], parms.mMaxs[1] );
}

void SpawnSpiral3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	result[0] = ( parms.mFlags & PPFLAG_LINEARSPACING )
		? parms.mMins[0] + ( parms.mMaxs[0] - parms.mMins[0] ) * result[0]
		: rvRandom::flrand( parms.mMins[0], parms.mMaxs[0] );
	const float y = rvRandom::flrand( parms.mMins[1], parms.mMaxs[1] );
	const float z = rvRandom::flrand( parms.mMins[2], parms.mMaxs[2] );
	const float angle = idMath::TWO_PI * result[0] / parms.mRange;
	const float c = cosf( angle );
	const float s = sinf( angle );
	result[1] = c * y - s * z;
	result[2] = c * z + s * y;
	if ( normal != NULL ) {
		normal->Set( centre == NULL ? result[0] : 0.0f, result[1], result[2] );
		normal->Normalize();
	}
}

void rvParticleParms::HandleRelativeParms( float *death, float *init, int count ) {
	if ( mFlags & PPFLAG_RELATIVE ) {
		for ( int i = 0; i < count; ++i ) {
			death[i] += init[i];
		}
	}
}

void rvParticleParms::GetMinsMaxs( idVec3 &mins, idVec3 &maxs ) {
	mins.Zero();
	maxs.Zero();
	const int dimensions = mSpawnType & 3;
	if ( mSpawnType >= SPF_ONE_0 && mSpawnType <= SPF_ONE_3 ) {
		for ( int i = 0; i < dimensions; ++i ) {
			mins[i] = maxs[i] = 1.0f;
		}
	} else if ( mSpawnType >= SPF_POINT_0 && mSpawnType <= SPF_POINT_3 ) {
		for ( int i = 0; i < dimensions; ++i ) {
			mins[i] = maxs[i] = mMins[i];
		}
	} else if ( mSpawnType >= SPF_LINEAR_0 ) {
		for ( int i = 0; i < dimensions; ++i ) {
			mins[i] = mMins[i];
			maxs[i] = mMaxs[i];
		}
	}
}

void SpawnModel3( float *result, const rvParticleParms &parms, idVec3 *normal, const idVec3 *centre ) {
	idRenderModel *model = static_cast<idRenderModel *>( parms.mMisc );
	if ( model == NULL || model->NumSurfaces() == 0 ) {
		result[0] = result[1] = result[2] = 0.0f;
		if ( normal != NULL ) {
			normal->Zero();
		}
		return;
	}
	const modelSurface_t *surface = model->Surface( rvRandom::irand( 0, model->NumSurfaces() - 1 ) );
	const srfTriangles_t *geometry = surface != NULL ? surface->geometry : NULL;
	if ( geometry == NULL || geometry->numIndexes < 3 ) {
		result[0] = result[1] = result[2] = 0.0f;
		return;
	}
	const int triangle = rvRandom::irand( 0, geometry->numIndexes / 3 - 1 );
	idVec3 weights( rvRandom::flrand( 0.0f, 1.0f ), rvRandom::flrand( 0.0f, 1.0f ), rvRandom::flrand( 0.0f, 1.0f ) );
	weights.Normalize();
	const idDrawVert &a = geometry->verts[geometry->indexes[triangle * 3 + 0]];
	const idDrawVert &b = geometry->verts[geometry->indexes[triangle * 3 + 1]];
	const idDrawVert &c = geometry->verts[geometry->indexes[triangle * 3 + 2]];
	idVec3 point = ( a.xyz * weights[0] + b.xyz * weights[1] + c.xyz * weights[2] ) * rvBSEManagerLocal::mModelToBSE;
	if ( normal != NULL ) {
		if ( centre != NULL ) {
			*normal = ( b.xyz - a.xyz ).Cross( c.xyz - a.xyz );
		} else {
			*normal = point;
		}
		*normal *= rvBSEManagerLocal::mModelToBSE;
		normal->Normalize();
	}
	const idBounds &bounds = geometry->bounds;
	for ( int i = 0; i < 3; ++i ) {
		const float sourceSize = bounds[1][i] - bounds[0][i];
		const float scale = sourceSize != 0.0f ? ( parms.mMaxs[i] - parms.mMins[i] ) / sourceSize : 0.0f;
		const float sourceCenter = ( bounds[0][i] + bounds[1][i] ) * 0.5f;
		const float targetCenter = ( parms.mMins[i] + parms.mMaxs[i] ) * 0.5f;
		result[i] = ( point[i] - sourceCenter ) * scale + targetCenter;
	}
}
