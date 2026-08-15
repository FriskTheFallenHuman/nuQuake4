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

#include "tr_local.h"

/* R_ImageStats_f -- Image_stats.obj, quake4.pdb RVA 0x000B08A0. */
void R_ImageStats_f( const idCmdArgs &args ) {
	if ( args.Argc() < 3 ) {
		common->Printf( "Usage - imageStats <lo> <hi>\n" );
		return;
	}

	const float cutoffLo = atof( args.Argv( 1 ) );
	const float cutoffHi = atof( args.Argv( 2 ) );
	float totalLuma = 0.0f;
	int numImages = 0;
	int numImagesOutOfRange = 0;
	int totalPixels = 0;
	int totalBrightPixels = 0;

	for ( int i = 0; i < globalImages->images.Num(); ++i ) {
		idImage *image = globalImages->images[i];
		if ( image == NULL || image->depth != TD_DIFFUSE ) {
			continue;
		}

		byte *pixels = NULL;
		int width = 0;
		int height = 0;
		R_LoadImage( image->imgName, &pixels, &width, &height, NULL, true );
		if ( pixels == NULL ) {
			continue;
		}

		float imageLuma = 0.0f;
		int opaquePixels = 0;
		const int pixelCount = width * height;
		for ( int pixel = 0; pixel < pixelCount; ++pixel ) {
			const byte *rgba = pixels + pixel * 4;
			if ( rgba[3] == 0 ) {
				continue;
			}
			const float luma = Max( rgba[0], Max( rgba[1], rgba[2] ) ) * ( 1.0f / 255.0f );
			imageLuma += luma;
			++opaquePixels;
			if ( luma > cutoffHi ) {
				++totalBrightPixels;
			}
		}
		if ( opaquePixels != 0 ) {
			imageLuma /= opaquePixels;
		}
		totalPixels += opaquePixels;
		if ( imageLuma < cutoffLo || imageLuma > cutoffHi ) {
			common->Printf( "%0.4g: %s\n", imageLuma, image->imgName.c_str() );
			++numImagesOutOfRange;
		}
		totalLuma += imageLuma;
		++numImages;
		R_StaticFree( pixels );
	}

	if ( numImages != 0 ) {
		common->Printf( "Average intensity of %g from %d diffuse images\n", totalLuma / numImages, numImages );
		common->Printf( "%d%% lie between %g and %g\n", 100 * ( numImages - numImagesOutOfRange ) / numImages, cutoffLo, cutoffHi );
		if ( totalPixels != 0 ) {
			common->Printf( "%g%% of pixels are brighter than %g\n", totalBrightPixels * 100.0f / totalPixels, cutoffHi );
		}
	}
}
