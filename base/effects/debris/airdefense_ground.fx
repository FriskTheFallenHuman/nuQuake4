effect effects/debris/airdefense_ground
{
	size	1304

	emitter "debris"
	{
		duration	3,4
		count		4,4
		attenuation	1000,1500

		sprite
		{
			duration	5,10
			material	"gfx/test/debris"

			start
			{
				position { line 0,-200,-200,0,200,200 }
				velocity { box 0,-5,-5,0,5,5 }
				size { box 60,60,100,100 }
				tint { point 0.294118,0.239216,0.160784 }
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
				size { box 400,400,800,800 }
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	delay "delay"
	{
		duration	2,6
	}
}
