effect effects/smoke/scorchsmoke_32
{
	size	85

	emitter "smoke"
	{
		duration	2,2
		count		5,5

		sprite
		{
			duration	3,4
			material	"gfx/test/smoke"
			gravity		-0.02,-0.02

			start
			{
				velocity { point 12,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 6,6,10,10 }
				tint { line 0.101961,0.0901961,0.0745098,0.333333,0.282353,0.184314 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
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
				size { line 35,35,40,40 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	delay "delay"
	{
		duration	2,9
	}
}
