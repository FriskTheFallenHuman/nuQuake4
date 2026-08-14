effect effects/monsters/harvester/walk
{
	size	1010

	spawner "dirt_up"
	{
		count		4,4

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.5,0.75

			start
			{
				position { cylinder 100,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 100,-100,-100,500,100,100 }
				acceleration { point -400,0,0 }
				size { line 0,0,1,1 }
				tint { point 0.541176,0.454902,0.356863 }
				fade { point 0 }
				rotate { box 0,0.0833333 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,200,200 }
				tint { point 0.364706,0.321569,0.27451 }
				fade { point 1 }
				rotate { box 0.0833333,0.166667 relative }
			}
		}
	}
	spawner "dirt_up2"
	{
		count		4,4

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/dirt3"
			gravity		0.5,0.75

			start
			{
				position { cylinder 150,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 100,-100,-100,400,100,100 }
				acceleration { point -400,0,0 }
				size { line 0,0,1,1 }
				tint { point 0.545098,0.454902,0.360784 }
				fade { point 0 }
				rotate { box -0.0833333,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,250,250 }
				tint { point 0.364706,0.32549,0.27451 }
				fade { point 1 }
				rotate { box -0.166667,-0.0833333 relative }
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
			gravity		-0.02,-0.02

			start
			{
				velocity { box -25,-25,-25,25,25,25 }
				size { line 50,50,100,100 }
				tint { point 0.752941,0.752941,0.752941 }
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
				fade { point 1 }
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
				size { line 100,100,150,150 }
				tint { point 0.752941,0.752941,0.752941 }
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
				fade { point 1 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "smoke_ring"
	{
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.03,-0.03
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-8,-8,0.1,8,8 surface }
				velocity { box 200,0,0,400,0,0 }
				acceleration { point -400,0,0 }
				size { point 6,6 }
				tint { point 0.376471,0.356863,0.309804 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "chunks"
	{
		start		0.12,0.12
		count		5,5

		sprite
		{
			duration	3,4
			material	"gfx/effects/rock_alpha"
			gravity		1,1
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				velocity { box 450,0,0,550,0,0 }
				size { line 6,6,15,15 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	spawner "unnamed6"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 20,20 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}

