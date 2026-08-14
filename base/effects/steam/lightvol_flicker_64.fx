effect effects/steam/lightvol_flicker_64
{
	size	229

	emitter "steam1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1.5,1.8
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.01,0.015

			start
			{
				velocity { box 0,0,0,100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 30,30,40,40 }
				fade { point 0.4 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope randomflick count 2 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 80,80,100,100 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1.5,1.8
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.015

			start
			{
				velocity { box 20,0,0,100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 30,30,40,40 }
				fade { point 0.4 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope randomflick count 2 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 80,80,100,100 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
