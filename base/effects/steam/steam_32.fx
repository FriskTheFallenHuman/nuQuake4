effect effects/steam/steam_32
{
	size	119

	emitter "steam1"
	{
		duration	30,30
		count		8,8

		sprite
		{
			duration	1,1.4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.16,-0.16

			start
			{
				velocity { box 5,-5,-5,5,5,5 }
				size { box 2,2,5,5 }
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
				size { box 50,50,80,80 }
				fade { point 0.3 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


