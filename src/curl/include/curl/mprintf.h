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

/***************************************************************************
 *                                  _   _ ____  _     
 *  Project                     ___| | | |  _ \| |    
 *                             / __| | | | |_) | |    
 *                            | (__| |_| |  _ <| |___ 
 *                             \___|\___/|_| \_\_____|
 *
 * Copyright (C) 1998 - 2004, Daniel Stenberg, <daniel@haxx.se>, et al.
 *
 * This software is licensed as described in the file COPYING, which
 * you should have received as part of this distribution. The terms
 * are also available at http://curl.haxx.se/docs/copyright.html.
 * 
 * You may opt to use, copy, modify, merge, publish, distribute and/or sell
 * copies of the Software, and permit persons to whom the Software is
 * furnished to do so, under the terms of the COPYING file.
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 * KIND, either express or implied.
 *
 * $Id: mprintf.h,v 1.8 2004/01/07 09:19:34 bagder Exp $
 ***************************************************************************/

#ifndef H_MPRINTF
#define H_MPRINTF

#include <stdarg.h>
#include <stdio.h> /* needed for FILE */

int curl_mprintf(const char *format, ...);
int curl_mfprintf(FILE *fd, const char *format, ...);
int curl_msprintf(char *buffer, const char *format, ...);
int curl_msnprintf(char *buffer, size_t maxlength, const char *format, ...);
int curl_mvprintf(const char *format, va_list args);
int curl_mvfprintf(FILE *fd, const char *format, va_list args);
int curl_mvsprintf(char *buffer, const char *format, va_list args);
int curl_mvsnprintf(char *buffer, size_t maxlength, const char *format, va_list args);
char *curl_maprintf(const char *format, ...);
char *curl_mvaprintf(const char *format, va_list args);

#ifdef _MPRINTF_REPLACE
# define printf curl_mprintf
# define fprintf curl_mfprintf
# define sprintf curl_msprintf
# define snprintf curl_msnprintf
# define vprintf curl_mvprintf
# define vfprintf curl_mvfprintf
# define vsprintf curl_mvsprintf
# define vsnprintf curl_mvsnprintf
# define aprintf curl_maprintf
# define vaprintf curl_mvaprintf
#endif

#endif /* H_MPRINTF */
