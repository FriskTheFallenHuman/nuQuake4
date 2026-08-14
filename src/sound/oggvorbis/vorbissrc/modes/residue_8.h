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

 function: toplevel residue templates 8/11kHz
 last mod: $Id: residue_8.h,v 1.2 2002/07/11 06:41:04 xiphmont Exp $

 ********************************************************************/

#include "../vorbis/codec.h"
#include "backends.h"

/***** residue backends *********************************************/

static static_bookblock _resbook_8s_0={
  {
    {0},{0,0,&_8c0_s_p1_0},{0,0,&_8c0_s_p2_0},{0,0,&_8c0_s_p3_0},
    {0,0,&_8c0_s_p4_0},{0,0,&_8c0_s_p5_0},{0,0,&_8c0_s_p6_0},
    {&_8c0_s_p7_0,&_8c0_s_p7_1},{&_8c0_s_p8_0,&_8c0_s_p8_1},
    {&_8c0_s_p9_0,&_8c0_s_p9_1,&_8c0_s_p9_2}
   }
};
static static_bookblock _resbook_8s_1={
  {
    {0},{0,0,&_8c1_s_p1_0},{0,0,&_8c1_s_p2_0},{0,0,&_8c1_s_p3_0},
    {0,0,&_8c1_s_p4_0},{0,0,&_8c1_s_p5_0},{0,0,&_8c1_s_p6_0},
    {&_8c1_s_p7_0,&_8c1_s_p7_1},{&_8c1_s_p8_0,&_8c1_s_p8_1},
    {&_8c1_s_p9_0,&_8c1_s_p9_1,&_8c1_s_p9_2}
   }
};

static vorbis_residue_template _res_8s_0[]={
  {2,0,  &_residue_44_mid,
   &_huff_book__8c0_s_single,&_huff_book__8c0_s_single,
   &_resbook_8s_0,&_resbook_8s_0},
};
static vorbis_residue_template _res_8s_1[]={
  {2,0,  &_residue_44_mid,
   &_huff_book__8c1_s_single,&_huff_book__8c1_s_single,
   &_resbook_8s_1,&_resbook_8s_1},
};

static vorbis_mapping_template _mapres_template_8_stereo[2]={
  { _map_nominal, _res_8s_0 }, /* 0 */
  { _map_nominal, _res_8s_1 }, /* 1 */
};

static static_bookblock _resbook_8u_0={
  {
    {0},
    {0,0,&_8u0__p1_0},
    {0,0,&_8u0__p2_0},
    {0,0,&_8u0__p3_0},
    {0,0,&_8u0__p4_0},
    {0,0,&_8u0__p5_0},
    {&_8u0__p6_0,&_8u0__p6_1},
    {&_8u0__p7_0,&_8u0__p7_1,&_8u0__p7_2}
   }
};
static static_bookblock _resbook_8u_1={
  {
    {0},
    {0,0,&_8u1__p1_0},
    {0,0,&_8u1__p2_0},
    {0,0,&_8u1__p3_0},
    {0,0,&_8u1__p4_0},
    {0,0,&_8u1__p5_0},
    {0,0,&_8u1__p6_0},
    {&_8u1__p7_0,&_8u1__p7_1},
    {&_8u1__p8_0,&_8u1__p8_1},
    {&_8u1__p9_0,&_8u1__p9_1,&_8u1__p9_2}
   }
};

static vorbis_residue_template _res_8u_0[]={
  {1,0,  &_residue_44_low_un,
   &_huff_book__8u0__single,&_huff_book__8u0__single,
   &_resbook_8u_0,&_resbook_8u_0},
};
static vorbis_residue_template _res_8u_1[]={
  {1,0,  &_residue_44_mid_un,
   &_huff_book__8u1__single,&_huff_book__8u1__single,
   &_resbook_8u_1,&_resbook_8u_1},
};

static vorbis_mapping_template _mapres_template_8_uncoupled[2]={
  { _map_nominal_u, _res_8u_0 }, /* 0 */
  { _map_nominal_u, _res_8u_1 }, /* 1 */
};
