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

// With GCC and xCode, a bool is 4 bytes. There are two approaches to 
// making bool one byte. You could #define bool as an unsigned char. The downside
// is that a function that take bool and one that takes a char will no longer have a unique function
// signature. You could #define bool to custom class that defines a bool operator, which
// fixes the function signature but includes others problems such as bool bitfields, 
// classes that have a bool operator, C function that accept ... as a param, the keyword
// volatile.

// The following approach works for the best for Doom because of the above issues, bitfields
// especially

#ifdef bool
#undef bool
#endif

#define bool unsigned char

