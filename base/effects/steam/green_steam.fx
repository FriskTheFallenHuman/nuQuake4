effect effects/steam/green_steam
{
	size	386

	emitter "steam"
	{
		duration	2,2
		count		1,1

		sprite
		{
			duration	8,10
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0,0.006

			start
			{
				velocity { box 20,0,0,30,0,0 }
				size { point 15,15 }
				tint { line 0.482353,0.494118,0.380392,0.458824,0.556863,0.321569 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,180,180 }
				fade { point 0.18 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}





