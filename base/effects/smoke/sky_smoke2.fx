effect effects/smoke/sky_smoke2
{
	size	119

	emitter "smoke2"
	{
		duration	1,1
		count		5,7

		sprite
		{
			duration	5,10
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.001,-0.001

			start
			{
				position { sphere -5,-80,-80,5,80,80 }
				angle { box 0,0,0,1,1,1 }
				size { point 10,10 }
				tint { line 0.690196,0.733333,0.8,0.752941,0.752941,0.752941 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 15,15,20,20 }
				fade { point 0.15 }
				angle { box -0.0833333,-0.0833333,-0.0833333,0.0833333,0.0833333,0.0833333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}


