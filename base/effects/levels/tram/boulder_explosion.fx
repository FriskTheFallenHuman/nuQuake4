effect effects/levels/tram/boulder_explosion
{
	size	1277

	sound "sound"
	{
		soundShader	"vehicle_walker_death"
	}
	spawner "Smoke"
	{
		count		3,8

		sprite
		{
			duration	6,6
			material	"gfx/effects/smoke/cloud_alpha"
			generatedNormal

			start
			{
				position { box -5,-5,-5,5,5,5 }
				velocity { box -100,-50,-50,-150,50,50 }
				angle { box 0,0,0.0833333,0,0,0.166667 }
				size { point 300,300 }
				tint { line 0.443137,0.333333,0.223529,0.403922,0.27451,0.184314 }
				fade { point 0.5 }
				offset { point 12,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fire_smokefade count 2,2,2 }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 500,500 }
				tint { line 0.227451,0.192157,0.152941,0.207843,0.188235,0.101961 }
				angle { point 0,0,0.222222 relative }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "large streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { cylinder -30,-5,-5,-30,5,5 }
				size { point 10 }
				length { box 100,-100,-100,150,100,100 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100 }
			}
		}
	}
	spawner "streaks"
	{
		count		2,2

		line
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -100,0,0 }
				size { point 10 }
				length { box 100,-30,-30,100,30,30 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 200 }
				length { point 400,0,0 }
			}
		}
	}
	spawner "streaks222"
	{
		count		2,2

		line
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -100,0,0 }
				size { point 10 }
				length { box 200,-30,-30,200,30,30 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 150 }
				length { point 400,0,0 }
			}
		}
	}
	spawner "shockwave2"
	{
		count		1,1

		oriented
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 0.02,0,0 }
				tint { point 0.231373,0.231373,0.231373 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 700,700 }
			}
		}
	}
	spawner "shockwave_vert"
	{
		count		1,1

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				size { point 25,25 }
				tint { point 0.231373,0.231373,0.231373 }
				rotate { box 0.1,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 900,900 }
			}
		}
	}
	spawner "dirt_up"
	{
		count		10,20

		sprite
		{
			duration	0.5,2
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.4,0.4

			start
			{
				velocity { box -200,-400,-400,200,400,400 }
				size { box 90,90,200,200 }
				tint { point 0.458824,0.356863,0.258824 }
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
				fade { point 1 }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
	spawner "ground_sprite"
	{
		count		2,2

		oriented
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 0.02,0,0 }
				size { point 100,100 }
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
				size { point 350,350 }
			}
		}
	}
	spawner "chunks2"
	{
		count		5,10

		sprite
		{
			duration	3,4
			material	"gfx/effects/rock_alpha"
			gravity		0.7,0.7
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				velocity { point -300,0,0 }
				size { point 4,4 }
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
	spawner "chunks3"
	{
		count		5,10

		sprite
		{
			duration	2,4
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.5,0.7

			start
			{
				velocity { box -150,-300,-300,-500,300,300 }
				size { line 4,4,12,12 }
				tint { point 0.376471,0.258824,0.12549 }
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
	spawner "chunks4"
	{
		count		6,11

		sprite
		{
			duration	3,4
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.9,0.9

			start
			{
				velocity { box -400,-400,-400,-400,400,400 }
				size { line 15,15,45,45 }
				tint { point 0.376471,0.258824,0.12549 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 1 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}


