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

#include "AASFile.h"
#include "AASFile_local.h"

/*
===============================================================================

	AAS File Manager

===============================================================================
*/

class idAASFileManagerLocal : public idAASFileManager {
public:
	virtual						~idAASFileManagerLocal( void ) {}

	virtual idAASFile *			LoadAAS( const char *fileName, unsigned int mapFileCRC );
	virtual void				FreeAAS( idAASFile *file );
};

idAASFileManagerLocal			AASFileManagerLocal;
idAASFileManager *				AASFileManager = &AASFileManagerLocal;


/*
================
idAASFileManagerLocal::LoadAAS
================
*/
idAASFile *idAASFileManagerLocal::LoadAAS( const char *fileName, unsigned int mapFileCRC ) {
	idAASFileLocal *file = new idAASFileLocal();
	if ( !file->Load( fileName, mapFileCRC ) ) {
		delete file;
		return NULL;
	}
	return file;
}

/*
================
idAASFileManagerLocal::FreeAAS
================
*/
void idAASFileManagerLocal::FreeAAS( idAASFile *file ) {
	delete file;
}
