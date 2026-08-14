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

#include "../idlib/precompiled.h"
#pragma hdrstop
#include "BSE.h"
#include "BSE_Particle.h"
#include "../renderer/tr_local.h"
#include "../renderer/rvMesh.h"

// Retail compilation unit: BSE_Render.obj. Implementations are recovered here.

bool rvParticle::GetEvaluationTime( float time, float &evalTime, bool infinite ) {
	evalTime = time - mStartTime;
	if ( time >= mEndTime - BSE_TIME_EPSILON ) {
		evalTime = mEndTime - mStartTime - BSE_TIME_EPSILON;
	}

	if ( infinite ) {
		return true;
	}
	return time > mStartTime - BSE_TIME_EPSILON && time < mEndTime;
}

int rvParticle::HandleTint( const rvBSE *effect, idVec4 &colour, float alpha ) {
	idVec4 tint;
	if ( mFlags & PTFLAG_ADDITIVE ) {
		const float particleAlpha = colour.w * alpha;
		tint.Set( effect->GetRed() * colour.x * particleAlpha,
			effect->GetGreen() * colour.y * particleAlpha,
			effect->GetBlue() * colour.z * particleAlpha, 1.0f );
	} else {
		tint.Set( effect->GetRed() * colour.x,
			effect->GetGreen() * colour.y,
			effect->GetBlue() * colour.z,
			effect->GetAlpha() * colour.w * alpha );
	}

	const float brightness = effect->GetBrightness();
	tint.x *= brightness;
	tint.y *= brightness;
	tint.z *= brightness;
	return static_cast<int>( PackColor( tint ) );
}

void rvParticle::RenderQuadTrail( const rvBSE *effect, srfTriangles_t *tri,
		idVec3 offset, float fraction, idVec4 &colour, idVec3 &pos, bool first ) {
	const dword color = HandleTint( effect, colour, 1.0f );
	idDrawVert *vert = &tri->verts[tri->numVerts];

	vert[0].xyz = pos + offset;
	vert[0].st.Set( 0.0f, fraction );
	vert[0].SetColor( color );
	vert[1].xyz = pos - offset;
	vert[1].st.Set( 1.0f, fraction );
	vert[1].SetColor( color );

	if ( !first ) {
		int *indexes = &tri->indexes[tri->numIndexes];
		indexes[0] = tri->numVerts - 2;
		indexes[1] = tri->numVerts - 1;
		indexes[2] = tri->numVerts;
		indexes[3] = tri->numVerts - 1;
		indexes[4] = tri->numVerts;
		indexes[5] = tri->numVerts + 1;
		tri->numIndexes += 6;
	}
	tri->numVerts += 2;
}

void rvParticle::RenderMotion( rvBSE *effect, srfTriangles_t *tri,
		const renderEffect_t *owner, float time ) {
	if ( mTrailCount == 0 ) {
		return;
	}

	const float trailStart = Max( time - mTrailTime, mStartTime );
	const float delta = time - trailStart;
	if ( delta <= BSE_TIME_EPSILON ) {
		return;
	}

	idVec4 colour;
	EvaluateTint( time - mStartTime, colour );
	const float fade = colour.w;
	idVec3 size;
	EvaluateSize( time - mStartTime, size.ToFloatPtr() );

	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	idVec3 localView = ( effect->GetViewOrg() - owner->origin ) * owner->axis;
	localView -= mInitPos;
	idVec3 offset = mVelocity.Cross( localView );
	if ( offset.LengthSqr() == 0.0f ) {
		offset = idVec3( 0.0f, 1.0f, 0.0f ).Cross( localView );
	}
	offset.Normalize();
	offset *= size.x * 0.5f;

	for ( int trail = 0; trail < mTrailCount; ++trail ) {
		const float fraction = static_cast<float>( trail ) /
			static_cast<float>( mTrailCount );
		colour.w = ( 1.0f - fraction ) * fade;
		RenderQuadTrail( effect, tri, offset, fraction, colour, position, trail == 0 );
		EvaluatePosition( effect, position,
			time - fraction * delta - mMotionStartTime );
	}

	colour.w = 0.0f;
	RenderQuadTrail( effect, tri, offset, 1.0f, colour, position, false );
}

