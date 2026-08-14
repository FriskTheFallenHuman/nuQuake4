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
#include "tr_local.h"
#include "rvMesh.h"

/*
===============================================================================

	Quake 4 MD5R mesh front end

	The exact 96-byte layout and these function boundaries come from rvMesh.obj
	in quake4.pdb; behavior follows the address-matched retail executable.

===============================================================================
*/

rvMesh::rvMesh() {
	ResetValues();
}

rvMesh::~rvMesh() {
	delete[] m_primBatches;
	ResetValues();
}

void rvMesh::Init( rvRenderModelMD5R &renderModel, Lexer &lexer ) {
	if ( m_renderModel != NULL ) {
		delete[] m_primBatches;
		ResetValues();
	}

	lexer.ExpectTokenString( "{" );
	idToken token;
	if ( !lexer.ReadToken( &token ) ) {
		lexer.Error( "Expected keyword." );
	}
	if ( token.Icmp( "LevelOfDetail" ) == 0 ) {
		m_levelOfDetail = static_cast<short>( lexer.ParseInt() );
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "Material" ) != 0 ) {
		lexer.Error( "Expected Material keyword." );
	}
	lexer.ReadToken( &token );
	m_material = declManager->FindMaterial( token.c_str() );
	if ( !lexer.ReadToken( &token ) ) {
		lexer.Error( "Expected SilhouetteEdge, SilTracePrimBatch or DrawPrimBatch keyword." );
	}

	if ( token.Icmp( "SilTraceBuffers" ) == 0 ) {
		m_silTraceVertexBuffer = static_cast<short>( lexer.ParseInt() );
		m_silTraceIndexBuffer = static_cast<short>( lexer.ParseInt() );
		if ( m_silTraceVertexBuffer >= renderModel.m_numVertexBuffers ||
				m_silTraceIndexBuffer >= renderModel.m_numIndexBuffers ) {
			lexer.Error( "Invalid buffer reference by SilTraceBuffers statement" );
		}
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "DrawBuffers" ) == 0 ) {
		m_drawVertexBuffer = static_cast<short>( lexer.ParseInt() );
		m_drawIndexBuffer = static_cast<short>( lexer.ParseInt() );
		if ( m_drawVertexBuffer >= renderModel.m_numVertexBuffers ||
				m_drawIndexBuffer >= renderModel.m_numIndexBuffers ) {
			lexer.Error( "Invalid buffer reference by DrawBuffers statement" );
		}
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "ShadowVolumeBuffers" ) == 0 ) {
		m_shadowVolVertexBuffer = static_cast<short>( lexer.ParseInt() );
		m_shadowVolIndexBuffer = static_cast<short>( lexer.ParseInt() );
		if ( m_shadowVolVertexBuffer >= renderModel.m_numVertexBuffers ||
				m_shadowVolIndexBuffer >= renderModel.m_numIndexBuffers ) {
			lexer.Error( "Invalid buffer reference by ShadowVolumeBuffers statement" );
		}
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "PrimBatch" ) != 0 ) {
		lexer.Error( "Expected PrimBatch keyword." );
	}
	lexer.ExpectTokenString( "[" );
	m_numPrimBatches = static_cast<short>( lexer.ParseInt() );
	lexer.ExpectTokenString( "]" );
	lexer.ExpectTokenString( "{" );
	m_primBatches = new rvPrimBatch[m_numPrimBatches];
	if ( m_primBatches == NULL ) {
		lexer.Error( "Out of memory" );
		return;
	}
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		lexer.ExpectTokenString( "PrimBatch" );
		m_primBatches[batch].Init( lexer );
	}
	CalcGeometryProfile();
	lexer.ExpectTokenString( "}" );
	lexer.ReadToken( &token );
	if ( token.Icmp( "Bounds" ) == 0 ) {
		m_bounds[0].Set( lexer.ParseFloat(), lexer.ParseFloat(), lexer.ParseFloat() );
		m_bounds[1].Set( lexer.ParseFloat(), lexer.ParseFloat(), lexer.ParseFloat() );
		lexer.ReadToken( &token );
	}
	if ( token.Icmp( "}" ) != 0 ) {
		lexer.Error( "couldn't find expected '}'" );
	}

	m_renderModel = &renderModel;
	if ( m_silTraceVertexBuffer != -1 && m_silTraceIndexBuffer != -1 ) {
		if ( m_drawVertexBuffer != -1 && m_drawIndexBuffer != -1 ) {
			rvVertexBuffer &silTraceVertexBuffer =
				renderModel.m_vertexBuffers[m_silTraceVertexBuffer];
			rvVertexBuffer &drawVertexBuffer = renderModel.m_vertexBuffers[m_drawVertexBuffer];
			if ( silTraceVertexBuffer.IsInitiallyEmpty() &&
					!drawVertexBuffer.IsInitiallyEmpty() ) {
				rvIndexBuffer &silTraceIndexBuffer =
					renderModel.m_indexBuffers[m_silTraceIndexBuffer];
				rvIndexBuffer &drawIndexBuffer = renderModel.m_indexBuffers[m_drawIndexBuffer];
				for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
					m_primBatches[batch].CopySilTraceVertices( silTraceVertexBuffer,
						silTraceIndexBuffer, drawVertexBuffer, drawIndexBuffer );
				}
			}
		}
		if ( m_shadowVolVertexBuffer != -1 ) {
			rvVertexBuffer &shadowVertexBuffer =
				renderModel.m_vertexBuffers[m_shadowVolVertexBuffer];
			if ( shadowVertexBuffer.IsInitiallyEmpty() ) {
				rvVertexBuffer &silTraceVertexBuffer =
					renderModel.m_vertexBuffers[m_silTraceVertexBuffer];
				for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
					m_primBatches[batch].CopyShadowVertices(
						shadowVertexBuffer, silTraceVertexBuffer );
				}
			}
		}
	}
}

