/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall (IceColdDuke).

Quake 4 tactical AAS generator reconstructed from the public Quake 4 AAS
format, the retail Toolsx86.dll behavior, and the Doom 3 AAS compiler.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "AASFile.h"

namespace {

const int TACTICAL_CONTENTS = CONTENTS_SOLID | CONTENTS_MONSTERCLIP | CONTENTS_AAS_SOLID;
const float TACTICAL_WALL_EPSILON = 0.5f;
const float TACTICAL_FEATURE_INSET = 1.0f;
const float TACTICAL_LEAN_DISTANCE = 16.0f;

struct tacticalCandidate_t {
	idVec3		origin;
	idVec3		normal;
	int			height;
	int			flags;
	idList<int>	areas;
};

class idAASTacticalBuilder {
public:
	idAASTacticalBuilder( idAASFile *aasFile, idCollisionModel *worldModel ) :
		file( aasFile ), world( worldModel ), settings( aasFile->GetSettings() ) {
	}

	int Build( const idMapFile &mapFile ) {
		file->ClearTactical();
		for ( int i = 0; i < file->GetNumAreas(); i++ ) {
			aasArea_t &area = file->GetArea( i );
			area.numFeatures = 0;
			area.firstFeature = 0;
		}

		AddManualFeatures( mapFile );
		AddAutomaticCoverFeatures();
		CommitFeatures();
		return candidates.Num();
	}

private:
	bool Trace( const idVec3 &start, const idVec3 &end ) const {
		trace_t trace;
		collisionModelManager->Translation( &trace, start, end, NULL, mat3_identity,
			TACTICAL_CONTENTS, world, vec3_origin, mat3_identity );
		return trace.fraction < 1.0f;
	}

	bool TraceWall( const idVec3 &origin, const idVec3 &normal, float height ) const {
		idVec3 start = origin;
		start.z += height;
		const float distance = settings.Radius() + 12.0f;
		return Trace( start, start + normal * distance );
	}

	int AreaForPoint( const idVec3 &point ) const {
		idVec3 raised = point;
		raised.z += 1.0f;
		int areaNum = file->PointAreaNum( raised );
		if ( areaNum > 0 ) {
			return areaNum;
		}
		const idBounds searchBounds( idVec3( -64.0f, -64.0f, -64.0f ), idVec3( 64.0f, 64.0f, 64.0f ) );
		return file->PointReachableAreaNum( point, searchBounds, AREA_REACHABLE_WALK, 0 );
	}

	bool ValidPackedOrigin( const idVec3 &origin ) const {
		for ( int i = 0; i < 3; i++ ) {
			if ( origin[i] < -32768.0f || origin[i] > 32767.0f ) {
				common->Warning( "[AAST] feature at (%g %g %g) is outside the Quake 4 packed coordinate range",
					origin.x, origin.y, origin.z );
				return false;
			}
		}
		return true;
	}

	int AddCandidate( const idVec3 &inOrigin, const idVec3 &inNormal, int height, int flags, int areaNum ) {
		if ( flags == 0 || !ValidPackedOrigin( inOrigin ) ) {
			return -1;
		}

		idVec3 normal = inNormal;
		normal.z = 0.0f;
		if ( normal.Normalize() == 0.0f ) {
			normal.Set( 1.0f, 0.0f, 0.0f );
		}
		height = idMath::ClampInt( 0, 255, height );

		for ( int i = 0; i < candidates.Num(); i++ ) {
			tacticalCandidate_t &candidate = candidates[i];
			if ( ( candidate.origin - inOrigin ).LengthSqr() > Square( 3.0f ) || candidate.normal * normal < 0.98f ) {
				continue;
			}
			candidate.flags |= flags;
			candidate.height = Max( candidate.height, height );
			if ( areaNum > 0 ) {
				candidate.areas.AddUnique( areaNum );
			}
			return i;
		}

		tacticalCandidate_t candidate;
		candidate.origin = inOrigin;
		candidate.normal = normal;
		candidate.height = height;
		candidate.flags = flags;
		if ( areaNum > 0 ) {
			candidate.areas.Append( areaNum );
		}
		return candidates.Append( candidate );
	}

