effect effects/steam/fogascend_96
{
	size	153

	emitter "steam1"
	{
		duration	30,30
		count		2,2

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.003,-0.003

			start
			{
				position { cylinder 0,-40,-40,0,40,40 }
				size { line 62,62,97,97 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.2 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}