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

#include "DeviceContext.h"

idVec4 idDeviceContext::colorPurple;
idVec4 idDeviceContext::colorOrange;
idVec4 idDeviceContext::colorYellow;
idVec4 idDeviceContext::colorGreen;
idVec4 idDeviceContext::colorBlue;
idVec4 idDeviceContext::colorRed;
idVec4 idDeviceContext::colorBlack;
idVec4 idDeviceContext::colorWhite;
idVec4 idDeviceContext::colorNone;


idCVar gui_smallFontLimit( "gui_smallFontLimit", "0.30", CVAR_GUI | CVAR_ARCHIVE, "" );
idCVar gui_mediumFontLimit( "gui_mediumFontLimit", "0.60", CVAR_GUI | CVAR_ARCHIVE, "" );


idList<fontInfoEx_t> idDeviceContext::fonts;

int idDeviceContext::FindFont( const char *name ) {
	int c = fonts.Num();
	for (int i = 0; i < c; i++) {
		if (idStr::Icmp(name, fonts[i].name) == 0) {
			return i;
		}
	}

	// If the font was not found, try to register it
	idStr fileName = name;
	fileName.Replace("fonts", va("fonts/%s", fontLang.c_str()) );

	fontInfoEx_t fontInfo;
		int index = fonts.Append( fontInfo );
		if ( renderSystem->RegisterFont( fileName, fonts[index] ) ){
		idStr::Copynz( fonts[index].name, name, sizeof( fonts[index].name ) );
		return index;
		} else {
		common->Printf( "Could not register font %s [%s]\n", name, fileName.c_str() );
		return -1;
}
}

void idDeviceContext::SetupFonts() {
	fonts.SetGranularity( 1 );

	fontLang = cvarSystem->GetCVarString( "sys_lang" );
	
	// western european languages can use the english font
	if ( fontLang == "french" || fontLang == "german" || fontLang == "spanish" || fontLang == "italian" ) {
		fontLang = "english";
	}

	// Default font has to be added first.  Quake 4's default face is the
	// language-specific chain font (fonts/<language>/chain_*.fontdat).
	FindFont( "fonts/chain" );
}

void idDeviceContext::SetFont( int num ) {
	if ( num >= 0 && num < fonts.Num() ) {
		activeFont = &fonts[num];
	} else {
		activeFont = &fonts[0];
	}
}


void idDeviceContext::Init() {
	xScale = 0.0;
	SetSize(VIRTUAL_WIDTH, VIRTUAL_HEIGHT);
	whiteImage = declManager->FindMaterial("gfx/guis/white.tga");
	whiteImage->SetSort( SS_GUI );
	mbcs = false;
	SetupFonts();
	activeFont = &fonts[0];
	colorPurple = idVec4(1, 0, 1, 1);
	colorOrange = idVec4(1, 1, 0, 1);
	colorYellow = idVec4(0, 1, 1, 1);
	colorGreen = idVec4(0, 1, 0, 1);
	colorBlue = idVec4(0, 0, 1, 1);
	colorRed = idVec4(1, 0, 0, 1);
	colorWhite = idVec4(1, 1, 1, 1);
	colorBlack = idVec4(0, 0, 0, 1);
	colorNone = idVec4(0, 0, 0, 0);
	cursorImages[CURSOR_ARROW] = declManager->FindMaterial("gfx/guis/guicursor_arrow.tga");
	cursorImages[CURSOR_HAND] = declManager->FindMaterial("gfx/guis/guicursor_hand.tga");
	scrollBarImages[SCROLLBAR_HBACK] = declManager->FindMaterial("gfx/guis/scrollbarh.tga");
	scrollBarImages[SCROLLBAR_VBACK] = declManager->FindMaterial("gfx/guis/scrollbarv.tga");
	scrollBarImages[SCROLLBAR_THUMB] = declManager->FindMaterial("gfx/guis/scrollbar_thumb.tga");
	scrollBarImages[SCROLLBAR_RIGHT] = declManager->FindMaterial("gfx/guis/scrollbar_right.tga");
	scrollBarImages[SCROLLBAR_LEFT] = declManager->FindMaterial("gfx/guis/scrollbar_left.tga");
	scrollBarImages[SCROLLBAR_UP] = declManager->FindMaterial("gfx/guis/scrollbar_up.tga");
	scrollBarImages[SCROLLBAR_DOWN] = declManager->FindMaterial("gfx/guis/scrollbar_down.tga");
	cursorImages[CURSOR_ARROW]->SetSort( SS_GUI );
	cursorImages[CURSOR_HAND]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_HBACK]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_VBACK]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_THUMB]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_RIGHT]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_LEFT]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_UP]->SetSort( SS_GUI );
	scrollBarImages[SCROLLBAR_DOWN]->SetSort( SS_GUI );
	cursor = CURSOR_ARROW;
	enableClipping = true;
	overStrikeMode = true;
	mat.Identity();
	origin.Zero();
	initialized = true;
}

void idDeviceContext::Shutdown() {
	fontName.Clear();
	clipRects.Clear();
	fonts.Clear();
	Clear();
}

