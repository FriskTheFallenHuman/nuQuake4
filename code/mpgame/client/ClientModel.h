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

//----------------------------------------------------------------
// ClientModel.h
//
// A non-interactive client-side model
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __GAME_CLIENT_MODEL_H__
#define __GAME_CLIENT_MODEL_H__

class rvClientModel : public rvClientEntity {
public:

	CLASS_PROTOTYPE( rvClientModel );

			rvClientModel ( void );
	virtual ~rvClientModel ( void );
	
	void						Spawn			( void );
	virtual void				Think			( void );
	
	virtual renderEntity_t*		GetRenderEntity	( void );
	const char*					GetClassname	( void ) const;

	virtual bool				SetCustomShader	( const char* shaderName );

	void						Save			( idSaveGame *savefile ) const;
	void						Restore			( idRestoreGame *savefile );

	virtual void				FreeEntityDef	( void );

	virtual void				SetModel( const char *modelname );

	virtual const idAnimator*	GetAnimator( void ) const { return NULL; }	
	virtual idAnimator*			GetAnimator( void ) { return NULL; }	


	bool						UpdateRenderEntity( renderEntity_s *renderEntity, const renderView_t *renderView );
	static bool					ModelCallback( renderEntity_s *renderEntity, const renderView_t *renderView );

	virtual bool				GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );
	void						ProjectOverlay( const idVec3 &origin, const idVec3 &dir, float size, const char *material );

	void						UpdateVisuals( void );
	void						UpdateModel( void );
	void						UpdateModelTransform( void );

	void						SetSkin( const idDeclSkin* skin );
	int							GetModelDefHandle( void );
protected:
	void						Present( void );

	renderEntity_t				renderEntity;
	int							entityDefHandle;

	idStr						classname;
};

ID_INLINE renderEntity_t* rvClientModel::GetRenderEntity ( void ) {
	return &renderEntity;
}

ID_INLINE const char* rvClientModel::GetClassname ( void ) const {
	return classname.c_str();
}

ID_INLINE int rvClientModel::GetModelDefHandle( void ) {
	return entityDefHandle;
}

class rvAnimatedClientEntity : public rvClientModel {
public:
	CLASS_PROTOTYPE( rvAnimatedClientEntity );

				rvAnimatedClientEntity ( void );
	virtual		~rvAnimatedClientEntity ( void );

	void						Spawn( void );
	virtual void				Think( void );
	virtual void				UpdateAnimation( void );

	virtual void				SetModel( const char *modelname );

	virtual const idAnimator*	GetAnimator( void ) const { return &animator; }
	virtual idAnimator*			GetAnimator( void ) { return &animator; }

protected:
	idAnimator					animator;
};

#endif // __GAME_CLIENT_MODEL_H__
