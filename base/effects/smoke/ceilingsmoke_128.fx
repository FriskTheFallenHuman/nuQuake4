effect effects/smoke/ceilingsmoke_128
{
	size	284

	emitter "smoke"
	{
		duration	10,10
		count		3,3

		sprite
		{
			duration	2,2.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 0,-90,-90,0,90,90 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 90,90,120,120 }
				tint { line 0.447059,0.447059,0.447059,0.47451,0.447059,0.368627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 120,120,150,150 }
				fade { line 0.5,0.6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}





