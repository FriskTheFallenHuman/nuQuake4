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
#include "collisionmodel_load_legacy.inc"
#else

/*
===========================================================================

Quake 4 source reconstruction

Public collision-manager methods recovered from the matching PDB and the
address-matched Hex-Rays bodies in quake4.exe.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

static char q4FullCollisionModelName[MAX_OSPATH];

idCollisionModelManagerLocal collisionModelManagerLocal;
idCollisionModelManager *collisionModelManager = &collisionModelManagerLocal;

idCollisionModelLocal::~idCollisionModelLocal( void ) {
}

idCollisionModelManagerLocal::idCollisionModelManagerLocal( void ) {
}

idCollisionModelManagerLocal::~idCollisionModelManagerLocal( void ) {
}

void idCollisionModelManagerLocal::Init( void ) {
	Clear();
}

void idCollisionModelManagerLocal::Shutdown( void ) {
	Clear();
}

void idCollisionModelManagerLocal::ClearModel( idCollisionModelLocal *model ) {
	model->refCount = 0;
	model->fileTime = -1;
	model->bounds.Clear();
	model->contents = 0;
	model->isTraceModel = false;
	model->isConvex = false;
	model->maxVertices = 0;
	model->numVertices = 0;
	model->vertices = NULL;
	model->maxEdges = 0;
	model->numEdges = 0;
	model->edges = NULL;
	model->maxPolygonEdges = 0;
	model->numPolygonEdges = 0;
	model->polygonEdges = NULL;
	model->maxPolygons = 0;
	model->numPolygons = 0;
	model->polygons = NULL;
	model->maxBrushPlanes = 0;
	model->numBrushPlanes = 0;
	model->brushPlanes = NULL;
	model->maxBrushes = 0;
	model->numBrushes = 0;
	model->brushes = NULL;
	model->numNodes = 0;
	model->node = NULL;
	model->nodeBlocks = NULL;
	model->polygonRefBlocks = NULL;
	model->brushRefBlocks = NULL;
	model->numPrimitives = 0;
	model->numBrushRefs = 0;
	model->numPolygonRefs = 0;
	model->numInternalEdges = 0;
	model->numSharpEdges = 0;
	model->numRemovedPolys = 0;
	model->numMergedPolys = 0;
	model->usedMemory = 0;
}

idCollisionModelLocal *idCollisionModelManagerLocal::AllocModel( void ) {
	idCollisionModelLocal *model = new idCollisionModelLocal;
	ClearModel( model );
	return model;
}

cm_node_t *idCollisionModelManagerLocal::AllocNode( idCollisionModelLocal *model, int blockSize ) {
	cm_nodeBlock_t *block = model->nodeBlocks;
	if ( block == NULL || block->nextNode == NULL ) {
		block = static_cast<cm_nodeBlock_t *>( Mem_ClearedAlloc(
			sizeof( cm_nodeBlock_t ) + blockSize * sizeof( cm_node_t ), MA_CM ) );
		block->nextNode = reinterpret_cast<cm_node_t *>( block + 1 );
		block->next = model->nodeBlocks;
		model->nodeBlocks = block;

		cm_node_t *node = block->nextNode;
		for ( int i = 0; i < blockSize - 1; i++, node++ ) {
			node->parent = node + 1;
		}
		node->parent = NULL;
	}

	cm_node_t *node = block->nextNode;
	block->nextNode = node->parent;
	node->parent = NULL;
	return node;
}

cm_polygonRef_t *idCollisionModelManagerLocal::AllocPolygonReference( idCollisionModelLocal *model, int blockSize ) {
	cm_polygonRefBlock_t *block = model->polygonRefBlocks;
	if ( block == NULL || block->nextRef == NULL ) {
		block = static_cast<cm_polygonRefBlock_t *>( Mem_Alloc(
			sizeof( cm_polygonRefBlock_t ) + blockSize * sizeof( cm_polygonRef_t ), MA_CM ) );
		block->nextRef = reinterpret_cast<cm_polygonRef_t *>( block + 1 );
		block->next = model->polygonRefBlocks;
		model->polygonRefBlocks = block;

		cm_polygonRef_t *ref = block->nextRef;
		for ( int i = 0; i < blockSize - 1; i++, ref++ ) {
			ref->next = ref + 1;
		}
		ref->next = NULL;
	}

	cm_polygonRef_t *ref = block->nextRef;
	block->nextRef = ref->next;
	return ref;
}

cm_brushRef_t *idCollisionModelManagerLocal::AllocBrushReference( idCollisionModelLocal *model, int blockSize ) {
	cm_brushRefBlock_t *block = model->brushRefBlocks;
	if ( block == NULL || block->nextRef == NULL ) {
		block = static_cast<cm_brushRefBlock_t *>( Mem_Alloc(
			sizeof( cm_brushRefBlock_t ) + blockSize * sizeof( cm_brushRef_t ), MA_CM ) );
		block->nextRef = reinterpret_cast<cm_brushRef_t *>( block + 1 );
		block->next = model->brushRefBlocks;
		model->brushRefBlocks = block;

		cm_brushRef_t *ref = block->nextRef;
		for ( int i = 0; i < blockSize - 1; i++, ref++ ) {
			ref->next = ref + 1;
		}
		ref->next = NULL;
	}

	cm_brushRef_t *ref = block->nextRef;
	block->nextRef = ref->next;
	return ref;
}

cm_polygon_t *idCollisionModelManagerLocal::AllocPolygon( idCollisionModelLocal *model, int numEdges ) {
	cm_polygon_t *polygon;
	if ( model->polygons != NULL || model->polygonEdges != NULL ) {
		polygon = &model->polygons[model->numPolygons++];
		polygon->numEdges = numEdges;
		polygon->edges = &model->polygonEdges[model->numPolygonEdges];
		model->numPolygonEdges += numEdges;
	} else {
		model->numPolygons++;
		model->numPolygonEdges += numEdges;
		polygon = static_cast<cm_polygon_t *>( Mem_Alloc(
			sizeof( cm_polygon_t ) + numEdges * sizeof( int ), MA_CM ) );
		polygon->edges = reinterpret_cast<int *>( polygon + 1 );
	}
	return polygon;
}

cm_brush_t *idCollisionModelManagerLocal::AllocBrush( idCollisionModelLocal *model, int numPlanes ) {
	cm_brush_t *brush;
	if ( model->brushes != NULL || model->brushPlanes != NULL ) {
		brush = &model->brushes[model->numBrushes++];
		brush->numPlanes = numPlanes;
		brush->planes = &model->brushPlanes[model->numBrushPlanes];
		model->numBrushPlanes += numPlanes;
	} else {
		model->numBrushes++;
		model->numBrushPlanes += numPlanes;
		brush = static_cast<cm_brush_t *>( Mem_Alloc(
			sizeof( cm_brush_t ) + numPlanes * sizeof( idPlane ), MA_CM ) );
		brush->planes = reinterpret_cast<idPlane *>( brush + 1 );
	}
	return brush;
}

int CM_GetNodeContents( cm_node_t *node ) {
	int contents = 0;
	while ( true ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			contents |= ref->p->contents;
		}
		for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
			contents |= ref->b->contents;
		}
		if ( node->planeType == -1 ) {
			break;
		}
		contents |= CM_GetNodeContents( node->children[1] );
		node = node->children[0];
	}
	return contents;
}

int CM_GetModelMemory( idCollisionModelLocal *model ) {
	return model->numPolygonEdges * sizeof( int )
		+ model->numEdges * sizeof( cm_edge_t )
		+ model->numNodes * sizeof( cm_node_t )
		+ model->numBrushRefs * sizeof( cm_brushRef_t )
		+ model->numPolygonRefs * sizeof( cm_polygonRef_t )
		+ model->numPolygons * sizeof( cm_polygon_t )
		+ model->numVertices * sizeof( cm_vertex_t )
		+ model->numBrushes * sizeof( cm_brush_t )
		+ model->numBrushPlanes * sizeof( idPlane );
}

void idCollisionModelManagerLocal::RemapEdges( cm_node_t *node, int *edgeRemap ) {
	while ( true ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			cm_polygon_t *polygon = ref->p;
			if ( polygon->checkcount == checkCount ) {
				continue;
			}
			polygon->checkcount = checkCount;
			for ( int i = 0; i < polygon->numEdges; i++ ) {
				const int edge = polygon->edges[i];
				polygon->edges[i] = edge >= 0 ? edgeRemap[edge] : -edgeRemap[-edge];
			}
		}
		if ( node->planeType == -1 ) {
			break;
		}
		RemapEdges( node->children[1], edgeRemap );
		node = node->children[0];
	}
}

void idCollisionModelManagerLocal::RemapPolygonReferences_r( cm_node_t *node, cm_polygon_t *polygon, cm_polygon_t *newPolygon ) {
	while ( node != NULL ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			if ( ref->p == polygon ) {
				ref->p = newPolygon;
				break;
			}
		}
		if ( node->planeType == -1 ) {
			return;
		}
		if ( polygon->bounds[0][node->planeType] <= node->planeDist ) {
			if ( polygon->bounds[1][node->planeType] >= node->planeDist ) {
				RemapPolygonReferences_r( node->children[1], polygon, newPolygon );
			}
			node = node->children[0];
		} else {
			node = node->children[1];
		}
	}
}

void idCollisionModelManagerLocal::RemapBrushReferences_r( cm_node_t *node, cm_brush_t *brush, cm_brush_t *newBrush ) {
	while ( node != NULL ) {
		for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
			if ( ref->b == brush ) {
				ref->b = newBrush;
				break;
			}
		}
		if ( node->planeType == -1 ) {
			return;
		}
		if ( brush->bounds[0][node->planeType] <= node->planeDist ) {
			if ( brush->bounds[1][node->planeType] >= node->planeDist ) {
				RemapBrushReferences_r( node->children[1], brush, newBrush );
			}
			node = node->children[0];
		} else {
			node = node->children[1];
		}
	}
}

static bool CM_R_InsideAllChildren( cm_node_t *node, const idBounds &bounds ) {
	if ( node->planeType == -1 ) {
		return true;
	}
	const int axis = node->planeType;
	return bounds[0][axis] < node->planeDist &&
		bounds[1][axis] > node->planeDist &&
		CM_R_InsideAllChildren( node->children[0], bounds ) &&
		CM_R_InsideAllChildren( node->children[1], bounds );
}

void idCollisionModelManagerLocal::R_FilterPolygonIntoTree( idCollisionModelLocal *model,
		cm_node_t *node, cm_polygonRef_t *pref, cm_polygon_t *polygon ) {
	while ( node->planeType != -1 ) {
		const int axis = node->planeType;
		if ( polygon->bounds[0][axis] < node->planeDist &&
			 polygon->bounds[1][axis] > node->planeDist &&
			 CM_R_InsideAllChildren( node->children[0], polygon->bounds ) &&
			 CM_R_InsideAllChildren( node->children[1], polygon->bounds ) ) {
			break;
		}
		if ( polygon->bounds[0][axis] >= node->planeDist ) {
			node = node->children[0];
			continue;
		}
		if ( polygon->bounds[1][axis] <= node->planeDist ) {
			node = node->children[1];
			continue;
		}
		R_FilterPolygonIntoTree( model, node->children[1], NULL, polygon );
		node = node->children[0];
	}

	if ( pref != NULL ) {
		pref->next = node->polygons;
		node->polygons = pref;
		return;
	}

	cm_polygonRef_t *ref = AllocPolygonReference( model,
		model->numPolygonRefs < REFERENCE_BLOCK_SIZE_SMALL ? REFERENCE_BLOCK_SIZE_SMALL : REFERENCE_BLOCK_SIZE_LARGE );
	ref->p = polygon;
	ref->next = node->polygons;
	node->polygons = ref;
	++model->numPolygonRefs;
}

void idCollisionModelManagerLocal::R_FilterBrushIntoTree( idCollisionModelLocal *model,
		cm_node_t *node, cm_brushRef_t *pref, cm_brush_t *brush ) {
	while ( node->planeType != -1 ) {
		const int axis = node->planeType;
		if ( brush->bounds[0][axis] < node->planeDist &&
			 brush->bounds[1][axis] > node->planeDist &&
			 CM_R_InsideAllChildren( node->children[0], brush->bounds ) &&
			 CM_R_InsideAllChildren( node->children[1], brush->bounds ) ) {
			break;
		}
		if ( brush->bounds[0][axis] >= node->planeDist ) {
			node = node->children[0];
			continue;
		}
		if ( brush->bounds[1][axis] <= node->planeDist ) {
			node = node->children[1];
			continue;
		}
		R_FilterBrushIntoTree( model, node->children[1], NULL, brush );
		node = node->children[0];
	}

	if ( pref != NULL ) {
		pref->next = node->brushes;
		node->brushes = pref;
		return;
	}

	cm_brushRef_t *ref = AllocBrushReference( model,
		model->numBrushRefs < REFERENCE_BLOCK_SIZE_SMALL ? REFERENCE_BLOCK_SIZE_SMALL : REFERENCE_BLOCK_SIZE_LARGE );
	ref->b = brush;
	ref->next = node->brushes;
	node->brushes = ref;
	++model->numBrushRefs;
}

void CM_R_GetNodeBounds( idBounds *bounds, cm_node_t *node ) {
	while ( true ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			bounds->AddBounds( ref->p->bounds );
		}
		for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
			bounds->AddBounds( ref->b->bounds );
		}
		if ( node->planeType == -1 ) {
			break;
		}
		CM_R_GetNodeBounds( bounds, node->children[1] );
		node = node->children[0];
	}
}

void CM_GetNodeBounds( idBounds *bounds, cm_node_t *node ) {
	bounds->Clear();
	CM_R_GetNodeBounds( bounds, node );
	if ( bounds->IsCleared() ) {
		bounds->Zero();
	}
}

void idCollisionModelManagerLocal::ClearHash( idBounds &bounds ) {
	cm_vertexHash->Clear();
	cm_edgeHash->Clear();
	cm_modelBounds = bounds;

	const float maxSize = Max( bounds[1].x - bounds[0].x, bounds[1].y - bounds[0].y );
	const int hashBoxSize = static_cast<int>( maxSize / VERTEX_HASH_BOXSIZE );
	if ( hashBoxSize <= 1 ) {
		cm_vertexShift = 1;
		return;
	}
	cm_vertexShift = 0;
	while ( ( 1 << cm_vertexShift ) < hashBoxSize ) {
		cm_vertexShift++;
	}
}

void idCollisionModelManagerLocal::SetupHash( void ) {
	if ( cm_vertexHash == NULL ) {
		cm_vertexHash = new idHashIndex( VERTEX_HASH_SIZE, 1024 );
	}
	if ( cm_edgeHash == NULL ) {
		cm_edgeHash = new idHashIndex( EDGE_HASH_SIZE, 1024 );
	}
	if ( cm_windingList == NULL ) {
		cm_windingList = new cm_windingList_t;
	}
	if ( cm_outList == NULL ) {
		cm_outList = new cm_windingList_t;
	}
	if ( cm_tmpList == NULL ) {
		cm_tmpList = new cm_windingList_t;
	}
}

void idCollisionModelManagerLocal::ShutdownHash( void ) {
	delete cm_vertexHash;
	cm_vertexHash = NULL;
	delete cm_edgeHash;
	cm_edgeHash = NULL;
	delete cm_tmpList;
	cm_tmpList = NULL;
	delete cm_outList;
	cm_outList = NULL;
	delete cm_windingList;
	cm_windingList = NULL;
}

void idCollisionModelManagerLocal::FinishModel( idCollisionModelLocal *model, bool mergePrimitives ) {
	checkCount++;
	MergeTreePolygons( model, model->node, mergePrimitives );
	checkCount++;
	FindInternalEdges( model, model->node );
	checkCount++;
	CalculateEdgeNormals( model, model->node );
	OptimizeArrays( model );
	CM_GetNodeBounds( &model->bounds, model->node );
	model->contents = CM_GetNodeContents( model->node );
	model->usedMemory = CM_GetModelMemory( model );
}

void idCollisionModelManagerLocal::MergeTreePolygons( idCollisionModelLocal *model,
		cm_node_t *node, bool mergePrimitives ) {
	// Quake 4 permits callers (notably render-model extraction) to preserve
	// primitive boundaries.  The array-based representation remains valid
	// without a merge; shared edges are still classified below.
	if ( node == NULL || !mergePrimitives ) {
		return;
	}
	// Preserve authored polygons.  This avoids changing primitive numbers,
	// which CompoundTrmFromModel uses to split compound hulls.
}

static bool CM_Q4PointInsidePolygon( const idCollisionModelLocal *model,
		const cm_polygon_t *polygon, const idVec3 &point ) {
	for ( int i = 0; i < polygon->numEdges; ++i ) {
		const int signedEdge = polygon->edges[i];
		const cm_edge_t &edge = model->edges[abs( signedEdge )];
		const idVec3 &a = model->vertices[edge.vertexNum[INTSIGNBITSET( signedEdge )]].p;
		const idVec3 &b = model->vertices[edge.vertexNum[INTSIGNBITNOTSET( signedEdge )]].p;
		if ( ( point - a ) * ( ( b - a ).Cross( polygon->plane.Normal() ) ) > VERTEX_EPSILON ) {
			return false;
		}
	}
	return true;
}

static void CM_Q4MarkInternalPair( idCollisionModelLocal *model,
		cm_polygon_t *first, cm_polygon_t *second ) {
	if ( first == second || first->contents != second->contents ||
			!first->bounds.IntersectsBounds( second->bounds.Expand( VERTEX_EPSILON ) ) ) {
		return;
	}
	for ( int i = 0; i < first->numEdges; ++i ) {
		const int signedEdge = first->edges[i];
		cm_edge_t &edge = model->edges[abs( signedEdge )];
		if ( edge.internal ) {
			continue;
		}
		for ( int j = 0; j < second->numEdges; ++j ) {
			if ( second->edges[j] == -signedEdge && edge.numUsers <= 2 ) {
				edge.internal = true;
				++model->numInternalEdges;
				break;
			}
		}
		if ( edge.internal ) {
			continue;
		}
		const idVec3 &a = model->vertices[edge.vertexNum[INTSIGNBITSET( signedEdge )]].p;
		const idVec3 &b = model->vertices[edge.vertexNum[INTSIGNBITNOTSET( signedEdge )]].p;
		if ( idMath::Fabs( second->plane.Distance( a ) ) <= VERTEX_EPSILON &&
			 idMath::Fabs( second->plane.Distance( b ) ) <= VERTEX_EPSILON &&
			 CM_Q4PointInsidePolygon( model, second, a ) && CM_Q4PointInsidePolygon( model, second, b ) ) {
			edge.internal = true;
			++model->numInternalEdges;
		}
	}
}

void idCollisionModelManagerLocal::FindInternalEdges( idCollisionModelLocal *model, cm_node_t *node ) {
	if ( model == NULL || node == NULL ) {
		return;
	}
	// The optimized array owns each polygon once, so pairwise classification
	// is deterministic even when the BSP holds multiple references.
	for ( int i = 0; i < model->numPolygons; ++i ) {
		for ( int j = i + 1; j < model->numPolygons; ++j ) {
			CM_Q4MarkInternalPair( model, &model->polygons[i], &model->polygons[j] );
		}
	}
}

#define Q4_SHARP_EDGE_DOT -0.7f
void idCollisionModelManagerLocal::CalculateEdgeNormals( idCollisionModelLocal *model, cm_node_t *node ) {
	while ( node != NULL ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			cm_polygon_t *polygon = ref->p;
			if ( polygon == NULL || polygon->checkcount == checkCount ) {
				continue;
			}
			polygon->checkcount = checkCount;
			for ( int i = 0; i < polygon->numEdges; ++i ) {
				const int edgeNum = polygon->edges[i];
				cm_edge_t &edge = model->edges[abs( edgeNum )];
				if ( edge.normal == vec3_zero ) {
					if ( edge.numUsers == 1 ) {
						const idVec3 direction = model->vertices[edge.vertexNum[edgeNum < 0]].p -
							model->vertices[edge.vertexNum[edgeNum > 0]].p;
						edge.normal = polygon->plane.Normal().Cross( direction );
						edge.normal.Normalize();
					} else {
						edge.normal = polygon->plane.Normal();
					}
				} else {
					const float dot = edge.normal * polygon->plane.Normal();
					if ( dot < Q4_SHARP_EDGE_DOT ) {
						const idVec3 direction = model->vertices[edge.vertexNum[edgeNum > 0]].p -
							model->vertices[edge.vertexNum[edgeNum < 0]].p;
						edge.normal = edge.normal.Cross( direction ) + polygon->plane.Normal().Cross( -direction );
						const float length = edge.normal.Length();
						if ( length > 0.0f ) {
							edge.normal *= ( 0.5f / ( 0.5f + 0.5f * Q4_SHARP_EDGE_DOT ) ) / length;
						}
						++model->numSharpEdges;
					} else {
						const float scale = 0.5f / ( 0.5f + 0.5f * dot );
						edge.normal = scale * ( edge.normal + polygon->plane.Normal() );
					}
				}
			}
		}
		if ( node->planeType == -1 ) {
			break;
		}
		CalculateEdgeNormals( model, node->children[1] );
		node = node->children[0];
	}
}

void idCollisionModelManagerLocal::OptimizeArrays( idCollisionModelLocal *model ) {
	if ( model == NULL || model->numVertices <= 0 || model->numEdges <= 0 ) {
		return;
	}
	const int remapCount = Max( model->numVertices, model->numEdges );
	int *remap = static_cast<int *>( Mem_ClearedAlloc( remapCount * sizeof( int ), MA_CM ) );
	for ( int i = 1; i < model->numEdges; ++i ) {
		if ( model->edges[i].numUsers != 0 ) {
			remap[model->edges[i].vertexNum[0]] = 1;
			remap[model->edges[i].vertexNum[1]] = 1;
		}
	}
	int newVertices = 0;
	for ( int i = 0; i < model->numVertices; ++i ) {
		if ( remap[i] ) {
			remap[i] = newVertices;
			model->vertices[newVertices++] = model->vertices[i];
		}
	}
	for ( int i = 1; i < model->numEdges; ++i ) {
		model->edges[i].vertexNum[0] = remap[model->edges[i].vertexNum[0]];
		model->edges[i].vertexNum[1] = remap[model->edges[i].vertexNum[1]];
	}
	memset( remap, 0, remapCount * sizeof( int ) );
	int newEdges = 1;
	for ( int i = 1; i < model->numEdges; ++i ) {
		if ( model->edges[i].numUsers != 0 ) {
			remap[i] = newEdges;
			model->edges[newEdges++] = model->edges[i];
		}
	}
	++checkCount;
	RemapEdges( model->node, remap );
	model->numVertices = newVertices;
	model->numEdges = newEdges;
	Mem_Free( remap );

	cm_vertex_t *oldVertices = model->vertices;
	model->vertices = static_cast<cm_vertex_t *>( Mem_ClearedAlloc( model->numVertices * sizeof( cm_vertex_t ), MA_CM ) );
	memcpy( model->vertices, oldVertices, model->numVertices * sizeof( cm_vertex_t ) );
	Mem_Free( oldVertices );
	cm_edge_t *oldEdges = model->edges;
	model->edges = static_cast<cm_edge_t *>( Mem_ClearedAlloc( model->numEdges * sizeof( cm_edge_t ), MA_CM ) );
	memcpy( model->edges, oldEdges, model->numEdges * sizeof( cm_edge_t ) );
	Mem_Free( oldEdges );
	model->maxVertices = model->numVertices;
	model->maxEdges = model->numEdges;
}
#undef Q4_SHARP_EDGE_DOT

void idCollisionModelManagerLocal::CopyPolygon( cm_polygon_t *dest, cm_polygon_t *src ) {
	int *destEdges = dest->edges;
	*dest = *src;
	dest->edges = destEdges;
	memcpy( dest->edges, src->edges, src->numEdges * sizeof( dest->edges[0] ) );
}

void idCollisionModelManagerLocal::RemovePolygonReferences_r( cm_node_t *node, cm_polygon_t *polygon ) {
	while ( node != NULL ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			if ( ref->p == polygon ) {
				ref->p = NULL;
				break;
			}
		}

		if ( node->planeType == -1 ) {
			return;
		}
		if ( polygon->bounds[0][node->planeType] <= node->planeDist ) {
			if ( polygon->bounds[1][node->planeType] >= node->planeDist ) {
				RemovePolygonReferences_r( node->children[1], polygon );
			}
			node = node->children[0];
		} else {
			node = node->children[1];
		}
	}
}

void idCollisionModelManagerLocal::RemoveBrushReferences_r( cm_node_t *node, cm_brush_t *brush ) {
	while ( node != NULL ) {
		for ( cm_brushRef_t *ref = node->brushes; ref != NULL; ref = ref->next ) {
			if ( ref->b == brush ) {
				ref->b = NULL;
				break;
			}
		}

		if ( node->planeType == -1 ) {
			return;
		}
		if ( brush->bounds[0][node->planeType] <= node->planeDist ) {
			if ( brush->bounds[1][node->planeType] >= node->planeDist ) {
				RemoveBrushReferences_r( node->children[1], brush );
			}
			node = node->children[0];
		} else {
			node = node->children[1];
		}
	}
}

void idCollisionModelManagerLocal::FreeTree_r( idCollisionModelLocal *model, cm_node_t *headNode, cm_node_t *node ) {
	while ( node->polygons != NULL ) {
		cm_polygonRef_t *ref = node->polygons;
		if ( ref->p != NULL ) {
			cm_polygon_t *polygon = ref->p;
			RemovePolygonReferences_r( headNode, polygon );
			if ( model->polygons == NULL && model->polygonEdges == NULL ) {
				model->numPolygons--;
				model->numPolygonEdges -= polygon->numEdges;
				Mem_Free( polygon );
			}
		}
		node->polygons = ref->next;
	}

	while ( node->brushes != NULL ) {
		cm_brushRef_t *ref = node->brushes;
		if ( ref->b != NULL ) {
			cm_brush_t *brush = ref->b;
			RemoveBrushReferences_r( headNode, brush );
			if ( model->brushes == NULL && model->brushPlanes == NULL ) {
				model->numBrushes--;
				model->numBrushPlanes -= brush->numPlanes;
				Mem_Free( brush );
			}
		}
		node->brushes = ref->next;
	}

	if ( node->planeType != -1 ) {
		FreeTree_r( model, headNode, node->children[0] );
		node->children[0] = NULL;
		FreeTree_r( model, headNode, node->children[1] );
		node->children[1] = NULL;
	}
}

void idCollisionModelManagerLocal::FreeModelMemory( idCollisionModelLocal *model ) {
	if ( model->node != NULL ) {
		FreeTree_r( model, model->node, model->node );
	}

	for ( cm_polygonRefBlock_t *block = model->polygonRefBlocks; block != NULL; ) {
		cm_polygonRefBlock_t *next = block->next;
		Mem_Free( block );
		block = next;
	}
	for ( cm_brushRefBlock_t *block = model->brushRefBlocks; block != NULL; ) {
		cm_brushRefBlock_t *next = block->next;
		Mem_Free( block );
		block = next;
	}
	for ( cm_nodeBlock_t *block = model->nodeBlocks; block != NULL; ) {
		cm_nodeBlock_t *next = block->next;
		Mem_Free( block );
		block = next;
	}

	Mem_Free16( model->polygonEdges );
	Mem_Free16( model->polygons );
	Mem_Free16( model->brushPlanes );
	Mem_Free16( model->brushes );
	Mem_Free( model->edges );
	Mem_Free( model->vertices );
	ClearModel( model );
}

void idCollisionModelManagerLocal::AddToMapModelReferenceCounts( const char *mapName, int add ) {
	idStr name = mapName;
	name.StripFileExtension();
	if ( name.Length() == 0 ) {
		return;
	}
	for ( int i = 0; i < models.Num(); i++ ) {
		if ( idStr::IcmpnPath( models[i]->name.c_str(), name.c_str(), name.Length() ) == 0 ) {
			models[i]->refCount += add;
		}
	}
}

void idCollisionModelManagerLocal::PrintModelInfo( const idCollisionModelLocal *model ) {
	common->Printf( "%6i vertices (%i KB)\n", model->numVertices, model->numVertices * sizeof( cm_vertex_t ) >> 10 );
	common->Printf( "%6i edges (%i KB)\n", model->numEdges, model->numEdges * sizeof( cm_edge_t ) >> 10 );
	common->Printf( "%6i polygons (%i KB)\n", model->numPolygons, model->numPolygons * sizeof( cm_polygon_t ) >> 10 );
	common->Printf( "%6i polygon edges (%i KB)\n", model->numPolygonEdges, model->numPolygonEdges * sizeof( int ) >> 10 );
	common->Printf( "%6i brushes (%i KB)\n", model->numBrushes, model->numBrushes * sizeof( cm_brush_t ) >> 10 );
	common->Printf( "%6i brush planes (%i KB)\n", model->numBrushPlanes, model->numBrushPlanes * sizeof( idPlane ) >> 10 );
	common->Printf( "%6i nodes (%i KB)\n", model->numNodes, model->numNodes * sizeof( cm_node_t ) >> 10 );
	common->Printf( "%6i polygon refs (%i KB)\n", model->numPolygonRefs, model->numPolygonRefs * sizeof( cm_polygonRef_t ) >> 10 );
	common->Printf( "%6i brush refs (%i KB)\n", model->numBrushRefs, model->numBrushRefs * sizeof( cm_brushRef_t ) >> 10 );
	common->Printf( "%6i internal edges\n", model->numInternalEdges );
	common->Printf( "%6i sharp edges\n", model->numSharpEdges );
	common->Printf( "%6i contained polygons removed\n", model->numRemovedPolys );
	common->Printf( "%6i polygons merged\n", model->numMergedPolys );
	common->Printf( "%6i KB total memory used\n", model->usedMemory >> 10 );
}

void idCollisionModelManagerLocal::AccumulateModelInfo( idCollisionModelLocal *total ) {
	ClearModel( total );
	for ( int i = 0; i < models.Num(); i++ ) {
		const idCollisionModelLocal *model = models[i];
		total->numVertices += model->numVertices;
		total->numEdges += model->numEdges;
		total->numPolygonEdges += model->numPolygonEdges;
		total->numPolygons += model->numPolygons;
		total->numBrushes += model->numBrushes;
		total->numBrushPlanes += model->numBrushPlanes;
		total->numNodes += model->numNodes;
		total->numBrushRefs += model->numBrushRefs;
		total->numPolygonRefs += model->numPolygonRefs;
		total->numInternalEdges += model->numInternalEdges;
		total->numSharpEdges += model->numSharpEdges;
		total->numRemovedPolys += model->numRemovedPolys;
		total->numMergedPolys += model->numMergedPolys;
		total->usedMemory += model->usedMemory;
	}
}

bool idCollisionModelManagerLocal::IsLoaded( void ) {
	return loaded != 0;
}

idCollisionModelLocal *idCollisionModelManagerLocal::FindModel( const char *name ) {
	for ( int i = 0; i < models.Num(); i++ ) {
		if ( idStr::Icmp( models[i]->name.c_str(), name ) == 0 ) {
			return models[i];
		}
	}
	return NULL;
}

bool idCollisionModelManagerLocal::IsRenderModelName( const char *modelName ) {
	return idStr::IcmpnPath( modelName, "models/", 7 ) == 0
		|| idStr::IcmpnPath( modelName, "gfx/", 4 ) == 0;
}

const char *idCollisionModelManagerLocal::GetFullModelName( const char *mapName, const char *modelName ) {
	if ( !IsRenderModelName( modelName ) ) {
		idStr name = mapName;
		name.StripFileExtension();
		if ( idStr::IcmpnPath( modelName, name.c_str(), name.Length() ) != 0 ) {
			idStr::snPrintf( q4FullCollisionModelName, sizeof( q4FullCollisionModelName ), "%s/%s", name.c_str(), modelName );
			return q4FullCollisionModelName;
		}
	}
	return modelName;
}

void idCollisionModelManagerLocal::PreCacheModel( const char *mapName, const char *modelName ) {
	idStr name = GetFullModelName( mapName, modelName );
	if ( FindModel( name.c_str() ) == NULL
			&& LoadModel( mapName, name.c_str() ) != NULL
			&& FindModel( name.c_str() ) == NULL ) {
		common->Warning( "idCollisionModelManagerLocal::PreCacheModel: collision file for '%s' contains different model",
			name.c_str() );
	}
}

void idCollisionModelManagerLocal::FreeMap( const char *mapName ) {
	AddToMapModelReferenceCounts( mapName, -1 );
}

bool idCollisionModelManagerLocal::TrmFromModel( const char *mapName, const char *modelName, idTraceModel &trm ) {
	idCollisionModelLocal *model = static_cast<idCollisionModelLocal *>( LoadModel( mapName, modelName ) );
	if ( model != NULL ) {
		return TrmFromModel( model, trm );
	}
	common->Printf( "idCollisionModelManagerLocal::TrmFromModel: model %s not found.\n", modelName );
	return false;
}

int idCollisionModelManagerLocal::CompoundTrmFromModel( const char *mapName, const char *modelName,
		idTraceModel *trms, int maxTrms ) {
	idCollisionModelLocal *model = static_cast<idCollisionModelLocal *>( LoadModel( mapName, modelName ) );
	if ( model != NULL ) {
		return CompoundTrmFromModel( model, trms, maxTrms );
	}
	common->Printf( "idCollisionModelManagerLocal::CompoundTrmFromModel: model %s not found.\n", modelName );
	return 0;
}

void idCollisionModelManagerLocal::PurgeModels( void ) {
	for ( int i = 0; i < models.Num(); i++ ) {
		if ( models[i]->refCount <= 0 ) {
			FreeModelMemory( models[i] );
		}
	}
}

void idCollisionModelManagerLocal::ModelInfo( int num ) {
	if ( num >= 0 ) {
		PrintModelInfo( models[num] );
		return;
	}
	idCollisionModelLocal total;
	AccumulateModelInfo( &total );
	PrintModelInfo( &total );
}

void idCollisionModelManagerLocal::ListModels( void ) {
	int totalMemory = 0;
	for ( int i = 0; i < models.Num(); i++ ) {
		common->Printf( "%4d: %5d KB   %s\n", i, models[i]->usedMemory >> 10, models[i]->name.c_str() );
		totalMemory += models[i]->usedMemory;
	}
	common->Printf( "%4d KB in %d models\n", totalMemory >> 10, models.Num() );
}

void idCollisionModelManagerLocal::PrintMemInfo( MemInfo *mi ) {
	idFile *file = fileSystem->OpenFileWrite( mi->filebase + "_coll.txt", "fs_savepath", false );
	if ( file == NULL ) {
		return;
	}

	int totalMemory = 0;
	for ( int i = 0; i < models.Num(); i++ ) {
		totalMemory += models[i]->usedMemory;
		file->Printf( "%8d: %s\n", models[i]->usedMemory, models[i]->name.c_str() );
	}
	mi->collAssetsTotal = totalMemory;
	mi->collAssetsCount = models.Num();
	file->Printf( "\nTotal collision model bytes allocated: %s (%s items)\n",
		idStr::FormatNumber( totalMemory ).c_str(), idStr::FormatNumber( models.Num() ).c_str() );
	fileSystem->CloseFile( file );
}

void idCollisionModelManagerLocal::FreeModel( idCollisionModel *model ) {
	if ( model == NULL ) {
		return;
	}

	idCollisionModelLocal *localModel = static_cast<idCollisionModelLocal *>( model );
	if ( localModel->isTraceModel ) {
		FreeModelMemory( localModel );
		delete localModel;
	} else if ( IsRenderModelName( localModel->name.c_str() ) && localModel->refCount > 0 ) {
		localModel->refCount--;
	}
}

void idCollisionModelManagerLocal::Clear( void ) {
	mapName.Clear();
	mapFileTime = 0;
	loaded = 0;
	checkCount = 0;

	for ( int i = 0; i < models.Num(); i++ ) {
		delete models[i];
	}
	models.Clear();

	getContacts = false;
	contacts = NULL;
	maxContacts = 0;
	numContacts = 0;
	numProcNodes = 0;
	procNodes = NULL;
	cm_windingList = NULL;
	cm_outList = NULL;
	cm_tmpList = NULL;
	cm_vertexHash = NULL;
	cm_edgeHash = NULL;
	cm_modelBounds.Clear();
	cm_vertexShift = 0;
}

bool idCollisionModelManagerLocal::TrmFromModel_r( idTraceModel &trm, cm_node_t *node, int primitiveNum ) {
	while ( node != NULL ) {
		for ( cm_polygonRef_t *ref = node->polygons; ref != NULL; ref = ref->next ) {
			cm_polygon_t *polygon = ref->p;
			if ( polygon == NULL || polygon->checkcount == checkCount ||
				( primitiveNum >= 0 && polygon->primitiveNum != primitiveNum ) ) {
				continue;
			}
			polygon->checkcount = checkCount;
			if ( trm.numPolys >= MAX_TRACEMODEL_POLYS || polygon->numEdges > MAX_TRACEMODEL_POLYEDGES ) {
				return false;
			}
			traceModelPoly_t &dest = trm.polys[trm.numPolys++];
			dest.bounds = polygon->bounds;
			dest.normal = polygon->plane.Normal();
			dest.dist = polygon->plane.Dist();
			dest.numEdges = polygon->numEdges;
			for ( int i = 0; i < polygon->numEdges; ++i ) {
				dest.edges[i] = polygon->edges[i];
			}
		}
		if ( node->planeType == -1 ) {
			return true;
		}
		if ( !TrmFromModel_r( trm, node->children[1], primitiveNum ) ) {
			return false;
		}
		node = node->children[0];
	}
	return true;
}

bool idCollisionModelManagerLocal::TrmFromModel( const idCollisionModelLocal *model, idTraceModel &trm ) {
	if ( model == NULL || model->node == NULL ) {
		return false;
	}
	if ( model->numVertices > MAX_TRACEMODEL_VERTS || model->numEdges > MAX_TRACEMODEL_EDGES + 1 ) {
		common->Printf( "idCollisionModelManagerLocal::TrmFromModel: model %s is too complex.\n", model->name.c_str() );
		PrintModelInfo( model );
		return false;
	}

	trm.type = TRM_CUSTOM;
	trm.numVerts = 0;
	trm.numEdges = 1;
	trm.numPolys = 0;
	trm.bounds.Clear();
	++checkCount;
	if ( !TrmFromModel_r( trm, model->node, -1 ) ) {
		common->Printf( "idCollisionModelManagerLocal::TrmFromModel: model %s has too many polygons.\n", model->name.c_str() );
		return false;
	}
	for ( int i = 0; i < model->numVertices; ++i ) {
		trm.verts[i] = model->vertices[i].p;
		trm.bounds.AddPoint( trm.verts[i] );
	}
	trm.numVerts = model->numVertices;
	for ( int i = 0; i < model->numEdges; ++i ) {
		trm.edges[i].v[0] = model->edges[i].vertexNum[0];
		trm.edges[i].v[1] = model->edges[i].vertexNum[1];
	}
	trm.numEdges = Max( 0, model->numEdges - 1 );
	if ( !trm.IsClosedSurface() ) {
		common->Warning( "idCollisionModelManagerLocal::TrmFromModel: model %s has dangling edges", model->name.c_str() );
		return false;
	}
	trm.offset = trm.bounds.GetCenter();
	trm.GenerateEdgeNormals();
	trm.TestConvexity();
	trm.ClearUnused();
	return true;
}

int idCollisionModelManagerLocal::CompoundTrmFromModel( const idCollisionModelLocal *model,
		idTraceModel *trms, int maxTrms ) {
	if ( model == NULL || trms == NULL || maxTrms <= 0 ) {
		return 0;
	}
	int numTrms = 0;
	for ( int primitive = 0; primitive < model->numPrimitives && numTrms < maxTrms; ++primitive ) {
		idTraceModel &trm = trms[numTrms];
		trm.type = TRM_CUSTOM;
		trm.numVerts = 0;
		trm.numEdges = 0;
		trm.numPolys = 0;
		trm.bounds.Clear();
		++checkCount;
		if ( !TrmFromModel_r( trm, model->node, primitive ) ) {
			continue;
		}
		if ( trm.numPolys == 0 ) {
			continue;
		}

		int edgeRemap[MAX_TRACEMODEL_EDGES + 1];
		int vertexRemap[MAX_TRACEMODEL_VERTS];
		memset( edgeRemap, 0, sizeof( edgeRemap ) );
		memset( vertexRemap, -1, sizeof( vertexRemap ) );
		for ( int p = 0; p < trm.numPolys; ++p ) {
			for ( int e = 0; e < trm.polys[p].numEdges; ++e ) {
				const int oldSigned = trm.polys[p].edges[e];
				const int oldEdge = abs( oldSigned );
				if ( oldEdge <= 0 || oldEdge >= model->numEdges ) {
					continue;
				}
				if ( edgeRemap[oldEdge] == 0 ) {
					if ( trm.numEdges >= MAX_TRACEMODEL_EDGES ) {
						return numTrms;
					}
					const cm_edge_t &sourceEdge = model->edges[oldEdge];
					const int newEdge = ++trm.numEdges;
					edgeRemap[oldEdge] = newEdge;
					for ( int side = 0; side < 2; ++side ) {
						const int oldVertex = sourceEdge.vertexNum[side];
						if ( vertexRemap[oldVertex] < 0 ) {
							if ( trm.numVerts >= MAX_TRACEMODEL_VERTS ) {
								return numTrms;
							}
							vertexRemap[oldVertex] = trm.numVerts;
							trm.verts[trm.numVerts++] = model->vertices[oldVertex].p;
						}
						trm.edges[newEdge].v[side] = vertexRemap[oldVertex];
					}
				}
				trm.polys[p].edges[e] = oldSigned < 0 ? -edgeRemap[oldEdge] : edgeRemap[oldEdge];
			}
		}
		for ( int v = 0; v < trm.numVerts; ++v ) {
			trm.bounds.AddPoint( trm.verts[v] );
		}
		if ( !trm.IsClosedSurface() ) {
			continue;
		}
		trm.offset = trm.bounds.GetCenter();
		trm.GenerateEdgeNormals();
		trm.TestConvexity();
		trm.ClearUnused();
		++numTrms;
	}
	return numTrms;
}

idCollisionModel *idCollisionModelManagerLocal::ModelFromTrm( const char *sourceMapName,
		const char *modelName, const idTraceModel &trm, const idMaterial *material ) {
	idCollisionModelLocal *model = AllocModel();
	model->name = GetFullModelName( sourceMapName ? sourceMapName : "", modelName ? modelName : "traceModel" );
	model->fileTime = -1;
	model->isTraceModel = true;
	model->isConvex = trm.isConvex;
	model->numPrimitives = 1;
	model->maxVertices = model->numVertices = trm.numVerts;
	model->maxEdges = model->numEdges = trm.numEdges + 1;
	model->maxPolygons = model->numPolygons = trm.numPolys;
	for ( int i = 0; i < trm.numPolys; ++i ) {
		model->maxPolygonEdges += trm.polys[i].numEdges;
	}
	model->numPolygonEdges = model->maxPolygonEdges;
	model->vertices = static_cast<cm_vertex_t *>( Mem_ClearedAlloc( model->maxVertices * sizeof( cm_vertex_t ), MA_CM ) );
	model->edges = static_cast<cm_edge_t *>( Mem_ClearedAlloc( model->maxEdges * sizeof( cm_edge_t ), MA_CM ) );
	model->polygonEdges = static_cast<int *>( Mem_Alloc16( model->maxPolygonEdges * sizeof( int ), MA_CM ) );
	model->polygons = static_cast<cm_polygon_t *>( Mem_Alloc16( model->maxPolygons * sizeof( cm_polygon_t ), MA_CM ) );
	memset( model->polygons, 0, model->maxPolygons * sizeof( cm_polygon_t ) );
	model->node = AllocNode( model, NODE_BLOCK_SIZE_SMALL );
	model->node->planeType = -1;
	model->bounds = trm.bounds;
	for ( int i = 0; i < trm.numVerts; ++i ) {
		model->vertices[i].p = trm.verts[i];
	}
	for ( int i = 0; i <= trm.numEdges; ++i ) {
		model->edges[i].vertexNum[0] = trm.edges[i].v[0];
		model->edges[i].vertexNum[1] = trm.edges[i].v[1];
	}
	const idMaterial *useMaterial = material ? material : declManager->FindMaterial( "_default" );
	int edgeOffset = 0;
	for ( int i = 0; i < trm.numPolys; ++i ) {
		cm_polygon_t &polygon = model->polygons[i];
		polygon.bounds = trm.polys[i].bounds;
		polygon.plane.SetNormal( trm.polys[i].normal );
		polygon.plane.SetDist( trm.polys[i].dist );
		polygon.material = useMaterial;
		polygon.contents = useMaterial->GetContentFlags();
		polygon.primitiveNum = 0;
		polygon.numEdges = trm.polys[i].numEdges;
		polygon.edges = model->polygonEdges + edgeOffset;
		memcpy( polygon.edges, trm.polys[i].edges, polygon.numEdges * sizeof( int ) );
		edgeOffset += polygon.numEdges;
		cm_polygonRef_t *ref = AllocPolygonReference( model, REFERENCE_BLOCK_SIZE_SMALL );
		ref->p = &polygon;
		ref->next = model->node->polygons;
		model->node->polygons = ref;
		++model->numPolygonRefs;
	}
	model->contents = useMaterial->GetContentFlags();
	model->usedMemory = CM_GetModelMemory( model );
	return model;
}

void idCollisionModelManagerLocal::PolygonFromWinding( idCollisionModelLocal *model,
		idFixedWinding *winding, const idPlane &plane, const idMaterial *material, int primitiveNum ) {
	if ( model == NULL || winding == NULL || winding->GetNumPoints() < 3 ) {
		return;
	}
	// Render-model extraction supplies exact capacities.  The MD5R path can
	// arrive through rvPrimBatch without a sizing pass, so reserve a bounded
	// working set on first use.
	if ( model->vertices == NULL ) {
		model->maxVertices = 65536;
		model->maxEdges = 65536;
		model->maxPolygons = 65536;
		model->maxPolygonEdges = 196608;
		model->vertices = static_cast<cm_vertex_t *>( Mem_ClearedAlloc( model->maxVertices * sizeof( cm_vertex_t ), MA_CM ) );
		model->edges = static_cast<cm_edge_t *>( Mem_ClearedAlloc( model->maxEdges * sizeof( cm_edge_t ), MA_CM ) );
		model->polygons = static_cast<cm_polygon_t *>( Mem_Alloc16( model->maxPolygons * sizeof( cm_polygon_t ), MA_CM ) );
		model->polygonEdges = static_cast<int *>( Mem_Alloc16( model->maxPolygonEdges * sizeof( int ), MA_CM ) );
		memset( model->polygons, 0, model->maxPolygons * sizeof( cm_polygon_t ) );
		model->numEdges = 1;
	}
	const int count = winding->GetNumPoints();
	if ( model->numPolygons >= model->maxPolygons || model->numPolygonEdges + count > model->maxPolygonEdges ) {
		common->Warning( "PolygonFromWinding: capacity exceeded for %s", model->name.c_str() );
		return;
	}
	cm_polygon_t *polygon = &model->polygons[model->numPolygons++];
	polygon->bounds.Clear();
	polygon->plane = plane;
	polygon->material = material ? material : declManager->FindMaterial( "_default" );
	polygon->contents = polygon->material->GetContentFlags();
	polygon->primitiveNum = primitiveNum;
	polygon->numEdges = count;
	polygon->edges = model->polygonEdges + model->numPolygonEdges;
	model->numPolygonEdges += count;
	for ( int i = 0; i < 3; ++i ) {
		polygon->texBounds[i].Set( (*winding)[Min( i, count - 1 )].s, (*winding)[Min( i, count - 1 )].t );
	}
	for ( int i = 0; i < count; ++i ) {
		const idVec3 &point = (*winding)[i].ToVec3();
		polygon->bounds.AddPoint( point );
		int vertex[2];
		const idVec3 edgePoints[2] = { point, (*winding)[( i + 1 ) % count].ToVec3() };
		for ( int side = 0; side < 2; ++side ) {
			vertex[side] = -1;
			for ( int v = 0; v < model->numVertices; ++v ) {
				if ( model->vertices[v].p.Compare( edgePoints[side], VERTEX_EPSILON ) ) {
					vertex[side] = v;
					break;
				}
			}
			if ( vertex[side] < 0 && model->numVertices < model->maxVertices ) {
				vertex[side] = model->numVertices;
				model->vertices[model->numVertices++].p = edgePoints[side];
			}
		}
		int edgeNum = 0;
		for ( int e = 1; e < model->numEdges; ++e ) {
			if ( model->edges[e].vertexNum[0] == vertex[0] && model->edges[e].vertexNum[1] == vertex[1] ) {
				edgeNum = e;
				break;
			}
			if ( model->edges[e].vertexNum[0] == vertex[1] && model->edges[e].vertexNum[1] == vertex[0] ) {
				edgeNum = -e;
				break;
			}
		}
		if ( edgeNum == 0 && model->numEdges < model->maxEdges ) {
			edgeNum = model->numEdges++;
			model->edges[edgeNum].vertexNum[0] = vertex[0];
			model->edges[edgeNum].vertexNum[1] = vertex[1];
		}
		polygon->edges[i] = edgeNum;
		++model->edges[abs( edgeNum )].numUsers;
	}
	if ( model->node == NULL ) {
		model->node = AllocNode( model, NODE_BLOCK_SIZE_SMALL );
		model->node->planeType = -1;
	}
	cm_polygonRef_t *ref = AllocPolygonReference( model, REFERENCE_BLOCK_SIZE_LARGE );
	ref->p = polygon;
	ref->next = model->node->polygons;
	model->node->polygons = ref;
	++model->numPolygonRefs;
	model->numPrimitives = Max( model->numPrimitives, abs( primitiveNum ) + 1 );
}

idCollisionModel *idCollisionModelManagerLocal::ExtractCollisionModel( idRenderModel *renderModel, const char *modelName ) {
	if ( renderModel == NULL ) {
		return NULL;
	}
	const idStr fullName = GetFullModelName( "", modelName ? modelName : renderModel->Name() );
	idCollisionModelLocal *existing = FindModel( fullName );
	if ( existing != NULL && existing->fileTime != -1 ) {
		++existing->refCount;
		return existing;
	}

	int triangles = 0;
	for ( int i = 0; i < renderModel->NumSurfaces(); ++i ) {
		const modelSurface_t *surface = renderModel->Surface( i );
		if ( surface && surface->geometry && surface->shader && surface->shader->GetContentFlags() != 0 ) {
			triangles += surface->geometry->numIndexes / 3;
		}
	}
	if ( triangles == 0 ) {
		return NULL;
	}
	idCollisionModelLocal *model = AllocModel();
	model->name = fullName;
	model->fileTime = 0;
	model->refCount = 1;
	model->maxVertices = triangles * 3;
	model->maxEdges = triangles * 3 + 1;
	model->maxPolygons = triangles;
	model->maxPolygonEdges = triangles * 3;
	model->vertices = static_cast<cm_vertex_t *>( Mem_ClearedAlloc( model->maxVertices * sizeof( cm_vertex_t ), MA_CM ) );
	model->edges = static_cast<cm_edge_t *>( Mem_ClearedAlloc( model->maxEdges * sizeof( cm_edge_t ), MA_CM ) );
	model->polygons = static_cast<cm_polygon_t *>( Mem_Alloc16( model->maxPolygons * sizeof( cm_polygon_t ), MA_CM ) );
	model->polygonEdges = static_cast<int *>( Mem_Alloc16( model->maxPolygonEdges * sizeof( int ), MA_CM ) );
	memset( model->polygons, 0, model->maxPolygons * sizeof( cm_polygon_t ) );
	model->numEdges = 1;
	model->node = AllocNode( model, NODE_BLOCK_SIZE_LARGE );
	model->node->planeType = -1;
	for ( int i = 0; i < renderModel->NumSurfaces(); ++i ) {
		const modelSurface_t *surface = renderModel->Surface( i );
		if ( surface == NULL || surface->geometry == NULL || surface->shader == NULL || surface->shader->GetContentFlags() == 0 ) {
			continue;
		}
		for ( int index = 0; index + 2 < surface->geometry->numIndexes; index += 3 ) {
			idFixedWinding winding;
			for ( int corner = 0; corner < 3; ++corner ) {
				const idDrawVert &vertex = surface->geometry->verts[surface->geometry->indexes[index + 2 - corner]];
				winding += vertex.xyz;
				winding[corner].s = vertex.st.x;
				winding[corner].t = vertex.st.y;
			}
			idPlane plane;
			winding.GetPlane( plane );
			if ( plane.Normal().LengthSqr() > 0.0f ) {
				PolygonFromWinding( model, &winding, -plane, surface->shader, i );
			}
		}
	}
	model->isConvex = false;
	FinishModel( model, false );
	models.Append( model );
	return model;
}

idCollisionModel *idCollisionModelManagerLocal::LoadModel( const char *sourceMapName, const char *modelName ) {
	const char *fullName = GetFullModelName( sourceMapName ? sourceMapName : "", modelName );
	idCollisionModelLocal *model = FindModel( fullName );
	if ( model != NULL && model->fileTime != -1 ) {
		if ( IsRenderModelName( model->name.c_str() ) ) {
			++model->refCount;
		}
		return model;
	}
	if ( LoadCollisionModelFile( fullName, 0 ) ) {
		model = FindModel( fullName );
		if ( model != NULL ) {
			return model;
		}
	}
	if ( IsRenderModelName( modelName ) ) {
		idRenderModel *renderModel = renderModelManager->FindModel( modelName );
		if ( renderModel != NULL && !renderModel->IsDefaultModel() ) {
			return ExtractCollisionModel( renderModel, fullName );
		}
	}
	return NULL;
}

void idCollisionModelManagerLocal::LoadMap( const idMapFile *mapFile, bool forceReload ) {
	if ( mapFile == NULL ) {
		common->Error( "idCollisionModelManagerLocal::LoadMap: NULL mapFile" );
	}
	const idStr worldName = GetFullModelName( mapFile->GetName(), "worldMap" );
	idCollisionModelLocal *world = FindModel( worldName );
	if ( world == NULL || world->fileTime == -1 || forceReload ) {
		SetupHash();
		LoadCollisionModelFile( mapFile->GetName(), mapFile->GetGeometryCRC() );
		ShutdownHash();
	}
	loaded = 1;
	mapName = mapFile->GetName();
	mapFileTime = mapFile->GetGeometryCRC();
	AddToMapModelReferenceCounts( mapFile->GetName(), 1 );
}

#endif
