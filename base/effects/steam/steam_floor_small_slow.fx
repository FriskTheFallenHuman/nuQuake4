effect effects/steam/steam_floor_small_slow
{
	size	127

	emitter "steam1"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	3.5,4.5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.01

			start
			{
				position { point -5,0,0 }
				velocity { box 5,-8,-8,15,8,8 }
				size { box 20,20,30,30 }
				tint { point 0.313726,0.494118,0.513726 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope brassscale count 0.12,0.12,0.12 }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 55,55,65,65 }
				tint { point 0.796079,0.729412,0.627451 }
				fade { line 0.15,0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	delay "unnamed2"
	{
		duration	0.1,2
	}
}




