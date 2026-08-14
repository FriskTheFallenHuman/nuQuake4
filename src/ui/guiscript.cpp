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

#include "Window.h"
#include "Winvar.h"
#include "GuiScript.h"
#include "UserInterfaceLocal.h"


/*
=========================
Script_Set
=========================
*/
void Script_Set(idWindow *window, idList<idGSWinVar> *src) {
	idStr key, val;
	idWinStr *dest = dynamic_cast<idWinStr*>((*src)[0].var);
	if (dest) {
		if (idStr::Icmp(*dest, "cmd") == 0) {
			dest = dynamic_cast<idWinStr*>((*src)[1].var);
			int parmCount = src->Num();
			if (parmCount > 2) {
				val = dest->c_str();
				int i = 2;
				while (i < parmCount) {
					val += " \"";
					val += (*src)[i].var->c_str();
					val += "\"";
					i++;
				}
				window->AddCommand(val);
			} else {
				window->AddCommand(*dest);
			}
			return;
		} 
	}
	(*src)[0].var->Set((*src)[1].var->c_str());
	(*src)[0].var->SetEval(false);
}

/*
=========================
Script_SetFocus
=========================
*/
void Script_SetFocus(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if (parm) {
		drawWin_t *win = window->GetGui()->GetDesktop()->FindChildByName(*parm);
		if (win && win->win) {
			window->SetFocus(win->win);
		}
	}
}

/*
=========================
Script_ShowCursor
=========================
*/
void Script_ShowCursor(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if ( parm ) {
		if ( atoi( *parm ) ) {
			window->GetGui()->GetDesktop()->ClearFlag( WIN_NOCURSOR );
		} else {
			window->GetGui()->GetDesktop()->SetFlag( WIN_NOCURSOR );
		}
	}
}

/*
=========================
Script_RunScript

 run scripts must come after any set cmd set's in the script
=========================
*/
void Script_RunScript(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if (parm) {
		idStr str = window->cmd;
		str += " ; runScript ";
		str += parm->c_str();
		window->cmd = str;
	}
}

/*
=========================
Script_LocalSound
=========================
*/
void Script_LocalSound(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if (parm) {
		soundSystem->PlayShaderDirectly( 1, *parm, -1 );
	}
}

void Script_SetLightColor(idWindow *window, idList<idGSWinVar> *src) {
	idWinVec4 *color = dynamic_cast<idWinVec4*>((*src)[0].var);
	window->GetGui()->SetLightColorVar( color );
}

void Script_NonInteractive(idWindow *window, idList<idGSWinVar> *src) {
	bool interactive = false;
	if ( src->Num() > 0 ) {
		idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
		interactive = parm && atoi( parm->c_str() ) == 0;
	}
	window->GetGui()->SetInteractive( interactive );
}

void Script_ResetVideo(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	drawWin_t *drawWin = parm ? window->GetGui()->GetDesktop()->FindChildByName( parm->c_str() ) : NULL;
	if ( drawWin && drawWin->win ) {
		drawWin->win->ResetCinematics();
		drawWin->win->EvalRegs( -1, true );
	} else if ( drawWin && drawWin->simp ) {
		drawWin->simp->ResetCinematics();
	} else {
		window->ResetCinematics();
		window->EvalRegs( -1, true );
	}
}

void Script_NamedEvent(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if ( !parm ) {
		return;
	}
	idStr event = parm->c_str();
	const int separator = event.Find( "::" );
	if ( separator <= 0 ) {
		window->GetGui()->HandleNamedEvent( event );
		return;
	}
	idStr windowName = event.Left( separator );
	idStr windowEvent = event.Right( event.Length() - separator - 2 );
	drawWin_t *drawWin = window->GetGui()->GetDesktop()->FindChildByName( windowName );
	if ( drawWin && drawWin->win ) {
		drawWin->win->RunNamedEvent( windowEvent );
	}
}

void Script_StopTransitions(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	if ( !parm ) {
		return;
	}
	drawWin_t *drawWin = window->GetGui()->GetDesktop()->FindChildByName( parm->c_str() );
	if ( drawWin && drawWin->win ) {
		drawWin->win->ClearTransitions();
	}
}

