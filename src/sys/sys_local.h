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

#ifndef __SYS_LOCAL__
#define __SYS_LOCAL__

/*
==============================================================

	idSysLocal

==============================================================
*/

class idSysLocal : public idSys {
public:
	virtual void			DebugPrintf( const char *fmt, ... )id_attribute((format(printf,2,3)));
	virtual void			DebugVPrintf( const char *fmt, va_list arg );

	virtual double			GetClockTicks( void );
	virtual double			ClockTicksPerSecond( void );
	virtual cpuid_t			GetProcessorId( void );
	virtual const char *	GetProcessorString( void );
	virtual const char *	FPU_GetState( void );
	virtual bool			FPU_StackIsEmpty( void );
	virtual void			FPU_SetFTZ( bool enable );
	virtual void			FPU_SetDAZ( bool enable );
	virtual void			FPU_SetPrecision( int flags );

	virtual void			GetCallStack( address_t *callStack, const int callStackSize );
	virtual const char *	GetCallStackStr( const address_t *callStack, const int callStackSize );
	virtual const char *	GetCallStackCurStr( int depth );
	virtual void			ShutdownSymbols( void );

	virtual bool			LockMemory( void *ptr, int bytes );
	virtual bool			UnlockMemory( void *ptr, int bytes );

	virtual int				DLL_Load( const char *dllName );
	virtual void *			DLL_GetProcAddress( int dllHandle, const char *procName );
	virtual void			DLL_Unload( int dllHandle );
	virtual void			DLL_GetFileName( const char *baseName, char *dllName, int maxLength );

	virtual sysEvent_t		GenerateMouseButtonEvent( int button, bool down );
	virtual sysEvent_t		GenerateMouseMoveEvent( int deltax, int deltay );

	virtual int				MapKey( unsigned long lParam, unsigned short wParam );
	virtual void			AddKeyPress( int key, bool state );
	virtual int				GetNumKeyPresses( void );
	virtual bool			GetKeyPress( const int n, int &key, bool &state );

	virtual void *			CreateWindowEx( const char *className, const char *windowName, int style, int x, int y, int w, int h, void *parent, void *menu, void *instance, void *param, int extStyle = 0 );
	virtual void *			GetDC( void *hWnd );
	virtual void			ReleaseDC( void *hWnd, void *hDC );
	virtual void			ShowWindow( void *hWnd, int show );
	virtual void			UpdateWindow( void *hWnd );
	virtual bool			IsWindowVisible( void *hWnd );
	virtual void			SetForegroundWindow( void *hWnd );
	virtual void			SetFocus( void *hWnd );
	virtual void			DestroyWindow( void *hWnd );

	virtual void			ShowConsole( int visLevel, bool quitOnClose );
	virtual void			UpdateConsole( void );
	virtual void			SetConsoleName( const char *consoleName );
	virtual bool			IsAppActive( void ) const;
	virtual int				Milliseconds( void );
	virtual void			InitInput( void );
	virtual void			ShutdownInput( void );
	virtual void			GenerateEvents( void );
	virtual void			GrabMouseCursor( bool grabIt );

	virtual FILE *			FOpen( const char *name, const char *mode );
	virtual void			FPrintf( FILE *file, const char *fmt );
	virtual int				FTell( FILE *file );
	virtual int				FSeek( FILE *file, long offset, int mode );
	virtual void			FClose( FILE *file );
	virtual int				FRead( void *buffer, int size, int count, FILE *file );
	virtual int				FWrite( void *buffer, int size, int count, FILE *file );
	virtual long			FileTimeStamp( FILE *file );
	virtual int				FEof( FILE *stream );
	virtual char *			FGets( char *string, int n, FILE *stream );
	virtual void			FFlush( FILE *file );
	virtual int				SetVBuf( FILE *stream, char *buffer, int mode, size_t size );

	virtual void			OpenURL( const char *url, bool quit );
	virtual void			StartProcess( const char *exeName, bool quit );
	virtual int				GetGUID( char *buf, int buflen );

private:
	struct keyPress_t {
		short keynum;
		bool state;
	};
	static keyPress_t	keyPress[256];
	static int			head;
	static int			tail;
	static int			free;
};

#endif /* !__SYS_LOCAL__ */