void idDeviceContext::Clear() {
	initialized = false;
	useFont = NULL;
	activeFont = NULL;
	mbcs = false;
}

idDeviceContext::idDeviceContext() {
	Clear();
}

void idDeviceContext::SetTransformInfo(const idVec3 &org, const idMat3 &m) {
	origin = org;
	mat = m;
}

// 
//  added method
void idDeviceContext::GetTransformInfo(idVec3& org, idMat3& m )
{
	m = mat;
	org = origin;
}
// 

void idDeviceContext::PopClipRect() {
	if (clipRects.Num()) {
		clipRects.RemoveIndex(clipRects.Num()-1);
	}
}

void idDeviceContext::PushClipRect(idRectangle r) {
	clipRects.Append(r);
}

void idDeviceContext::PushClipRect(float x, float y, float w, float h) {
	clipRects.Append(idRectangle(x, y, w, h));
}

bool idDeviceContext::ClippedCoords(float *x, float *y, float *w, float *h, float *s1, float *t1, float *s2, float *t2) {

	if ( enableClipping == false || clipRects.Num() == 0 ) {
		return false;
	}

	int c = clipRects.Num();
	while( --c > 0 ) {
		idRectangle *clipRect = &clipRects[c];
 
		float ox = *x;
		float oy = *y;
		float ow = *w;
		float oh = *h;

		if ( ow <= 0.0f || oh <= 0.0f ) {
			break;
		}

		if (*x < clipRect->x) {
			*w -= clipRect->x - *x;
			*x = clipRect->x;
		} else if (*x > clipRect->x + clipRect->w) {
			*x = *w = *y = *h = 0;
		}
		if (*y < clipRect->y) {
			*h -= clipRect->y - *y;
			*y = clipRect->y;
		} else if (*y > clipRect->y + clipRect->h) {
			*x = *w = *y = *h = 0;
		}
		if (*w > clipRect->w) {
			*w = clipRect->w - *x + clipRect->x;
		} else if (*x + *w > clipRect->x + clipRect->w) {
			*w = clipRect->Right() - *x;
		}
		if (*h > clipRect->h) {
			*h = clipRect->h - *y + clipRect->y;
		} else if (*y + *h > clipRect->y + clipRect->h) {
			*h = clipRect->Bottom() - *y;
		}

		if ( s1 && s2 && t1 && t2 && ow > 0.0f ) {
			float ns1, ns2, nt1, nt2;
			// upper left
			float u = ( *x - ox ) / ow;
			ns1 = *s1 * ( 1.0f - u ) + *s2 * ( u );

			// upper right
			u = ( *x + *w - ox ) / ow;
			ns2 = *s1 * ( 1.0f - u ) + *s2 * ( u );

			// lower left
			u = ( *y - oy ) / oh;
			nt1 = *t1 * ( 1.0f - u ) + *t2 * ( u );

			// lower right
			u = ( *y + *h - oy ) / oh;
			nt2 = *t1 * ( 1.0f - u ) + *t2 * ( u );

			// set values
			*s1 = ns1;
			*s2 = ns2;
			*t1 = nt1;
			*t2 = nt2;
		}
	}

	return (*w == 0 || *h == 0) ? true : false;
}


void idDeviceContext::AdjustCoords(float *x, float *y, float *w, float *h) {
	if (x) {
		*x *= xScale;
	}
	if (y) {
		*y *= yScale;
	}
	if (w) {
		*w *= xScale;
	}
	if (h) {
		*h *= yScale;
	}
}

