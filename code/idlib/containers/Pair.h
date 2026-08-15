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
// Pair.cpp
//
// Copyright 2002-2004 Raven Software
//----------------------------------------------------------------

#ifndef __PAIR_H__
#define __PAIR_H__

template< class type1, class type2 >
class rvPair {
public:
	rvPair() {};
	rvPair( const type1& T1, const type2& T2 ) { first = T1; second = T2; };

	const type1& First( void ) const { return first; };
	const type2& Second( void ) const { return second; };

	static int rvPairFirstCompare( const rvPair< type1, type2 > *a, const rvPair< type1, type2 > *b ) {
		return b->First() - a->First();
	}

	static int rvPairSecondCompare( const rvPair< type1, type2 > *a, const rvPair< type1, type2 > *b ) {
		return  b->Second() - a->Second();
	}

	static int rvPairFirstCompareDirect( const rvPair< type1, type2 > *a, const rvPair< type1, type2 > *b ) {
		if( b->First() - a->First() < 0.001f || b->First() - a->First() < -0.001f ) {
			return 0;
		}

		if( a->First() > b->First() ) {
			return -1;
		} else if( a->First() < b->First() ) {
			return 1;
		} 
		return 0;
	}

	static int rvPairSecondCompareDirect( const rvPair< type1, type2 > *a, const rvPair< type1, type2 > *b ) {
		if( b->Second() - a->Second() < 0.001f || b->Second() - a->Second() < -0.001f ) {
			return 0;
		}

		if( a->Second() > b->Second() ) {
			return -1;
		} else if( a->Second() < b->Second() ) {
			return 1;
		} 
		return 0;
	}

private:
	type1 first;
	type2 second;
};

#endif
