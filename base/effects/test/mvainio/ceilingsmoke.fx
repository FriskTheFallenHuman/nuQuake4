effect effects/test/mvainio/ceilingsmoke
{
	size	284

	emitter "smoke"
	{
		duration	10,10
		count		4,4

		sprite
		{
			duration	2,2.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 0,-90,-90,0,90,90 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 60,60,90,90 }
				tint { line 0.501961,0.501961,0.501961,0.568627,0.52549,0.435294 }
				fade { point 0 }
				rotate { box -0.111111,0 }
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
				fade { point 0.6 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
}