void idDeviceContext::DrawStretchPic(float x, float y, float w, float h, float s1, float t1, float s2, float t2, const idMaterial *shader) {
	idDrawVert verts[4];
	glIndex_t indexes[6];
	indexes[0] = 3;
	indexes[1] = 0;
	indexes[2] = 2;
	indexes[3] = 2;
	indexes[4] = 0;
	indexes[5] = 1;
	verts[0].xyz[0] = x;
	verts[0].xyz[1] = y;
	verts[0].xyz[2] = 0;
	verts[0].st[0] = s1;
	verts[0].st[1] = t1;
	verts[0].normal[0] = 0;
	verts[0].normal[1] = 0;
	verts[0].normal[2] = 1;
	verts[0].tangents[0][0] = 1;
	verts[0].tangents[0][1] = 0;
	verts[0].tangents[0][2] = 0;
	verts[0].tangents[1][0] = 0;
	verts[0].tangents[1][1] = 1;
	verts[0].tangents[1][2] = 0;
	verts[1].xyz[0] = x + w;
	verts[1].xyz[1] = y;
	verts[1].xyz[2] = 0;
	verts[1].st[0] = s2;
	verts[1].st[1] = t1;
	verts[1].normal[0] = 0;
	verts[1].normal[1] = 0;
	verts[1].normal[2] = 1;
	verts[1].tangents[0][0] = 1;
	verts[1].tangents[0][1] = 0;
	verts[1].tangents[0][2] = 0;
	verts[1].tangents[1][0] = 0;
	verts[1].tangents[1][1] = 1;
	verts[1].tangents[1][2] = 0;
	verts[2].xyz[0] = x + w;
	verts[2].xyz[1] = y + h;
	verts[2].xyz[2] = 0;
	verts[2].st[0] = s2;
	verts[2].st[1] = t2;
	verts[2].normal[0] = 0;
	verts[2].normal[1] = 0;
	verts[2].normal[2] = 1;
	verts[2].tangents[0][0] = 1;
	verts[2].tangents[0][1] = 0;
	verts[2].tangents[0][2] = 0;
	verts[2].tangents[1][0] = 0;
	verts[2].tangents[1][1] = 1;
	verts[2].tangents[1][2] = 0;
	verts[3].xyz[0] = x;
	verts[3].xyz[1] = y + h;
	verts[3].xyz[2] = 0;
	verts[3].st[0] = s1;
	verts[3].st[1] = t2;
	verts[3].normal[0] = 0;
	verts[3].normal[1] = 0;
	verts[3].normal[2] = 1;
	verts[3].tangents[0][0] = 1;
	verts[3].tangents[0][1] = 0;
	verts[3].tangents[0][2] = 0;
	verts[3].tangents[1][0] = 0;
	verts[3].tangents[1][1] = 1;
	verts[3].tangents[1][2] = 0;
	
	bool ident = !mat.IsIdentity();
	if ( ident ) {
		verts[0].xyz -= origin;
		verts[0].xyz *= mat;
		verts[0].xyz += origin;
		verts[1].xyz -= origin;
		verts[1].xyz *= mat;
		verts[1].xyz += origin;
		verts[2].xyz -= origin;
		verts[2].xyz *= mat;
		verts[2].xyz += origin;
		verts[3].xyz -= origin;
		verts[3].xyz *= mat;
		verts[3].xyz += origin;
	}

	renderSystem->DrawStretchPic( &verts[0], &indexes[0], 4, 6, shader, ident );
	
}


void idDeviceContext::DrawMaterial(float x, float y, float w, float h, const idMaterial *mat, const idVec4 &color, float scalex, float scaley) {

	renderSystem->SetColor(color);

	float	s0, s1, t0, t1;
// 
//  handle negative scales as well	
	if ( scalex < 0 )
	{
		w *= -1;
		scalex *= -1;
	}
	if ( scaley < 0 )
	{
		h *= -1;
		scaley *= -1;
	}
// 
	if( w < 0 ) {	// flip about vertical
		w  = -w;
		s0 = 1 * scalex;
		s1 = 0;
	}
	else {
		s0 = 0;
		s1 = 1 * scalex;
	}

	if( h < 0 ) {	// flip about horizontal
		h  = -h;
		t0 = 1 * scaley;
		t1 = 0;
	}
	else {
		t0 = 0;
		t1 = 1 * scaley;
	}

	if ( ClippedCoords( &x, &y, &w, &h, &s0, &t0, &s1, &t1 ) ) {
		return;
	}

	AdjustCoords(&x, &y, &w, &h);

	DrawStretchPic( x, y, w, h, s0, t0, s1, t1, mat);
}

void idDeviceContext::DrawMaterialRotated(float x, float y, float w, float h, const idMaterial *mat, const idVec4 &color, float scalex, float scaley, float angle) {
	
	renderSystem->SetColor(color);

	float	s0, s1, t0, t1;
	// 
	//  handle negative scales as well	
	if ( scalex < 0 )
	{
		w *= -1;
		scalex *= -1;
	}
	if ( scaley < 0 )
	{
		h *= -1;
		scaley *= -1;
	}
	// 
	if( w < 0 ) {	// flip about vertical
		w  = -w;
		s0 = 1 * scalex;
		s1 = 0;
	}
	else {
		s0 = 0;
		s1 = 1 * scalex;
	}

	if( h < 0 ) {	// flip about horizontal
		h  = -h;
		t0 = 1 * scaley;
		t1 = 0;
	}
	else {
		t0 = 0;
		t1 = 1 * scaley;
	}

	if ( angle == 0.0f && ClippedCoords( &x, &y, &w, &h, &s0, &t0, &s1, &t1 ) ) {
		return;
	}

	AdjustCoords(&x, &y, &w, &h);

	DrawStretchPicRotated( x, y, w, h, s0, t0, s1, t1, mat, angle);
}

