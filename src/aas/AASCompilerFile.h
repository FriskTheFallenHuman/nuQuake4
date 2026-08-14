/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

===========================================================================
*/

#ifndef __AASCOMPILERFILE_H__
#define __AASCOMPILERFILE_H__

#include "AASFile.h"

/*
===============================================================================

	Compiler-facing adapter for the Quake 4 idAASFile interface.

	The Doom 3 compiler operated directly on idAASFileLocal's idList members.
	Quake 4 deliberately exposes the same operations through idAASFile virtuals
	so the compiler in Toolsx86.dll does not depend on the engine's private AAS
	object layout.  These small list views preserve the original compiler code's
	shape while routing every access through that public interface.

===============================================================================
*/

template< class type >
class idAASCompilerList {
public:
	typedef int ( idAASFile::*numFunction_t )( void ) const;
	typedef type &( idAASFile::*getFunction_t )( int );
	typedef int ( idAASFile::*appendFunction_t )( type & );
	typedef void ( idAASFile::*setNumFunction_t )( int );

	idAASCompilerList( idAASFile *file, numFunction_t numFunction,
			getFunction_t getFunction, appendFunction_t appendFunction = NULL,
			setNumFunction_t setNumFunction = NULL ) :
		file( file ), numFunction( numFunction ), getFunction( getFunction ),
		appendFunction( appendFunction ), setNumFunction( setNumFunction ) {
	}

	int Num( void ) const {
		return ( file->*numFunction )();
	}

	type &operator[]( int index ) {
		return ( file->*getFunction )( index );
	}

	int Append( type &value ) {
		assert( appendFunction != NULL );
		return ( file->*appendFunction )( value );
	}

	void SetNum( int count ) {
		assert( setNumFunction != NULL );
		( file->*setNumFunction )( count );
	}

private:
	idAASFile *			file;
	numFunction_t		numFunction;
	getFunction_t		getFunction;
	appendFunction_t	appendFunction;
	setNumFunction_t	setNumFunction;
};

class idAASCompilerPlaneList {
public:
	explicit idAASCompilerPlaneList( idAASFile *file ) : file( file ) {}

	idPlane &operator[]( int index ) {
		return file->GetPlane( index );
	}

	int FindPlane( const idPlane &plane, float normalEpsilon, float distanceEpsilon ) {
		return file->FindPlane( plane, normalEpsilon, distanceEpsilon );
	}

private:
	idAASFile *file;
};

class idAASCompilerFile {
public:
	explicit idAASCompilerFile( idAASFile *file ) :
		file( file ),
		planeList( file ),
		vertices( file, &idAASFile::GetNumVertices, &idAASFile::GetVertex, &idAASFile::AppendVertex ),
		edges( file, &idAASFile::GetNumEdges, &idAASFile::GetEdge, &idAASFile::AppendEdge ),
		edgeIndex( file, &idAASFile::GetNumEdgeIndexes, &idAASFile::GetEdgeIndex, &idAASFile::AppendEdgeIndex ),
		faces( file, &idAASFile::GetNumFaces, &idAASFile::GetFace, &idAASFile::AppendFace ),
		faceIndex( file, &idAASFile::GetNumFaceIndexes, &idAASFile::GetFaceIndex, &idAASFile::AppendFaceIndex ),
		areas( file, &idAASFile::GetNumAreas, &idAASFile::GetArea, &idAASFile::AppendArea ),
		nodes( file, &idAASFile::GetNumNodes, &idAASFile::GetNode, &idAASFile::AppendNode, &idAASFile::SetNumNodes ),
		portals( file, &idAASFile::GetNumPortals, &idAASFile::GetPortal, &idAASFile::AppendPortal ),
		portalIndex( file, &idAASFile::GetNumPortalIndexes, &idAASFile::GetPortalIndex ),
		clusters( file, &idAASFile::GetNumClusters, &idAASFile::GetCluster, &idAASFile::AppendCluster ),
		settings( file->GetSettings() ) {
		assert( file != NULL );
	}

	~idAASCompilerFile( void ) {
		delete file;
	}

	void Clear( void ) { file->Clear(); }
	void DeleteClusters( void ) { file->DeleteClusters(); }
	void DeleteReachabilities( void ) { file->DeleteReachabilities(); }
	idVec3 EdgeCenter( int edgeNum ) const { return file->EdgeCenter( edgeNum ); }
	idVec3 FaceCenter( int faceNum ) const { return file->FaceCenter( faceNum ); }
	void FinishAreas( void ) { file->FinishAreas(); }
	idAASSettings &GetSettings( void ) { return file->GetSettings(); }
	void LinkReversedReachability( void ) { file->LinkReversedReachability(); }
	bool Load( const idStr &name, unsigned int crc ) { return file->Load( name, crc ); }
	void Optimize( void ) { file->Optimize(); }
	void ReportRoutingEfficiency( void ) const { file->ReportRoutingEfficiency(); }
	void SetSizes( sizeEstimate_t size ) { file->SetSizes( size ); }
	bool Trace( aasTrace_t &trace, const idVec3 &start, const idVec3 &end ) const { return file->Trace( trace, start, end ); }
	bool Write( const idStr &name, unsigned int crc ) { return file->Write( name, crc ); }

	int AppendPortalIndex( aasIndex_t &portalNum, int clusterNum ) {
		return file->AppendPortalIndex( portalNum, clusterNum );
	}

	idAASFile *GetFile( void ) { return file; }

	idAASCompilerPlaneList			planeList;
	idAASCompilerList< aasVertex_t >	vertices;
	idAASCompilerList< aasEdge_t >		edges;
	idAASCompilerList< aasIndex_t >		edgeIndex;
	idAASCompilerList< aasFace_t >		faces;
	idAASCompilerList< aasIndex_t >		faceIndex;
	idAASCompilerList< aasArea_t >		areas;
	idAASCompilerList< aasNode_t >		nodes;
	idAASCompilerList< aasPortal_t >	portals;
	idAASCompilerList< aasIndex_t >		portalIndex;
	idAASCompilerList< aasCluster_t >	clusters;
	idAASSettings &					settings;

private:
	idAASFile *file;
};

#endif /* !__AASCOMPILERFILE_H__ */