void Script_ConsoleCmd(idWindow *window, idList<idGSWinVar> *src) {
	idStr command;
	for ( int i = 0; i < src->Num(); ++i ) {
		if ( i > 0 ) {
			command += " ";
		}
		command += (*src)[i].var->c_str();
	}
	command += " \n";
	cmdSystem->BufferCommandText( CMD_EXEC_APPEND, command );
}

/*
=========================
Script_EvalRegs
=========================
*/
void Script_EvalRegs(idWindow *window, idList<idGSWinVar> *src) {
	window->EvalRegs(-1, true);
}

/*
=========================
Script_EndGame
=========================
*/
void Script_EndGame( idWindow *window, idList<idGSWinVar> *src ) {
	cvarSystem->SetCVarBool( "g_nightmare", true );
	cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "disconnect\n" );
}

/*
=========================
Script_ResetTime
=========================
*/
void Script_ResetTime(idWindow *window, idList<idGSWinVar> *src) {
	idWinStr *parm = dynamic_cast<idWinStr*>((*src)[0].var);
	drawWin_t *win = NULL;
	if (parm && src->Num() > 1) {
		win = window->GetGui()->GetDesktop()->FindChildByName(*parm);
		parm = dynamic_cast<idWinStr*>((*src)[1].var);
	}
	if (win && win->win) {
		win->win->ResetTime(atoi(*parm));
		win->win->EvalRegs(-1, true);
	} else {
		window->ResetTime(atoi(*parm));
		window->EvalRegs(-1, true);
	}
}

/*
=========================
Script_ResetCinematics
=========================
*/
void Script_ResetCinematics(idWindow *window, idList<idGSWinVar> *src) {
	window->ResetCinematics();
}

/*
=========================
Script_Transition
=========================
*/
void Script_Transition(idWindow *window, idList<idGSWinVar> *src) {
	if ( src->Num() < 4 ) {
		return;
	}

	idWinVar *destination = (*src)[0].var;
	idWinInt *timeVar = dynamic_cast<idWinInt *>( (*src)[3].var );
	if ( !destination || !timeVar ) {
		common->Warning( "Bad transition in gui %s in window %s\n", window->GetGui()->GetSourceFile(), window->GetName() );
		return;
	}

	idVec4 from;
	idVec4 to;
	idWinVec4 *fromVec = dynamic_cast<idWinVec4 *>( (*src)[1].var );
	idWinVec4 *toVec = dynamic_cast<idWinVec4 *>( (*src)[2].var );
	if ( fromVec ) {
		from = static_cast<const idVec4 &>( *fromVec );
	} else {
		const float value = (*src)[1].var->x();
		from.Set( value, value, value, value );
	}
	if ( toVec ) {
		to = static_cast<const idVec4 &>( *toVec );
	} else {
		const float value = (*src)[2].var->x();
		to.Set( value, value, value, value );
	}

	float accel = 0.0f;
	float decel = 0.0f;
	if ( src->Num() > 5 ) {
		idWinFloat *accelVar = dynamic_cast<idWinFloat *>( (*src)[4].var );
		idWinFloat *decelVar = dynamic_cast<idWinFloat *>( (*src)[5].var );
		if ( accelVar && decelVar ) {
			accel = *accelVar;
			decel = *decelVar;
		}
	}

	destination->SetEval( false );
	window->AddTransition( destination, from, to, *timeVar, accel, decel );
	window->StartTransition();
}

typedef struct {
	const char *name;
	void (*handler) (idWindow *window, idList<idGSWinVar> *src);
	int mMinParms;
	int mMaxParms;
} guiCommandDef_t;

guiCommandDef_t commandList[] = {
	{ "set", Script_Set, 2, 999 },
	{ "setFocus", Script_SetFocus, 1, 2 },
	{ "endGame", Script_EndGame, 0, 0 },
	{ "consoleCmd", Script_ConsoleCmd, 0, 10 },
	{ "resetTime", Script_ResetTime, 1, 2 },
	{ "showCursor", Script_ShowCursor, 1, 1 },
	{ "resetCinematics", Script_ResetCinematics, 0, 2 },
	{ "resetVideo", Script_ResetVideo, 1, 1 },
	{ "transition", Script_Transition, 4, 6 },
	{ "localSound", Script_LocalSound, 1, 1 },
	{ "runScript", Script_RunScript, 1, 1 },
	{ "evalRegs", Script_EvalRegs, 0, 0 },
	{ "setlightcolor", Script_SetLightColor, 1, 1 },
	{ "namedEvent", Script_NamedEvent, 1, 1 },
	{ "stopTransitions", Script_StopTransitions, 1, 1 },
	{ "nonInteractive", Script_NonInteractive, 0, 1 }
};