bool rvSpriteParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime ) ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	idVec2 size;
	EvaluateSize( evalTime, size.ToFloatPtr() );
	float rotation;
	EvaluateRotation( evalTime, &rotation );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	const dword color = HandleTint( effect, tint, override );

	const idVec2 &spriteSize = effect->GetSpriteSize();
	if ( spriteSize.x > FLT_EPSILON || spriteSize.y > FLT_EPSILON ) {
		size = spriteSize;
	}

	float sine;
	float cosine;
	idMath::SinCos( rotation, sine, cosine );
	const idVec3 left = ( cosine * view[1] - sine * view[2] ) * size.x;
	const idVec3 up = ( sine * view[1] + cosine * view[2] ) * size.y;
	idDrawVert *vert = &tri->verts[tri->numVerts];

	vert[0].xyz = position - left;
	vert[0].st.Set( 0.0f, 0.0f );
	vert[0].normal = position;
	vert[0].SetColor( color );
	vert[1].xyz = position - up;
	vert[1].st.Set( 1.0f, 0.0f );
	vert[1].normal = position;
	vert[1].SetColor( color );
	vert[2].xyz = position + left;
	vert[2].st.Set( 1.0f, 1.0f );
	vert[2].normal = position;
	vert[2].SetColor( color );
	vert[3].xyz = position + up;
	vert[3].st.Set( 0.0f, 1.0f );
	vert[3].normal = position;
	vert[3].SetColor( color );

	int *indexes = &tri->indexes[tri->numIndexes];
	indexes[0] = tri->numVerts;
	indexes[1] = tri->numVerts + 1;
	indexes[2] = tri->numVerts + 2;
	indexes[3] = tri->numVerts;
	indexes[4] = tri->numVerts + 2;
	indexes[5] = tri->numVerts + 3;
	tri->numVerts += 4;
	tri->numIndexes += 6;
	return true;
}

bool rvLineParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime ) ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	float size;
	EvaluateSize( evalTime, &size );
	idVec3 length;
	EvaluateLength( evalTime, length );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );

	if ( !( mFlags & PTFLAG_LOCKED ) ) {
		length *= mInitAxis * effect->GetCurrentAxis().Transpose();
	}
	if ( mFlags & PTFLAG_GENERATED_LINE ) {
		idVec3 velocity;
		EvaluateVelocity( effect, velocity, time - mMotionStartTime );
		velocity.Normalize();
		length = velocity * length.Length();
	}

	const idVec3 end = position + length;
	const idVec3 localView = view[0] - ( position + length * 0.5f );
	idVec3 offset = length.Cross( localView );
	offset.Normalize();
	offset *= size;
	const dword color = HandleTint( effect, tint, override );
	idDrawVert *vert = &tri->verts[tri->numVerts];

	vert[0].xyz = position + offset;
	vert[0].st.Set( 0.0f, 0.0f );
	vert[0].normal = position;
	vert[0].SetColor( color );
	vert[1].xyz = position - offset;
	vert[1].st.Set( 0.0f, 1.0f );
	vert[1].normal = position;
	vert[1].SetColor( color );
	vert[2].xyz = end - offset;
	vert[2].st.Set( mTextureScale, 1.0f );
	vert[2].normal = position;
	vert[2].SetColor( color );
	vert[3].xyz = end + offset;
	vert[3].st.Set( mTextureScale, 0.0f );
	vert[3].normal = position;
	vert[3].SetColor( color );

	int *indexes = &tri->indexes[tri->numIndexes];
	indexes[0] = tri->numVerts;
	indexes[1] = tri->numVerts + 1;
	indexes[2] = tri->numVerts + 2;
	indexes[3] = tri->numVerts;
	indexes[4] = tri->numVerts + 2;
	indexes[5] = tri->numVerts + 3;
	tri->numVerts += 4;
	tri->numIndexes += 6;
	return true;
}

bool rvOrientedParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime ) ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	idVec2 size;
	EvaluateSize( evalTime, size.ToFloatPtr() );
	idVec3 rotation;
	EvaluateRotation( evalTime, rotation.ToFloatPtr() );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	idMat3 transform;
	rvAngles( rotation ).ToMat3( transform );
	const idVec3 left = -transform[1] * size.x;
	const idVec3 up = transform[2] * size.y;
	const dword color = HandleTint( effect, tint, override );
	idDrawVert *vert = &tri->verts[tri->numVerts];

	vert[0].xyz = position - left;
	vert[0].st.Set( 0.0f, 0.0f );
	vert[0].normal = position;
	vert[0].SetColor( color );
	vert[1].xyz = position - up;
	vert[1].st.Set( 1.0f, 0.0f );
	vert[1].normal = position;
	vert[1].SetColor( color );
	vert[2].xyz = position + left;
	vert[2].st.Set( 1.0f, 1.0f );
	vert[2].normal = position;
	vert[2].SetColor( color );
	vert[3].xyz = position + up;
	vert[3].st.Set( 0.0f, 1.0f );
	vert[3].normal = position;
	vert[3].SetColor( color );

	int *indexes = &tri->indexes[tri->numIndexes];
	indexes[0] = tri->numVerts;
	indexes[1] = tri->numVerts + 1;
	indexes[2] = tri->numVerts + 2;
	indexes[3] = tri->numVerts;
	indexes[4] = tri->numVerts + 2;
	indexes[5] = tri->numVerts + 3;
	tri->numVerts += 4;
	tri->numIndexes += 6;
	return true;
}

