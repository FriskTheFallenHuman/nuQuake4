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

 function: highlevel encoder setup struct seperated out for vorbisenc clarity
 last mod: $Id: highlevel.h,v 1.4 2002/07/01 11:20:11 xiphmont Exp $

 ********************************************************************/

typedef struct highlevel_byblocktype {
  double tone_mask_setting;
  double tone_peaklimit_setting;
  double noise_bias_setting;
  double noise_compand_setting;
} highlevel_byblocktype;
  
typedef struct highlevel_encode_setup {
  void *setup;
  int   set_in_stone;

  double base_setting;
  double long_setting;
  double short_setting;
  double impulse_noisetune;

  int    managed;
  long   bitrate_min;
  long   bitrate_av_lo;
  long   bitrate_av_hi;
  long   bitrate_max;
  double bitrate_limit_window;
  double bitrate_av_window;
  double bitrate_av_window_center;
  
  int impulse_block_p;
  int noise_normalize_p;

  double stereo_point_setting;
  double lowpass_kHz;

  double ath_floating_dB;
  double ath_absolute_dB;

  double amplitude_track_dBpersec;
  double trigger_setting;
  
  highlevel_byblocktype block[4]; /* padding, impulse, transition, long */

} highlevel_encode_setup;

