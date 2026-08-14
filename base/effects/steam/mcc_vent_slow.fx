effect effects/steam/mcc_vent_slow
{
	size	139

	emitter "steam1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.0125,0.0125

			start
			{
				position { point 0,0,0 cone }
				velocity { box 5,-5,-5,5,5,5 }
				angle { box 0,0,0,1,0,1 }
				size { box 5,5,10,10 }
				tint { line 1,1,1,0.713726,0.733333,0.796079 }
				fade { point 0.35 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,90,90 }
				angle { box -0.5,0,-0.5,0.5,0,0.5 relative }
				rotate { point 0 relative }
			}
		}
	}
}