void idDeviceContext::DrawStretchPicRotated(float x, float y, float w, float h, float s1, float t1, float s2, float t2, const idMaterial *shader, float angle) {
	
	idDrawVert verts[4];
	glIndex_t indexes[6];
	indexes[0] = 3;
	indexes[1] = 0;
	indexes[2] = 2;
	indexes[3] = 2;
	indexes[4] = 0;
	indexes[5] = 1;
	verts[0].xyz[0] = x;
	verts[0].xyz[1] = y;
	verts[0].xyz[2] = 0;
	verts[0].st[0] = s1;
	verts[0].st[1] = t1;
	verts[0].normal[0] = 0;
	verts[0].normal[1] = 0;
	verts[0].normal[2] = 1;
	verts[0].tangents[0][0] = 1;
	verts[0].tangents[0][1] = 0;
	verts[0].tangents[0][2] = 0;
	verts[0].tangents[1][0] = 0;
	verts[0].tangents[1][1] = 1;
	verts[0].tangents[1][2] = 0;
	verts[1].xyz[0] = x + w;
	verts[1].xyz[1] = y;
	verts[1].xyz[2] = 0;
	verts[1].st[0] = s2;
	verts[1].st[1] = t1;
	verts[1].normal[0] = 0;
	verts[1].normal[1] = 0;
	verts[1].normal[2] = 1;
	verts[1].tangents[0][0] = 1;
	verts[1].tangents[0][1] = 0;
	verts[1].tangents[0][2] = 0;
	verts[1].tangents[1][0] = 0;
	verts[1].tangents[1][1] = 1;
	verts[1].tangents[1][2] = 0;
	verts[2].xyz[0] = x + w;
	verts[2].xyz[1] = y + h;
	verts[2].xyz[2] = 0;
	verts[2].st[0] = s2;
	verts[2].st[1] = t2;
	verts[2].normal[0] = 0;
	verts[2].normal[1] = 0;
	verts[2].normal[2] = 1;
	verts[2].tangents[0][0] = 1;
	verts[2].tangents[0][1] = 0;
	verts[2].tangents[0][2] = 0;
	verts[2].tangents[1][0] = 0;
	verts[2].tangents[1][1] = 1;
	verts[2].tangents[1][2] = 0;
	verts[3].xyz[0] = x;
	verts[3].xyz[1] = y + h;
	verts[3].xyz[2] = 0;
	verts[3].st[0] = s1;
	verts[3].st[1] = t2;
	verts[3].normal[0] = 0;
	verts[3].normal[1] = 0;
	verts[3].normal[2] = 1;
	verts[3].tangents[0][0] = 1;
	verts[3].tangents[0][1] = 0;
	verts[3].tangents[0][2] = 0;
	verts[3].tangents[1][0] = 0;
	verts[3].tangents[1][1] = 1;
	verts[3].tangents[1][2] = 0;

	bool ident = !mat.IsIdentity();
	if ( ident ) {
		verts[0].xyz -= origin;
		verts[0].xyz *= mat;
		verts[0].xyz += origin;
		verts[1].xyz -= origin;
		verts[1].xyz *= mat;
		verts[1].xyz += origin;
		verts[2].xyz -= origin;
		verts[2].xyz *= mat;
		verts[2].xyz += origin;
		verts[3].xyz -= origin;
		verts[3].xyz *= mat;
		verts[3].xyz += origin;
	}

	//Generate a translation so we can translate to the center of the image rotate and draw
	idVec3 origTrans;
	origTrans.x = x+(w/2);
	origTrans.y = y+(h/2);
	origTrans.z = 0;


	//Rotate the verts about the z axis before drawing them
	idMat4 rotz;
	rotz.Identity();
	float sinAng = idMath::Sin(angle);
	float cosAng = idMath::Cos(angle);
	rotz[0][0] = cosAng;
	rotz[0][1] = sinAng;
	rotz[1][0] = -sinAng;
	rotz[1][1] = cosAng;
	for(int i = 0; i < 4; i++) {
		//Translate to origin
		verts[i].xyz -= origTrans;

		//Rotate
		verts[i].xyz = rotz * verts[i].xyz;

		//Translate back
		verts[i].xyz += origTrans;
	}


	renderSystem->DrawStretchPic( &verts[0], &indexes[0], 4, 6, shader, (angle == 0.0) ? false : true );
}

void idDeviceContext::DrawFilledRect( float x, float y, float w, float h, const idVec4 &color) {

	if ( color.w == 0.0f ) {
		return;
	}

	renderSystem->SetColor(color);
	
	if (ClippedCoords(&x, &y, &w, &h, NULL, NULL, NULL, NULL)) {
		return;
	}

	AdjustCoords(&x, &y, &w, &h);
	DrawStretchPic( x, y, w, h, 0, 0, 0, 0, whiteImage);
}


void idDeviceContext::DrawRect( float x, float y, float w, float h, float size, const idVec4 &color) {

	if ( color.w == 0.0f ) {
		return;
	}

	renderSystem->SetColor(color);
	
	if (ClippedCoords(&x, &y, &w, &h, NULL, NULL, NULL, NULL)) {
		return;
	}

	AdjustCoords(&x, &y, &w, &h);
	DrawStretchPic( x, y, size, h, 0, 0, 0, 0, whiteImage );
	DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, whiteImage );
	DrawStretchPic( x, y, w, size, 0, 0, 0, 0, whiteImage );
	DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, whiteImage );
}

void idDeviceContext::DrawMaterialRect( float x, float y, float w, float h, float size, const idMaterial *mat, const idVec4 &color) {

	if ( color.w == 0.0f ) {
		return;
	}

	renderSystem->SetColor(color);
	DrawMaterial( x, y, size, h, mat, color );
	DrawMaterial( x + w - size, y, size, h, mat, color );
	DrawMaterial( x, y, w, size, mat, color );
	DrawMaterial( x, y + h - size, w, size, mat, color );
}


