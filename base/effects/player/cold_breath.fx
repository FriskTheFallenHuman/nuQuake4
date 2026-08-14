effect effects/player/cold_breath
{
	size	16

	emitter "Steam"
	{
		duration	0.5,1
		count		7,7
		locked

		sprite
		{
			duration	0.5,3
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.00125,0

			start
			{
				position { point 3,0,0 }
				velocity { box 2,0,0,5,0,0 }
				size { point 0,0 }
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
				size { point 5,5 }
				rotate { box -0.497222,0.497222 relative }
			}
		}
	}
	delay "unnamed1"
	{
		duration	2,3
	}
}


