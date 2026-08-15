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

/********************************************************************
 *                                                                  *
 * THIS FILE IS PART OF THE OggVorbis SOFTWARE CODEC SOURCE CODE.   *
 * USE, DISTRIBUTION AND REPRODUCTION OF THIS LIBRARY SOURCE IS     *
 * GOVERNED BY A BSD-STYLE SOURCE LICENSE INCLUDED WITH THIS SOURCE *
 * IN 'COPYING'. PLEASE READ THESE TERMS BEFORE DISTRIBUTING.       *
 *                                                                  *
 * THE OggVorbis SOURCE CODE IS (C) COPYRIGHT 1994-2002             *
 * by the XIPHOPHORUS Company http://www.xiph.org/                  *
 *                                                                  *
 ********************************************************************

 function: 11kHz settings 
 last mod: $Id: psych_11.h,v 1.1 2002/07/10 03:04:22 xiphmont Exp $

 ********************************************************************/

static double _psy_lowpass_11[3]={4.5,5.5,30.,};

static att3 _psy_tone_masteratt_11[3]={
  {{ 30,  25,  12},  0,   0},  /* 0 */
  {{ 30,  25,  12},  0,   0},  /* 0 */
  {{ 20,   0, -14},  0,  1.}, /* 0 */
};

static vp_adjblock _vp_tonemask_adj_11[3]={
  /* adjust for mode zero */
  /* 63     125     250     500     1     2     4     8    16 */
  {{-20,-20,-20,-20,-20,-16,-10, 0, 0, 0, 0,10, 2, 0,99,99,99}}, /* 0 */
  {{-20,-20,-20,-20,-20,-16,-10, 0, 0, 0, 0, 5, 0, 0,99,99,99}}, /* 1 */
  {{-20,-20,-20,-20,-20,-16,-10, 0, 0, 0, 0, 0, 0, 0,99,99,99}}, /* 2 */
};


static noise3 _psy_noisebias_11[3]={
  /*  63     125     250     500      1k       2k      4k      8k     16k*/
  {{{-10,-10,-10,-10, -5, -5, -5,  0,  4, 10, 10, 12, 12, 12, 99, 99, 99},
    {-15,-15,-15,-15,-10,-10, -5,  0,  0,  4,  4,  5,  5, 10, 99, 99, 99},
    {-30,-30,-30,-30,-30,-24,-20,-14,-10, -6, -8, -8, -6, -6, 99, 99, 99}}},

  {{{-10,-10,-10,-10, -5, -5, -5,  0,  4, 10, 10, 12, 12, 12, 99, 99, 99},
    {-15,-15,-15,-15,-10,-10, -5, -5, -5,  0,  0,  0,  0,  0, 99, 99, 99},
    {-30,-30,-30,-30,-30,-24,-20,-14,-10, -6, -8, -8, -6, -6, 99, 99, 99}}},

  {{{-15,-15,-15,-15,-15,-12,-10, -8,  0,  2,  4,  4,  5,  5, 99, 99, 99},
    {-30,-30,-30,-30,-26,-22,-20,-14,-12,-12,-10,-10,-10,-10, 99, 99, 99},
    {-30,-30,-30,-30,-26,-26,-26,-26,-26,-26,-26,-26,-26,-24, 99, 99, 99}}},
};

static double _noise_thresh_11[3]={ .3,.5,.5 };