void idDeviceContext::SetCursor(int n) {
	cursor = (n < CURSOR_ARROW || n >= CURSOR_COUNT) ? CURSOR_ARROW : n;
}

void idDeviceContext::DrawCursor(float *x, float *y, float size) {
	if (*x < 0) {
		*x = 0;
	}

	if (*x >= vidWidth) {
		*x = vidWidth;
	}

	if (*y < 0) {
		*y = 0;
	}

	if (*y >= vidHeight) {
		*y = vidHeight;
	}

	renderSystem->SetColor(colorWhite);
	AdjustCoords(x, y, &size, &size);
	DrawStretchPic( *x, *y, size, size, 0, 0, 1, 1, cursorImages[cursor]);
}
/*
 =======================================================================================================================
 =======================================================================================================================
 */

void idDeviceContext::PaintChar(float x,float y,float width,float height,float scale,float	s,float	t,float	s2,float t2,const idMaterial *hShader) {
	float	w, h;
	w = width * scale;
	h = height * scale;

	if (ClippedCoords(&x, &y, &w, &h, &s, &t, &s2, &t2)) {
		return;
	}

	AdjustCoords(&x, &y, &w, &h);
	DrawStretchPic(x, y, w, h, s, t, s2, t2, hShader);
}


void idDeviceContext::SetFontByScale(float scale) {
	if (scale <= gui_smallFontLimit.GetFloat()) {
		useFont = &activeFont->fontInfoSmall;
		activeFont->maxHeight = activeFont->maxHeightSmall;
		activeFont->maxWidth = activeFont->maxWidthSmall;
	} else if (scale <= gui_mediumFontLimit.GetFloat()) {
		useFont = &activeFont->fontInfoMedium;
		activeFont->maxHeight = activeFont->maxHeightMedium;
		activeFont->maxWidth = activeFont->maxWidthMedium;
	} else {
		useFont = &activeFont->fontInfoLarge;
		activeFont->maxHeight = activeFont->maxHeightLarge;
		activeFont->maxWidth = activeFont->maxWidthLarge;
	}
}

int idDeviceContext::DrawText(float x, float y, float scale, idVec4 color, const char *text, float adjust, int limit, int style, int cursor, bool resetEscapes) {
	SetFontByScale( scale );
	if ( !useFont || useFont->pointSize == 0.0f ) {
		return 0;
	}

	const float useScale = scale / useFont->pointSize * 48.0f;
	if ( resetEscapes ) {
		drawTextColor = color;
		drawTextColorAdjust = 0.0f;
	}
	idVec4 newColor = drawTextColor;
	renderSystem->SetColor( newColor );

	if ( !text || color.w == 0.0f ) {
		return 0;
	}
	const int len = ( limit > 0 ) ? Min( static_cast<int>( strlen( text ) ), limit ) : static_cast<int>( strlen( text ) );
	int count = 0;
	while ( *text && count < len ) {
		int escapeType = 0;
		const int escapeLength = idStr::IsEscape( text, &escapeType );
		if ( escapeLength ) {
			if ( escapeType == S_ESCAPE_COLORINDEX ) {
				if ( text[1] == C_COLOR_DEFAULT ) {
					drawTextColor = color;
				} else {
					drawTextColor = idStr::ColorForIndex( text[1] );
					drawTextColor.w = color.w;
				}
				drawTextColorAdjust = 0.0f;
				newColor = drawTextColor;
				renderSystem->SetColor( newColor );
			} else if ( escapeType == S_ESCAPE_COLOR && escapeLength == 5 ) {
				drawTextColor.x = ( text[2] - '0' ) / 9.0f;
				drawTextColor.y = ( text[3] - '0' ) / 9.0f;
				drawTextColor.z = ( text[4] - '0' ) / 9.0f;
				drawTextColor.w = color.w;
				drawTextColorAdjust = 0.0f;
				newColor = drawTextColor;
				renderSystem->SetColor( newColor );
			} else if ( escapeType == S_ESCAPE_ICON ) {
				char code[4] = { text[2], text[3], text[4], '\0' };
				embeddedIcon_s *icon = NULL;
				if ( icons.Get( code, &icon ) && icon && icon->height > 0 ) {
					const glyphInfo_t& reference = useFont->glyphs['W'];
					const float iconScale = reference.height / icon->height;
					PaintChar( x, y - useScale * reference.horiBearingY - 1.0f,
						icon->width * iconScale, icon->height * iconScale, useScale,
						icon->s1, icon->t1, icon->s2, icon->t2, icon->shader );
					x += icon->width * iconScale;
				}
			}
			text += escapeLength;
			count += escapeLength;
			continue;
		}

		const glyphInfo_t& glyph = useFont->glyphs[static_cast<unsigned char>( *text )];
		const float glyphX = x + glyph.horiBearingX * useScale;
		const float glyphY = y - glyph.horiBearingY * useScale - 1.0f;
		if ( style == 1 ) {
			idVec4 shadowColor( 0.0f, 0.0f, 0.0f, newColor.w );
			renderSystem->SetColor( shadowColor );
			PaintChar( glyphX + 1.0f, glyphY + 1.0f, glyph.width, glyph.height, useScale,
				glyph.s1, glyph.t1, glyph.s2, glyph.t2, useFont->material );
			renderSystem->SetColor( newColor );
		}
		PaintChar( glyphX, glyphY, glyph.width, glyph.height, useScale,
			glyph.s1, glyph.t1, glyph.s2, glyph.t2, useFont->material );
		if ( cursor != -1 && cursor <= count ) {
			DrawEditCursor( x, y, scale );
			cursor = -1;
		}
		x += idMath::Ceil( ( glyph.horiAdvance + adjust ) * useScale );
		text++;
		count++;
	}
	if ( cursor != -1 && cursor <= count ) {
		DrawEditCursor( x, y, scale );
	}
	return count;
}