int	scriptCommandCount = sizeof(commandList) / sizeof(guiCommandDef_t);


/*
=========================
idGuiScript::idGuiScript
=========================
*/
idGuiScript::idGuiScript() {
	ifList = NULL;
	elseList = NULL;
	conditionReg = -1;
	handler = NULL;
	parms.SetGranularity( 2 );
}

/*
=========================
idGuiScript::~idGuiScript
=========================
*/
idGuiScript::~idGuiScript() {
	delete ifList;
	delete elseList;
	int c = parms.Num();
	for ( int i = 0; i < c; i++ ) {
		if ( parms[i].own ) {
			delete parms[i].var;
		}
	}
}

/*
=========================
idGuiScript::WriteToSaveGame
=========================
*/
void idGuiScript::WriteToSaveGame( idFile *savefile ) {
	int i;

	if ( ifList ) {
		ifList->WriteToSaveGame( savefile );
	}
	if ( elseList ) {
		elseList->WriteToSaveGame( savefile );
	}

	savefile->Write( &conditionReg, sizeof( conditionReg ) );

	for ( i = 0; i < parms.Num(); i++ ) {
		if ( parms[i].own ) {
			parms[i].var->WriteToSaveGame( savefile );
		}
	}
}

/*
=========================
idGuiScript::ReadFromSaveGame
=========================
*/
void idGuiScript::ReadFromSaveGame( idFile *savefile ) {
	int i;

	if ( ifList ) {
		ifList->ReadFromSaveGame( savefile );
	}
	if ( elseList ) {
		elseList->ReadFromSaveGame( savefile );
	}

	savefile->Read( &conditionReg, sizeof( conditionReg ) );

	for ( i = 0; i < parms.Num(); i++ ) {
		if ( parms[i].own ) {
			parms[i].var->ReadFromSaveGame( savefile );
		}
	}
}

/*
=========================
idGuiScript::Parse
=========================
*/
bool idGuiScript::Parse(idParser *src) {
	int i;
	
	// first token should be function call
	// then a potentially variable set of parms
	// ended with a ;
	idToken token;
	if ( !src->ReadToken(&token) ) {
		src->Error( "Unexpected end of file" );
		return false;
	}

	handler	= NULL;
	
	for ( i = 0; i < scriptCommandCount ; i++ ) {
		if ( idStr::Icmp(token, commandList[i].name) == 0 ) {
			handler = commandList[i].handler;
			break;
		}
	}

	if (handler == NULL) {
		src->Error("Uknown script call %s", token.c_str());
	}
	// now read parms til ;
	// all parms are read as idWinStr's but will be fixed up later 
	// to be proper types
	while (1) {
		if ( !src->ReadToken(&token) ) {
			src->Error( "Unexpected end of file" );
			return false;
		}
		
		if (idStr::Icmp(token, ";") == 0) {
			break;
		}

		if (idStr::Icmp(token, "}") == 0) {
			src->UnreadToken(&token);
			break;
		}

		idWinStr *str = new idWinStr();
		*str = token;
		idGSWinVar wv;
		wv.own = true;
		wv.var = str;
		parms.Append( wv );
	}

	// 
	//  verify min/max params
	if ( handler && (parms.Num() < commandList[i].mMinParms || parms.Num() > commandList[i].mMaxParms ) ) {
		src->Error("incorrect number of parameters for script %s", commandList[i].name );
	}
	// 

	return true;
}

/*
=========================
idGuiScriptList::Execute
=========================
*/
void idGuiScriptList::Execute(idWindow *win) {
	int c = list.Num();
	for (int i = 0; i < c; i++) {
		idGuiScript *gs = list[i];
		assert(gs);
		if (gs->conditionReg >= 0) {
			if (win->HasOps()) {
				float f = win->EvalRegs(gs->conditionReg);
				if (f) {
					if (gs->ifList) {
						win->RunScriptList(gs->ifList);
					}
				} else if (gs->elseList) {
					win->RunScriptList(gs->elseList);
				}
			}
		}
		gs->Execute(win);
	}
}

