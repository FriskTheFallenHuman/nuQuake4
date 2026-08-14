effect effects/debris/debris
{
	size	1788

	emitter "debris"
	{
		duration	3,4
		count		4,4
		attenuation	1000,1500

		sprite
		{
			duration	2,3
			material	"gfx/test/debris"
			gravity		0.01,0.02

			start
			{
				velocity { box 200,-5,-5,500,5,5 }
				size { box 60,60,100,100 }
				tint { point 0.427451,0.352941,0.239216 }
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
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris2"
	{
		start		3,3
		duration	1,1
		count		4,4
		attenuation	1000,1500

		sprite
		{
			duration	2,3
			material	"gfx/test/debris"
			gravity		0.01,0.02

			start
			{
				velocity { box 80,-5,-5,200,5,5 }
				size { box 60,60,100,100 }
				tint { point 0.427451,0.352941,0.239216 }
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
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	delay "delay"
	{
		duration	2,6
	}
}



