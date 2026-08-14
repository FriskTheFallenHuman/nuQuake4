effect effects/levels/waste/floor_steam2
{
	size	330

	delay "unnamed2"
	{
		duration	0.1,2
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		10,10

		oriented
		{
			duration	3.5,4.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 1,-280,-100,1,280,100 }
				size { box 80,80,120,120 }
				tint { point 0.521569,0.482353,0.345098 }
				fade { point 0 }
				offset { box 0,0,0,10,0,0 }
				rotate { box 0,0,-0.0833333,0,0,0.0833333 }
			}

			motion
			{
				fade { envelope cosine }
			}

			end
			{
				fade { line 0.15,0.25 }
			}
		}
	}
}