/*
=========================
idGuiScriptList::FixupParms
=========================
*/
void idGuiScript::FixupParms(idWindow *win) {
	if (handler == &Script_Set) {
		bool precacheBackground = false;
		bool precacheSounds = false;
		idWinStr *str = dynamic_cast<idWinStr*>(parms[0].var);
		assert(str);
		idWinVar *dest = win->GetWinVarByName(*str, true);
		// Quake 4 binds every valid winvar destination here.  Restricting this
		// to transition-compatible numeric types leaves bool/string/int set
		// commands pointing at their temporary parser strings.
		if ( dest ) {
			delete parms[0].var;
			parms[0].var = dest;
			parms[0].own = false;

			if ( dynamic_cast<idWinBackground *>(dest) != NULL ) {
				precacheBackground = true;
			}
		} else if ( idStr::Icmp( str->c_str(), "cmd" ) == 0 ) {
			precacheSounds = true;
		}
		int parmCount = parms.Num();
		for (int i = 1; i < parmCount; i++) {
			idWinStr *str = dynamic_cast<idWinStr*>(parms[i].var);		
			if (idStr::Icmpn(*str, "gui::", 5) == 0) {

				//  always use a string here, no point using a float if it is one
				//  FIXME: This creates duplicate variables, while not technically a problem since they
				//  are all bound to the same guiDict, it does consume extra memory and is generally a bad thing
				idWinStr* defvar = new idWinStr();
				defvar->Init ( *str, win );
				win->AddDefinedVar ( defvar );
				delete parms[i].var;
				parms[i].var = defvar;
				parms[i].own = false;

				//dest = win->GetWinVarByName(*str, true);
				//if (dest) {
				//	delete parms[i].var;
				//	parms[i].var = dest;
				//	parms[i].own = false;
				//}
				// 
			} else if ((*str[0]) == '$') {
				// 
				//  dont include the $ when asking for variable
				dest = win->GetGui()->GetDesktop()->GetWinVarByName((const char*)(*str) + 1, true);
				// 					
				if (dest) {
					delete parms[i].var;
					parms[i].var = dest;
					parms[i].own = false;
				}
			} else if ( idStr::Cmpn( str->c_str(), STRTABLE_ID, STRTABLE_ID_LENGTH ) == 0 ) {
				str->Set( common->GetLocalizedString( str->c_str() ) );
			} else if ( precacheBackground ) {
				const idMaterial *mat = declManager->FindMaterial( str->c_str() );
				mat->SetSort( SS_GUI );
			} else if ( precacheSounds ) {
				// Search for "play <...>"
				idToken token;
				idParser parser( LEXFL_NOSTRINGCONCAT | LEXFL_ALLOWMULTICHARLITERALS | LEXFL_ALLOWBACKSLASHSTRINGCONCAT );
				parser.LoadMemory(str->c_str(), str->Length(), "command");

				while ( parser.ReadToken(&token) ) {
					if ( token.Icmp("play") == 0 ) {
						if ( parser.ReadToken(&token) && ( token != "" ) ) {
							declManager->FindSound( token.c_str() );
						}
					}
				}
			}
		}
	} else if (handler == &Script_Transition) {
		if (parms.Num() < 4) {
			common->Warning("Window %s in gui %s has a bad transition definition", win->GetName(), win->GetGui()->GetSourceFile());
			handler = NULL;
			return;
		}
		idWinStr *str = dynamic_cast<idWinStr*>(parms[0].var);
		assert(str);

		drawWin_t *destOwner = NULL;
		idWinVar *dest = win->GetWinVarByName(*str, true, &destOwner );
		idWinVec4 *destVec = dynamic_cast<idWinVec4 *>( dest );
		idWinFloat *destFloat = dynamic_cast<idWinFloat *>( dest );
		idWinRectangle *destRect = dynamic_cast<idWinRectangle *>( dest );
		idWinFloatMember *destMember = dynamic_cast<idWinFloatMember *>( dest );
		if ( !destVec && !destFloat && !destRect && !destMember ) {
			common->Warning("Window %s in gui %s: a transition does not have a valid destination var %s", win->GetName(), win->GetGui()->GetSourceFile(),str->c_str());
			handler = NULL;
			return;
		}
		delete parms[0].var;
		parms[0].var = dest;
		parms[0].own = false;

		// Quake 4 retains scalar transition parameters as floats and vector /
		// rectangle parameters as vec4s.  Script_Transition then expands a
		// scalar into all four interpolation lanes.
		for ( int c = 1; c < 3; c++ ) {
			str = dynamic_cast<idWinStr*>(parms[c].var);
			assert( str );

			if ( str->c_str()[0] == '$' ) {
				drawWin_t *sourceOwner = NULL;
				idWinVar *source = win->GetWinVarByName( str->c_str() + 1, true, &sourceOwner );
				idWinVec4 *sourceVec = dynamic_cast<idWinVec4 *>( source );
				idWinFloat *sourceFloat = dynamic_cast<idWinFloat *>( source );
				idWinRectangle *sourceRect = dynamic_cast<idWinRectangle *>( source );
				idWinFloatMember *sourceMember = dynamic_cast<idWinFloatMember *>( source );

				const bool compatible =
					( destVec && sourceVec ) ||
					( destFloat && sourceFloat ) ||
					( destRect && ( sourceVec || sourceRect ) ) ||
					( destMember && ( sourceFloat || sourceMember ) );
				if ( !compatible ) {
					common->Warning( "Window %s in gui %s: transition has an invalid parameter %d (%s)",
						win->GetName(), win->GetGui()->GetSourceFile(), c, str->c_str() );
					handler = NULL;
					return;
				}

				if ( destRect && sourceRect ) {
					idWinVec4 *value = new idWinVec4;
					*value = idVec4( 0.0f, 0.0f, 0.0f, 0.0f );
					idWindow *sourceParent = sourceOwner ?
						( sourceOwner->simp ? sourceOwner->simp->GetParent() : sourceOwner->win->GetParent() ) : NULL;
					idWindow *destinationParent = destOwner ?
						( destOwner->simp ? destOwner->simp->GetParent() : destOwner->win->GetParent() ) : NULL;
					if ( sourceParent && destinationParent ) {
						idRectangle rect = *sourceRect;
						sourceParent->ClientToScreen( &rect );
						destinationParent->ScreenToClient( &rect );
						*value = rect.ToVec4();
					} else {
						value->Set( sourceRect->c_str() );
					}
					parms[c].var = value;
					parms[c].own = true;
				} else {
					parms[c].var = source;
					parms[c].own = false;
				}
			} else {
				idWinVar *value;
				if ( destVec || destRect ) {
					idWinVec4 *vecValue = new idWinVec4;
					*vecValue = idVec4( 0.0f, 0.0f, 0.0f, 0.0f );
					value = vecValue;
				} else {
					value = new idWinFloat;
				}
				value->Set( str->c_str() );
				parms[c].var = value;
				parms[c].own = true;
			}

			delete str;
		}

		str = dynamic_cast<idWinStr *>( parms[3].var );
		assert( str );
		idWinInt *time = new idWinInt;
		time->Set( str->c_str() );
		delete str;
		parms[3].var = time;
		parms[3].own = true;

		for ( int i = 4; i < parms.Num() && i < 6; i++ ) {
			str = dynamic_cast<idWinStr *>( parms[i].var );
			assert( str );
			idWinFloat *value = new idWinFloat;
			value->Set( str->c_str() );
			delete str;
			parms[i].var = value;
			parms[i].own = true;
		}

	} else {
		int c = parms.Num();
		for (int i = 0; i < c; i++) {
			parms[i].var->Init(parms[i].var->c_str(), win);
		}
	}
}

/*
=========================
idGuiScriptList::FixupParms
=========================
*/
void idGuiScriptList::FixupParms(idWindow *win) {
	int c = list.Num();
	for (int i = 0; i < c; i++) {
		idGuiScript *gs = list[i];
		gs->FixupParms(win);
		if (gs->ifList) {
			gs->ifList->FixupParms(win);
		}
		if (gs->elseList) {
			gs->elseList->FixupParms(win);
		}
	}
}

/*
=========================
idGuiScriptList::WriteToSaveGame
=========================
*/
void idGuiScriptList::WriteToSaveGame( idFile *savefile ) {
	int i;

	for ( i = 0; i < list.Num(); i++ ) {
		list[i]->WriteToSaveGame( savefile );
	}
}

/*
=========================
idGuiScriptList::ReadFromSaveGame
=========================
*/
void idGuiScriptList::ReadFromSaveGame( idFile *savefile ) {
	int i;

	for ( i = 0; i < list.Num(); i++ ) {
		list[i]->ReadFromSaveGame( savefile );
	}
}
