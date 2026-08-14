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

#include "../idlib/precompiled.h"
#pragma hdrstop
#include "sys_local.h"
#include "win32/win_local.h"

const char * sysLanguageNames[] = {
	"english", "spanish", "italian", "german", "french", "russian", 
	"polish", "korean", "japanese", "chinese", NULL
};

idCVar sys_lang( "sys_lang", "english", CVAR_SYSTEM | CVAR_ARCHIVE,  "", sysLanguageNames, idCmdSystem::ArgCompletion_String<sysLanguageNames> );

idSysLocal			sysLocal;
idSys *				sys = &sysLocal;

idSysLocal::keyPress_t idSysLocal::keyPress[256];
int idSysLocal::head = 0;
int idSysLocal::tail = 0;
int idSysLocal::free = 250;

void idSysLocal::DebugPrintf( const char *fmt, ... ) {
	va_list argptr;

	va_start( argptr, fmt );
	Sys_DebugVPrintf( fmt, argptr );
	va_end( argptr );
}

void idSysLocal::DebugVPrintf( const char *fmt, va_list arg ) {
	Sys_DebugVPrintf( fmt, arg );
}

double idSysLocal::GetClockTicks( void ) {
	return Sys_GetClockTicks();
}

double idSysLocal::ClockTicksPerSecond( void ) {
	return Sys_ClockTicksPerSecond();
}

cpuid_t idSysLocal::GetProcessorId( void ) {
	return Sys_GetProcessorId();
}

const char *idSysLocal::GetProcessorString( void ) {
	return Sys_GetProcessorString();
}

const char *idSysLocal::FPU_GetState( void ) {
	return Sys_FPU_GetState();
}

bool idSysLocal::FPU_StackIsEmpty( void ) {
	return Sys_FPU_StackIsEmpty();
}

void idSysLocal::FPU_SetFTZ( bool enable ) {
	Sys_FPU_SetFTZ( enable );
}

void idSysLocal::FPU_SetDAZ( bool enable ) {
	Sys_FPU_SetDAZ( enable );
}

bool idSysLocal::LockMemory( void *ptr, int bytes ) {
	return Sys_LockMemory( ptr, bytes );
}

bool idSysLocal::UnlockMemory( void *ptr, int bytes ) {
	return Sys_UnlockMemory( ptr, bytes );
}

void idSysLocal::GetCallStack( address_t *callStack, const int callStackSize ) {
	Sys_GetCallStack( callStack, callStackSize );
}

const char * idSysLocal::GetCallStackStr( const address_t *callStack, const int callStackSize ) {
	return Sys_GetCallStackStr( callStack, callStackSize );
}

const char * idSysLocal::GetCallStackCurStr( int depth ) {
	return Sys_GetCallStackCurStr( depth );
}

void idSysLocal::ShutdownSymbols( void ) {
	Sys_ShutdownSymbols();
}

int idSysLocal::DLL_Load( const char *dllName ) {
	return Sys_DLL_Load( dllName );
}

void *idSysLocal::DLL_GetProcAddress( int dllHandle, const char *procName ) {
	return Sys_DLL_GetProcAddress( dllHandle, procName );
}

void idSysLocal::DLL_Unload( int dllHandle ) {
	Sys_DLL_Unload( dllHandle );
}

void idSysLocal::DLL_GetFileName( const char *baseName, char *dllName, int maxLength ) {
#ifdef _WIN32
	idStr::snPrintf( dllName, maxLength, "%s" CPUSTRING ".dll", baseName );
#elif defined( __linux__ )
	idStr::snPrintf( dllName, maxLength, "%s" CPUSTRING ".so", baseName );
#elif defined( MACOS_X )
	idStr::snPrintf( dllName, maxLength, "%s" ".dylib", baseName );
#else
#error OS define is required
#endif
}

sysEvent_t idSysLocal::GenerateMouseButtonEvent( int button, bool down ) {
	sysEvent_t ev;
	ev.evType = SE_KEY;
	ev.evValue = K_MOUSE1 + button - 1;
	ev.evValue2 = down;
	ev.evPtrLength = 0;
	ev.evPtr = NULL;
	return ev;
}

sysEvent_t idSysLocal::GenerateMouseMoveEvent( int deltax, int deltay ) {
	sysEvent_t ev;
	ev.evType = SE_MOUSE;
	ev.evValue = deltax;
	ev.evValue2 = deltay;
	ev.evPtrLength = 0;
	ev.evPtr = NULL;
	return ev;
}

void idSysLocal::FPU_SetPrecision( int flags ) {
	Sys_FPU_SetPrecision( flags );
}

int idSysLocal::MapKey( unsigned long lParam, unsigned short wParam ) {
	return Sys_MapKey( lParam, wParam );
}

