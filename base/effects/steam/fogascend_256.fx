effect effects/steam/fogascend_256
{
	size	340

	emitter "steam1"
	{
		duration	30,30
		count		3,3

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.003,-0.003

			start
			{
				position { cylinder 0,-160,-160,0,160,160 }
				size { line 120,120,160,160 }
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


