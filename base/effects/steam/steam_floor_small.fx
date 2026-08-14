effect effects/steam/steam_floor_small
{
	size	190

	emitter "steam1"
	{
		duration	1,1
		count		4,5

		sprite
		{
			duration	1.5,2.5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.01

			start
			{
				position { point -5,0,0 }
				velocity { box 45,-8,-8,65,8,8 }
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
				size { box 75,75,85,85 }
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