void rvMesh::Init( rvRenderModelMD5R &renderModel, modelSurface_t &sourceSurface,
		int *silRemap, int silTraceVertexBuffer, int drawVertexBuffer,
		int shadowVertexBuffer, int silTraceIndexBuffer, int drawIndexBuffer,
		int shadowIndexBuffer ) {
	m_renderModel = &renderModel;
	m_material = sourceSurface.shader;
	srfTriangles_t &source = *sourceSurface.geometry;
	m_numPrimBatches = 1;
	m_primBatches = new rvPrimBatch[1];
	if ( m_primBatches == NULL ) {
		common->FatalError( "Out of memory" );
		return;
	}
	m_primBatches[0].Init( NULL, 1 );
	m_silTraceVertexBuffer = static_cast<short>( silTraceVertexBuffer );
	m_drawVertexBuffer = static_cast<short>( drawVertexBuffer );
	m_shadowVolVertexBuffer = static_cast<short>( shadowVertexBuffer );
	m_silTraceIndexBuffer = static_cast<short>( silTraceIndexBuffer );
	m_drawIndexBuffer = static_cast<short>( drawIndexBuffer );
	m_shadowVolIndexBuffer = source.shadowVertexes != NULL
		? static_cast<short>( shadowIndexBuffer ) : -1;

	if ( source.numVerts != 0 && source.numIndexes != 0 ) {
		unsigned int *silVertexMapOldToNew = NULL;
		if ( source.verts != NULL && m_silTraceVertexBuffer >= 0 &&
				m_silTraceVertexBuffer < renderModel.m_numVertexBuffers &&
				m_silTraceIndexBuffer >= 0 &&
				m_silTraceIndexBuffer < renderModel.m_numIndexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_silTraceVertexBuffer];
			rvIndexBuffer &indexBuffer = renderModel.m_indexBuffers[m_silTraceIndexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			const int indexStart = indexBuffer.GetNumIndicesWritten();
			silVertexMapOldToNew = static_cast<unsigned int *>( _alloca16(
				source.numVerts * sizeof( unsigned int ) ) );
			const int numSilVertices = vertexBuffer.CopySilTraceData(
				silVertexMapOldToNew, vertexStart, source.numVerts,
				silRemap, source.verts );
			indexBuffer.CopyRemappedData( indexStart, source.numIndexes,
				silVertexMapOldToNew, source.indexes, 0 );
			m_primBatches[0].m_silTraceGeoSpec.m_vertexStart = vertexStart;
			m_primBatches[0].m_silTraceGeoSpec.m_vertexCount = numSilVertices;
			m_primBatches[0].m_silTraceGeoSpec.m_indexStart = indexStart;
			m_primBatches[0].m_silTraceGeoSpec.m_primitiveCount = source.numIndexes / 3;
		}

		if ( source.verts != NULL && m_drawVertexBuffer >= 0 &&
				m_drawVertexBuffer < renderModel.m_numVertexBuffers &&
				m_drawIndexBuffer >= 0 &&
				m_drawIndexBuffer < renderModel.m_numIndexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_drawVertexBuffer];
			rvIndexBuffer &indexBuffer = renderModel.m_indexBuffers[m_drawIndexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			const int indexStart = indexBuffer.GetNumIndicesWritten();
			vertexBuffer.CopyData( vertexStart, source.numVerts, source.verts );
			indexBuffer.CopyData( indexStart, source.numIndexes, source.indexes, vertexStart );
			m_primBatches[0].m_drawGeoSpec.m_vertexStart = vertexStart;
			m_primBatches[0].m_drawGeoSpec.m_vertexCount = source.numVerts;
			m_primBatches[0].m_drawGeoSpec.m_indexStart = indexStart;
			m_primBatches[0].m_drawGeoSpec.m_primitiveCount = source.numIndexes / 3;
		}

		if ( m_shadowVolVertexBuffer >= 0 &&
				m_shadowVolVertexBuffer < renderModel.m_numVertexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_shadowVolVertexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			if ( source.verts != NULL ) {
				vertexBuffer.CopyRemappedShadowVolData( vertexStart, source.numVerts,
					silRemap, source.verts );
				m_primBatches[0].m_shadowVolGeoSpec.m_vertexStart = vertexStart;
				m_primBatches[0].m_shadowVolGeoSpec.m_vertexCount =
					m_primBatches[0].m_silTraceGeoSpec.m_vertexCount * 2;
			} else if ( m_shadowVolIndexBuffer >= 0 &&
					m_shadowVolIndexBuffer < renderModel.m_numIndexBuffers ) {
				rvIndexBuffer &indexBuffer = renderModel.m_indexBuffers[m_shadowVolIndexBuffer];
				const int indexStart = indexBuffer.GetNumIndicesWritten();
				vertexBuffer.CopyShadowVolData( vertexStart, source.numVerts,
					source.shadowVertexes );
				indexBuffer.CopyData( indexStart, source.numIndexes,
					source.indexes, vertexStart );
				m_primBatches[0].m_shadowVolGeoSpec.m_vertexStart = vertexStart;
				m_primBatches[0].m_shadowVolGeoSpec.m_vertexCount = source.numVerts;
				m_primBatches[0].m_shadowVolGeoSpec.m_indexStart = indexStart;
				m_primBatches[0].m_shadowVolGeoSpec.m_primitiveCount = source.numIndexes / 3;
				m_primBatches[0].m_numShadowPrimitivesNoCaps =
					source.numShadowIndexesNoCaps / 3;
				m_primBatches[0].m_shadowCapPlaneBits = source.shadowCapPlaneBits;
			}
		}

		if ( source.verts != NULL && source.numSilEdges != 0 &&
				silVertexMapOldToNew != NULL ) {
			const int edgeStart = renderModel.m_numSilEdgesAdded;
			for ( int edge = 0; edge < source.numSilEdges; ++edge ) {
				silEdge_t remappedEdge = source.silEdges[edge];
				remappedEdge.v1 = silVertexMapOldToNew[remappedEdge.v1];
				remappedEdge.v2 = silVertexMapOldToNew[remappedEdge.v2];
				renderModel.m_silEdges[renderModel.m_numSilEdgesAdded++] = remappedEdge;
			}
			m_primBatches[0].m_silEdgeStart = edgeStart;
			m_primBatches[0].m_silEdgeCount = source.numSilEdges;
		}
		CalcGeometryProfile();
		m_bounds = source.bounds;
	}
}

