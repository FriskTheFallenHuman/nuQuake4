effect effects/smoke/ceilingsmoke_64
{
	size	206

	emitter "smoke"
	{
		duration	10,10
		count		8,8

		sprite
		{
			duration	2,2.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 0,-120,-120,0,120,120 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 50,50,65,65 }
				tint { line 0.45098,0.45098,0.45098,0.478431,0.447059,0.372549 }
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
				size { line 65,65,80,80 }
				fade { point 0.6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}


