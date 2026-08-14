effect effects/steam/fogascend_oriented_128
{
	size	283

	emitter "oriented fog"
	{
		duration	30,30
		count		1,1

		oriented
		{
			duration	4,6
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.003,-0.003

			start
			{
				position { cylinder 0,-80,-80,0,80,80 }
				size { line 120,120,160,160 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.2 }
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
}