void rvMesh::Init( rvRenderModelMD5R &renderModel, const idMaterial *material,
		int numTransforms, rvBlend4DrawVert *drawVertices, int numDrawVertices,
		int *drawIndices, int numIndices, silEdge_t *silEdges, int numSilEdges,
		int *silRemap, int silTraceVertexBuffer, int drawVertexBuffer,
		int shadowVertexBuffer, int silTraceIndexBuffer, int drawIndexBuffer ) {
	if ( m_renderModel != NULL ) {
		delete[] m_primBatches;
		ResetValues();
	}
	m_material = material;
	m_renderModel = &renderModel;
	if ( numTransforms < 1 ) {
		numTransforms = 1;
	}
	m_silTraceVertexBuffer = static_cast<short>( silTraceVertexBuffer );
	m_silTraceIndexBuffer = static_cast<short>( silTraceIndexBuffer );
	m_drawVertexBuffer = static_cast<short>( drawVertexBuffer );
	m_drawIndexBuffer = static_cast<short>( drawIndexBuffer );
	m_shadowVolVertexBuffer = static_cast<short>( shadowVertexBuffer );
	m_shadowVolIndexBuffer = -1;

	int *batchStarts = static_cast<int *>( _alloca16(
		( numIndices / 3 + 2 ) * sizeof( int ) ) );
	unsigned char *transformUsed = static_cast<unsigned char *>( _alloca16( numTransforms ) );
	SIMDProcessor->Memset( transformUsed, 0, numTransforms );
	int numPrimBatches = 1;
	int transformPaletteSize = 0;
	int index = 0;
	batchStarts[0] = 0;
	while ( index < numIndices ) {
		int addedTransforms[12];
		int numAddedTransforms = 0;
		for ( int corner = 0; corner < 3; ++corner ) {
			const rvBlend4DrawVert &vertex = drawVertices[drawIndices[index + corner]];
			for ( int weight = 0; weight < 4; ++weight ) {
				const int transform = vertex.blendIndex[weight];
				if ( vertex.blendWeight[weight] <= 0.0f || transformUsed[transform] ) {
					continue;
				}
				bool alreadyAdded = false;
				for ( int added = 0; added < numAddedTransforms; ++added ) {
					if ( addedTransforms[added] == transform ) {
						alreadyAdded = true;
						break;
					}
				}
				if ( !alreadyAdded ) {
					addedTransforms[numAddedTransforms++] = transform;
				}
			}
		}
		if ( transformPaletteSize + numAddedTransforms > 25 ) {
			batchStarts[numPrimBatches++] = index;
			SIMDProcessor->Memset( transformUsed, 0, numTransforms );
			transformPaletteSize = 0;
			continue;
		}
		for ( int added = 0; added < numAddedTransforms; ++added ) {
			transformUsed[addedTransforms[added]] = 1;
		}
		transformPaletteSize += numAddedTransforms;
		index += 3;
	}
	batchStarts[numPrimBatches] = numIndices;
	m_numPrimBatches = static_cast<short>( numPrimBatches );
	m_primBatches = new rvPrimBatch[numPrimBatches];
	if ( m_primBatches == NULL ) {
		common->FatalError( "Out of memory" );
		return;
	}

	int *transformPalette = static_cast<int *>( _alloca16( numTransforms * sizeof( int ) ) );
	unsigned int *transformOldToNew = static_cast<unsigned int *>( _alloca16(
		numTransforms * sizeof( unsigned int ) ) );
	unsigned int *drawVertexMapOldToNew = static_cast<unsigned int *>( _alloca16(
		numDrawVertices * sizeof( unsigned int ) ) );
	unsigned int *drawVertexMapNewToOld = static_cast<unsigned int *>( _alloca16(
		numDrawVertices * sizeof( unsigned int ) ) );
	unsigned int *silVertexMapOldToNew = static_cast<unsigned int *>( _alloca16(
		numDrawVertices * sizeof( unsigned int ) ) );
	unsigned int *silVertexMapNewToOld = static_cast<unsigned int *>( _alloca16(
		numDrawVertices * sizeof( unsigned int ) ) );
	unsigned char *silEdgeAdded = static_cast<unsigned char *>( _alloca16( numSilEdges ) );
	SIMDProcessor->Memset( silEdgeAdded, 0, numSilEdges );

	for ( int batch = 0; batch < numPrimBatches; ++batch ) {
		SIMDProcessor->Memset( transformOldToNew, -1,
			numTransforms * sizeof( unsigned int ) );
		SIMDProcessor->Memset( drawVertexMapOldToNew, -1,
			numDrawVertices * sizeof( unsigned int ) );
		SIMDProcessor->Memset( silVertexMapOldToNew, -1,
			numDrawVertices * sizeof( unsigned int ) );
		int numBatchDrawVertices = 0;
		int numBatchSilVertices = 0;
		int numBatchTransforms = 0;
		for ( int batchIndex = batchStarts[batch];
				batchIndex < batchStarts[batch + 1]; ++batchIndex ) {
			const unsigned int oldVertex = drawIndices[batchIndex];
			if ( drawVertexMapOldToNew[oldVertex] != UINT_MAX ) {
				continue;
			}
			const unsigned int oldSilVertex = silRemap[oldVertex];
			if ( silVertexMapOldToNew[oldSilVertex] == UINT_MAX ) {
				silVertexMapOldToNew[oldSilVertex] = numBatchSilVertices;
				silVertexMapNewToOld[numBatchSilVertices++] = oldSilVertex;
			}
			silVertexMapOldToNew[oldVertex] = silVertexMapOldToNew[oldSilVertex];
			drawVertexMapOldToNew[oldVertex] = numBatchDrawVertices;
			drawVertexMapNewToOld[numBatchDrawVertices++] = oldVertex;
			const rvBlend4DrawVert &vertex = drawVertices[oldVertex];
			for ( int weight = 0; weight < 4; ++weight ) {
				const int transform = vertex.blendIndex[weight];
				if ( vertex.blendWeight[weight] > 0.0f &&
						transformOldToNew[transform] == UINT_MAX ) {
					transformPalette[numBatchTransforms] = transform;
					transformOldToNew[transform] = numBatchTransforms++;
				}
			}
		}
		m_primBatches[batch].Init( transformPalette, numBatchTransforms );
		for ( int transform = 0; transform < numTransforms; ++transform ) {
			if ( transformOldToNew[transform] == UINT_MAX ) {
				transformOldToNew[transform] = 0;
			}
		}
		const int batchIndexStart = batchStarts[batch];
		const int batchIndexCount = batchStarts[batch + 1] - batchIndexStart;

		if ( m_silTraceVertexBuffer >= 0 &&
				m_silTraceVertexBuffer < renderModel.m_numVertexBuffers &&
				m_silTraceIndexBuffer >= 0 &&
				m_silTraceIndexBuffer < renderModel.m_numIndexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_silTraceVertexBuffer];
			rvIndexBuffer &indexBuffer = renderModel.m_indexBuffers[m_silTraceIndexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			const int indexStart = indexBuffer.GetNumIndicesWritten();
			vertexBuffer.CopyRemappedData( vertexStart, numBatchSilVertices,
				silVertexMapNewToOld, transformOldToNew, drawVertices, true );
			indexBuffer.CopyRemappedData( indexStart, batchIndexCount,
				silVertexMapOldToNew, drawIndices + batchIndexStart, 0 );
			m_primBatches[batch].m_silTraceGeoSpec.m_vertexStart = vertexStart;
			m_primBatches[batch].m_silTraceGeoSpec.m_vertexCount = numBatchSilVertices;
			m_primBatches[batch].m_silTraceGeoSpec.m_indexStart = indexStart;
			m_primBatches[batch].m_silTraceGeoSpec.m_primitiveCount = batchIndexCount / 3;
		}
		if ( m_drawVertexBuffer >= 0 &&
				m_drawVertexBuffer < renderModel.m_numVertexBuffers &&
				m_drawIndexBuffer >= 0 &&
				m_drawIndexBuffer < renderModel.m_numIndexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_drawVertexBuffer];
			rvIndexBuffer &indexBuffer = renderModel.m_indexBuffers[m_drawIndexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			const int indexStart = indexBuffer.GetNumIndicesWritten();
			vertexBuffer.CopyRemappedData( vertexStart, numBatchDrawVertices,
				drawVertexMapNewToOld, transformOldToNew, drawVertices, false );
			indexBuffer.CopyRemappedData( indexStart, batchIndexCount,
				drawVertexMapOldToNew, drawIndices + batchIndexStart, vertexStart );
			m_primBatches[batch].m_drawGeoSpec.m_vertexStart = vertexStart;
			m_primBatches[batch].m_drawGeoSpec.m_vertexCount = numBatchDrawVertices;
			m_primBatches[batch].m_drawGeoSpec.m_indexStart = indexStart;
			m_primBatches[batch].m_drawGeoSpec.m_primitiveCount = batchIndexCount / 3;
		}
		if ( m_shadowVolVertexBuffer >= 0 &&
				m_shadowVolVertexBuffer < renderModel.m_numVertexBuffers ) {
			rvVertexBuffer &vertexBuffer = renderModel.m_vertexBuffers[m_shadowVolVertexBuffer];
			const int vertexStart = vertexBuffer.GetNumVerticesWritten();
			vertexBuffer.CopyRemappedShadowVolData( vertexStart, numBatchSilVertices,
				silVertexMapNewToOld, transformOldToNew, drawVertices );
			m_primBatches[batch].m_shadowVolGeoSpec.m_vertexStart = vertexStart;
			m_primBatches[batch].m_shadowVolGeoSpec.m_vertexCount = numBatchSilVertices * 2;
		}
		if ( numSilEdges != 0 ) {
			const int edgeStart = renderModel.m_numSilEdgesAdded;
			for ( int edge = 0; edge < numSilEdges; ++edge ) {
				if ( silEdgeAdded[edge] ) {
					continue;
				}
				const silEdge_t &sourceEdge = silEdges[edge];
				if ( silVertexMapOldToNew[sourceEdge.v1] == UINT_MAX ||
						silVertexMapOldToNew[sourceEdge.v2] == UINT_MAX ) {
					continue;
				}
				silEdge_t &destEdge = renderModel.m_silEdges[renderModel.m_numSilEdgesAdded++];
				destEdge.p1 = sourceEdge.p1;
				destEdge.p2 = sourceEdge.p2;
				destEdge.v1 = silVertexMapOldToNew[sourceEdge.v1];
				destEdge.v2 = silVertexMapOldToNew[sourceEdge.v2];
				silEdgeAdded[edge] = 1;
			}
			m_primBatches[batch].m_silEdgeStart = edgeStart;
			m_primBatches[batch].m_silEdgeCount =
				renderModel.m_numSilEdgesAdded - edgeStart;
		}
	}
	CalcGeometryProfile();
}

