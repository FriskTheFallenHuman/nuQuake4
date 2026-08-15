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

#include "../../idlib/precompiled.h"
#pragma hdrstop
#include "../Game_local.h"

// This equates to about 1 second
#define MAX_VOICE_PACKET_SIZE	382

idCVar si_voiceChat( "si_voiceChat", "1", CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_INFO, "enables or disables voice chat through the server" );
idCVar g_voiceChatDebug( "g_voiceChatDebug", "0", CVAR_GAME | CVAR_INTEGER | CVAR_NOCHEAT, "display info on voicechat net traffic" );

void idMultiplayerGame::ReceiveAndForwardVoiceData( int clientNum, const idBitMsg &inMsg, int messageType ) {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );

	idBitMsg	outMsg;
	int			i;
	byte		msgBuf[MAX_VOICE_PACKET_SIZE + 2];
	idPlayer *	from;
	
	from = ( idPlayer * )gameLocal.entities[clientNum];
	if( !gameLocal.serverInfo.GetBool( "si_voiceChat" ) || !from ) {
		return;
	}

	// Create a new packet with forwarded data
	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.WriteByte( GAME_UNRELIABLE_MESSAGE_VOICEDATA_SERVER );
	outMsg.WriteByte( clientNum );
	outMsg.WriteData( inMsg.GetReadData(), inMsg.GetRemainingData() );

	if( g_voiceChatDebug.GetInteger() & 2 ) {
		common->Printf( "VC: Received %d bytes, forwarding...\n", inMsg.GetRemainingData() );
	}

	// Forward to appropriate parties
	for( i = 0; i < gameLocal.numClients; i++ )  {
		idPlayer* to = ( idPlayer * )gameLocal.entities[i];
		if( to && to->GetUserInfo() && to->GetUserInfo()->GetBool( "s_voiceChatReceive" ) )
		{
			if( i != gameLocal.localClientNum && CanTalk( from, to, !!( messageType & 1 ) ) )
			{
				if( messageType & 2 )
				{
					// If "from" is testing - then only send back to him
					if( from == to )
					{
						gameLocal.SendUnreliableMessage( outMsg, to->entityNumber );
					}
				}
				else
				{
					if( to->AllowedVoiceDest( from->entityNumber ) )
					{
						gameLocal.SendUnreliableMessage( outMsg, to->entityNumber );
						if( g_voiceChatDebug.GetInteger() & 2 )
						{
							common->Printf( " ... to client %d\n", to->entityNumber );
						}
					}
					else
					{
						if( g_voiceChatDebug.GetInteger() )
						{
							common->Printf( " ... suppressed packet to client %d\n", to->entityNumber );
						}
					}
				}
			}
		}
	}

#ifdef _USE_VOICECHAT
	// Listen servers need to manually call the receive function
	if ( gameLocal.isListenServer ) {
		// Skip over control byte
		outMsg.ReadByte();
        
		idPlayer* to = gameLocal.GetLocalPlayer();
		if( to->GetUserInfo()->GetBool( "s_voiceChatReceive" ) )
		{
			if( CanTalk( from, to, !!( messageType & 1 ) ) )
			{
				if( messageType & 2 )
				{
					// If "from" is testing - then only send back to him
					if( from == to )
					{
						ReceiveAndPlayVoiceData( outMsg );
					}
				}
				else
				{
					if( to->AllowedVoiceDest( from->entityNumber ) )
					{
						if( g_voiceChatDebug.GetInteger() & 2 )
						{
							common->Printf( " ... to local client %d\n", gameLocal.localClientNum );
						}
						ReceiveAndPlayVoiceData( outMsg );
					}
				}
			}
		}
	}
#endif
}

bool idMultiplayerGame::CanTalk( idPlayer *from, idPlayer *to, bool echo ) {
	if ( !to ) {
		return false;
	}

	if ( !from ) {
		return false;
	}

	if ( from->spectating != to->spectating ) {
		return false;
	}

	if ( to->IsPlayerMuted( from ) ) {
		return false;
	}

	if ( to->GetArena() != from->GetArena() ) {
		return false;
	}

	if ( gameLocal.IsTeamGame() && from->team != to->team ) {
		return false;
	}

	if ( from == to ) {
		return echo;
	}

	return true;
}

#ifdef _USE_VOICECHAT

void idMultiplayerGame::XmitVoiceData( void )
{
	idBitMsg	outMsg;
	int			count;
	byte		work;
	byte		buffer[MAX_VOICE_PACKET_SIZE];
	byte		msgBuf[MAX_VOICE_PACKET_SIZE + 1];

	if( !gameLocal.serverInfo.GetBool( "si_voiceChat" ) )
	{
		return;
	}

	outMsg.Init( msgBuf, sizeof( msgBuf ) );

	// Grab any new input and send up to the server
	count = soundSystem->GetVoiceData( buffer, MAX_VOICE_PACKET_SIZE );
	if( count )
	{
		outMsg.BeginWriting();
		outMsg.BeginReading();

		work = GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT + cvarSystem->GetCVarBool( "s_voiceChatEcho" ) + ( cvarSystem->GetCVarInteger( "s_voiceChatTest" ) * 2 );
		outMsg.WriteByte( work );
		outMsg.WriteData( buffer, count );

		// FIXME!!! FIXME!!! This should be unreliable - this is very bad
		networkSystem->ClientSendReliableMessage( outMsg );

		if( g_voiceChatDebug.GetInteger() & 1 )
		{
			common->Printf( "VC: sent %d bytes at %d\n", count, gameLocal.time );
		}
	}
}

void idMultiplayerGame::ReceiveAndPlayVoiceData( const idBitMsg &inMsg )
{
	int		clientNum;

	if( !gameLocal.serverInfo.GetBool( "si_voiceChat" ) )
	{
		return;
	}
	
	clientNum = inMsg.ReadByte();
	soundSystem->PlayVoiceData( clientNum, inMsg.GetReadData(), inMsg.GetRemainingData() );
	if( g_voiceChatDebug.GetInteger() & 4 )
	{
		common->Printf( "VC: Playing %d bytes\n", inMsg.GetRemainingData() );
	}
}

#endif

// end
