effect effects/materials/plastic
{
	size	486

	sound "sound"
	{
		soundShader	"bullet_ricochet"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { box 7,7,10,10 }
				fade { point 0.5 }
				rotate { box 0,10 }
			}
		}
	}
	spawner "smoke"
	{
		start		0.12,0.12
		count		1,2

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 5,0,0 }
				velocity { box 10,-20,-20,20,20,20 }
				friction { box -200,0,0,-300,0,0 }
				size { point 10,10 }
				tint { line 0.384314,0.34902,0.258824,0.501961,0.501961,0.501961 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	spawner "chunks_pyschics"
	{
		count		4,6

		sprite
		{
			duration	2,3
			material	"gfx/effects/particles_shapes/chunk_grey"
			gravity		0.5,1

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-150,-150,300,150,150 }
				size { box 2,2,1,1 }
				fade { point 0 }
			}

			motion
			{
				fade { envelope pop_fade }
			}

			end
			{
				fade { point 1 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
}