void rvMesh::UpdateSurface( modelSurface_t &surface, const renderEntity_t &entity,
		idJointMat *skinSpaceToLocalMats ) {
	surface.shader = m_material;
	if ( surface.geometry == NULL ||
			( surface.geometry->verts == NULL &&
			( surface.geometry->silTraceVerts == NULL ||
			  surface.geometry->numVerts != m_numSilTraceVertices ||
			  surface.geometry->numIndexes != m_numSilTraceIndices ) ) ) {
		if ( surface.geometry != NULL ) {
			R_FreeStaticTriSurf( surface.geometry );
		}
		surface.geometry = R_AllocStaticTriSurf();
	} else {
		R_FreeStaticTriSurfVertexCaches( surface.geometry );
	}

	srfTriangles_t &tri = *surface.geometry;
	tri.deformedSurface = true;
	tri.tangentsCalculated = true;
	tri.facePlanesCalculated = false;
	tri.numVerts = m_numSilTraceVertices;
	tri.numIndexes = m_numSilTraceIndices;
	tri.primBatchMesh = this;
	tri.numSilEdges = m_numSilEdges;
	tri.silEdges = &m_renderModel->m_silEdges[m_primBatches[0].m_silEdgeStart];
	if ( tri.silTraceVerts == NULL ) {
		R_AllocStaticTriSurfSilTraceVerts( &tri, m_numSilTraceVertices );
	}
	R_AllocStaticSkinToModelTransforms( &tri, m_numTransforms );
	tri.bounds.Clear();
	rvVertexBuffer &silTraceVertexBuffer =
		m_renderModel->m_vertexBuffers[m_silTraceVertexBuffer];
	int vertexBase = 0;
	int transformBase = 0;
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		idVec3 batchMin;
		idVec3 batchMax;
		m_primBatches[batch].TransformVertsMinMax( tri.silTraceVerts + vertexBase,
			batchMin, batchMax, silTraceVertexBuffer, skinSpaceToLocalMats,
			entity.joints, tri.skinToModelTransforms + transformBase * 16 );
		tri.bounds.AddPoint( batchMin );
		tri.bounds.AddPoint( batchMax );
		vertexBase += m_primBatches[batch].m_silTraceGeoSpec.m_vertexCount;
		transformBase += m_primBatches[batch].m_numTransforms;
	}
	m_drawSetUp = false;
}

