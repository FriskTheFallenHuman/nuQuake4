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

#ifndef __SIMPLEWIN_H__
#define __SIMPLEWIN_H__

class idUserInterfaceLocal;
class idDeviceContext;
class idSimpleWindow;

typedef struct {
	idWindow *win;
	idSimpleWindow *simp;
} drawWin_t;

class idSimpleWindow {
	friend class idWindow;
public:
					idSimpleWindow(idWindow* win);
	virtual			~idSimpleWindow();
	void			Redraw(float x, float y);
	void			StateChanged( bool redraw );
	void			ResetCinematics();

	idStr			name;

	idWinVar *		GetWinVarByName(const char *_name);
	int				GetWinVarOffset( idWinVar *wv, drawWin_t* owner);
	size_t			Size();
	bool			GetMaxTextIndex( const char *text, wrapInfo_t& wrapInfo ) const;

	idWindow*		GetParent ( void ) { return mParent; }

	virtual void	WriteToSaveGame( idFile *savefile );
	virtual void	ReadFromSaveGame( idFile *savefile );

protected:
	void 			CalcClientRect(float xofs, float yofs);
	void 			SetupTransforms(float x, float y);
	void 			DrawBackground(const idRectangle &drawRect);
	void 			DrawBorderAndCaption(const idRectangle &drawRect);

	idUserInterfaceLocal *gui;
	idDeviceContext *dc;
	int 			flags;
	idRectangle 	drawRect;			// overall rect
	idRectangle 	clientRect;			// client area
	idRectangle 	textRect;
	idVec2			origin;
	int 			fontNum;
	float 			matScalex;
	float 			matScaley;
	float 			borderSize;
	int 			textAlign;
	float 			textAlignx;
	float 			textAligny;
	float			textSpacing;
	int				textStyle;
	int				textShadow;

	idWinStr		text;
	idWinBool		visible;
	idWinRectangle	rect;				// overall rect
	idWinVec4		backColor;
	idWinVec4		matColor;
	idWinVec4		foreColor;
	idWinVec4		borderColor;
	idWinFloat		textScale;
	idWinFloat		rotate;
	idWinVec2		shear;
	idWinBackground	backGroundName;

	const idMaterial* background;
	
	idWindow *		mParent;

	idWinBool	hideCursor;
	idList<idWinVar *> definedVars;
};

#endif /* !__SIMPLEWIN_H__ */
