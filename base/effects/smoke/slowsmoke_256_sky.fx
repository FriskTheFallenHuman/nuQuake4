effect effects/smoke/slowsmoke_256_sky
{
	size	987

	emitter "smoke"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	8,10
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0001,-0.0001

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 50,0,0,90,-1,-1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { box 150,150,180,180 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 300,300,400,400 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}
