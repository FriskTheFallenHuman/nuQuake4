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

#ifndef __STRPOOL_H__
#define __STRPOOL_H__

/*
===============================================================================

	idStrPool

===============================================================================
*/

class idStrPool;

class idPoolStr : public idStr {
	friend class idStrPool;

public:
						idPoolStr() { numUsers = 0; }
						~idPoolStr() { assert( numUsers == 0 ); }

						// returns total size of allocated memory
	size_t				Allocated( void ) const { return idStr::Allocated(); }
						// returns total size of allocated memory including size of string pool type
	size_t				Size( void ) const { return sizeof( *this ) + Allocated(); }
						// returns a pointer to the pool this string was allocated from
	const idStrPool *	GetPool( void ) const { return pool; }

private:
	idStrPool *			pool;
	mutable int			numUsers;
};

class idStrPool {
public:
						idStrPool() { caseSensitive = true; }

	void				SetCaseSensitive( bool caseSensitive );

	int					Num( void ) const { return pool.Num(); }
	size_t				Allocated( void ) const;
	size_t				Size( void ) const;

	const idPoolStr *	operator[]( int index ) const { return pool[index]; }

	const idPoolStr *	AllocString( const char *string );
	void				FreeString( const idPoolStr *poolStr );
	const idPoolStr *	CopyString( const idPoolStr *poolStr );
	void				Clear( void );

// RAVEN BEGIN
// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	void				SetAllocatorHeap ( rvHeap* heap )
	{
		assert(heap);
		pool.SetAllocatorHeap(heap);
		poolHash.SetAllocatorHeap(heap);
	}
#endif
// RAVEN END

private:
	bool				caseSensitive;
	idList<idPoolStr *>	pool;
	idHashIndex			poolHash;
};

/*
================
idStrPool::SetCaseSensitive
================
*/
ID_INLINE void idStrPool::SetCaseSensitive( bool caseSensitive ) {
	this->caseSensitive = caseSensitive;
}

/*
================
idStrPool::AllocString
================
*/
ID_INLINE const idPoolStr *idStrPool::AllocString( const char *string ) {
	int i, hash;
	idPoolStr *poolStr;

	hash = poolHash.GenerateKey( string, caseSensitive );
	if ( caseSensitive ) {
		for ( i = poolHash.First( hash ); i != -1; i = poolHash.Next( i ) ) {
			if ( pool[i]->Cmp( string ) == 0 ) {
				pool[i]->numUsers++;
				return pool[i];
			}
		}
	} else {
		for ( i = poolHash.First( hash ); i != -1; i = poolHash.Next( i ) ) {
			if ( pool[i]->Icmp( string ) == 0 ) {
				pool[i]->numUsers++;
				return pool[i];
			}
		}
	}

// RAVEN BEGIN
// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	RV_PUSH_SYS_HEAP_ID(RV_HEAP_ID_PERMANENT);
#endif
// RAVEN END
	poolStr = new idPoolStr;
// RAVEN BEGIN
// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	RV_POP_HEAP();
#endif
// RAVEN END
	*static_cast<idStr *>(poolStr) = string;
	poolStr->pool = this;
	poolStr->numUsers = 1;
	poolHash.Add( hash, pool.Append( poolStr ) );
	return poolStr;
}

/*
================
idStrPool::FreeString
================
*/
ID_INLINE void idStrPool::FreeString( const idPoolStr *poolStr ) {
	int i, hash;

	assert( poolStr->numUsers >= 1 );
	assert( poolStr->pool == this );

	poolStr->numUsers--;
	if ( poolStr->numUsers <= 0 ) {
		hash = poolHash.GenerateKey( poolStr->c_str(), caseSensitive );
		if ( caseSensitive ) { 
			for ( i = poolHash.First( hash ); i != -1; i = poolHash.Next( i ) ) {
				if ( pool[i]->Cmp( poolStr->c_str() ) == 0 ) {
					break;
				}
			}
		} else {
			for ( i = poolHash.First( hash ); i != -1; i = poolHash.Next( i ) ) {
				if ( pool[i]->Icmp( poolStr->c_str() ) == 0 ) {
					break;
				}
			}
		}
		assert( i != -1 );
		assert( pool[i] == poolStr );
		delete pool[i];
		pool.RemoveIndex( i );
		poolHash.RemoveIndex( hash, i );
	}
}

/*
================
idStrPool::CopyString
================
*/
ID_INLINE const idPoolStr *idStrPool::CopyString( const idPoolStr *poolStr ) {

	assert( poolStr->numUsers >= 1 );

	if ( poolStr->pool == this ) {
		// the string is from this pool so just increase the user count
		poolStr->numUsers++;
		return poolStr;
	} else {
		// the string is from another pool so it needs to be re-allocated from this pool.
		return AllocString( poolStr->c_str() );
	}
}

/*
================
idStrPool::Clear
================
*/
ID_INLINE void idStrPool::Clear( void ) {
	int i;

	for ( i = 0; i < pool.Num(); i++ ) {
		pool[i]->numUsers = 0;
	}
	pool.DeleteContents( true );
	poolHash.Free();
}

/*
================
idStrPool::Allocated
================
*/
ID_INLINE size_t idStrPool::Allocated( void ) const {
	int i;
	size_t size;

	size = pool.Allocated() + poolHash.Allocated();
	for ( i = 0; i < pool.Num(); i++ ) {
		size += pool[i]->Allocated();
	}
	return size;
}

/*
================
idStrPool::Size
================
*/
ID_INLINE size_t idStrPool::Size( void ) const {
	int i;
	size_t size;

	size = pool.Size() + poolHash.Size();
	for ( i = 0; i < pool.Num(); i++ ) {
		size += pool[i]->Size();
	}
	return size;
}

#endif /* !__STRPOOL_H__ */