	void AddManualFeatures( const idMapFile &mapFile ) {
		for ( int i = 0; i < mapFile.GetNumEntities(); i++ ) {
			const idDict &dict = mapFile.GetEntity( i )->epairs;
			if ( idStr::Icmp( dict.GetString( "classname" ), "info_tactical_feature" ) != 0 ) {
				continue;
			}

			const idVec3 origin = dict.GetVector( "origin", "0 0 0" );
			const float angle = dict.GetFloat( "angle", "0" );
			const idVec3 normal = idAngles( 0.0f, angle, 0.0f ).ToForward();
			int height = dict.GetInt( "height", "72" );
			int flags = dict.GetInt( "flags", "0" );

			if ( dict.GetBool( "vantage", "0" ) ) {
				flags |= FEATURE_VANTAGE;
			}
			if ( dict.GetBool( "pinch", "0" ) ) {
				flags |= FEATURE_PINCH;
			}
			if ( dict.GetBool( "cover", "0" ) ) {
				flags |= FEATURE_COVER;
			}
			if ( dict.GetBool( "lean_left", "0" ) ) {
				flags |= FEATURE_COVER | FEATURE_LOOK_LEFT;
			}
			if ( dict.GetBool( "corner_left", "0" ) ) {
				flags |= FEATURE_COVER | FEATURE_LOOK_LEFT | FEATURE_CORNER_LEFT;
			}
			if ( dict.GetBool( "lean_right", "0" ) ) {
				flags |= FEATURE_COVER | FEATURE_LOOK_RIGHT;
			}
			if ( dict.GetBool( "corner_right", "0" ) ) {
				flags |= FEATURE_COVER | FEATURE_LOOK_RIGHT | FEATURE_CORNER_RIGHT;
			}
			if ( height >= 20 && height < 64 ) {
				flags |= FEATURE_COVER | FEATURE_LOOK_OVER;
			}

			const int areaNum = AreaForPoint( origin );
			if ( areaNum == 0 ) {
				common->Warning( "[AAST] info_tactical_feature at (%g %g %g) is not in an AAS area",
					origin.x, origin.y, origin.z );
				continue;
			}
			AddCandidate( origin, normal, height, flags, areaNum );
		}
	}

	bool FindSolidWallPlane( int areaNum, const idVec3 &start, const idVec3 &end, idPlane &wallPlane ) const {
		const aasArea_t &area = file->GetArea( areaNum );
		for ( int i = 0; i < area.numFaces; i++ ) {
			const int signedFaceNum = file->GetFaceIndex( area.firstFace + i );
			const aasFace_t &face = file->GetFace( abs( signedFaceNum ) );
			if ( !( face.flags & FACE_SOLID ) ) {
				continue;
			}
			const int orientedPlaneNum = face.planeNum ^ ( signedFaceNum < 0 ? 1 : 0 );
			const idPlane &plane = file->GetPlane( orientedPlaneNum );
			if ( idMath::Fabs( plane.Normal().z ) > 0.25f ) {
				continue;
			}
			if ( idMath::Fabs( plane.Distance( start ) ) <= TACTICAL_WALL_EPSILON &&
				 idMath::Fabs( plane.Distance( end ) ) <= TACTICAL_WALL_EPSILON ) {
				wallPlane = plane;
				return true;
			}
		}
		return false;
	}

