effect effects/weapons/nailgun/impact_bpglass
{
	size	237

	sound "sound"
	{
		soundShader	"bullet_impact_glass"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/bpglass"

			start
			{
				size { box 3,3,6,6 }
				rotate { line 0,1 }
			}
		}
	}
	spawner "chunks"
	{
		detail		0.5
		start		0.1,0.1
		count		10,15

		sprite
		{
			duration	1,2
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.2,0.2

			start
			{
				position { point 1,0,0 }
				velocity { box 60,-40,-40,140,40,40 }
				size { line 0.25,0.25,0.75,0.75 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		count		5,5

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.02,0.02

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 0,-5,-5,20,5,5 }
				acceleration { point -20,0,0 }
				size { line 0.5,0.5,1,1 }
				tint { line 0.717647,0.792157,0.815686,0.713726,0.819608,0.760784 }
				fade { point 0.8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		6,9

		sprite
		{
			duration	0.2,0.3
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.6,0.6
			generatedOriginNormal
			trailType	motion
			trailTime	0.2,0.2
			trailCount	2,2

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 250,0,0,300,0,0 }
				size { box 0.5,0.5,3,3 }
				tint { point 0.941177,0.921569,0.819608 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" count 2,2,2 }
				fade { envelope "linear_flicker" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { point 0.882353,0.956863,0.992157 }
			}
		}
	}
}


