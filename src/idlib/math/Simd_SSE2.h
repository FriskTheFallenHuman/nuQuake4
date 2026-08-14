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

#ifndef __MATH_SIMD_SSE2_H__
#define __MATH_SIMD_SSE2_H__

/*
===============================================================================

	SSE2 implementation of idSIMDProcessor

===============================================================================
*/

class idSIMD_SSE2 : public idSIMD_SSE {
#ifdef _WIN32
public:
	virtual const char * VPCALL GetName( void ) const;

	//virtual void VPCALL MatX_LowerTriangularSolve( const idMatX &L, float *x, const float *b, const int n, int skip = 0 );
	//virtual void VPCALL MatX_LowerTriangularSolveTranspose( const idMatX &L, float *x, const float *b, const int n );

	virtual void VPCALL ConvertJointQuatsToJointMats( idJointMat *jointMats, const idJointQuat *jointQuats, const int numJoints );
	virtual void VPCALL TransformJoints( idJointMat *jointMats, const int *parents, const int firstJoint, const int lastJoint );
	virtual void VPCALL UntransformJoints( idJointMat *jointMats, const int *parents, const int firstJoint, const int lastJoint );
	virtual void VPCALL MultiplyJoints( idJointMat *result, const idJointMat *joints1, const idJointMat *joints2, const int numJoints );

	virtual void VPCALL TransformVertsNew( idDrawVert *verts, const int numVerts, idBounds &bounds, const idJointMat *joints, const idVec4 *base, const jointWeight_t *weights, const int numWeights );
	virtual void VPCALL TransformVertsAndTangents( idDrawVert *verts, const int numVerts, idBounds &bounds, const idJointMat *joints, const idVec4 *base, const jointWeight_t *weights, const int numWeights );
	virtual void VPCALL TransformVertsAndTangentsFast( idDrawVert *verts, const int numVerts, idBounds &bounds, const idJointMat *joints, const idVec4 *base, const jointWeight_t *weights, const int numWeights );

	virtual int  VPCALL ShadowVolume_CountFacing( const byte *facing, const int numFaces );
	virtual int  VPCALL ShadowVolume_CountFacingCull( byte *facing, const int numFaces, const int *indexes, const byte *cull );
	virtual int  VPCALL ShadowVolume_CreateSilTriangles( int *shadowIndexes, const byte *facing, const silEdge_s *silEdges, const int numSilEdges );
	virtual int  VPCALL ShadowVolume_CreateCapTriangles( int *shadowIndexes, const byte *facing, const int *indexes, const int numIndexes );

	virtual void VPCALL MixedSoundToSamples( short *samples, const float *mixBuffer, const int numSamples );

#endif
};

#endif /* !__MATH_SIMD_SSE2_H__ */
