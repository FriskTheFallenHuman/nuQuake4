effect effects/steam/lightvol_96_mp
{
	size	255

	emitter "steam2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.015

			start
			{
				velocity { box 0,0,0,15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 60,60,70,70 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,120,120 }
				fade { point 0.25 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
