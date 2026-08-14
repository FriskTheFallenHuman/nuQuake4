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

#ifndef __RV_TRAM_GATE_H
#define __RV_TRAM_GATE_H

extern const idEventDef EV_OpenGate;
extern const idEventDef EV_CloseGate;

class rvTramGate : public idAnimatedEntity {
	CLASS_PROTOTYPE( rvTramGate );

public:
	void				Spawn();
	virtual				~rvTramGate();

	void				OpenGate();
	void				CloseGate();

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

protected:
	void				SpawnDoors();
	void				AdjustFrameRate();

	int					PlayAnim( int channel, const char* animName, int blendFrames = 0 );
	void				CycleAnim( int channel, const char* animName, int blendFrames = 0 );
	void				ClearAllAnims( int blendFrames = 0 );
	void				ClearAnim( int channel, int blendFrames = 0 );
	bool				AnimIsPlaying( int channel, int blendFrames = 0 );

	bool				IsOpen() const;
	bool				IsClosed() const;

	idDoor*				GetDoorMaster() const;
	bool				IsDoorMasterValid() const;
	
protected:
	void				Event_Touch( idEntity* other, trace_t* trace );
	void				Event_Activate( idEntity* activator );

	void				Event_OpenGate();
	void				Event_CloseGate();

	void				Event_IsOpen( void );
	void				Event_IsLocked( void );
	void				Event_Lock( int f );

protected:
	idList< idEntityPtr<idDoor> > doorList;
};

#endif
