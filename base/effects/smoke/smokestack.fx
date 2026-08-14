effect effects/smoke/smokestack
{
	size	1406

	emitter "SMOKE"
	{
		duration	1,1
		count		6,8

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.12,-0.05

			start
			{
				velocity { box 50,-50,-50,200,50,50 }
				size { line 75,75,50,50 }
				tint { point 0,0,0 }
				fade { point 0.5 }
				rotate { point 0.5 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 400,400,600,600 }
				tint { point 0.133333,0.109804,0.0509804 }
			}
		}
	}
}




