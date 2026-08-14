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

///////////////////////////////////////////////////////////////////////////////
// AAS_tactical
//
// This file is the interface to an AAS Tactical Extractor, which can search
// out from a given start point and report a variety of tactically important
// objectives, including corners, walls, and pinch points.
//
// By seeing the AAS graph as a qualitative and simplified spatial 
// representation of the game world.  This representation is amply capapble of
// rendering higher level tactical data efficiently in real time.
//
///////////////////////////////////////////////////////////////////////////////
#ifndef __AAS_TACTICAL_H__
#define __AAS_TACTICAL_H__


///////////////////////////////////////////////////////////////////////////////
// rvAASTacticalSensor
//
// The sensor structure is the public interface to the internals of AAS
// tactical features.  
///////////////////////////////////////////////////////////////////////////////
struct rvAASTacticalSensor
{
	// Regular Update Function
	///////////////////////////////////////////////////////////////////////
	virtual void			Update() = 0;
	virtual void			Save(idSaveGame *savefile) = 0;
	virtual void			Restore(idRestoreGame *savefile) = 0;
	virtual void			Clear() = 0;

	// Search
	///////////////////////////////////////////////////////////////////////
	virtual void			SearchRadius(const idVec3& origin=vec3_origin, float rangeMin=0.0f, float rangeMax=1.0f) = 0;
	virtual void			SearchCover(float rangeMin=0.0f, float rangeMax=1.0f) = 0;
	virtual void			SearchHide(idEntity* from=0) = 0;
	virtual void			SearchFlank() = 0;
	virtual void			SearchAdvance() = 0;
	virtual void			SearchRetreat() = 0;
	virtual void			SearchAmbush() = 0;
	virtual void			SearchDebug() = 0;

	// Feature Testing
	///////////////////////////////////////////////////////////////////////
	virtual bool			TestValid(aasFeature_t* f, float walkDistanceToFeature) = 0;
	virtual bool			TestValidWithCurrentState(aasFeature_t* f=0) = 0;

	// Feature Reservation
	///////////////////////////////////////////////////////////////////////
	virtual void			Reserve(aasFeature_t* f) = 0;

	// Access To Results
	///////////////////////////////////////////////////////////////////////
	virtual int				FeatureCount() = 0;
	virtual aasFeature_t*	Feature(int i) = 0;
	virtual aasFeature_t*	Near() const = 0;
	virtual aasFeature_t*	Look() const = 0;
	virtual aasFeature_t*	Reserved() const = 0;
	virtual const idVec3&	ReservedOrigin() const = 0;



	// STATIC SYSTEM FUNCTIONS
	///////////////////////////////////////////////////////////////////////
	static rvAASTacticalSensor*		CREATE_SENSOR(idActor* owner);
};


#endif /* !__AAS_TACTICAL_H__ */
