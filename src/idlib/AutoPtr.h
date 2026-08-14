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

#ifndef __AUTOPTR_H__
#define __AUTOPTR_H__


// this class is NOT safe for array new's.  It will not properly call
// the destructor for each element and you will silently leak memory.
// it does work for classes requiring no destructor however(base types)
template<typename type>
class idAutoPtr
{
public:
	explicit idAutoPtr(type *ptr = 0)
		: mPtr(ptr)
		{
		}

	~idAutoPtr()
	{
		delete mPtr;
	}

	type &operator*() const
		{
		return *mPtr;
		}

	type *operator->() const
	{
		return &**this;
	}

	type *get() const
	{
		return mPtr;
	}

	type *release()
	{
		type *ptr = mPtr;
		mPtr = NULL;
		return ptr;
		}

	void reset(type *ptr = NULL)
	{
		if (ptr != mPtr)
			delete mPtr;
		mPtr = ptr;
	}

	operator type*()
	{
		return get();
	}

private:
	// disallow copies
	idAutoPtr<type> &operator=(idAutoPtr<type>& ptr);
	idAutoPtr(idAutoPtr<type>& ptr);

	type *mPtr;
};

#endif
