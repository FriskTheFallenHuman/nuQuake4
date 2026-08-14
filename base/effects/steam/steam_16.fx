effect effects/steam/steam_16
{
	size	70

	emitter "steam1"
	{
		duration	30,30
		count		9,12

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.05,-0.02

			start
			{
				velocity { box 15,-5,-5,30,5,5 }
				size { box 2,2,3,2 }
				tint { point 0.862745,0.858824,0.803922 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 20,20,30,30 }
				fade { point 0.15 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