void rvMesh::UpdateSurface( modelSurface_t &surface ) {
	surface.shader = m_material;
	if ( surface.geometry == NULL ||
			( surface.geometry->verts == NULL &&
			( surface.geometry->silTraceVerts == NULL ||
			  surface.geometry->numVerts != m_numSilTraceVertices ||
			  surface.geometry->numIndexes != m_numSilTraceIndices ) ) ) {
		if ( surface.geometry != NULL ) {
			R_FreeStaticTriSurf( surface.geometry );
		}
		surface.geometry = R_AllocStaticTriSurf();
	} else {
		R_FreeStaticTriSurfVertexCaches( surface.geometry );
	}

	srfTriangles_t &tri = *surface.geometry;
	tri.deformedSurface = false;
	tri.tangentsCalculated = true;
	tri.facePlanesCalculated = false;
	tri.primBatchMesh = this;
	if ( m_numSilTraceVertices != 0 ) {
		tri.numVerts = m_numSilTraceVertices;
		tri.numIndexes = m_numSilTraceIndices;
		tri.numSilEdges = m_numSilEdges;
		tri.silEdges = &m_renderModel->m_silEdges[m_primBatches[0].m_silEdgeStart];
		tri.silTraceVerts = m_renderModel->m_vertexBuffers[m_silTraceVertexBuffer]
			.GetSilTraceVertexArray( m_primBatches[0].m_silTraceGeoSpec.m_vertexStart );
		if ( !m_bounds.IsCleared() ) {
			tri.bounds = m_bounds;
		} else {
			SIMDProcessor->MinMax( tri.bounds[0], tri.bounds[1],
				tri.silTraceVerts, m_numSilTraceVertices );
		}
	} else {
		int numVerts = 0;
		int numIndexes = 0;
		int numIndexesNoCaps = 0;
		for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
			numVerts += m_primBatches[batch].m_shadowVolGeoSpec.m_vertexCount;
			numIndexes += m_primBatches[batch].m_shadowVolGeoSpec.m_primitiveCount * 3;
			numIndexesNoCaps += m_primBatches[batch].m_numShadowPrimitivesNoCaps * 3;
		}
		tri.numVerts = numVerts;
		tri.numIndexes = numIndexes;
		tri.numShadowIndexesNoCaps = numIndexesNoCaps;
		tri.numShadowIndexesNoFrontCaps = numIndexes;
		tri.shadowCapPlaneBits = m_primBatches[0].m_shadowCapPlaneBits;
		tri.bounds = m_bounds;
	}
}

void rvMesh::ResetValues() {
	m_bounds.Clear();
	m_renderModel = NULL;
	m_material = NULL;
	m_nextInLOD = NULL;
	m_primBatches = NULL;
	m_numPrimBatches = 0;
	m_levelOfDetail = -1;
	m_surfaceNum = -1;
	m_meshIdentifier = 0;
	m_silTraceVertexBuffer = -1;
	m_silTraceIndexBuffer = -1;
	m_drawVertexBuffer = -1;
	m_drawIndexBuffer = -1;
	m_shadowVolVertexBuffer = -1;
	m_shadowVolIndexBuffer = -1;
	m_numSilTraceVertices = 0;
	m_numSilTraceIndices = 0;
	m_numSilTracePrimitives = 0;
	m_numSilEdges = 0;
	m_numDrawVertices = 0;
	m_numDrawIndices = 0;
	m_numDrawPrimitives = 0;
	m_numTransforms = 0;
	m_drawSetUp = false;
}

int rvMesh::FlipOutsideBackFaces( srfCullInfo_t &cullInfo ) {
	unsigned char *facing = cullInfo.facing;
	const unsigned char *cullBits = cullInfo.cullBits;
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	int numRemaining = 0;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		numRemaining += m_primBatches[i].FlipOutsideBackFaces(
			facing, cullBits, indexBuffer );
		facing += m_primBatches[i].m_silTraceGeoSpec.m_primitiveCount;
		cullBits += m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
	}
	return numRemaining;
}

void rvMesh::CalcGeometryProfile() {
	m_numSilTraceVertices = 0;
	m_numSilTraceIndices = 0;
	m_numSilTracePrimitives = 0;
	m_numSilEdges = 0;
	m_numDrawVertices = 0;
	m_numDrawIndices = 0;
	m_numDrawPrimitives = 0;
	m_numTransforms = 0;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		const rvPrimBatch &batch = m_primBatches[i];
		m_numSilTraceVertices += batch.m_silTraceGeoSpec.m_vertexCount;
		m_numSilTraceIndices += batch.m_silTraceGeoSpec.m_primitiveCount * 3;
		m_numSilTracePrimitives += batch.m_silTraceGeoSpec.m_primitiveCount;
		m_numSilEdges += batch.m_silEdgeCount;
		m_numDrawVertices += batch.m_drawGeoSpec.m_vertexCount;
		m_numDrawIndices += batch.m_drawGeoSpec.m_primitiveCount * 3;
		m_numDrawPrimitives += batch.m_drawGeoSpec.m_primitiveCount;
		m_numTransforms += static_cast<short>( batch.m_numTransforms );
	}
}

void rvMesh::Draw( const float *skinToModelTransforms,
		const rvVertexFormat *vertexComponentsNeeded ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		rvPrimBatch &batch = m_primBatches[i];
		batch.LoadMatrixPaletteIntoVPParams( skinToModelTransforms );
		batch.Draw( vertexBuffer, indexBuffer, vertexComponentsNeeded );
		skinToModelTransforms += batch.m_numTransforms * 16;
	}
	m_drawSetUp = false;
}

void rvMesh::Draw( const float *skinToModelTransforms, int *indices, int,
		const rvVertexFormat *vertexComponentsNeeded ) {
	int *batchIndices = indices + m_numPrimBatches;
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		rvPrimBatch &batch = m_primBatches[i];
		batch.LoadMatrixPaletteIntoVPParams( skinToModelTransforms );
		batch.Draw( vertexBuffer, batchIndices, indices[i], vertexComponentsNeeded );
		skinToModelTransforms += batch.m_numTransforms * 16;
		batchIndices += indices[i];
	}
	m_drawSetUp = false;
}

void rvMesh::DrawShadowVolume( const float *skinToModelTransforms, int *indices,
		bool drawCaps, const rvVertexFormat *vertexComponentsNeeded ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_shadowVolVertexBuffer];
	if ( indices == NULL ) {
		if ( m_shadowVolIndexBuffer < 0 ) {
			return;
		}
		rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_shadowVolIndexBuffer];
		for ( int i = 0; i < m_numPrimBatches; ++i ) {
			rvPrimBatch &batch = m_primBatches[i];
			batch.LoadMatrixPaletteIntoVPParams( skinToModelTransforms );
			batch.DrawShadowVolume( vertexBuffer, indexBuffer, drawCaps, vertexComponentsNeeded );
			skinToModelTransforms += batch.m_numTransforms * 16;
		}
		m_drawSetUp = false;
		return;
	}

	int *batchIndices = indices + m_numPrimBatches * 2;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		const int numIndices = indices[i * 2 + ( drawCaps ? 1 : 0 )];
		rvPrimBatch &batch = m_primBatches[i];
		if ( numIndices > 0 ) {
			batch.LoadMatrixPaletteIntoVPParams( skinToModelTransforms );
			batch.DrawShadowVolume( vertexBuffer, batchIndices, numIndices,
				vertexComponentsNeeded );
		}
		skinToModelTransforms += batch.m_numTransforms * 16;
		batchIndices += indices[i * 2 + 1];
	}
	m_drawSetUp = false;
}