void idDeviceContext::SetSize(float width, float height) {
	vidWidth = VIRTUAL_WIDTH;
	vidHeight = VIRTUAL_HEIGHT;
	xScale = yScale = 0.0f;
	if ( width != 0.0f && height != 0.0f ) {
		xScale = vidWidth * ( 1.0f / width );
		yScale = vidHeight * ( 1.0f / height );
	}
}

void idDeviceContext::SizeIcon( embeddedIcon_s *icon ) {
	if ( !icon || !icon->shader ) {
		return;
	}
	const int imageWidth = icon->shader->GetImageWidth();
	const int imageHeight = icon->shader->GetImageHeight();
	if ( imageWidth <= 0 || imageHeight <= 0 ) {
		return;
	}
	const int x = static_cast<int>( icon->s1 );
	const int y = static_cast<int>( icon->t1 );
	const int width = icon->width;
	const int height = icon->height;
	icon->s1 = ( x == -1 ) ? 0.0f : static_cast<float>( x ) / imageWidth;
	icon->t1 = ( y == -1 ) ? 0.0f : static_cast<float>( y ) / imageHeight;
	icon->s2 = ( x == -1 ) ? 1.0f : static_cast<float>( x + width ) / imageWidth;
	icon->t2 = ( y == -1 ) ? 1.0f : static_cast<float>( y + height ) / imageHeight;
	icon->width = ( width == -1 ) ? imageWidth : width;
	icon->height = ( height == -1 ) ? imageHeight : height;
}

void idDeviceContext::SizeIcons() {
	for ( int i = 0; i < icons.Num(); i++ ) {
		SizeIcon( icons.GetIndex( i ) );
	}
}

void idDeviceContext::RegisterIcon( const char *code, const char *shader, int x, int y, int w, int h ) {
	embeddedIcon_s icon;
	memset( &icon, 0, sizeof( icon ) );
	idStr::Copynz( icon.code, code, sizeof( icon.code ) );
	icon.shader = declManager->FindMaterial( shader );
	if ( !icon.shader ) {
		return;
	}
	const_cast<idMaterial *>( icon.shader )->EnsureNotPurged();
	icon.shader->SetSort( SS_GUI );
	icon.width = w;
	icon.height = h;
	icon.s1 = icon.s2 = static_cast<float>( x );
	icon.t1 = icon.t2 = static_cast<float>( y );
	if ( icon.shader->GetImageWidth() && icon.shader->GetImageHeight() ) {
		SizeIcon( &icon );
	}
	icons.Set( icon.code, icon );
}

int idDeviceContext::CharWidth( const char c, float scale, int adjust ) {
	SetFontByScale( scale );
	if ( !useFont || useFont->pointSize == 0.0f ) {
		return 0;
	}
	const float advance = idMath::Ceil( useFont->glyphs[static_cast<unsigned char>( c )].horiAdvance );
	return static_cast<int>( ( advance + adjust ) / useFont->pointSize * scale * 48.0f );
}

int idDeviceContext::TextWidth( const char *text, float scale, int limit, int adjust ) {
	SetFontByScale( scale );
	if ( !text || !useFont || useFont->pointSize == 0.0f ) {
		return 0;
	}
	float width = 0.0f;
	for ( int i = 0; text[i] && ( limit <= 0 || i < limit ); ) {
		int escapeType = 0;
		const int escapeLength = idStr::IsEscape( text + i, &escapeType );
		if ( escapeLength ) {
			if ( escapeType == S_ESCAPE_ICON ) {
				char code[4] = { text[i + 2], text[i + 3], text[i + 4], '\0' };
				embeddedIcon_s *icon = NULL;
				if ( icons.Get( code, &icon ) && icon && icon->height > 0 ) {
					width += useFont->glyphs['W'].height / icon->height * icon->width;
				}
			}
			i += escapeLength;
			continue;
		}
		width += idMath::Ceil( useFont->glyphs[static_cast<unsigned char>( text[i] )].horiAdvance ) + adjust;
		i++;
	}
	return static_cast<int>( width / useFont->pointSize * scale * 48.0f );
}

