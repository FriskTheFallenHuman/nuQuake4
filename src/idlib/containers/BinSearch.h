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

#ifndef __BINSEARCH_H__
#define __BINSEARCH_H__

/*
===============================================================================

	Binary Search templates

	The array elements have to be ordered in increasing order.

===============================================================================
*/

/*
====================
idBinSearch_GreaterEqual

	Finds the last array element which is smaller than the given value.
====================
*/
template< class type >
ID_INLINE int idBinSearch_Less( const type *array, const int arraySize, const type &value ) {
	int len = arraySize;
	int mid = len;
	int offset = 0;
	while( mid > 0 ) {
		mid = len >> 1;
		if ( array[offset+mid] < value ) {
			offset += mid;
		}
		len -= mid;
	}
	return offset;
}

/*
====================
idBinSearch_GreaterEqual

	Finds the last array element which is smaller than or equal to the given value.
====================
*/
template< class type >
ID_INLINE int idBinSearch_LessEqual( const type *array, const int arraySize, const type &value ) {
	int len = arraySize;
	int mid = len;
	int offset = 0;
	while( mid > 0 ) {
		mid = len >> 1;
		if ( array[offset+mid] <= value ) {
			offset += mid;
		}
		len -= mid;
	}
	return offset;
}

/*
====================
idBinSearch_Greater

	Finds the first array element which is greater than the given value.
====================
*/
template< class type >
ID_INLINE int idBinSearch_Greater( const type *array, const int arraySize, const type &value ) {
	int len = arraySize;
	int mid = len;
	int offset = 0;
	int res = 0;
	while( mid > 0 ) {
		mid = len >> 1;
		if ( array[offset+mid] > value ) {
			res = 0;
		} else {
			offset += mid;
			res = 1;
		}
		len -= mid;
	}
	return offset+res;
}

/*
====================
idBinSearch_GreaterEqual

	Finds the first array element which is greater than or equal to the given value.
====================
*/
template< class type >
ID_INLINE int idBinSearch_GreaterEqual( const type *array, const int arraySize, const type &value ) {
	int len = arraySize;
	int mid = len;
	int offset = 0;
	int res = 0;
	while( mid > 0 ) {
		mid = len >> 1;
		if ( array[offset+mid] >= value ) {
			res = 0;
		} else {
			offset += mid;
			res = 1;
		}
		len -= mid;
	}
	return offset+res;
}

#endif /* !__BINSEARCH_H__ */
