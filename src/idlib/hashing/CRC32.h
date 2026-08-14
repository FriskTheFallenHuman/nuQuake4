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

#ifndef __CRC32_H__
#define __CRC32_H__

/*
===============================================================================

	Calculates a checksum for a block of data
	using the CRC-32.

===============================================================================
*/

void CRC32_InitChecksum( unsigned long &crcvalue );
void CRC32_UpdateChecksum( unsigned long &crcvalue, const void *data, int length );
void CRC32_FinishChecksum( unsigned long &crcvalue );
unsigned long CRC32_BlockChecksum( const void *data, int length );

#endif /* !__CRC32_H__ */