	void TestCoverPoint( int areaNum, const idVec3 &point, const idPlane &wallPlane ) {
		idVec3 wallNormal = -wallPlane.Normal();
		wallNormal.z = 0.0f;
		if ( wallNormal.Normalize() == 0.0f ) {
			return;
		}

		idVec3 origin = point + wallPlane.Normal() * TACTICAL_FEATURE_INSET;
		int coverHeight = 0;
		for ( int height = 20; height <= 72; height += 4 ) {
			if ( TraceWall( origin, wallNormal, static_cast<float>( height ) ) ) {
				coverHeight = height;
			}
		}
		if ( coverHeight < 20 ) {
			return;
		}

		int flags = FEATURE_COVER;
		if ( coverHeight < 68 ) {
			flags |= FEATURE_LOOK_OVER;
			AddCandidate( origin, wallNormal, coverHeight, flags, areaNum );
			return;
		}

		coverHeight = 72;
		const idVec3 up( 0.0f, 0.0f, 1.0f );
		const idVec3 right = wallNormal.Cross( up );
		const float lookHeight = static_cast<float>( coverHeight ) - TACTICAL_LEAN_DISTANCE;
		idVec3 lookOrigin = origin;
		lookOrigin.z += lookHeight;

		const idVec3 leftLook = lookOrigin - right * TACTICAL_LEAN_DISTANCE;
		if ( !Trace( lookOrigin, leftLook ) && !TraceWall( origin - right * TACTICAL_LEAN_DISTANCE, wallNormal, lookHeight ) ) {
			flags |= FEATURE_LOOK_LEFT | FEATURE_CORNER_LEFT;
		}

		const idVec3 rightLook = lookOrigin + right * TACTICAL_LEAN_DISTANCE;
		if ( !Trace( lookOrigin, rightLook ) && !TraceWall( origin + right * TACTICAL_LEAN_DISTANCE, wallNormal, lookHeight ) ) {
			flags |= FEATURE_LOOK_RIGHT | FEATURE_CORNER_RIGHT;
		}

		if ( flags & ( FEATURE_LOOK_LEFT | FEATURE_LOOK_RIGHT ) ) {
			AddCandidate( origin, wallNormal, coverHeight, flags, areaNum );
		}
	}

	void AddAutomaticCoverFeatures() {
		for ( int areaNum = 1; areaNum < file->GetNumAreas(); areaNum++ ) {
			const aasArea_t &area = file->GetArea( areaNum );
			if ( !( area.flags & AREA_FLOOR ) || ( area.flags & AREA_LIQUID ) ) {
				continue;
			}

			for ( int faceOffset = 0; faceOffset < area.numFaces; faceOffset++ ) {
				const int signedFaceNum = file->GetFaceIndex( area.firstFace + faceOffset );
				const aasFace_t &floorFace = file->GetFace( abs( signedFaceNum ) );
				if ( !( floorFace.flags & FACE_FLOOR ) ) {
					continue;
				}

				for ( int edgeOffset = 0; edgeOffset < floorFace.numEdges; edgeOffset++ ) {
					const int signedEdgeNum = file->GetEdgeIndex( floorFace.firstEdge + edgeOffset );
					const aasEdge_t &edge = file->GetEdge( abs( signedEdgeNum ) );
					const idVec3 start = file->GetVertex( edge.vertexNum[0] );
					const idVec3 end = file->GetVertex( edge.vertexNum[1] );

					idPlane wallPlane;
					if ( !FindSolidWallPlane( areaNum, start, end, wallPlane ) ) {
						continue;
					}

					idVec3 edgeDirection = end - start;
					edgeDirection.z = 0.0f;
					const float edgeLength = edgeDirection.Normalize();
					if ( edgeLength < 4.0f ) {
						continue;
					}

					const float inset = Min( 8.0f, edgeLength * 0.25f );
					TestCoverPoint( areaNum, start + edgeDirection * inset, wallPlane );
					TestCoverPoint( areaNum, end - edgeDirection * inset, wallPlane );

					const int segments = Max( 1, idMath::Ftoi( edgeLength / 96.0f ) );
					for ( int sample = 1; sample < segments; sample++ ) {
						TestCoverPoint( areaNum, start + edgeDirection * ( edgeLength * sample / segments ), wallPlane );
					}
				}
			}
		}
	}

	static unsigned char PackNormal( float value ) {
		const int packed = idMath::Ftoi( ( value + 1.0f ) * 127.0f + 0.5f );
		return static_cast<unsigned char>( idMath::ClampInt( 0, 254, packed ) );
	}

