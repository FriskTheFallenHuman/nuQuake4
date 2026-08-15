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

#ifndef __MATH_FFT_H__
#define __MATH_FFT_H__

/*
===============================================================================

  Fast Fourier Transform

===============================================================================
*/

// complex number
typedef struct {
	float re;
	float im;
} cpxFloat_t;

class idFFT {
public:
// RAVEN BEGIN
// jscott: added stride to 1D, created 2D
	static void		FFT1D( cpxFloat_t *data, int N, int ISI, int stride = 1 );
	static void		FFT2D( cpxFloat_t *data, int N, int ISI );
	static void		FFT3D( cpxFloat_t *data, int N, int ISI );
// RAVEN END
};

#endif  /* !__MATH_FFT_H__ */
