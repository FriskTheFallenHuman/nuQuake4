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
// Buying.cpp
//
// Copyright 2005 Ritual Entertainment
//
// This file essentially serves as an extension to the Game DLL
// source files Multiplayer.cpp and Player.cpp, in an attempt
// to isolate, as much as possible, these changes from the main
// body of code (for merge simplification, etc).
//----------------------------------------------------------------

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "Buying.h"


riBuyingManager::riBuyingManager() :
	_buyingGameBalanceConstants( NULL ),
	opponentKillCashAward( 0 ),
	opponentKillFragCount( -1 ) { }

riBuyingManager::~riBuyingManager() { }

int riBuyingManager::GetIntValueForKey( const char* keyName, int defaultValue ) {
	if( !keyName )
	{
		return defaultValue;
	}

	if( !_buyingGameBalanceConstants )
	{
		_buyingGameBalanceConstants = static_cast<const idDeclEntityDef*>( declManager->FindType( DECL_ENTITYDEF, "BuyingGameBalanceConstants", false ) );

		if( !_buyingGameBalanceConstants )
		{
			return defaultValue;
		}
	}

	for( int i = 0; i < _buyingGameBalanceConstants->dict.GetNumKeyVals(); i++ )
	{
		const idKeyValue* keyValuePair = _buyingGameBalanceConstants->dict.GetKeyVal( i );
		if( !keyValuePair->GetKey().Icmp( keyName ) )
		{
			return atoi( keyValuePair->GetValue() );
		}
	}

	return defaultValue;
}

int riBuyingManager::GetOpponentKillCashAward( void ) {
	int targetFragCount = gameLocal.serverInfo.GetInt( "si_fragLimit" );
	if ( opponentKillFragCount != targetFragCount ) {
		opponentKillFragCount = targetFragCount;
		if ( idStr::Icmp( gameLocal.serverInfo.GetString( "si_gameType" ), "DM" ) && idStr::Icmp( gameLocal.serverInfo.GetString( "si_gameType" ), "Team DM" ) ) {
			// only do frag reward scaling in DM/TDM
			opponentKillCashAward = GetIntValueForKey( "playerCashAward_killingOpponent", 600 );
		} else {
			targetFragCount = idMath::ClampInt( GetIntValueForKey( "killingOpponent_minFragAdjust", 10 ), GetIntValueForKey( "killingOpponent_maxFragAdjust",50 ), targetFragCount );
			int baseVal = GetIntValueForKey( "playerCashAward_killingOpponent", 600 );
			int fragTarget = GetIntValueForKey( "killingOpponent_bestFragCount", 25 );
			opponentKillCashAward = ( baseVal * fragTarget ) / targetFragCount;
		}
	}
	return opponentKillCashAward;
}
