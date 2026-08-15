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

/*
================

AI_Medic.h

================
*/
#include "AI_Tactical.h"

#ifndef __AI_MEDIC__
#define __AI_MEDIC__

class rvAIMedic : public rvAITactical {
public:

	CLASS_PROTOTYPE( rvAIMedic );

	rvAIMedic ( void );

	void				InitSpawnArgsVariables			( void );
	void				Spawn							( void );
	void				Think							( void );
	void				Save							( idSaveGame *savefile ) const;
	void				Restore							( idRestoreGame *savefile );
	
	virtual void		Show							( void );

	virtual void		TalkTo							( idActor *actor );

	virtual void		GetDebugInfo					( debugInfoProc_t proc, void* userData );

	virtual bool		IsTethered						( void ) const;

	virtual void		OnStateThreadClear				( const char *statename, int flags );

	virtual bool		Pain							( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location );

	bool				isTech;

protected:
	virtual void		OnStartMoving					( void );

private:

	idEntityPtr<idPlayer> patient;
	bool				healing;
	int					lastPatientCheckTime;
	bool				emergencyOverride;

	bool				noAutoHeal;
	bool				stationary;
	bool				silent;
	bool				healObeyTether;
	int					healAmt;
	float				patientRange;
	float				buddyRange;
	float				enemyRange;

	int					curHealValue;
	int					maxHealValue;
	int					minHealValue;
	int					healedAmount;
	int					maxPatientValue;

	int					healDebounceInterval;
	int					healDebounceTime;

	bool				healDisabled;
	bool				wasAware;
	bool				wasIgnoreEnemies;

	void				SetHealValues					( idPlayer* player );
 	
	void				TakePatient						( idPlayer* pPatient );
	void				DropPatient						( void );
 	bool				CheckTakePatient				( idPlayer* actor );
 	bool				SituationAllowsPatient			( void );
 	bool				AvailableToTakePatient			( void );

	stateResult_t		State_Medic						( const stateParms_t& parms );
	
	void				Event_EnableHeal				( void );
	void				Event_DisableHeal				( void );
	void				Event_EnableMovement			( void );
	void				Event_DisableMovement			( void );

	rvScriptFuncUtility	mPostHealScript;		// script to run after completing a heal

	CLASS_STATES_PROTOTYPE ( rvAIMedic );
};

#endif /* !__AI_MEDIC__ */
