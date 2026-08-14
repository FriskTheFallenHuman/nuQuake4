effect effects/debris/debris4_sml1
{
	size	758

	emitter "debrisfast"
	{
		duration	5,5
		count		4,4
		attenuation	1000,1500

		sprite
		{
			duration	0.5,1
			material	"gfx/test/debris"
			gravity		-0.2,-0.2

			start
			{
				velocity { box 600,-5,-5,600,5,5 }
				size { box 125,125,150,150 }
				tint { line 0.941177,0.521569,0.317647,0.843137,0.576471,0.415686 }
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
				size { box 300,300,350,350 }
				fade { point 0.08 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "debris"
	{
		start		3,3
		duration	10,10
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	1,2
			material	"gfx/test/debris"
			gravity		-0.05,-0.05

			start
			{
				velocity { box 200,-5,-5,200,5,5 }
				size { box 125,125,150,150 }
				tint { line 0.941177,0.521569,0.317647,0.843137,0.576471,0.415686 }
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
				size { box 300,300,350,350 }
				fade { point 0.08 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	delay "delay"
	{
		start		13,13
		duration	5,5
	}
}


