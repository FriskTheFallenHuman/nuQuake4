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

#include "NetworkSystem.h"

idNetworkSystem		networkSystemLocal;
idNetworkSystem *	networkSystem = &networkSystemLocal;

// The retail implementation stores this state in Raven's server-scan object.
// Keep the ABI-neutral state here until that UI scanner is reconstructed.
static bool			networkFriendClients[MAX_ASYNC_CLIENTS];
static idList<sortInfo_t>	networkSortFunctions;
static idList<sortInfo_t>	networkActiveSortFunctions;

static int FindSortFunction( const idList<sortInfo_t> &list, const sortInfo_t &sortInfo ) {
	for ( int i = 0; i < list.Num(); i++ ) {
		if ( list[i].column == sortInfo.column &&
			 list[i].compareFn == sortInfo.compareFn &&
			 list[i].filterFn == sortInfo.filterFn ) {
			return i;
		}
	}
	return -1;
}

/*
==================
idNetworkSystem::Shutdown
==================
*/
void idNetworkSystem::Shutdown( void ) {
	networkSortFunctions.Clear();
	networkActiveSortFunctions.Clear();
	memset( networkFriendClients, 0, sizeof( networkFriendClients ) );
}


/*
==================
idNetworkSystem::ServerSendReliableMessage
==================
*/
void idNetworkSystem::ServerSendReliableMessage( int clientNum, const idBitMsg &msg, bool inhibitRepeater ) {
	(void)inhibitRepeater;
	if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.SendReliableGameMessage( clientNum, msg );
	}
}

/*
==================
idNetworkSystem::RepeaterSendReliableMessage
idNetworkSystem::RepeaterSendReliableMessageExcluding
==================
*/
void idNetworkSystem::RepeaterSendReliableMessage( int clientNum, const idBitMsg &msg, bool inhibitHeader, int including ) {
	(void)inhibitHeader;
	(void)including;
	if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.SendReliableGameMessage( clientNum, msg );
	}
}

void idNetworkSystem::RepeaterSendReliableMessageExcluding( int excluding, const idBitMsg &msg, bool inhibitHeader, int clientNum ) {
	(void)inhibitHeader;
	(void)clientNum;
	if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.SendReliableGameMessageExcluding( excluding, msg );
	}
}

/*
==================
idNetworkSystem::ServerSendReliableMessageExcluding
==================
*/
void idNetworkSystem::ServerSendReliableMessageExcluding( int clientNum, const idBitMsg &msg, bool inhibitRepeater ) {
	(void)inhibitRepeater;
	if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.SendReliableGameMessageExcluding( clientNum, msg );
	}
}

/*
==================
idNetworkSystem::ServerGetClientPing
==================
*/
int idNetworkSystem::ServerGetClientPing( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientPing( clientNum );
	}
	return 0;
}

/*
==================
idNetworkSystem::ServerGetClientTimeSinceLastPacket
==================
*/
int idNetworkSystem::ServerGetClientTimeSinceLastPacket( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientTimeSinceLastPacket( clientNum );
	}
	return 0;
}

/*
==================
idNetworkSystem::ServerGetClientTimeSinceLastInput
==================
*/
int idNetworkSystem::ServerGetClientTimeSinceLastInput( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientTimeSinceLastInput( clientNum );
	}
	return 0;
}

/*
==================
idNetworkSystem::ServerGetClientOutgoingRate
==================
*/
int idNetworkSystem::ServerGetClientOutgoingRate( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientOutgoingRate( clientNum );
	}
	return 0;
}

/*
==================
idNetworkSystem::ServerGetClientIncomingRate
==================
*/
int idNetworkSystem::ServerGetClientIncomingRate( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientIncomingRate( clientNum );
	}
	return 0;
}

/*
==================
idNetworkSystem::ServerGetClientIncomingPacketLoss
==================
*/
float idNetworkSystem::ServerGetClientIncomingPacketLoss( int clientNum ) {
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientIncomingPacketLoss( clientNum );
	}
	return 0.0f;
}

