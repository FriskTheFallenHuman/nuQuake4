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
#include "collisionmodel_contents_legacy.inc"
#else

/*
===========================================================================

Quake 4 source reconstruction

Compact collision-contents entry points recovered from the matching retail
PDB and address-matched Hex-Rays bodies.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

cm_node_t *idCollisionModelManagerLocal::PointNode( const idVec3 &point, idCollisionModelLocal *model ) {
	cm_node_t *node = model->node;
	while ( node->planeType != -1 ) {
		node = point[node->planeType] > node->planeDist ? node->children[0] : node->children[1];
	}
	return node;
}

int idCollisionModelManagerLocal::PointContents( const idVec3 point, idCollisionModelLocal *model ) {
	cm_node_t *node = PointNode( point, model );
	for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
		cm_brush_t *brush = ref->b;
		int i;
		for ( i = 0; i < 3; i++ ) {
			if ( point[i] < brush->bounds[0][i] || point[i] > brush->bounds[1][i] ) {
				break;
			}
		}
		if ( i < 3 ) {
			continue;
		}

		for ( i = 0; i < brush->numPlanes; i++ ) {
			if ( brush->planes[i].Distance( point ) >= 0.0f ) {
				break;
			}
		}
		if ( i >= brush->numPlanes ) {
			return brush->contents;
		}
	}
	return 0;
}

int idCollisionModelManagerLocal::TransformedPointContents( const idVec3 &point, idCollisionModelLocal *model,
		const idVec3 &origin, const idMat3 &modelAxis ) {
	idVec3 localPoint = point - origin;
	if ( modelAxis.IsRotated() ) {
		localPoint *= modelAxis;
	}
	return PointContents( localPoint, model );
}

bool idCollisionModelManagerLocal::TestTrmVertsInBrush( cm_traceWork_t *traceWork, cm_brush_t *brush ) {
	if ( brush->checkcount == checkCount ) {
		return false;
	}
	brush->checkcount = checkCount;
	if ( !( brush->contents & traceWork->contents )
			|| !brush->bounds.IntersectsBounds( traceWork->traceBounds ) ) {
		return false;
	}

	const int numVertices = traceWork->pointTrace ? 1 : traceWork->numVerts;
	for ( int vertex = 0; vertex < numVertices; vertex++ ) {
		const idVec3 &point = traceWork->vertices[vertex].p;
		int bestPlane = 0;
		float bestDistance = -idMath::INFINITY;
		int plane;
		for ( plane = 0; plane < brush->numPlanes; plane++ ) {
			const float distance = brush->planes[plane].Distance( point );
			if ( distance >= 0.0f ) {
				break;
			}
			if ( distance > bestDistance ) {
				bestDistance = distance;
				bestPlane = plane;
			}
		}
		if ( plane >= brush->numPlanes ) {
			traceWork->trace.fraction = 0.0f;
			traceWork->trace.c.type = CONTACT_TRMVERTEX;
			traceWork->trace.c.normal = brush->planes[bestPlane].Normal();
			traceWork->trace.c.dist = brush->planes[bestPlane].Dist();
			traceWork->trace.c.contents = brush->contents;
			traceWork->trace.c.material = brush->material;
			traceWork->trace.c.point = point;
			traceWork->trace.c.modelFeature = 0;
			traceWork->trace.c.trmFeature = vertex;
			CM_GetMaterialType( traceWork, NULL );
			return true;
		}
	}
	return false;
}

bool idCollisionModelManagerLocal::TestTrmInPolygon( cm_traceWork_t *traceWork, cm_polygon_t *polygon ) {
	if ( polygon->checkcount == checkCount ) {
		return false;
	}
	polygon->checkcount = checkCount;
	if ( !( polygon->contents & traceWork->contents )
			|| !polygon->bounds.IntersectsBounds( traceWork->traceBounds ) ) {
		return false;
	}

	switch ( traceWork->traceBounds.PlaneSide( polygon->plane ) ) {
		case PLANESIDE_CROSS:
			break;
		case PLANESIDE_FRONT:
			if ( traceWork->model->isConvex ) {
				traceWork->quickExit = true;
				return true;
			}
		default:
			return false;
	}

	if ( traceWork->isConvex ) {
		for ( int i = 0; i < polygon->numEdges; i++ ) {
			const int edgeNum = polygon->edges[i];
			cm_edge_t *edge = &traceWork->model->edges[abs( edgeNum )];
			if ( edge->checkcount == checkCount ) {
				continue;
			}
			for ( int j = 0; j < 2; j++ ) {
				cm_vertex_t *vertex = &traceWork->model->vertices[edge->vertexNum[j]];
				if ( vertex->checkcount == checkCount ) {
					continue;
				}
				int bestPlane = 0;
				float bestDistance = -idMath::INFINITY;
				int plane;
				for ( plane = 0; plane < traceWork->numPolys; plane++ ) {
					const float distance = traceWork->polys[plane].plane.Distance( vertex->p );
					if ( distance >= 0.0f ) {
						break;
					}
					if ( distance > bestDistance ) {
						bestDistance = distance;
						bestPlane = plane;
					}
				}
				if ( plane >= traceWork->numPolys ) {
					traceWork->trace.fraction = 0.0f;
					traceWork->trace.c.type = CONTACT_MODELVERTEX;
					traceWork->trace.c.normal = -traceWork->polys[bestPlane].plane.Normal();
					traceWork->trace.c.dist = -traceWork->polys[bestPlane].plane.Dist();
					traceWork->trace.c.contents = polygon->contents;
					traceWork->trace.c.material = polygon->material;
					traceWork->trace.c.point = vertex->p;
					traceWork->trace.c.modelFeature = edge->vertexNum[j];
					traceWork->trace.c.trmFeature = 0;
					CM_GetMaterialType( traceWork, polygon );
					return true;
				}
			}
		}
	}

	for ( int i = 0; i < polygon->numEdges; i++ ) {
		const int edgeNum = polygon->edges[i];
		cm_edge_t *edge = &traceWork->model->edges[abs( edgeNum )];
		if ( edge->checkcount != checkCount ) {
			edge->sideSet = 0;
		}
		traceWork->polygonEdgePlueckerCache[i].FromLine(
			traceWork->model->vertices[edge->vertexNum[0]].p,
			traceWork->model->vertices[edge->vertexNum[1]].p );
		cm_vertex_t *vertex = &traceWork->model->vertices[edge->vertexNum[INTSIGNBITSET( edgeNum )]];
		if ( vertex->checkcount != checkCount ) {
			vertex->sideSet = 0;
		}
		vertex->checkcount = checkCount;
	}

	int sides[MAX_TRACEMODEL_VERTS];
	for ( int i = 0; i < traceWork->numVerts; i++ ) {
		sides[i] = polygon->plane.Distance( traceWork->vertices[i].p ) < 0.0f ? -1 : 1;
	}

	for ( int i = 1; i <= traceWork->numEdges; i++ ) {
		cm_trmEdge_t *trmEdge = &traceWork->edges[i];
		if ( sides[trmEdge->vertexNum[0]] == sides[trmEdge->vertexNum[1]] ) {
			continue;
		}
		const int flip = INTSIGNBITSET( sides[trmEdge->vertexNum[0]] );
		int j;
		for ( j = 0; j < polygon->numEdges; j++ ) {
			const int edgeNum = polygon->edges[j];
			cm_edge_t *edge = &traceWork->model->edges[abs( edgeNum )];
			if ( !( edge->sideSet & ( 1u << i ) ) ) {
				const float side = trmEdge->pl.PermutedInnerProduct( traceWork->polygonEdgePlueckerCache[j] );
				edge->side = ( edge->side & ~( 1u << i ) ) | ( FLOATSIGNBITSET( side ) << i );
				edge->sideSet |= 1u << i;
			}
			if ( INTSIGNBITSET( edgeNum ) ^ ( ( edge->side >> i ) & 1 ) ^ flip ) {
				break;
			}
		}
		if ( j >= polygon->numEdges ) {
			traceWork->trace.fraction = 0.0f;
			traceWork->trace.c.type = CONTACT_EDGE;
			traceWork->trace.c.normal = polygon->plane.Normal();
			traceWork->trace.c.dist = polygon->plane.Dist();
			traceWork->trace.c.contents = polygon->contents;
			traceWork->trace.c.material = polygon->material;
			traceWork->trace.c.point = traceWork->vertices[trmEdge->vertexNum[!flip]].p;
			traceWork->trace.c.modelFeature = reinterpret_cast<int>( polygon );
			traceWork->trace.c.trmFeature = i;
			CM_GetMaterialType( traceWork, polygon );
			return true;
		}
	}

	for ( int i = 0; i < polygon->numEdges; i++ ) {
		const int edgeNum = polygon->edges[i];
		cm_edge_t *edge = &traceWork->model->edges[abs( edgeNum )];
		if ( edge->checkcount == checkCount ) {
			continue;
		}
		edge->checkcount = checkCount;
		for ( int j = 0; j < traceWork->numPolys; j++ ) {
			cm_vertex_t *v1 = &traceWork->model->vertices[edge->vertexNum[0]];
			if ( !( v1->sideSet & ( 1u << j ) ) ) {
				const float side = traceWork->polys[j].plane.Distance( v1->p );
				v1->side = side < 0.0f ? v1->side | ( 1u << j ) : v1->side & ~( 1u << j );
				v1->sideSet |= 1u << j;
			}
			cm_vertex_t *v2 = &traceWork->model->vertices[edge->vertexNum[1]];
			if ( !( v2->sideSet & ( 1u << j ) ) ) {
				const float side = traceWork->polys[j].plane.Distance( v2->p );
				v2->side = side < 0.0f ? v2->side | ( 1u << j ) : v2->side & ~( 1u << j );
				v2->sideSet |= 1u << j;
			}
			if ( !( ( ( v1->side ^ v2->side ) >> j ) & 1 ) ) {
				continue;
			}
			const int flip = ( v1->side >> j ) & 1;
			int k;
			for ( k = 0; k < traceWork->polys[j].numEdges; k++ ) {
				const int trmEdgeNum = traceWork->polys[j].edges[k];
				cm_trmEdge_t *trmEdge = &traceWork->edges[abs( trmEdgeNum )];
				const int bitNum = abs( trmEdgeNum );
				if ( !( edge->sideSet & ( 1u << bitNum ) ) ) {
					const float side = trmEdge->pl.PermutedInnerProduct( traceWork->polygonEdgePlueckerCache[i] );
					edge->side = ( edge->side & ~( 1u << bitNum ) ) | ( FLOATSIGNBITSET( side ) << bitNum );
					edge->sideSet |= 1u << bitNum;
				}
				if ( INTSIGNBITSET( trmEdgeNum ) ^ ( ( edge->side >> bitNum ) & 1 ) ^ flip ) {
					break;
				}
			}
			if ( k >= traceWork->polys[j].numEdges ) {
				traceWork->trace.fraction = 0.0f;
				traceWork->trace.c.type = CONTACT_EDGE;
				traceWork->trace.c.normal = -traceWork->polys[j].plane.Normal();
				traceWork->trace.c.dist = -traceWork->polys[j].plane.Dist();
				traceWork->trace.c.contents = polygon->contents;
				traceWork->trace.c.material = polygon->material;
				traceWork->trace.c.point = traceWork->model->vertices[edge->vertexNum[!flip]].p;
				traceWork->trace.c.modelFeature = edgeNum;
				traceWork->trace.c.trmFeature = j;
				CM_GetMaterialType( traceWork, polygon );
				return true;
			}
		}
	}
	return false;
}

int idCollisionModelManagerLocal::ContentsTrm( trace_t *results, const idVec3 &start,
		const idTraceModel *trm, const idMat3 &trmAxis, int contentMask,
		idCollisionModel *collisionModel, const idVec3 &modelOrigin, const idMat3 &modelAxis ) {
	idCollisionModelLocal *model = static_cast<idCollisionModelLocal *>( collisionModel );

	if ( trm == NULL || ( trm->bounds[1][0] - trm->bounds[0][0] <= 0.0f
			&& trm->bounds[1][1] - trm->bounds[0][1] <= 0.0f
			&& trm->bounds[1][2] - trm->bounds[0][2] <= 0.0f ) ) {
		results->c.contents = TransformedPointContents( start, model, modelOrigin, modelAxis );
		results->fraction = results->c.contents == 0;
		results->endpos = start;
		results->endAxis = trmAxis;
		return results->c.contents;
	}

	checkCount++;
	ALIGN16( cm_traceWork_t traceWork );
	traceWork.contents = contentMask;
	traceWork.trace.fraction = 1.0f;
	traceWork.trace.c.contents = 0;
	traceWork.trace.c.type = CONTACT_NONE;
	traceWork.trace.c.material = NULL;
	traceWork.trace.c.materialType = NULL;
	traceWork.isConvex = trm->isConvex;
	traceWork.model = model;
	traceWork.rotation = false;
	traceWork.positionTest = true;
	traceWork.pointTrace = false;
	traceWork.quickExit = false;
	traceWork.numContacts = 0;
	traceWork.start = start - modelOrigin;
	traceWork.end = traceWork.start;

	const bool modelRotated = modelAxis.IsRotated();
	idMat3 inverseModelAxis;
	if ( modelRotated ) {
		inverseModelAxis = modelAxis.Transpose();
	}

	SetupTrm( &traceWork, trm );
	const bool trmRotated = trmAxis.IsRotated();

	if ( trmRotated ) {
		for ( int i = 0; i < traceWork.numVerts; i++ ) {
			traceWork.vertices[i].p *= trmAxis;
		}
	}
	for ( int i = 0; i < traceWork.numVerts; i++ ) {
		traceWork.vertices[i].p += traceWork.start;
	}
	if ( modelRotated ) {
		for ( int i = 0; i < traceWork.numVerts; i++ ) {
			traceWork.vertices[i].p *= inverseModelAxis;
		}
	}

	if ( trmRotated ) {
		const idVec3 offset = trm->offset * trmAxis;
		traceWork.start += offset;
		traceWork.end += offset;
	} else {
		traceWork.start += trm->offset;
		traceWork.end += trm->offset;
	}
	if ( modelRotated ) {
		traceWork.start *= inverseModelAxis;
		traceWork.end *= inverseModelAxis;
	}

	traceWork.trmBounds.Clear();
	for ( int i = 0; i < traceWork.numVerts; i++ ) {
		traceWork.trmBounds.AddPoint( traceWork.vertices[i].p - traceWork.start );
	}

	for ( int i = 1; i <= traceWork.numEdges; i++ ) {
		traceWork.edges[i].pl.FromLine(
			traceWork.vertices[traceWork.edges[i].vertexNum[0]].p,
			traceWork.vertices[traceWork.edges[i].vertexNum[1]].p );
	}

	if ( trmRotated && modelRotated ) {
		const idMat3 axis = trmAxis * inverseModelAxis;
		for ( int i = 0; i < traceWork.numPolys; i++ ) {
			traceWork.polys[i].plane *= axis;
		}
	} else if ( trmRotated ) {
		for ( int i = 0; i < traceWork.numPolys; i++ ) {
			traceWork.polys[i].plane *= trmAxis;
		}
	} else if ( modelRotated ) {
		for ( int i = 0; i < traceWork.numPolys; i++ ) {
			traceWork.polys[i].plane *= inverseModelAxis;
		}
	}
	for ( int i = 0; i < traceWork.numPolys; i++ ) {
		const cm_trmEdge_t &edge = traceWork.edges[abs( traceWork.polys[i].edges[0] )];
		traceWork.polys[i].plane.FitThroughPoint( traceWork.vertices[edge.vertexNum[0]].p );
	}

	for ( int i = 0; i < 3; i++ ) {
		if ( traceWork.start[i] < traceWork.end[i] ) {
			traceWork.traceBounds[0][i] = traceWork.start[i] + traceWork.trmBounds[0][i] - CM_BOX_EPSILON;
			traceWork.traceBounds[1][i] = traceWork.end[i] + traceWork.trmBounds[1][i] + CM_BOX_EPSILON;
		} else {
			traceWork.traceBounds[0][i] = traceWork.end[i] + traceWork.trmBounds[0][i] - CM_BOX_EPSILON;
			traceWork.traceBounds[1][i] = traceWork.start[i] + traceWork.trmBounds[1][i] + CM_BOX_EPSILON;
		}
		traceWork.trmExtents[i] = Max( idMath::Fabs( traceWork.trmBounds[0][i] ),
			idMath::Fabs( traceWork.trmBounds[1][i] ) ) + CM_BOX_EPSILON;
	}

	TraceThroughModel( &traceWork );
	*results = traceWork.trace;
	results->fraction = results->c.contents == 0;
	results->endpos = start;
	results->endAxis = trmAxis;
	return results->c.contents;
}

int idCollisionModelManagerLocal::Contents( const idVec3 &start, const idTraceModel *trm,
		const idMat3 &trmAxis, int contentMask, idCollisionModel *model,
		const idVec3 &modelOrigin, const idMat3 &modelAxis ) {
	if ( model == NULL ) {
		return 0;
	}
	trace_t results;
	return ContentsTrm( &results, start, trm, trmAxis, contentMask, model, modelOrigin, modelAxis );
}

#endif
