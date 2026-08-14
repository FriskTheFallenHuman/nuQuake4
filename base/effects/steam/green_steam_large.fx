effect effects/steam/green_steam_large
{
	size	354

	emitter "steam"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	3,5
			material	"gfx/effects/smoke/steam_green"
			gravity		0.05,0.05

			start
			{
				size { box 120,120,140,140 }
				fade { point 0 }
				rotate { box 0,0.277778 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 225,225,250,250 }
				fade { point 0.15 }
				rotate { box 0.277778,0.555556 relative }
			}
		}
	}
}