/*
==================
idNetworkSystem::ServerGetClientNum
idNetworkSystem::ServerGetServerTime
idNetworkSystem::ServerConnectBot
idNetworkSystem::RepeaterGetClientNum
==================
*/
int idNetworkSystem::ServerGetClientNum( int clientId ) {
	// The reconstructed asynchronous server does not expose its private clientId
	// table. Local callers pass an already resolved client number.
	return ( clientId >= 0 && clientId < MAX_ASYNC_CLIENTS ) ? clientId : -1;
}

int idNetworkSystem::ServerGetServerTime( void ) {
	return common->GetFrameTime();
}

int idNetworkSystem::ServerConnectBot( void ) {
	return -1;
}

int idNetworkSystem::RepeaterGetClientNum( int clientId ) {
	return ServerGetClientNum( clientId );
}

/*
==================
idNetworkSystem::ClientSendReliableMessage
==================
*/
void idNetworkSystem::ClientSendReliableMessage( const idBitMsg &msg ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		idAsyncNetwork::client.SendReliableGameMessage( msg );
	} else if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.LocalClientSendReliableMessage( msg );
	}
}

/*
==================
idNetworkSystem::ClientGetPrediction
==================
*/
int idNetworkSystem::ClientGetPrediction( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return idAsyncNetwork::client.GetPrediction();
	}
	return 0;
}

/*
==================
idNetworkSystem::ClientGetTimeSinceLastPacket
==================
*/
int idNetworkSystem::ClientGetTimeSinceLastPacket( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return idAsyncNetwork::client.GetTimeSinceLastPacket();
	}
	return 0;
}

/*
==================
idNetworkSystem::ClientGetOutgoingRate
==================
*/
int idNetworkSystem::ClientGetOutgoingRate( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return idAsyncNetwork::client.GetOutgoingRate();
	}
	return 0;
}

/*
==================
idNetworkSystem::ClientGetIncomingRate
==================
*/
int idNetworkSystem::ClientGetIncomingRate( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return idAsyncNetwork::client.GetIncomingRate();
	}
	return 0;
}

/*
==================
idNetworkSystem::ClientGetIncomingPacketLoss
==================
*/
float idNetworkSystem::ClientGetIncomingPacketLoss( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return idAsyncNetwork::client.GetIncomingPacketLoss();
	}
	return 0.0f;
}

/*
==================
idNetworkSystem::GetServerAddress
==================
*/
const char *idNetworkSystem::GetServerAddress( void ) {
	if ( idAsyncNetwork::client.IsActive() ) {
		return Sys_NetAdrToString( idAsyncNetwork::client.GetServerAddress() );
	}
	if ( idAsyncNetwork::server.IsActive() ) {
		return Sys_NetAdrToString( idAsyncNetwork::server.GetBoundAdr() );
	}
	return "";
}

/*
==================
idNetworkSystem::GetClientAddress
==================
*/
const char *idNetworkSystem::GetClientAddress( int clientNum ) {
	if ( !idAsyncNetwork::server.IsActive() ) {
		return "";
	}
	return Sys_NetAdrToString( idAsyncNetwork::server.GetClientAddress( clientNum ) );
}

/*
==================
idNetworkSystem::AddFriend
idNetworkSystem::RemoveFriend
==================
*/
void idNetworkSystem::AddFriend( int clientNum ) {
	if ( clientNum >= 0 && clientNum < MAX_ASYNC_CLIENTS ) {
		networkFriendClients[clientNum] = true;
	}
}

void idNetworkSystem::RemoveFriend( int clientNum ) {
	if ( clientNum >= 0 && clientNum < MAX_ASYNC_CLIENTS ) {
		networkFriendClients[clientNum] = false;
	}
}

/*
==================
idNetworkSystem::SetLoadingText
idNetworkSystem::AddLoadingIcon
==================
*/
void idNetworkSystem::SetLoadingText( const char *loadingText ) {
	session->SetLoadingText( loadingText );
}

void idNetworkSystem::AddLoadingIcon( const char *icon ) {
	session->AddLoadingIcon( icon );
}

/*
==================
idNetworkSystem::GetClientGUID
==================
*/
const char *idNetworkSystem::GetClientGUID( int clientNum ) {
	if ( clientNum < 0 || clientNum >= MAX_ASYNC_CLIENTS ) {
		common->Warning( "idNetworkSystem::GetClientGUID() - Invalid clientNum '%d'\n", clientNum );
		return NULL;
	}
	if ( idAsyncNetwork::server.IsActive() ) {
		return idAsyncNetwork::server.GetClientGUID( clientNum );
	}
	return game->GetGuidByClientNum( clientNum );
}

