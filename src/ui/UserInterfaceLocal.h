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

class idWindow;

class idUserInterfaceLocal : public idUserInterface {
	friend class idUserInterfaceManagerLocal;
public:
								idUserInterfaceLocal();
	virtual						~idUserInterfaceLocal();

	virtual const char *		Name() const;
	virtual const char *		Comment() const;
	virtual bool				IsInteractive() const;
	virtual void				SetInteractive( bool interactive );
	virtual bool				InitFromFile( const char *qpath, bool rebuild = true, bool cache = true );
	virtual const char *		HandleEvent( const sysEvent_t *event, int time, bool *updateVisuals );
	virtual void				HandleNamedEvent( const char* namedEvent );
	virtual void				Redraw( int time );
	virtual void				DrawCursor();
	virtual const idDict &		State() const;
	virtual void				DeleteStateVar( const char *varName );
	virtual void				SetStateString( const char *varName, const char *value );
	virtual void				SetStateBool( const char *varName, const bool value );
	virtual void				SetStateInt( const char *varName, const int value );
	virtual void				SetStateFloat( const char *varName, const float value );
	virtual void				SetStateVector( const char *varName, const idVec3& vector );
	virtual void				SetStateVec4( const char *varName, const idVec4& vector );
	virtual void				ClearState( void );
	virtual void				DeleteState( const char *varName );
	virtual idVec4				GetLightColor( void );

	// Gets a gui state variable
	virtual const char*			GetStateString( const char *varName, const char* defaultString = "" ) const;
	virtual bool				GetStateBool( const char *varName, const char* defaultString = "0" ) const;
	virtual int					GetStateInt( const char *varName, const char* defaultString = "0" ) const;
	virtual float				GetStateFloat( const char *varName, const char* defaultString = "0" ) const;
	virtual idVec3				GetStateVector( const char *varName, const char* defaultString = "0 0 0" ) const;
	virtual idVec4				GetStateVec4( const char *varName, const char* defaultString = "0 0 0 0" ) const;

	virtual void				StateChanged( int time, bool redraw );
	virtual const char *		Activate( bool activate, int time );
	virtual void				Trigger( int time );
	virtual void				ReadFromDemoFile( class idDemoFile *f );
	virtual void				WriteToDemoFile( class idDemoFile *f );
	virtual bool				WriteToSaveGame( idFile *savefile ) const;
	virtual bool				ReadFromSaveGame( idFile *savefile );
	virtual void				SetKeyBindingNames( void );
	virtual bool				IsUniqued() const { return uniqued; };
	virtual void				SetUniqued( bool b ) { uniqued = b; };
	virtual void				SetCursor( float x, float y );

	virtual float				CursorX() { return cursorX; }
	virtual float				CursorY() { return cursorY; }
	virtual bool				GetMaxTextIndex( const char *windowName, const char *text, wrapInfo_t& wrapInfo ) const;

	size_t						Size();

	idDict *					GetStateDict() { return &state; }

	const char *				GetSourceFile( void ) const { return source; }
	ID_TIME_T						GetTimeStamp( void ) const { return timeStamp; }

	idWindow *					GetDesktop() const { return desktop; }
	void						SetBindHandler( idWindow *win ) { bindHandler = win; }
	bool						Active() const { return active; }
	int							GetTime() const { return time; }
	void						SetTime( int _time ) { time = _time; }
	void						SetLightColorVar( idWinVec4 *var ) { lightColorVar = var; }

	void						ClearRefs() { refs = 0; }
	void						AddRef() { refs++; }
	int							GetRefs() { return refs; }

	void						RecurseSetKeyBindingNames( idWindow *window );
	idStr						&GetPendingCmd() { return pendingCmd; };
	idStr						&GetReturnCmd() { return returnCmd; };

private:
	bool						active;
	bool						loading;
	bool						interactive;
	bool						uniqued;

	idDict						state;
	idWindow *					desktop;
	idWindow *					bindHandler;

	idStr						source;
	idStr						activateStr;
	idStr						pendingCmd;
	idStr						returnCmd;
	ID_TIME_T						timeStamp;
	bool						initialized;

	float						cursorX;
	float						cursorY;

	int							time;

	int							refs;
	idWinVec4 *					lightColorVar;
};

class idUserInterfaceManagerLocal : public idUserInterfaceManager {
	friend class idUserInterfaceLocal;

public:
	virtual void				Init();
	virtual void				Shutdown();
	virtual void				Touch( const char *name );
	virtual void				WritePrecacheCommands( idFile *f );
	virtual void				SetSize( float width, float height );
	virtual void				BeginLevelLoad();
	virtual void				EndLevelLoad();
	virtual void				Reload( bool all );
	virtual void				ListGuis() const;
	virtual bool				CheckGui( const char *qpath ) const;
	virtual idUserInterface *	Alloc( void ) const;
	virtual void				DeAlloc( idUserInterface *gui );
	virtual idUserInterface *	FindGui( const char *qpath, bool autoLoad = false, bool needInteractive = false, bool forceUnique = false );
	virtual idUserInterface *	FindDemoGui( const char *qpath );
	virtual	idListGUI *			AllocListGUI( void ) const;
	virtual void				FreeListGUI( idListGUI *listgui );
	virtual void				RunAlwaysThinkGUIs( int time );
	virtual void				RegisterIcon( const char *code, const char *shader, int x = -1, int y = -1, int w = -1, int h = -1 );

private:
	idRectangle					screenRect;
	idDeviceContext				dc;

	idList<idUserInterfaceLocal*> guis;
	idList<idUserInterfaceLocal*> demoGuis;
	idList<idUserInterfaceLocal*> alwaysThinkGUIs;

};

#if defined( _WIN32 ) && defined( Q4_RECON_ENGINE_PRIVATE )
static_assert( sizeof( idUserInterfaceLocal ) == 0xD8, "idUserInterfaceLocal ABI drift" );
static_assert( sizeof( idUserInterfaceManagerLocal ) == 0x134, "idUserInterfaceManagerLocal ABI drift" );
#endif
