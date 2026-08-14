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

#ifndef __ANIM_TESTMODEL_H__
#define __ANIM_TESTMODEL_H__

/*
==============================================================================================

	idTestModel

==============================================================================================
*/

class idTestModel : public idAnimatedEntity {
public:
	CLASS_PROTOTYPE( idTestModel );

							idTestModel();
							~idTestModel();

	void					Save( idSaveGame *savefile );
	void					Restore( idRestoreGame *savefile );

	void					Spawn( void );

	virtual bool			ShouldConstructScriptObjectAtSpawn( void ) const;

	void					NextAnim( const idCmdArgs &args );
	void					PrevAnim( const idCmdArgs &args );
	void					NextFrame( const idCmdArgs &args );
	void					PrevFrame( const idCmdArgs &args );
	void					TestAnim( const idCmdArgs &args );
	void					BlendAnim( const idCmdArgs &args );

	static void 			KeepTestModel_f( const idCmdArgs &args );
	static void 			TestModel_f( const idCmdArgs &args );
	static void				ArgCompletion_TestModel( const idCmdArgs &args, void(*callback)( const char *s ) );
	static void 			TestSkin_f( const idCmdArgs &args );
	static void 			TestShaderParm_f( const idCmdArgs &args );
	static void 			TestParticleStopTime_f( const idCmdArgs &args );
	static void 			TestAnim_f( const idCmdArgs &args );
	static void				ArgCompletion_TestAnim( const idCmdArgs &args, void(*callback)( const char *s ) );
	static void 			TestBlend_f( const idCmdArgs &args );
	static void 			TestModelNextAnim_f( const idCmdArgs &args );
	static void 			TestModelPrevAnim_f( const idCmdArgs &args );
	static void 			TestModelNextFrame_f( const idCmdArgs &args );
	static void 			TestModelPrevFrame_f( const idCmdArgs &args );

private:
// RAVEN BEGIN
// ddynerman: new head system
	idEntityPtr<idAFAttachment>	head;
// RAVEN END
	idAnimator				*headAnimator;
	idAnim					customAnim;
	idPhysics_Parametric	physicsObj;
	idStr					animname;
	int						anim;
	int						headAnim;
	int						mode;
	int						frame;
	int						starttime;
	int						animtime;

	idList<copyJoints_t>	copyJoints;

	virtual void			Think( void );

	void					Event_Footstep( void );
};

#endif /* !__ANIM_TESTMODEL_H__*/
