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

#ifndef __AASFILELOCAL_H__
#define __AASFILELOCAL_H__

/*
===============================================================================

	AAS File Local

===============================================================================
*/

class idAASFileLocal : public idAASFile {
	friend class idAASBuild;
	friend class idAASReach;
	friend class idAASCluster;
public:
								idAASFileLocal( void );
	virtual					~idAASFileLocal( void );

	virtual idAASFile *			CreateNew( void );
	virtual idAASSettings *		CreateAASSettings( void );
	virtual idReachability *		CreateReachability( int type );
	virtual bool					FromParser( idAASSettings *edit, Lexer &src );
	virtual const char *			GetName( void ) const;
	virtual unsigned int			GetCRC( void ) const;
	virtual void					SetSizes( sizeEstimate_t size );

	virtual int					GetNumPlanes( void ) const;
	virtual idPlane &				GetPlane( int index );
	virtual int					FindPlane( const idPlane &plane, const float normalEps, const float distEps );
	virtual int					GetNumVertices( void ) const;
	virtual aasVertex_t &			GetVertex( int index );
	virtual int					AppendVertex( aasVertex_t &vertex );
	virtual int					GetNumEdges( void ) const;
	virtual aasEdge_t &			GetEdge( int index );
	virtual int					AppendEdge( aasEdge_t &edge );
	virtual int					GetNumEdgeIndexes( void ) const;
	virtual aasIndex_t &			GetEdgeIndex( int index );
	virtual int					AppendEdgeIndex( aasIndex_t &index );
	virtual int					GetNumFaces( void ) const;
	virtual aasFace_t &			GetFace( int index );
	virtual int					AppendFace( aasFace_t &face );
	virtual int					GetNumFaceIndexes( void ) const;
	virtual aasIndex_t &			GetFaceIndex( int index );
	virtual int					AppendFaceIndex( aasIndex_t &index );
	virtual int					GetNumAreas( void ) const;
	virtual aasArea_t &			GetArea( int index );
	virtual int					AppendArea( aasArea_t &area );
	virtual int					GetNumNodes( void ) const;
	virtual aasNode_t &			GetNode( int index );
	virtual int					AppendNode( aasNode_t &node );
	virtual void					SetNumNodes( int num );
	virtual int					GetNumPortals( void ) const;
	virtual aasPortal_t &			GetPortal( int index );
	virtual int					AppendPortal( aasPortal_t &portal );
	virtual int					GetNumPortalIndexes( void ) const;
	virtual aasIndex_t &			GetPortalIndex( int index );
	virtual int					AppendPortalIndex( aasIndex_t &index, int clusterNum );
	virtual int					GetNumClusters( void ) const;
	virtual aasCluster_t &		GetCluster( int index );
	virtual int					AppendCluster( aasCluster_t &cluster );

	virtual void					ClearTactical( void );
	virtual int					GetNumFeatureIndexes( void ) const;
	virtual aasIndex_t &			GetFeatureIndex( int index );
	virtual int					AppendFeatureIndex( aasIndex_t &index );
	virtual int					GetNumFeatures( void ) const;
	virtual aasFeature_t &		GetFeature( int index );
	virtual int					AppendFeature( aasFeature_t &feature );

	virtual idAASSettings &		GetSettings( void );
	virtual void					SetSettings( const idAASSettings &in );
	virtual void					SetPortalMaxTravelTime( int index, int time );
	virtual void					SetAreaTravelFlag( int index, int flag );
	virtual void					RemoveAreaTravelFlag( int index, int flag );

	virtual idVec3				EdgeCenter( int edgeNum ) const;
	virtual idVec3				FaceCenter( int faceNum ) const;
	virtual idVec3				AreaCenter( int areaNum ) const;
	virtual idBounds			EdgeBounds( int edgeNum ) const;
	virtual idBounds			FaceBounds( int faceNum ) const;
	virtual idBounds			AreaBounds( int areaNum ) const;
	virtual int					PointAreaNum( const idVec3 &origin ) const;
	virtual int					PointReachableAreaNum( const idVec3 &origin, const idBounds &searchBounds, const int areaFlags, const int excludeTravelFlags ) const;
	virtual int					BoundsReachableAreaNum( const idBounds &bounds, const int areaFlags, const int excludeTravelFlags ) const;
	virtual void				PushPointIntoAreaNum( int areaNum, idVec3 &point ) const;
	virtual bool				Trace( aasTrace_t &trace, const idVec3 &start, const idVec3 &end ) const;
	virtual void				PrintInfo( void ) const;
	virtual size_t				GetMemorySize( void );

