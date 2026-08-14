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

//----------------------------------------------------------------
// MultifieldSort.cpp
//
// Routines for performing multi-field sorts on idList's
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#ifndef __MULTIFIELD_SORT_H__
#define __MULTIFIELD_SORT_H__

template< class type >
class rvMultifieldSort {
public:
	void Clear( void );
	void AddCompareFunction( typename idList<type>::cmp_t* fn );
	void AddFilterFunction( typename idList<type>::filter_t* fn );

	void Sort( idList<type>& list );

private:
	void QSort_Iterative( idList<type>& list, int low, int n );
	int Median3( type* list, int a, int b, int c );
	int Compare( const type* lhs, const type* rhs );

	// sortingFields							- pointers to sorting functions, in order to be sorted
	idList<typename idList<type>::cmp_t*>		sortingFields;
	// filterFields								- pointers to filter functions, in order to be filtered
	idList<typename idList<type>::filter_t*>	filterFields;
};

template< class type >
void rvMultifieldSort< type >::Clear( void ) {
	sortingFields.Clear();
	filterFields.Clear();
}

template< class type >
int rvMultifieldSort< type >::Compare( const type* lhs, const type* rhs ) {
	for( int i = 0; i < sortingFields.Num(); i++ ) {
		int result = (*sortingFields[ i ])( lhs, rhs );
		if( result != 0 ) {
			return result;
		}
	}

	// items are equal on all fields
	return 0;
}

template< class type >
ID_INLINE void rvMultifieldSort< type >::AddCompareFunction( typename idList<type>::cmp_t* fn ) {
	sortingFields.Append( fn );
}

template< class type >
ID_INLINE void rvMultifieldSort< type >::AddFilterFunction( typename idList<type>::filter_t* fn ) {
	filterFields.Append( fn );
}

template< class type >
void rvMultifieldSort< type >::Sort( idList<type>& list ) {
	int i, j;

	if ( filterFields.Num() ) {
		for ( i = 0; i < list.Num(); i++ ) {
			for ( j = 0; j < filterFields.Num(); j++ ) {
				if( (*filterFields[ j ])( (const type*)(&list[ i ]) ) ) {
					list.RemoveIndex( i );
					i--;
					break;
				}
			}
		}
	}
	QSort_Iterative( list, 0, list.Num() );
}

template< class type >
ID_INLINE int rvMultifieldSort< type >::Median3( type* list, int a, int b, int c ) {
	return Compare( &list[ a ], &list[ b ] ) < 0 ?
		( Compare( &list[ b ], &list[ c ] ) < 0 ? b : ( Compare( &list[ a ], &list[ c ] ) < 0 ? c : a ) )
		: ( Compare( &list[ b ], &list[ c ] ) > 0 ? b : ( Compare( &list[ a ], &list[ c ] ) < 0 ? a : c ));
}

template< class type >
void rvMultifieldSort< type >::QSort_Iterative( idList<type>& list, int low, int n ) {
	int swap_cnt, pivot, lowBound, highBound;

loop:
	swap_cnt = 0;

	// insertion sort on small arrays
	if( n < 7 ) {
		for( int i = low + 1; i < low + n; i++ ) {
			for( int j = i; j > low && Compare( &list[ j - 1 ], &list[ j ] ) > 0; j-- ) {
				type t = list[ j - 1 ];
				list[ j - 1 ] = list[ j ];
				list[ j ] = t;
			}
		}
		return;
	}

	// pivot selection
	pivot = n / 2 + low;
	if( n > 7 ) {
		lowBound = low;
		highBound = low + n - 1;
		if (n > 40) {
			int d = (n / 8);
			lowBound = Median3( list.Ptr(), lowBound, lowBound + d, lowBound + 2 * d );
			pivot = Median3( list.Ptr(), pivot - d, pivot, pivot + d );
			highBound = Median3( list.Ptr(), highBound - 2 * d, highBound - d, highBound );
		}
		pivot = Median3( list.Ptr(), lowBound, pivot, highBound );
	}
	type t = list[ low ];
	list[ low ] = list[ pivot ];
	list[ pivot ] = t;

	// qsort
	int leftA, leftB, rightC, rightD, r;
	leftA = leftB = low + 1;
	rightC = rightD = low + n - 1; 
	for (;;) {
		while ( leftB <= rightC && (r = Compare( &list[ leftB ], &list[ low ] )) <= 0) {
			if (r == 0) {
				swap_cnt = 1;
				type t = list[ leftA ];
				list[ leftA ] = list[ leftB ];
				list[ leftB ] = t;
				leftA++;
			}
			leftB++;
		}
		while (leftB <= rightC && (r = Compare( &list[ rightC ], &list[ low ] )) >= 0) {
			if (r == 0) {
				swap_cnt = 1;
				type t = list[ rightC ];
				list[ rightC ] = list[ rightD ];
				list[ rightD ] = t;
				rightD--;
			}
			rightC--;
		}
		if( leftB > rightC ) {
			break;
		}
		type t = list[ leftB ];
		list[ leftB ] = list[ rightC ];
		list[ rightC ] = t;
		swap_cnt = 1;	
		leftB++;
		rightC--;
	}
	if (swap_cnt == 0) {  /* Switch to insertion sort */
		for( int i = low + 1; i < low + n; i++ ) {
			for( int j = i; j > low && Compare( &list[ j - 1 ], &list[ j ] ) > 0; j-- ) {
				type t = list[ j ];
				list[ j ] = list[ j - 1 ];
				list[ j - 1 ] = t;
			}
		}
		return;
	}

	highBound = low + n;
	r = Min( leftA - low, leftB - leftA );
	for( int i = 0; i < r; i++ ) {
		type t = list[ low + i ];
		list[ low + i ] = list[ leftB - r + i ];
		list[ leftB - r + i ] = t;	
	}
	
	r = Min( rightD - rightC, highBound - rightD - 1 );
	for( int i = 0; i < r; i++ ) {
		type t = list[ leftB + i ];
		list[ leftB + i ] = list[ highBound - r + i ];
		list[ highBound - r + i ] = t;	
	}

	if ( (r = leftB - leftA) > 1 ) {
		QSort_Iterative( list, low, r );
	}
	if ((r = rightD - rightC) > 1) {
		/* Iterate rather than recurse to save stack space */
		low = highBound - r;
		n = r;
		goto loop;
	}
	/*		qsort(pn - r, r / es, es, cmp);*/
}



/////////

#endif

