effect effects/monsters/strogg_flyer/impact_rock
{
	size	1035

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 15,15 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "chunks"
	{
		count		4,6

		sprite
		{
			duration	2,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		1,1

			start
			{
				velocity { box 150,-450,-450,450,450,450 }
				size { line 4,4,8,8 }
				tint { point 0.545098,0.454902,0.360784 }
				fade { point 0 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope decalfade }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "embers_out"
	{
		count		10,15

		sprite
		{
			duration	0.25,0.75
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.02,-0.02

			start
			{
				position { sphere 1,-5,-5,0,5,5 }
				velocity { box 200,-50,-50,500,50,50 }
				angle { box 0,0,0,1,1,1 }
				size { point 8,8 }
				fade { point 0.3 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear_flicker }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box 0,0,0,1,1,1 relative }
			}
		}
	}
	spawner "dirt_up"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.4,0.6

			start
			{
				velocity { box 100,-100,-100,400,100,100 }
				size { line 60,60,80,80 }
				tint { point 0.545098,0.454902,0.360784 }
				fade { point 0 }
				rotate { box -0.0833333,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				tint { point 0.364706,0.32549,0.27451 }
				fade { point 1 }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
	spawner "smoke_hang"
	{
		start		0.09,0.09
		count		2,2

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			generatedOriginNormal

			start
			{
				velocity { box -25,-25,-25,25,25,25 }
				size { line 50,50,100,100 }
				tint { line 0.74902,0.74902,0.74902,0.541176,0.47451,0.4 }
				fade { point 0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 75,75,150,150 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.8 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "smoke_up"
	{
		start		0.09,0.09
		count		2,2

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,0,0,50,0,0 }
				size { point 20,20 }
				tint { line 0.74902,0.74902,0.74902,0.392157,0.305882,0.176471 }
				fade { point 0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 125,125,175,175 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.8 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 50,50,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 75,75,150,150 }
			}
		}
	}
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 10,20 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box 30,0,0,100,0,0 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
}
