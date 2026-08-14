effect effects/steam/steam_floor_small_sputter
{
	size	106

	emitter "steam1"
	{
		start		0,2
		duration	0.1,0.5
		count		12,12

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.02,0.5

			start
			{
				position { point 25,0,0 }
				velocity { box 200,-8,-8,250,8,8 }
				size { box 15,15,17,17 }
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
				size { box 25,25,27,27 }
				fade { point 0.25 }
			}
		}
	}
	emitter "steam2"
	{
		start		0,1
		duration	0.1,0.5
		count		6,6

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.005,0.1

			start
			{
				position { point 12,0,0 }
				velocity { box 100,-8,-8,150,8,8 }
				size { box 15,15,17,17 }
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
				size { box 25,25,27,27 }
				fade { point 0.25 }
			}
		}
	}
	emitter "steam3"
	{
		start		0,2
		duration	0.25,0.5
		count		25,25

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.005,-0.005

			start
			{
				velocity { box 100,-8,-8,150,8,8 }
				size { box 5,5,10,10 }
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
				size { box 15,15,20,20 }
				fade { point 0.25 }
			}
		}
	}
}


