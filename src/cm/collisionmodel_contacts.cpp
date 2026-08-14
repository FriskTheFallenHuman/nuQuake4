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

#if defined( Q4_CM_LEGACY_SEED )
#include "collisionmodel_contacts_legacy.inc"
#else

/*
===========================================================================

Quake 4 object-based contact entry point reconstructed in the exact
CollisionModel_contacts.obj source owner identified by quake4.pdb.

===========================================================================
*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "CollisionModel_local.h"

int idCollisionModelManagerLocal::Contacts( contactInfo_t *contactList, const int contactLimit,
		const idVec3 &start, const idVec6 &dir, const float depth,
		const idTraceModel *trm, const idMat3 &trmAxis, int contentMask,
		idCollisionModel *model, const idVec3 &modelOrigin, const idMat3 &modelAxis ) {
	contacts = contactList;
	maxContacts = contactLimit;
	getContacts = true;
	numContacts = 0;

	const idVec3 end = start + depth * dir.SubVec3( 0 );
	trace_t results;
	Translation( &results, start, end, trm, trmAxis, contentMask, model, modelOrigin, modelAxis );

	getContacts = false;
	maxContacts = 0;
	return numContacts;
}

#endif