/*
==================
idNetworkSystem::GetTrafficStats
==================
*/
void idNetworkSystem::GetTrafficStats( int &bytesSent, int &packetsSent, int &bytesReceived, int &packetsReceived ) const {
	if ( idAsyncNetwork::server.IsActive() ) {
		idAsyncNetwork::server.GetTrafficStats( bytesSent, packetsSent, bytesReceived, packetsReceived );
	} else {
		idAsyncNetwork::client.GetTrafficStats( bytesSent, packetsSent, bytesReceived, packetsReceived );
	}
}

/*
==================
idNetworkSystem server browser API
==================
*/
int idNetworkSystem::GetNumScannedServers( void ) {
	return idAsyncNetwork::client.serverList.Num();
}

const scannedServer_t *idNetworkSystem::GetScannedServerInfo( int serverNum ) {
	if ( serverNum < 0 || serverNum >= idAsyncNetwork::client.serverList.Num() ) {
		return NULL;
	}

	const networkServer_t &source = idAsyncNetwork::client.serverList[serverNum];
	scannedServer.adr = source.adr;
	scannedServer.serverInfo = source.serverInfo;
	scannedServer.ping = source.ping;
	scannedServer.clients = source.clients;
	scannedServer.OSMask = source.OSMask;
	scannedServer.favorite = false;
	scannedServer.dedicated = source.serverInfo.GetBool( "si_dedicated" );
	scannedServer.performanceFiltered = false;
	return &scannedServer;
}

const scannedClient_t *idNetworkSystem::GetScannedServerClientInfo( int serverNum, int clientNum ) {
	if ( serverNum < 0 || serverNum >= idAsyncNetwork::client.serverList.Num() ) {
		return NULL;
	}

	const networkServer_t &source = idAsyncNetwork::client.serverList[serverNum];
	if ( clientNum < 0 || clientNum >= source.clients || clientNum >= MAX_ASYNC_CLIENTS ) {
		return NULL;
	}

	scannedClient.nickname = source.nickname[clientNum];
	scannedClient.clan.Clear();
	scannedClient.ping = source.pings[clientNum];
	scannedClient.rate = source.rate[clientNum];
	return &scannedClient;
}

void idNetworkSystem::AddSortFunction( const sortInfo_t &sortInfo ) {
	if ( FindSortFunction( networkSortFunctions, sortInfo ) < 0 ) {
		networkSortFunctions.Append( sortInfo );
	}
}

bool idNetworkSystem::RemoveSortFunction( const sortInfo_t &sortInfo ) {
	const int activeIndex = FindSortFunction( networkActiveSortFunctions, sortInfo );
	if ( activeIndex >= 0 ) {
		networkActiveSortFunctions.RemoveIndex( activeIndex );
	}
	const int index = FindSortFunction( networkSortFunctions, sortInfo );
	if ( index < 0 ) {
		return false;
	}
	networkSortFunctions.RemoveIndex( index );
	return true;
}

void idNetworkSystem::UseSortFunction( const sortInfo_t &sortInfo, bool use ) {
	const int index = FindSortFunction( networkActiveSortFunctions, sortInfo );
	if ( use ) {
		AddSortFunction( sortInfo );
		if ( index < 0 ) {
			networkActiveSortFunctions.Append( sortInfo );
		}
	} else if ( index >= 0 ) {
		networkActiveSortFunctions.RemoveIndex( index );
	}
}

bool idNetworkSystem::SortFunctionIsActive( const sortInfo_t &sortInfo ) {
	return FindSortFunction( networkActiveSortFunctions, sortInfo ) >= 0;
}

bool idNetworkSystem::HTTPEnable( bool enable ) {
	(void)enable;
	return false;
}

void idNetworkSystem::ClientSetServerInfo( const idDict &serverSI ) {
	if ( game != NULL ) {
		game->SetServerInfo( serverSI );
	}
}

void idNetworkSystem::RepeaterSetInfo( const idDict &info ) {
	(void)info;
}

const char *idNetworkSystem::GetViewerGUID( int clientNum ) {
	return GetClientGUID( clientNum );
}