bool idDeviceContext::GetMaxTextIndex( const char *text, int limit, float textScale, wrapInfo_t& wrapInfo ) {
	wrapInfo.lastWhitespace = -1;
	wrapInfo.maxIndex = -1;
	SetFontByScale( textScale );
	if ( !text || !useFont || useFont->pointSize == 0.0f ) {
		return false;
	}
	float width = 0.0f;
	for ( int i = 0; text[i]; ) {
		int escapeType = 0;
		const int escapeLength = idStr::IsEscape( text + i, &escapeType );
		if ( escapeLength ) {
			if ( escapeType == S_ESCAPE_ICON ) {
				char code[4] = { text[i + 2], text[i + 3], text[i + 4], '\0' };
				embeddedIcon_s *icon = NULL;
				if ( icons.Get( code, &icon ) && icon && icon->height > 0 ) {
					width += useFont->glyphs['W'].height / icon->height * icon->width;
				}
			}
			i += escapeLength;
		} else {
			width += idMath::Ceil( useFont->glyphs[static_cast<unsigned char>( text[i] )].horiAdvance );
			const int pixelWidth = static_cast<int>( width / useFont->pointSize * textScale * 48.0f );
			if ( pixelWidth > limit ) {
				wrapInfo.maxIndex = i - 1;
				return true;
			}
			if ( text[i] == ' ' ) {
				wrapInfo.lastWhitespace = i;
			}
			i++;
		}
	}
	return false;
}

int idDeviceContext::TextHeight(const char *text, float scale, int limit) {
	int			len, count;
	float		max;
	glyphInfo_t *glyph;
	const char	*s = text;
	SetFontByScale(scale);
	fontInfo_t	*font = useFont;
	if ( !font || font->pointSize == 0.0f ) {
		return 0;
	}
	const float useScale = scale / font->pointSize * 48.0f;
	max = 0;
	if (text) {
		len = strlen(text);
		if (limit > 0 && len > limit) {
			len = limit;
		}

		count = 0;
		while (s && *s && count < len) {
			const int escapeLength = idStr::IsEscape( s );
			if ( escapeLength ) {
				s += escapeLength;
				continue;
			}
			else {
				glyph = &font->glyphs[*(const unsigned char*)s];
				if (max < glyph->height) {
					max = glyph->height;
				}

				s++;
				count++;
			}
		}
	}

	return idMath::FtoiFast( max * useScale );
}

int idDeviceContext::MaxCharWidth(float scale) {
	SetFontByScale(scale);
	if ( !useFont || useFont->pointSize == 0.0f ) {
		return 0;
	}
	return static_cast<int>( scale / useFont->pointSize * 48.0f * activeFont->maxWidth );
}

int idDeviceContext::MaxCharHeight(float scale) {
	SetFontByScale(scale);
	if ( !useFont || useFont->pointSize == 0.0f ) {
		return 0;
	}
	return static_cast<int>( scale / useFont->pointSize * 48.0f * activeFont->maxHeight );
}

const idMaterial *idDeviceContext::GetScrollBarImage(int index) {
	if (index >= SCROLLBAR_HBACK && index < SCROLLBAR_COUNT) {
		return scrollBarImages[index];
	}
	return scrollBarImages[SCROLLBAR_HBACK];
}

// this only supports left aligned text
idRegion *idDeviceContext::GetTextRegion(const char *text, float textScale, idRectangle rectDraw, float xStart, float yStart) {
#if 0
	const char	*p, *textPtr, *newLinePtr;
	char		buff[1024];
	int			len, textWidth, newLine, newLineWidth;
	float		y;

	float charSkip = MaxCharWidth(textScale) + 1;
	float lineSkip = MaxCharHeight(textScale);

	textWidth = 0;
	newLinePtr = NULL;
#endif
	return NULL;
/*
	if (text == NULL) {
		return;
	}

	textPtr = text;
	if (*textPtr == '\0') {
		return;
	}

	y = lineSkip + rectDraw.y + yStart; 
	len = 0;
	buff[0] = '\0';
	newLine = 0;
	newLineWidth = 0;
	p = textPtr;

	textWidth = 0;
	while (p) {
		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
			newLine = len;
			newLinePtr = p + 1;
			newLineWidth = textWidth;
		}

		if ((newLine && textWidth > rectDraw.w) || *p == '\n' || *p == '\0') {
			if (len) {

				float x = rectDraw.x ;
				
				buff[newLine] = '\0';
				DrawText(x, y, textScale, color, buff, 0, 0, 0);
				if (!wrap) {
					return;
				}
			}

			if (*p == '\0') {
				break;
			}

			y += lineSkip + 5;
			p = newLinePtr;
			len = 0;
			newLine = 0;
			newLineWidth = 0;
			continue;
		}

		buff[len++] = *p++;
		buff[len] = '\0';
		textWidth = TextWidth( buff, textScale, -1 );
	}
*/
}

void idDeviceContext::DrawEditCursor( float x, float y, float scale ) {
	if ( com_ticNumber & 0x10 ) {
		return;
	}
	SetFontByScale(scale);
	if ( !useFont || useFont->pointSize == 0.0f ) {
		return;
	}
	float useScale = scale / useFont->pointSize * 48.0f;
	const glyphInfo_t *glyph2 = &useFont->glyphs[(overStrikeMode) ? '_' : '|'];
	float yadj = useScale * glyph2->horiBearingY - 1.0f;
	PaintChar( x, y - yadj, glyph2->width, glyph2->height, useScale,
		glyph2->s1, glyph2->t1, glyph2->s2, glyph2->t2, useFont->material );
}