void rvMesh::DeriveTriPlanes( idPlane *planes,
		const rvSilTraceVertT *silTraceVerts ) {
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].DeriveTriPlanes( planes, silTraceVerts, indexBuffer );
		silTraceVerts += m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
		planes += m_primBatches[i].m_silTraceGeoSpec.m_primitiveCount;
	}
}

bool rvMesh::PreciseCullSurface( idBounds &ndcBounds,
		const rvSilTraceVertT *silTraceVerts, const idVec3 &localView,
		const float *modelMatrix ) {
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		if ( m_primBatches[i].PreciseCullSurface( ndcBounds, silTraceVerts,
				localView, modelMatrix, indexBuffer ) ) {
			return true;
		}
		silTraceVerts += m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
	}
	return false;
}

int rvMesh::CreateSilShadowVolTris( int primBatch, int *shadowIndices,
		const unsigned char *facing ) {
	return m_primBatches[primBatch].CreateSilShadowVolTris(
		shadowIndices, facing, m_renderModel->m_silEdges );
}

int rvMesh::CreateFrontBackShadowVolTris( int primBatch, int *shadowIndices,
		const unsigned char *facing ) {
	return m_primBatches[primBatch].CreateFrontBackShadowVolTris(
		shadowIndices, facing, m_renderModel->m_indexBuffers[m_silTraceIndexBuffer] );
}

int rvMesh::GetNearestJoint( int silTraceIndex0, int silTraceIndex1,
		int silTraceIndex2 ) const {
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		const primBatchGeoSpec_s &geo = m_primBatches[i].m_silTraceGeoSpec;
		if ( silTraceIndex0 >= geo.m_indexStart &&
				silTraceIndex0 < geo.m_indexStart + geo.m_primitiveCount * 3 ) {
			return m_primBatches[i].GetNearestJoint( silTraceIndex0,
				silTraceIndex1, silTraceIndex2,
				m_renderModel->m_vertexBuffers[m_silTraceVertexBuffer],
				m_renderModel->m_indexBuffers[m_silTraceIndexBuffer] );
		}
	}
	return 0;
}

void rvMesh::LocalTrace( localTrace_t &hit, int &testPlanes, int &testEdges,
		int &intersections, const idVec3 &start, const idVec3 &end,
		const unsigned char *cullBits, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts, float radius,
		const idMaterial *material ) {
	rvIndexBuffer &silTraceIndexBuffer =
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	testPlanes = 0;
	testEdges = 0;
	intersections = 0;
	int lastIntersectBatch = -1;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		int batchIntersections = 0;
		m_primBatches[i].LocalTrace( hit, testPlanes, testEdges, batchIntersections,
			start, end, cullBits, facePlanes, silTraceVerts, radius,
			silTraceIndexBuffer, drawIndexBuffer );
		if ( batchIntersections != 0 ) {
			lastIntersectBatch = i;
			intersections += batchIntersections;
		}
		const primBatchGeoSpec_s &geo = m_primBatches[i].m_silTraceGeoSpec;
		cullBits += geo.m_vertexCount;
		silTraceVerts += geo.m_vertexCount;
		facePlanes += geo.m_primitiveCount;
	}
	if ( intersections != 0 ) {
		hit.materialType = m_primBatches[lastIntersectBatch].GetMaterialType(
			material, hit, m_renderModel->m_vertexBuffers[m_drawVertexBuffer] );
	}
}

void rvMesh::CreateLightTris( srfTriangles_t &newTri, int &backFaced,
		int &distanceCulled, srfCullInfo_t &cullInfo,
		const rvSilTraceVertT *silTraceVerts, bool includeBackFaces ) {
	rvIndexBuffer &silTraceIndexBuffer =
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	R_AllocStaticTriSurfIndexes( &newTri, m_numSilTraceIndices + m_numPrimBatches );
	newTri.bounds.Clear();

	int numIndices = 0;
	int *batchCounts = newTri.indexes;
	int *destIndices = newTri.indexes + m_numPrimBatches;
	const unsigned char *facing = cullInfo.facing;
	const unsigned char *cullBits = cullInfo.cullBits;
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		int batchIndexCount = 0;
		int batchBackFaced = 0;
		int batchDistanceCulled = 0;
		idBounds batchBounds;
		m_primBatches[batch].CreateLightTris( destIndices, batchIndexCount,
			batchBounds, batchBackFaced, batchDistanceCulled, facing, cullBits,
			cullInfo.localClipPlanes, silTraceVerts, includeBackFaces,
			silTraceIndexBuffer, drawIndexBuffer );
		batchCounts[batch] = batchIndexCount;
		numIndices += batchIndexCount;
		backFaced += batchBackFaced;
		distanceCulled += batchDistanceCulled;
		if ( batchIndexCount != 0 ) {
			newTri.bounds.AddBounds( batchBounds );
		}
		destIndices += batchIndexCount;
		facing += m_primBatches[batch].m_silTraceGeoSpec.m_primitiveCount;
		cullBits += m_primBatches[batch].m_silTraceGeoSpec.m_vertexCount;
		silTraceVerts += m_primBatches[batch].m_silTraceGeoSpec.m_vertexCount;
	}
	R_ResizeStaticTriSurfIndexes( &newTri,
		numIndices != 0 ? numIndices + m_numPrimBatches : 0 );
	newTri.numIndexes = numIndices;
}

void rvMesh::CreateFrontFaceTris( srfTriangles_t &newTri, int &backFaced,
		srfCullInfo_t &cullInfo, const rvSilTraceVertT *silTraceVerts ) {
	rvIndexBuffer &silTraceIndexBuffer =
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	R_AllocStaticTriSurfIndexes( &newTri, m_numSilTraceIndices + m_numPrimBatches );
	newTri.bounds.Clear();

	int numIndices = 0;
	int *batchCounts = newTri.indexes;
	int *destIndices = newTri.indexes + m_numPrimBatches;
	const unsigned char *facing = cullInfo.facing;
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		int batchIndexCount = 0;
		int batchBackFaced = 0;
		idBounds batchBounds;
		m_primBatches[batch].CreateFrontFaceTris( destIndices, batchIndexCount,
			batchBounds, batchBackFaced, facing, silTraceVerts,
			silTraceIndexBuffer, drawIndexBuffer );
		batchCounts[batch] = batchIndexCount;
		numIndices += batchIndexCount;
		backFaced += batchBackFaced;
		if ( batchIndexCount != 0 ) {
			newTri.bounds.AddBounds( batchBounds );
		}
		destIndices += batchIndexCount;
		facing += m_primBatches[batch].m_silTraceGeoSpec.m_primitiveCount;
		silTraceVerts += m_primBatches[batch].m_silTraceGeoSpec.m_vertexCount;
	}
	R_ResizeStaticTriSurfIndexes( &newTri,
		numIndices != 0 ? numIndices + m_numPrimBatches : 0 );
	newTri.numIndexes = numIndices;
}

