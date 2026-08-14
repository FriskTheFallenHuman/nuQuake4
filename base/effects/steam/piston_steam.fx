effect effects/steam/piston_steam
{
	size	99

	emitter "steam"
	{
		duration	1,1
		count		150,150

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.25,0.25

			start
			{
				position { cylinder 0,-20,-20,0,20,20 surface }
				velocity { box 100,0,0,350,0,0 }
				size { point 5,5 }
				tint { line 0.541176,0.517647,0.458824,0.74902,0.74902,0.74902 }
				fade { line 0.2,0.3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
				rotate { point 0 relative }
			}
		}
	}
}