	void CommitFeatures() {
		idList<int> featureNumbers;
		featureNumbers.SetNum( candidates.Num() );
		for ( int i = 0; i < candidates.Num(); i++ ) {
			const tacticalCandidate_t &candidate = candidates[i];
			aasFeature_t feature;
			memset( &feature, 0, sizeof( feature ) );
			feature.x = static_cast<short>( idMath::Ftoi( candidate.origin.x ) );
			feature.y = static_cast<short>( idMath::Ftoi( candidate.origin.y ) );
			feature.z = static_cast<short>( idMath::Ftoi( candidate.origin.z ) );
			feature.flags = static_cast<unsigned short>( candidate.flags );
			feature.normalx = PackNormal( candidate.normal.x );
			feature.normaly = PackNormal( candidate.normal.y );
			feature.height = static_cast<unsigned char>( candidate.height );
			featureNumbers[i] = file->AppendFeature( feature );
		}

		for ( int areaNum = 0; areaNum < file->GetNumAreas(); areaNum++ ) {
			aasArea_t &area = file->GetArea( areaNum );
			area.firstFeature = static_cast<unsigned short>( file->GetNumFeatureIndexes() );
			for ( int candidateNum = 0; candidateNum < candidates.Num(); candidateNum++ ) {
				if ( candidates[candidateNum].areas.FindIndex( areaNum ) < 0 ) {
					continue;
				}
				aasIndex_t featureNum = featureNumbers[candidateNum];
				file->AppendFeatureIndex( featureNum );
				area.numFeatures++;
			}
		}
	}

	idAASFile *file;
	idCollisionModel *world;
	idAASSettings &settings;
	idList<tacticalCandidate_t> candidates;
};

static idStr TacticalMapName( const char *argument ) {
	idStr mapName = argument;
	mapName.BackSlashesToSlashes();
	mapName.StripFileExtension();
	if ( mapName.Icmpn( "maps/", 5 ) != 0 ) {
		mapName = "maps/" + mapName;
	}
	return mapName;
}

}

void RunAASTactical_f( const idCmdArgs &args ) {
	if ( args.Argc() != 2 ) {
		common->Printf( "runAASTactical <mapfile>\n" );
		return;
	}

	common->ClearWarnings( "generating tactical AAS features" );
	common->SetRefreshOnPrint( true );
	common->Printf( "[AAST] Generating Tactical Features...\n" );

	const idStr mapName = TacticalMapName( args.Argv( 1 ) );
	idStr mapFileName = mapName;
	mapFileName.SetFileExtension( "map" );
	idMapFile mapFile;
	if ( !mapFile.Parse( mapFileName ) ) {
		common->Warning( "[AAST] couldn't load map file '%s'", mapFileName.c_str() );
		common->SetRefreshOnPrint( false );
		common->PrintWarnings();
		return;
	}

	cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disconnect" );
	collisionModelManager->LoadMap( &mapFile, false );
	idCollisionModel *world = collisionModelManager->LoadModel( mapFile.GetName(), WORLD_MODEL_NAME );
	if ( world == NULL ) {
		common->Warning( "[AAST] couldn't load collision world for '%s'", mapName.c_str() );
		collisionModelManager->FreeMap( mapFile.GetName() );
		common->SetRefreshOnPrint( false );
		common->PrintWarnings();
		return;
	}

	int totalFeatures = 0;
	const idDict *types = gameEdit->FindEntityDefDict( "aas_types", false );
	if ( types == NULL ) {
		common->Warning( "[AAST] unable to find entityDef 'aas_types'" );
	} else {
		const idKeyValue *type = types->MatchPrefix( "type" );
		while ( type != NULL ) {
			const idDict *settingsDict = gameEdit->FindEntityDefDict( type->GetValue(), false );
			if ( settingsDict != NULL ) {
				idAASSettings settings;
				settings.FromDict( type->GetValue(), settingsDict );
				if ( settings.generateTacticalFeatures ) {
					idStr aasName = mapName;
					aasName.SetFileExtension( settings.fileExtension );
					idAASFile *file = AASFile->CreateNew();
					if ( file->Load( aasName, mapFile.GetGeometryCRC() ) ) {
						file->SetSettings( settings );
						idAASTacticalBuilder builder( file, world );
						const int count = builder.Build( mapFile );
						if ( file->Write( aasName, mapFile.GetGeometryCRC() ) ) {
							common->Printf( "[AAST] %d Features Generated for %s\n", count, settings.fileExtension.c_str() );
							totalFeatures += count;
						}
					} else {
						common->Warning( "[AAST] couldn't load '%s'; run runAAS first", aasName.c_str() );
					}
					delete file;
				}
			}
			type = types->MatchPrefix( "type", type );
		}
	}

	collisionModelManager->FreeMap( mapFile.GetName() );
	common->Printf( "[AAST] %d Features Generated\n", totalFeatures );
	common->SetRefreshOnPrint( false );
	common->PrintWarnings();
}