void rvMesh::CreateOverlayTriangles( overlayVertex_t *overlayVerts,
		int &numVerts, int *overlayIndices, int &numIndices,
		const idPlane *planes, const rvSilTraceVertT *silTraceVerts ) {
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	int vertexBase = 0;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		const int vertexCount = m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
		unsigned char *cullBits = static_cast<unsigned char *>(
			_alloca16( vertexCount * sizeof( unsigned char ) ) );
		idVec2 *textureCoordinates = static_cast<idVec2 *>(
			_alloca16( vertexCount * sizeof( idVec2 ) ) );
		SIMDProcessor->OverlayPointCull( cullBits, textureCoordinates,
			planes, silTraceVerts, vertexCount );
		m_primBatches[i].FindOverlayTriangles( overlayVerts, numVerts,
			overlayIndices, numIndices, cullBits, textureCoordinates,
			vertexBase, indexBuffer );
		vertexBase += vertexCount;
		silTraceVerts += vertexCount;
	}
}

void rvMesh::CreateDecalTriangles( idRenderModelDecal &decalModel,
		const decalProjectionInfo_t &localInfo, const idPlane *facePlanes,
		const rvSilTraceVertT *silTraceVerts ) {
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].FindDecalTriangles( decalModel, localInfo,
			facePlanes, silTraceVerts, indexBuffer );
		const primBatchGeoSpec_s &geo = m_primBatches[i].m_silTraceGeoSpec;
		silTraceVerts += geo.m_vertexCount;
		if ( facePlanes != NULL ) {
			facePlanes += geo.m_primitiveCount;
		}
	}
}

void rvMesh::GenerateCollisionPolys( idCollisionModelManagerLocal &modelManager,
		idCollisionModelLocal &collisionModel ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].GenerateCollisionPolys( modelManager, collisionModel,
			*m_material, vertexBuffer, indexBuffer );
	}
}

void rvMesh::CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		const rvSilTraceVertT *silTraceVerts ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	rvIndexBuffer &silTraceIndexBuffer =
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	int destBase = 0;
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].CopyTriangles( destDrawVerts, destIndices,
			vertexBuffer, drawIndexBuffer, silTraceVerts, silTraceIndexBuffer,
			destBase );
		destBase += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destDrawVerts += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destIndices += m_primBatches[i].m_drawGeoSpec.m_primitiveCount * 3;
		silTraceVerts += m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
	}
}

void rvMesh::CopyTriangles( idDrawVert *destDrawVerts, int *destIndices,
		int destBase ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].CopyDrawVertices( destDrawVerts, vertexBuffer );
		m_primBatches[i].CopyDrawIndices( destIndices, indexBuffer, destBase );
		destBase += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destDrawVerts += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destIndices += m_primBatches[i].m_drawGeoSpec.m_primitiveCount * 3;
	}
}

void rvMesh::TransformTriangles( idDrawVert *destDrawVerts, int *destIndices,
		const idMat4 &transform, int colorShift, unsigned char *colorAdd,
		int destBase ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].TransformDrawVertices( destDrawVerts, vertexBuffer,
			transform, colorShift, colorAdd );
		m_primBatches[i].CopyDrawIndices( destIndices, indexBuffer, destBase );
		destBase += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destDrawVerts += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destIndices += m_primBatches[i].m_drawGeoSpec.m_primitiveCount * 3;
	}
}

void rvMesh::TubeDeform( idDrawVert *destDrawVerts, int *destIndices,
		const idVec3 &localView, const rvSilTraceVertT *silTraceVerts ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	rvIndexBuffer &silTraceIndexBuffer =
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];
	for ( int i = 0; i < m_numPrimBatches; ++i ) {
		m_primBatches[i].TubeDeform( destDrawVerts, destIndices, localView,
			vertexBuffer, drawIndexBuffer, silTraceVerts, silTraceIndexBuffer );
		destDrawVerts += m_primBatches[i].m_drawGeoSpec.m_vertexCount;
		destIndices += m_primBatches[i].m_drawGeoSpec.m_primitiveCount * 3;
		silTraceVerts += m_primBatches[i].m_silTraceGeoSpec.m_vertexCount;
	}
}

const rvVertexFormat *rvMesh::GetDrawVertexBufferFormat() const {
	if ( m_drawVertexBuffer < 0 ) {
		return NULL;
	}
	return &m_renderModel->m_vertexBuffers[m_drawVertexBuffer].GetFormat();
}

const rvVertexFormat *rvMesh::GetShadowVolVertexBufferFormat() const {
	if ( m_shadowVolVertexBuffer < 0 ) {
		return NULL;
	}
	return &m_renderModel->m_vertexBuffers[m_shadowVolVertexBuffer].GetFormat();
}

void rvMesh::PlaneForSurface( idPlane &destPlane,
		const rvSilTraceVertT *silTraceVerts ) {
	m_primBatches[0].PlaneForSurface( destPlane, silTraceVerts,
		m_renderModel->m_indexBuffers[m_silTraceIndexBuffer] );
}

void rvMesh::SetupForDrawRender( const rvVertexFormat *vertexComponentsNeeded ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	vertexBuffer.SetupForRender( 0,
		vertexComponentsNeeded != NULL ? *vertexComponentsNeeded : vertexBuffer.GetFormat() );
	if ( indexBuffer.IsVideoMemory() ) {
		qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, indexBuffer.GetBufferId() );
	}
	m_drawSetUp = true;
}

void rvMesh::SetupForShadowVolRender( const rvVertexFormat *vertexComponentsNeeded ) {
	rvVertexBuffer &vertexBuffer = m_renderModel->m_vertexBuffers[m_shadowVolVertexBuffer];
	vertexBuffer.SetupForRender( 0,
		vertexComponentsNeeded != NULL ? *vertexComponentsNeeded : vertexBuffer.GetFormat() );
	if ( m_shadowVolIndexBuffer != -1 ) {
		rvIndexBuffer &indexBuffer = m_renderModel->m_indexBuffers[m_shadowVolIndexBuffer];
		if ( indexBuffer.IsVideoMemory() ) {
			qglBindBufferARB( GL_ELEMENT_ARRAY_BUFFER_ARB, indexBuffer.GetBufferId() );
		}
	}
}

