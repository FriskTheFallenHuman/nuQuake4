effect effects/debris/debris2_small
{
	size	1287

	emitter "debrisfast"
	{
		duration	5,5
		count		1,1
		attenuation	1000,1500

		sprite
		{
			duration	1,2
			material	"gfx/test/debris"
			gravity		0.1,0.2

			start
			{
				velocity { box 250,-5,-5,500,5,5 }
				size { box 200,200,400,400 }
				tint { point 0.294118,0.329412,0.34902 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 400,400,600,600 }
				fade { point 0.2 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris"
	{
		start		3,3
		duration	10,10
		count		0.5,0.5
		attenuation	1000,1500

		sprite
		{
			duration	2,3
			material	"gfx/test/debris"
			gravity		0.05,0.15

			start
			{
				velocity { box 100,-5,-5,250,5,5 }
				size { box 200,200,400,400 }
				tint { point 0.294118,0.329412,0.34902 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 400,400,600,600 }
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	delay "delay"
	{
		start		13,13
		duration	5,5
	}
}
