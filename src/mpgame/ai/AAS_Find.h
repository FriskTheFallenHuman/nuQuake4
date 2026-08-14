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

AAS_Find.h

================
*/

#ifndef __AAS_FIND__
#define __AAS_FIND__

class idAI;
class rvAIHelper;

/*
===============================================================================
								rvAASFindHide
===============================================================================
*/

class rvAASFindGoalForHide : public idAASCallback {
public:
	rvAASFindGoalForHide	( const idVec3 &hideFromPos );
	~rvAASFindGoalForHide	( void );

protected:

	virtual bool		TestArea	( class idAAS *aas, int areaNum, const aasArea_t& area );

private:

	pvsHandle_t			hidePVS;
	int					PVSAreas[ idEntity::MAX_PVS_AREAS ];
};

/*
===============================================================================
								rvAASFindAreaOutOfRange
===============================================================================
*/

class rvAASFindGoalOutOfRange : public idAASCallback {
public:
	
	rvAASFindGoalOutOfRange ( idAI* _owner );

protected:

	virtual bool		TestPoint		( class idAAS *aas, const idVec3& point, const float zAllow=0.0f );

private:

	idAI*			owner;
};

/*
===============================================================================
								rvAASFindAttackPosition
===============================================================================
*/

class rvAASFindGoalForAttack : public idAASCallback {
public:
	rvAASFindGoalForAttack		( idAI *self );
	~rvAASFindGoalForAttack	( void );


	bool				TestCachedGoals	( int count, aasGoal_t& goal );

	virtual void		Init			( void );
	virtual void		Finish			( void );
	
private:

	virtual bool		TestArea		( class idAAS *aas, int areaNum, const aasArea_t& area );
	virtual bool		TestPoint		( class idAAS *aas, const idVec3& point, const float zAllow=0.0f );
	
	bool				TestCachedGoal	( int index );

	idAI*				owner;
	
  	pvsHandle_t			targetPVS;
  	int					PVSAreas[ idEntity::MAX_PVS_AREAS ];
	
	idList<aasGoal_t>	cachedGoals;
	int					cachedIndex;
	int					cachedAreaNum;
};

/*
===============================================================================
							rvAASFindGoalForTether
===============================================================================
*/

class rvAASFindGoalForTether : public idAASCallback {
public:
	rvAASFindGoalForTether	( idAI* owner, rvAITether* helper );
	~rvAASFindGoalForTether	( void );

protected:

	virtual bool		TestArea	( class idAAS *aas, int areaNum, const aasArea_t& area );
	virtual bool		TestPoint	( class idAAS* aas, const idVec3& pos, const float zAllow=0.0f );

private:

	idAI*			owner;
	rvAITether*		tether;
};

#endif // __AAS_FIND__
