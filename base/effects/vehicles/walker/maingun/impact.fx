effect effects/vehicles/walker/maingun/impact
{
	size	1002

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 75,75 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	spawner "embers_out"
	{
		count		30,30

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/flash"
			gravity		0.2,0.5

			start
			{
				position { sphere 50,-25,-25,0,25,25 }
				velocity { box 150,-200,-200,650,200,200 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { line 1,1,1,0.952941,0.678431,0.372549 }
				offset { box 0,-25,-25,0,25,25 }
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
				size { line 0.5,0.5,1,1 }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 relative }
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
				velocity { box 500,0,0,600,0,0 }
				acceleration { point -600,0,0 }
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
				fade { point 0.8 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "smoke_up_underlit"
	{
		count		2,2

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/smoke/smoke_underlit"
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,0,0,50,0,0 }
				size { line 50,50,100,100 }
				tint { point 0.603922,0.584314,0.505882 }
				fade { point 0 }
				rotate { box -0.0833333,-0.166667 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
			}

			end
			{
				size { line 125,125,175,175 }
				fade { point 0.5 }
			}
		}
	}
	spawner "smoke_fill"
	{
		start		0.4,0.4
		count		2,2

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 10,0,0 }
				velocity { box 0,0,0,200,0,0 }
				acceleration { point -200,0,0 }
				size { line 100,100,200,200 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,100,100 }
				fade { point 0.8 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.09,0.09
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				velocity { box 300,-50,-50,400,50,50 }
				size { point 500,500 }
				tint { point 1,1,0.8 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 200,200 }
				fade { point 0.8 }
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
				size { box 40,60 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box 30,0,0,250,0,0 }
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


