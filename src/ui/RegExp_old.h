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
#ifndef REGEXP_H_
#define REGEXP_H_

class idWindow;

class idRegister {
public:
	idRegister() {};
	idRegister(const char *p, int t) {
		name = p;
		type = t;
		assert(t >= 0 && t < NUMTYPES);
		regCount = REGCOUNT[t];
		enabled = (type == STRING) ? false : true;
	};
	bool enabled;
	int type;
	int regCount;
	enum REGTYPE { VEC4 = 0, FLOAT, BOOL, INT, STRING, VEC2, VEC3, NUMTYPES } ;
	static int REGCOUNT[NUMTYPES];
	idStr name;
	int regs[4];
	void SetToRegs(float *registers, idTypedDict *state);
	void SetToRegList(idList<float> *registers, idTypedDict *state);
	void GetFromRegs(float *registers, idTypedDict *state);
	void CopyRegs(idRegister *src) {
		regs[0] = src->regs[0];
		regs[1] = src->regs[1];
		regs[2] = src->regs[2];
		regs[3] = src->regs[3];
	}
	void Enable(bool b) {
		enabled = b;
	}
	void ReadFromDemoFile(idDemoFile *f);
	void WriteToDemoFile(idDemoFile *f);

};

class idRegisterList {
	idList<idRegister> regs;
public:
	
	// 
	void RemoveReg ( const char* name );
	// 

	void AddReg(const char *name, int type, idParser *src, idWindow *win);
	void AddReg(const char *name, int type, idVec4 data, idWindow *win);
	idRegister *FindReg(const char *name);
	int			FindRegIndex ( const char* name );
	void SetToRegs(float *registers, idTypedDict *state);
	void GetFromRegs(float *registers, idTypedDict *state);
	void Reset();
	void ReadFromDemoFile(idDemoFile *f);
	void WriteToDemoFile(idDemoFile *f);

};

#endif