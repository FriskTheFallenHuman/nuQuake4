effect effects/levels/tram/waterpipe
{
	size	116

	emitter "water"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.7,0.7
			material	" gfx/effects/fluids_drips/bubble_green"
			gravity		0.8,0.8

			start
			{
				position { line 0,-3,-3,0,3,-9 }
				velocity { box 90,-10,-10,100,10,10 }
				size { point 20,20 }
				fade { point 0 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope pop_drop_grow }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
}