int idDeviceContext::DrawText( const char *text, float textScale, int textAlign, idVec4 color, idRectangle rectDraw, bool wrap, int cursor, bool calcOnly, idList<int> *breaks, int limit ) {
	const char	*p, *textPtr, *newLinePtr;
	char		buff[1024];
	int			len, newLine, newLineWidth, count;
	float		y;
	float		textWidth;

	float		charSkip = MaxCharWidth( textScale ) + 1;
	float		lineSkip = MaxCharHeight( textScale );

	float		cursorSkip = ( cursor >= 0 ? charSkip : 0 );

	bool		lineBreak, wordBreak;

	SetFontByScale( textScale );

	textWidth = 0;
	newLinePtr = NULL;

	if (!calcOnly && !(text && *text)) {
		if (cursor == 0) {
			renderSystem->SetColor(color);
			DrawEditCursor(rectDraw.x, lineSkip + rectDraw.y, textScale);
		}
		return idMath::FtoiFast( rectDraw.w / charSkip );
	}

	textPtr = text;

	y = lineSkip + rectDraw.y; 
	len = 0;
	buff[0] = '\0';
	newLine = 0;
	newLineWidth = 0;
	p = textPtr;

	if ( breaks ) {
		breaks->Append(0);
	}
	count = 0;
	textWidth = 0;
	lineBreak = false;
	wordBreak = false;
	while (p) {

		if ( *p == '\n' || *p == '\r' || *p == '\0' ) {
			lineBreak = true;
			if ((*p == '\n' && *(p + 1) == '\r') || (*p == '\r' && *(p + 1) == '\n')) {
				p++;
			}
		}

		int nextCharWidth = ( idStr::CharIsPrintable(*p) ? CharWidth( *p, textScale ) : cursorSkip );
		// FIXME: this is a temp hack until the guis can be fixed not not overflow the bounding rectangles
		//		  the side-effect is that list boxes and edit boxes will draw over their scroll bars
		//	The following line and the !linebreak in the if statement below should be removed
		nextCharWidth = 0;

		if ( !lineBreak && ( textWidth + nextCharWidth ) > rectDraw.w ) {
			// The next character will cause us to overflow, if we haven't yet found a suitable
			// break spot, set it to be this character
			if ( len > 0 && newLine == 0 ) {
				newLine = len;
				newLinePtr = p;
				newLineWidth = textWidth;
			}
			wordBreak = true;
		} else if ( lineBreak || ( wrap && (*p == ' ' || *p == '\t') ) ) {
			// The next character is in view, so if we are a break character, store our position
			newLine = len;
			newLinePtr = p + 1;
			newLineWidth = textWidth;
		}

		if ( lineBreak || wordBreak ) {
			float x = rectDraw.x;

			if (textAlign == ALIGN_RIGHT) {
				x = rectDraw.x + rectDraw.w - newLineWidth;
			} else if (textAlign == ALIGN_CENTER) {
				x = rectDraw.x + (rectDraw.w - newLineWidth) / 2;
			}

			if ( wrap || newLine > 0 ) {
				buff[newLine] = '\0';

				// This is a special case to handle breaking in the middle of a word.
				// if we didn't do this, the cursor would appear on the end of this line
				// and the beginning of the next.
				if ( wordBreak && cursor >= newLine && newLine == len ) {
					cursor++;
				}
			}

			if (!calcOnly) {
				count += DrawText(x, y, textScale, color, buff, 0, 0, 0, cursor);
			}

			if ( cursor < newLine ) {
				cursor = -1;
			} else if ( cursor >= 0 ) {
				cursor -= ( newLine + 1 );
			}

			if ( !wrap ) {
				return newLine;
			}

			if ( ( limit && count > limit ) || *p == '\0' ) {
				break;
			}

			y += lineSkip + 5;

			if ( !calcOnly && y > rectDraw.Bottom() ) {
				break;
			}

			p = newLinePtr;

			if (breaks) {
				breaks->Append(p - text);
			}

			len = 0;
			newLine = 0;
			newLineWidth = 0;
			textWidth = 0;
			lineBreak = false;
			wordBreak = false;
			continue;
		}

		buff[len++] = *p++;
		buff[len] = '\0';
		// Escape sequences and embedded icons are measured as a unit.
		textWidth = static_cast<float>( TextWidth( buff, textScale, -1 ) );
	}

	return idMath::FtoiFast( rectDraw.w / charSkip );
}

/*
=============
idRectangle::String
=============
*/
char *idRectangle::String( void ) const {
	static	int		index = 0;
	static	char	str[ 8 ][ 48 ];
	char	*s;

	// use an array so that multiple toString's won't collide
	s = str[ index ];
	index = (index + 1)&7;

	sprintf( s, "%.2f %.2f %.2f %.2f", x, y, w, h );

	return s;
}
