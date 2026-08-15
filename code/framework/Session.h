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

#ifndef __SESSION_H__
#define __SESSION_H__

/*
===============================================================================

	The session is the glue that holds games together between levels.

===============================================================================
*/

// needed by the gui system for the load game menu
typedef struct {
	short		health;
	short		heartRate;
	short		stamina;
	short		combat;
} logStats_t;

static const int	MAX_LOGGED_STATS = 60 * 120;		// log every half second 

typedef enum {
	MSG_OK,
	MSG_ABORT,
	MSG_OKCANCEL,
	MSG_YESNO,
	MSG_PROMPT,
	MSG_CDKEY,
	MSG_INFO,
	MSG_WAIT
} msgBoxType_t;

typedef const char * (*HandleGuiCommand_t)( const char * );

class idSession {
public:
	virtual			~idSession() {}

	virtual void	Init( void ) = 0;
	virtual void	Shutdown( void ) = 0;
	virtual void	Stop( void ) = 0;
	virtual void	UpdateScreen( bool outOfSequence = true ) = 0;
	virtual void	PacifierUpdate( void ) = 0;
	virtual void	QuickMapChange( const char *mapName ) = 0;
	virtual bool	GetMapSpawned( void ) = 0;
	virtual bool	GetLoadingSaveGame( void ) = 0;
	virtual idRenderWorld *GetGameRenderWorld( void ) = 0;
	virtual void	Frame( void ) = 0;
	virtual bool	IsMultiplayer( void ) = 0;
	virtual bool	ProcessEvent( const sysEvent_t *event ) = 0;
	virtual void	StartMenu( const char *menuName = NULL ) = 0;
	virtual void	SetGUI( idUserInterface *gui, HandleGuiCommand_t handle ) = 0;
	virtual idUserInterface *GetActiveGUI( void ) = 0;
	virtual int		GetDesiredSoundWorld( bool menuSoundWorld, bool &newSoundWorld ) = 0;
	virtual const char *KeysFromBinding( const char *bind ) = 0;
	virtual void	GuiFrameEvents( void ) = 0;
	virtual const char *MessageBox( msgBoxType_t type, const char *message, const char *title = NULL, bool wait = false, const char *fire_yes = NULL, const char *fire_no = NULL, bool network = false ) = 0;
	virtual void	StopBox( void ) = 0;
	virtual void	DownloadProgressBox( backgroundDownload_t *bgl, const char *title, int progress_start = 0, int progress_end = 100 ) = 0;
	virtual void	TimeHitch( int msec ) = 0;
	virtual void	ReadCDKey( void ) = 0;
	virtual void	WriteCDKey( void ) = 0;
	virtual const char *GetCDKey( void ) = 0;
	virtual bool	CheckKey( const char *key, bool netConnect, bool offlineValid ) = 0;
	virtual bool	CDKeysAreValid( bool strict ) = 0;
	virtual void	ClearCDKey( bool valid ) = 0;
	virtual void	SetCDKeyGuiVars( void ) = 0;
	virtual bool	WaitingForGameAuth( void ) = 0;
	virtual void	CDKeysAuthReply( bool valid, const char *authMessage ) = 0;
	virtual void	EmitClientAuth( void ) = 0;
	virtual void	UpdateFriends( void ) = 0;
	virtual void	KillLoadingGUI( void ) = 0;
	virtual void	GetCurrentMapName( idStr &mapName ) = 0;
	virtual int		GetSaveGameVersion( void ) = 0;
	virtual void	PrecacheMPSettingsMenu( void ) = 0;
	virtual void	SetLoadingText( const char *text ) = 0;
	virtual void	AddLoadingIcon( const char *icon ) = 0;
	virtual void	SetMainMenuGuiVars( void ) = 0;

	// PDB layout: 0x14 bytes on Win32, with the vtable pointer at offset 0.
	idRenderWorld *	rw;
	idDemoFile *	readDemo;
	idDemoFile *	writeDemo;
	int				renderdemoVersion;
};

#if defined( _WIN32 )
static_assert( sizeof( idSession ) == 0x14, "idSession ABI drift" );
#endif

extern	idSession *	session;

#endif /* !__SESSION_H__ */
