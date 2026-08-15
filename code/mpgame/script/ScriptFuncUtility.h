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

#ifndef __RV_SCRIPT_FUNC_UTILITY_H
#define __RV_SCRIPT_FUNC_UTILITY_H

class idThread;

enum sfuReturnType {
	SFU_NOFUNC = -1,
	SFU_ERROR = 0,
	SFU_OK = 1
};

class rvScriptFuncUtility {
public:
	rvScriptFuncUtility();
	explicit rvScriptFuncUtility( const rvScriptFuncUtility* sfu );
	explicit rvScriptFuncUtility( const rvScriptFuncUtility& sfu );
	explicit rvScriptFuncUtility( const char* source );
	explicit rvScriptFuncUtility( const idCmdArgs& args );

	sfuReturnType			Init( const char* source );
	sfuReturnType			Init( const idCmdArgs& args );
	void					Clear();

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

	idTypeDef*				GetParmType( int index ) const;
	idTypeDef*				GetReturnType() const ;
	int						NumParms() const;
	bool					ReturnsAVal() const;

	void					SetFunction( const function_t* func );
	void					SetParms( const idList<idStr>& parms );
	void					SetReturnKey( const char* key ) { returnKey = key; }

	const char*				GetFuncName() const;
	const function_t*		GetFunc() const { return func; }
	const char*				GetParm( int index ) const;
	const char*				GetReturnKey() const { return returnKey.c_str(); }

	void					InsertInt( int parm, int index );
	void					InsertFloat( float parm, int index );
	void					InsertVec3( const idVec3& parm, int index );
	void					InsertEntity( const idEntity* parm, int index );
	void					InsertString( const char* parm, int index );
	void					InsertBool( bool parm, int index );
	void					RemoveIndex( int index );

	const function_t*		FindFunction( const char* name ) const;
	void					CallFunc( idDict* returnDict ) const;

	bool					Valid() const;

	rvScriptFuncUtility&	Assign( const rvScriptFuncUtility* sfu );
	rvScriptFuncUtility&	operator=( const rvScriptFuncUtility* sfu );
	rvScriptFuncUtility&	operator=( const rvScriptFuncUtility& sfu );

	bool					IsEqualTo( const rvScriptFuncUtility* sfu ) const;
	bool					operator==( const rvScriptFuncUtility* sfu ) const;
	bool					operator==( const rvScriptFuncUtility& sfu ) const;

private:
	sfuReturnType			Init();

protected:
	const function_t*		func;
	idList<idStr>			parms;
	idStr					returnKey;
};

#endif