bool rvModelParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime ) || mModel == NULL ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	idVec3 size;
	EvaluateSize( evalTime, size.ToFloatPtr() );
	idVec3 rotation;
	EvaluateRotation( evalTime, rotation.ToFloatPtr() );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	const dword color = HandleTint( effect, tint, override );

	idMat3 transform;
	rvAngles( rotation ).ToMat3( transform );
	if ( !( mFlags & PTFLAG_LOCKED ) ) {
		transform *= mInitAxis * effect->GetCurrentAxis().Transpose();
	}

	const modelSurface_t *surface = mModel->Surface( 0 );
	if ( surface == NULL || surface->geometry == NULL ) {
		return true;
	}
	srfTriangles_t *source = surface->geometry;
	if ( source->primBatchMesh != NULL ) {
		const idMat4 modelTransform(
			transform[0][0] * size.x, transform[1][0] * size.x,
			transform[2][0] * size.x, position.x,
			transform[0][1] * size.y, transform[1][1] * size.y,
			transform[2][1] * size.y, position.y,
			transform[0][2] * size.z, transform[1][2] * size.z,
			transform[2][2] * size.z, position.z,
			0.0f, 0.0f, 0.0f, 1.0f );
		unsigned char colorAdd[4];
		memcpy( colorAdd, &color, sizeof( colorAdd ) );
		rvMesh *mesh = source->primBatchMesh;
		mesh->TransformTriangles( &tri->verts[tri->numVerts],
			&tri->indexes[tri->numIndexes], modelTransform, 32, colorAdd,
			tri->numVerts );
		tri->numVerts += mesh->m_numDrawVertices;
		tri->numIndexes += mesh->m_numDrawIndices;
		return true;
	}

	idDrawVert *destVerts = &tri->verts[tri->numVerts];
	for ( int vertex = 0; vertex < source->numVerts; ++vertex ) {
		destVerts[vertex] = source->verts[vertex];
		destVerts[vertex].SetColor( color );
		destVerts[vertex].xyz *= transform;
		destVerts[vertex].xyz.x *= size.x;
		destVerts[vertex].xyz.y *= size.y;
		destVerts[vertex].xyz.z *= size.z;
		destVerts[vertex].xyz += position;
	}
	for ( int index = 0; index < source->numIndexes; ++index ) {
		tri->indexes[tri->numIndexes + index] =
			tri->numVerts + source->indexes[index];
	}
	tri->numVerts += source->numVerts;
	tri->numIndexes += source->numIndexes;
	return true;
}

bool rvLinkedParticle::Render( const rvBSE *effect, const idMat3 &view,
		srfTriangles_t *tri, float time, float override ) {
	float evalTime;
	if ( !GetEvaluationTime( time, evalTime ) ) {
		return false;
	}

	idVec4 tint;
	EvaluateTint( evalTime, tint );
	float size;
	EvaluateSize( evalTime, &size );
	idVec3 position;
	EvaluatePosition( effect, position, time - mMotionStartTime );
	const idVec3 offset = view[1] * size;
	const dword color = HandleTint( effect, tint, override );
	idDrawVert *vert = &tri->verts[tri->numVerts];

	vert[0].xyz = position + offset;
	vert[0].st.Set( mFraction * mTextureScale, 0.0f );
	vert[0].normal = position;
	vert[0].SetColor( color );
	vert[1].xyz = position - offset;
	vert[1].st.Set( mFraction * mTextureScale, 1.0f );
	vert[1].normal = position;
	vert[1].SetColor( color );

	if ( tri->numVerts > 0 ) {
		int *indexes = &tri->indexes[tri->numIndexes];
		indexes[0] = tri->numVerts - 2;
		indexes[1] = tri->numVerts - 1;
		indexes[2] = tri->numVerts;
		indexes[3] = tri->numVerts - 1;
		indexes[4] = tri->numVerts + 1;
		indexes[5] = tri->numVerts;
		tri->numIndexes += 6;
	}
	tri->numVerts += 2;
	return true;
}