void rvMesh::ScreenRectFromDrawSurf( idScreenRect &destRect,
		const float *modelMatrix, float *viewMatrix, float *projectionMatrix,
		const idScreenRect &viewport, const rvSilTraceVertT *silTraceVerts ) const {
	for ( int vertex = 0; vertex < m_numSilTraceVertices; ++vertex ) {
		idVec3 global;
		R_LocalPointToGlobal( modelMatrix, silTraceVerts[vertex].xyzw.ToVec3(), global );

		idPlane view;
		idPlane clip;
		for ( int component = 0; component < 4; ++component ) {
			view[component] = global[0] * viewMatrix[component + 0 * 4] +
				global[1] * viewMatrix[component + 1 * 4] +
				global[2] * viewMatrix[component + 2 * 4] +
				viewMatrix[component + 3 * 4];
		}
		for ( int component = 0; component < 4; ++component ) {
			clip[component] = view[0] * projectionMatrix[component + 0 * 4] +
				view[1] * projectionMatrix[component + 1 * 4] +
				view[2] * projectionMatrix[component + 2 * 4] +
				view[3] * projectionMatrix[component + 3 * 4];
		}
		const idVec3 ndc( clip[0] / clip[3], clip[1] / clip[3],
			( clip[2] + clip[3] ) / ( 2.0f * clip[3] ) );
		const float x = ( viewport.x2 - viewport.x1 ) * ( ndc.x + 1.0f ) * 0.5f;
		const float y = viewport.y2 -
			( viewport.y2 - viewport.y1 ) * ( ndc.y + 1.0f ) * 0.5f;
		destRect.AddPoint( x, y );
	}
}

void rvMesh::Write( idFile &outFile, const char *prepend ) {
	idStr indent = prepend;
	indent += "\t";
	outFile.WriteFloatString( "%sMesh\n%s{\n", prepend, prepend );
	if ( m_levelOfDetail != -1 ) {
		outFile.WriteFloatString( "%sLevelOfDetail %d\n", indent.c_str(), m_levelOfDetail );
	}
	if ( m_material != NULL ) {
		outFile.WriteFloatString( "%sMaterial \"%s\"\n", indent.c_str(), m_material->GetName() );
	}
	if ( m_levelOfDetail >= 0 ) {
		outFile.WriteFloatString( "%sLevelOfDetail %d\n", indent.c_str(), m_levelOfDetail );
	}
	if ( m_silTraceVertexBuffer >= 0 || m_silTraceIndexBuffer >= 0 ) {
		outFile.WriteFloatString( "%sSilTraceBuffers %d %d\n", indent.c_str(),
			m_silTraceVertexBuffer, m_silTraceIndexBuffer );
	}
	if ( m_drawVertexBuffer >= 0 || m_drawIndexBuffer >= 0 ) {
		outFile.WriteFloatString( "%sDrawBuffers %d %d\n", indent.c_str(),
			m_drawVertexBuffer, m_drawIndexBuffer );
	}
	if ( m_shadowVolVertexBuffer >= 0 || m_shadowVolIndexBuffer >= 0 ) {
		outFile.WriteFloatString( "%sShadowVolumeBuffers %d %d\n", indent.c_str(),
			m_shadowVolVertexBuffer, m_shadowVolIndexBuffer );
	}
	outFile.WriteFloatString( "%sPrimBatch[ %d ]\n%s{\n", indent.c_str(),
		m_numPrimBatches, indent.c_str() );
	idStr batchIndent = indent;
	batchIndent += "\t";
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		m_primBatches[batch].Write( outFile, batchIndent.c_str() );
	}
	outFile.WriteFloatString( "%s}\n", indent.c_str() );
	if ( !m_bounds.IsCleared() ) {
		outFile.WriteFloatString( "%sBounds %f %f %f  %f %f %f\n", indent.c_str(),
			m_bounds[0].x, m_bounds[0].y, m_bounds[0].z,
			m_bounds[1].x, m_bounds[1].y, m_bounds[1].z );
	}
	outFile.WriteFloatString( "%s}\n", prepend );
}

void rvMesh::SurfaceToTextureAxis( idVec3 &origin, idVec3 axis[3],
		const rvSilTraceVertT *silTraceVerts ) {
	rvVertexBuffer &drawVertexBuffer = m_renderModel->m_vertexBuffers[m_drawVertexBuffer];
	rvIndexBuffer &drawIndexBuffer = m_renderModel->m_indexBuffers[m_drawIndexBuffer];
	rvIndexBuffer &silTraceIndexBuffer = m_renderModel->m_indexBuffers[m_silTraceIndexBuffer];

	float bounds[2][2] = {
		{ 999999.0f, 999999.0f },
		{ -999999.0f, -999999.0f }
	};
	for ( int batch = 0; batch < m_numPrimBatches; ++batch ) {
		m_primBatches[batch].GetTextureBounds( bounds, drawVertexBuffer );
	}
	const float boundsOrigin[2] = {
		idMath::Floor( ( bounds[0][0] + bounds[1][0] ) * 0.5f ),
		idMath::Floor( ( bounds[0][1] + bounds[1][1] ) * 0.5f )
	};

	idDrawVert a;
	idDrawVert b;
	idDrawVert c;
	m_primBatches[0].GetTriangle( a, b, c, 0, drawVertexBuffer,
		drawIndexBuffer, silTraceVerts, silTraceIndexBuffer );
	const idVec3 d0 = b.xyz - a.xyz;
	const idVec3 d1 = c.xyz - a.xyz;
	const float ds0 = b.st.x - a.st.x;
	const float dt0 = b.st.y - a.st.y;
	const float ds1 = c.st.x - a.st.x;
	const float dt1 = c.st.y - a.st.y;
	const float area = ds0 * dt1 - dt0 * ds1;
	if ( area == 0.0f ) {
		axis[0].Zero();
		axis[1].Zero();
		axis[2].Zero();
		return;
	}
	const float invArea = 1.0f / area;
	axis[0] = ( d0 * dt1 - d1 * dt0 ) * invArea;
	axis[1] = ( d1 * ds0 - d0 * ds1 ) * invArea;
	idPlane plane;
	plane.FromPoints( a.xyz, b.xyz, c.xyz );
	axis[2] = plane.Normal();
	origin = a.xyz + ( boundsOrigin[0] - a.st.x ) * axis[0];
	origin += ( boundsOrigin[1] - a.st.y ) * axis[1];
}
