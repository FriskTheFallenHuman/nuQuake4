effect effects/steam/steam_hit
{
	size	170

	emitter "DepthSteam"
	{
		duration	1,1
		count		12,12

		sprite
		{
			duration	20,20
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				velocity { box 0,-10,-10,1,10,10 }
				size { point 32,32 }
				fade { point 0.25 }
				rotate { box -0.497222,0.497222 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope cosine }
			}

			end
			{
				size { point 24,24 }
				rotate { box -0.497222,0.497222 relative }
			}
		}
	}
}






