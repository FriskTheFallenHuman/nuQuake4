effect effects/steam/steam_drop
{
	size	140

	emitter "DepthSteam"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	10,10
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.0125,0.0125

			start
			{
				velocity { box 5,-5,-5,10,5,0 }
				size { point 64,64 }
				fade { point 0.25 }
				rotate { box -0.497222,0.497222 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope cosine }
			}

			end
			{
				size { point 32,32 }
				rotate { box -0.497222,0.497222 relative }
			}
		}
	}
}








