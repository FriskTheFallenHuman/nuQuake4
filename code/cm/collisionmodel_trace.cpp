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

#if defined( Q4_CM_LEGACY_SEED )
#include "collisionmodel_trace_legacy.inc"
#else

/*
===========================================================================

Quake 4 source reconstruction

Retail object-based collision trace traversal recovered from the matching
PDB and address-matched Hex-Rays body.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

void idCollisionModelManagerLocal::TraceTrmThroughNode( cm_traceWork_t *traceWork, cm_node_t *node ) {
	if ( traceWork->positionTest ) {
		if ( traceWork->trace.fraction == 0.0f ) {
			return;
		}
		for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
			if ( TestTrmVertsInBrush( traceWork, ref->b ) ) {
				return;
			}
		}
		if ( traceWork->pointTrace ) {
			return;
		}
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			if ( TestTrmInPolygon( traceWork, ref->p ) ) {
				return;
			}
		}
	} else if ( traceWork->rotation ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			if ( RotateTrmThroughPolygon( traceWork, ref->p ) ) {
				return;
			}
		}
	} else {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			if ( TranslateTrmThroughPolygon( traceWork, ref->p ) ) {
				return;
			}
		}
	}
}

void idCollisionModelManagerLocal::TraceThroughAxialBSPTree_r( cm_traceWork_t *traceWork,
		cm_node_t *node, float p1f, float p2f, idVec3 &p1, idVec3 &p2 ) {
	if ( node == NULL || traceWork->quickExit || traceWork->trace.fraction <= p1f ) {
		return;
	}

	if ( node->polygons != NULL || ( traceWork->positionTest && node->brushes != NULL ) ) {
		TraceTrmThroughNode( traceWork, node );
	}
	if ( traceWork->positionTest && traceWork->trace.fraction == 0.0f ) {
		return;
	}
	if ( node->planeType == -1 ) {
		return;
	}

	const float t1 = p1[node->planeType] - node->planeDist;
	const float t2 = p2[node->planeType] - node->planeDist;
	const float offset = traceWork->trmExtents[node->planeType];
	if ( t1 >= offset && t2 >= offset ) {
		TraceThroughAxialBSPTree_r( traceWork, node->children[0], p1f, p2f, p1, p2 );
		return;
	}
	if ( t1 < -offset && t2 < -offset ) {
		TraceThroughAxialBSPTree_r( traceWork, node->children[1], p1f, p2f, p1, p2 );
		return;
	}

	int side;
	float fraction;
	float fraction2;
	if ( t1 < t2 ) {
		const float inverseDistance = 1.0f / ( t1 - t2 );
		side = 1;
		fraction2 = ( t1 + offset ) * inverseDistance;
		fraction = ( t1 - offset ) * inverseDistance;
	} else if ( t1 > t2 ) {
		const float inverseDistance = 1.0f / ( t1 - t2 );
		side = 0;
		fraction2 = ( t1 - offset ) * inverseDistance;
		fraction = ( t1 + offset ) * inverseDistance;
	} else {
		side = 0;
		fraction = 1.0f;
		fraction2 = 0.0f;
	}

	fraction = Max( 0.0f, Min( 1.0f, fraction ) );
	idVec3 mid = p1 + fraction * ( p2 - p1 );
	float midFraction = p1f + ( p2f - p1f ) * fraction;
	TraceThroughAxialBSPTree_r( traceWork, node->children[side], p1f, midFraction, p1, mid );

	fraction2 = Max( 0.0f, Min( 1.0f, fraction2 ) );
	mid = p1 + fraction2 * ( p2 - p1 );
	midFraction = p1f + ( p2f - p1f ) * fraction2;
	TraceThroughAxialBSPTree_r( traceWork, node->children[side ^ 1], midFraction, p2f, mid, p2 );
}

void idCollisionModelManagerLocal::TraceThroughModel( cm_traceWork_t *traceWork ) {
	if ( !traceWork->rotation ) {
		TraceThroughAxialBSPTree_r( traceWork, traceWork->model->node,
			0.0f, 1.0f, traceWork->start, traceWork->end );
		return;
	}

	const float distance = traceWork->radius * DEG2RAD( traceWork->angle );
	idVec3 start = traceWork->start;
	if ( distance > CIRCLE_APPROXIMATION_LENGTH ) {
		const int numSteps = static_cast<int>( distance / CIRCLE_APPROXIMATION_LENGTH );
		for ( int i = 0; i < numSteps; i++ ) {
			idRotation rotation( traceWork->origin, traceWork->axis,
				traceWork->angle * static_cast<float>( i + 1 ) / numSteps );
			idVec3 end = start * rotation;
			TraceThroughAxialBSPTree_r( traceWork, traceWork->model->node, 0.0f, 1.0f, start, end );
			if ( traceWork->trace.fraction < 1.0f ) {
				return;
			}
			start = end;
		}
	}
	TraceThroughAxialBSPTree_r( traceWork, traceWork->model->node,
		0.0f, 1.0f, start, traceWork->end );
}

#endif
