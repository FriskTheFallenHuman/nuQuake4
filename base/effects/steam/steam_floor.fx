effect effects/steam/steam_floor
{
	size	162

	emitter "steam1"
	{
		duration	0.8,0.8
		count		12,12

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 250,-15,-15,255,15,15 }
				acceleration { point -150,0,0 }
				size { box 30,30,35,35 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 50,50,55,55 }
				fade { point 0.25 }
			}
		}
	}
	emitter "steam2"
	{
		start		0.6,0.6
		duration	1,1
		count		6,6

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 200,-15,-15,205,15,15 }
				acceleration { point -150,0,0 }
				size { box 30,30,35,35 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,55,55 }
				fade { point 0.25 }
				rotate { box 0,1 }
			}
		}
	}
	emitter "steam3"
	{
		start		1,1
		duration	0.4,0.4
		count		8,8

		sprite
		{
			duration	2.2,2.2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 50,-15,-15,55,15,15 }
				size { box 40,40,45,45 }
				tint { point 0.6,0.6,0.6 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,65,65 }
				fade { point 0.25 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_steam_blast"
	}
}


