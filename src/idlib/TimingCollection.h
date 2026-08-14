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

#ifndef __TIMINGCOLLECTION_H_
#define __TIMINGCOLLECTION_H_

// Fixme!  Move this.  It doesn't belong in AI at all, obviously.
#include "../idlib/Str.h"
#include "../idlib/containers/List.h"
#include "../idlib/containers/HashTable.h"
#include "../framework/File.h"
#include "Timer.h"

//-----------------------------------------------------------------------------
//
//								rvTimingCollection
//
//-----------------------------------------------------------------------------

#define RV_TIMERCOLLECTION

#define START_PROFILING(a, b) (a)._TimingStart(b, __FILE__, __LINE__)
#define STOP_PROFILING(a, b) (a)._TimingStop(b, __FILE__, __LINE__)

// Easy and quick way to remove all of this from the codebase
#ifdef RV_TIMERCOLLECTION

#define MAX_TIMERS	16

class rvSingleTiming
{
public:
	int						mTotalUpdates;
	double					mCurValue;
	double					mTotalValue;
	double					mPeakValue;
	double					mLimit;
	int						mLimitExceeded;
	int						mLimitExceededTimesFive;
	int						mDisplayLevel;

	idStr					mName;
	idStr					mParentName;

	idStr					mStartFile;
	int						mStartLine;
	idStr					mEndFile;
	int						mEndLine;

	rvSingleTiming();
	rvSingleTiming( idStr &newName );

	void 					Clear();
	void 					OutputDataToFile( idFile *file, int framesRecorded );
	void 					OutputInfoToFile( idFile *file );
};

class rvTimingCollection
{
protected:
	idTimer					mTimer[MAX_TIMERS];
	idStr					mTimerName[MAX_TIMERS];

	idList<rvSingleTiming>	mTimings;
	idHashTable	<int>		mTimingsIndex;

	int						mCurTimer;
	int						mUpdates;
	int						mCurrentlyUpdating;
	int						mFramesRecorded;

	rvSingleTiming			*GetTiming( idStr &timingName );
	void					DisplayTimingValues( void );
	void					OutputToFile( void );

public:
	rvTimingCollection();

	void					InitFrame( bool inUse, bool displayText, bool outputFileWhenDone );
	void					_TimingStart( const char *timingName, const char *fileName, const int lineNum );
	void					_TimingStop( double msecLimit, const char *fileName, const int lineNum );
	void					AppendToDict( idDict* dict );
	void					Clear( void );
};

#else

class rvTimingCollection
{
protected:
public:
	rvTimingCollection(){}

	void					InitFrame( bool inUse, bool displayText, bool outputFileWhenDone ){}
	void					_TimingStart( const char *timingName, const char *fileName, const int lineNum ){}
	void					_TimingStop( double msecLimit, const char *fileName, const int lineNum ){}
	void					AppendToDict( idDict* dict ){}
	void					Clear( void ){}
};

#endif

#endif
