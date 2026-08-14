effect effects/steam/lightvol_128
{
	size	262

	emitter "steam1"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	4,4
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.01,0.015

			start
			{
				velocity { box 0,0,0,15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 96,96,128,128 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 128,128,160,160 }
				fade { point 0.2 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	4,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.015

			start
			{
				velocity { box 0,0,0,15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 96,96,128,128 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 128,128,160,160 }
				fade { point 0.2 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}

