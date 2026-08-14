/*
===========================================================================

Quake 4 Reconstructed GPL Source Code
Copyright (C) 2026 Justin Marshall(IceColdDuke).

Small tool-DLL-side adapters for renderer operations that are intentionally
not exported as concrete engine symbols.  Object ownership remains with the
engine interfaces passed through toolsImport_t.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "../renderer/Image.h"

idImage *idMaterial::GetEditorImage( void ) const {
	if ( editorImage != NULL ) {
		return editorImage;
	}

	if ( stages != NULL ) {
		for ( int i = 0; i < numStages; ++i ) {
			if ( stages[i].lighting == SL_DIFFUSE && stages[i].texture.image != NULL ) {
				editorImage = stages[i].texture.image;
				break;
			}
		}
		if ( editorImage == NULL && numStages > 0 ) {
			editorImage = stages[0].texture.image;
		}
	}

	if ( editorImage == NULL && globalImages != NULL ) {
		editorImage = globalImages->defaultImage;
	}
	return editorImage;
}

void idImageManager::BindNull( void ) {
	qglDisable( GL_TEXTURE_2D );
	qglDisable( GL_TEXTURE_3D );
	qglDisable( GL_TEXTURE_CUBE_MAP_EXT );
}

void GL_State( int stateBits ) {
	(void)stateBits;
	qglColorMask( GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE );
	qglDepthMask( GL_TRUE );
	qglDepthFunc( GL_LEQUAL );
	qglDisable( GL_BLEND );
	qglDisable( GL_ALPHA_TEST );
	qglPolygonMode( GL_FRONT_AND_BACK, GL_FILL );
}
