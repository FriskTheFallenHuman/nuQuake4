effect effects/smoke/dmgsmoke1
{
	size	269

	emitter "smoke"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.03,-0.02

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 40,-2,-2,60,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 30,30,40,40 }
				tint { line 0.219608,0.219608,0.211765,0.321569,0.278431,0.227451 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,100,100 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}