	virtual void					Init( void );
	virtual bool					Load( const idStr &fileName, unsigned int mapFileCRC );
	virtual bool					Write( const idStr &fileName, unsigned int mapFileCRC );
	virtual void					Clear( void );
	virtual void					FinishAreas( void );
	virtual void					ReportRoutingEfficiency( void ) const;
	virtual void					LinkReversedReachability( void );
	virtual void					DeleteReachabilities( void );
	virtual void					DeleteClusters( void );
	virtual void					Optimize( void );
	virtual bool					IsDummyFile( unsigned int mapFileCRC );
	virtual const idDict &		GetReachabilitySpecialDict( idReachability *reach ) const;
	virtual void					SetReachabilitySpecialDictKeyValue( idReachability *reach, const char *key, const char *value );

	int							MemorySize( void ) const;

private:
	bool						ParseIndex( Lexer &src, idList<aasIndex_t> &indexes, int numIndexes );
	bool						ParsePlanes( Lexer &src, int numPlanes );
	bool						ParseVertices( Lexer &src, int numVertices );
	bool						ParseEdges( Lexer &src, int numEdges );
	bool						ParseFaces( Lexer &src, int numFaces );
	bool						ParseReachabilities( Lexer &src, int areaNum );
	bool						ParseAreas( Lexer &src, int numAreas );
	bool						ParseNodes( Lexer &src, int numNodes );
	bool						ParsePortals( Lexer &src, int numPortals );
	bool						ParseClusters( Lexer &src, int numClusters );
	bool						ParseFeatures( Lexer &src );

#if defined( Q4_RECON_SEED )
	bool						ParseIndex( idLexer &src, idList<aasIndex_t> &indexes );
	bool						ParsePlanes( idLexer &src );
	bool						ParseVertices( idLexer &src );
	bool						ParseEdges( idLexer &src );
	bool						ParseFaces( idLexer &src );
	bool						ParseReachabilities( idLexer &src, int areaNum );
	bool						ParseAreas( idLexer &src );
	bool						ParseNodes( idLexer &src );
	bool						ParsePortals( idLexer &src );
	bool						ParseClusters( idLexer &src );
#endif

	int							BoundsReachableAreaNum_r( int nodeNum, const idBounds &bounds, const int areaFlags, const int excludeTravelFlags ) const;
	void						MaxTreeDepth_r( int nodeNum, int &depth, int &maxDepth ) const;
	int							MaxTreeDepth( void ) const;
	int							AreaContentsTravelFlags( int areaNum ) const;
	idVec3						AreaReachableGoal( int areaNum ) const;
	int							NumReachabilities( void ) const;

	idStr						name;
	idStr						version;
	unsigned int				crc;
	bool						isDummy[11];
	idPlaneSet					planeList;
	idList<aasVertex_t>			vertices;
	idList<aasEdge_t>			edges;
	idList<aasIndex_t>			edgeIndex;
	idList<aasFace_t>			faces;
	idList<aasIndex_t>			faceIndex;
	idList<aasArea_t>			areas;
	idList<aasNode_t>			nodes;
	idList<aasPortal_t>			portals;
	idList<aasIndex_t>			portalIndex;
	idList<aasCluster_t>		clusters;
	idList<aasIndex_t>			featureIndex;
	idList<aasFeature_t>		features;
	idAASSettings				settings;
};

#if defined( _WIN32 )
static_assert( sizeof( idAASFileLocal ) == 0x230, "idAASFileLocal ABI drift" );
#endif

#endif /* !__AASFILELOCAL_H__ */