void idSysLocal::AddKeyPress( int key, bool state ) {
	if ( free <= 0 ) {
		return;
	}
	free--;
	keyPress[head].keynum = (short)key;
	keyPress[head].state = state;
	head = ( head + 1 ) & 255;
}

bool idSysLocal::GetKeyPress( const int n, int &key, bool &state ) {
	(void)n;
	if ( free >= 250 ) {
		return false;
	}
	key = keyPress[tail].keynum;
	state = keyPress[tail].state;
	free++;
	tail = ( tail + 1 ) & 255;
	return true;
}

int idSysLocal::GetNumKeyPresses( void ) {
	return 250 - free;
}

void idSysLocal::ShowConsole( int visLevel, bool quitOnClose ) { Sys_ShowConsole( visLevel, quitOnClose ); }
void idSysLocal::UpdateConsole( void ) {}
void idSysLocal::SetConsoleName( const char *consoleName ) { SetConsoleTitleA( consoleName ? consoleName : "Quake4" ); }
bool idSysLocal::IsAppActive( void ) const { return win32.activeApp; }
int idSysLocal::Milliseconds( void ) { return Sys_Milliseconds(); }
void idSysLocal::InitInput( void ) { Sys_InitInput(); }
void idSysLocal::ShutdownInput( void ) { Sys_ShutdownInput(); }
void idSysLocal::GenerateEvents( void ) { Sys_GenerateEvents(); }
void idSysLocal::GrabMouseCursor( bool grabIt ) { Sys_GrabMouseCursor( grabIt ); }

FILE *idSysLocal::FOpen( const char *name, const char *mode ) { return fopen( name, mode ); }
void idSysLocal::FPrintf( FILE *file, const char *fmt ) { fprintf( file, "%s", fmt ); }
int idSysLocal::FTell( FILE *file ) { return ftell( file ); }
int idSysLocal::FSeek( FILE *file, long offset, int mode ) { return fseek( file, offset, mode ); }
void idSysLocal::FClose( FILE *file ) { fclose( file ); }
int idSysLocal::FRead( void *buffer, int size, int count, FILE *file ) { return fread( buffer, size, count, file ); }
int idSysLocal::FWrite( void *buffer, int size, int count, FILE *file ) { return fwrite( buffer, size, count, file ); }
long idSysLocal::FileTimeStamp( FILE *file ) { return (long)Sys_FileTimeStamp( file ); }
int idSysLocal::FEof( FILE *stream ) { return feof( stream ); }
char *idSysLocal::FGets( char *string, int n, FILE *stream ) { return fgets( string, n, stream ); }
void idSysLocal::FFlush( FILE *file ) { fflush( file ); }
int idSysLocal::SetVBuf( FILE *stream, char *buffer, int mode, size_t size ) { return setvbuf( stream, buffer, mode, size ); }

int idSysLocal::GetGUID( char *buf, int buflen ) {
	if ( buf && buflen > 0 ) {
		buf[0] = '\0';
	}
	return 0;
}

/*
=================
Sys_TimeStampToStr
=================
*/
const char *Sys_TimeStampToStr( long timeStamp ) {
	static char timeString[MAX_STRING_CHARS];
	timeString[0] = '\0';

	time_t localTimeStamp = (time_t)timeStamp;
	tm*	time = localtime( &localTimeStamp );
	idStr out;
	
	idStr lang = cvarSystem->GetCVarString( "sys_lang" );
	if ( lang.Icmp( "english" ) == 0 ) {
		// english gets "month/day/year  hour:min" + "am" or "pm"
		out = va( "%02d", time->tm_mon + 1 );
		out += "/";
		out += va( "%02d", time->tm_mday );
		out += "/";
		out += va( "%d", time->tm_year + 1900 );
		out += "\t";
		if ( time->tm_hour > 12 ) {
			out += va( "%02d", time->tm_hour - 12 );
		} else if ( time->tm_hour == 0 ) {
				out += "12";
		} else {
			out += va( "%02d", time->tm_hour );
		}
		out += ":";
		out +=va( "%02d", time->tm_min );
		if ( time->tm_hour >= 12 ) {
			out += "pm";
		} else {
			out += "am";
		}
	} else {
		// europeans get "day/month/year  24hour:min"
		out = va( "%02d", time->tm_mday );
		out += "/";
		out += va( "%02d", time->tm_mon + 1 );
		out += "/";
		out += va( "%d", time->tm_year + 1900 );
		out += "\t";
		out += va( "%02d", time->tm_hour );
		out += ":";
		out += va( "%02d", time->tm_min );
	}
	idStr::Copynz( timeString, out, sizeof( timeString ) );

	return timeString;
}
