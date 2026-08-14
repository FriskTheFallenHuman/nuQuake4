effect effects/debris/debris_base
{
	size	3010

	emitter "debrisfast"
	{
		duration	5,5
		count		1.5,1.5
		attenuation	1000,1500

		sprite
		{
			duration	1,2
			material	"gfx/test/debris"
			gravity		0.1,0.2

			start
			{
				velocity { box 1000,-5,-5,1500,5,5 }
				size { box 600,600,800,800 }
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
				size { box 800,800,1200,1200 }
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
			duration	5,6
			material	"gfx/test/debris"
			gravity		0.01,0.02

			start
			{
				velocity { box 100,-5,-5,250,5,5 }
				size { box 600,600,800,800 }
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
				size { box 800,800,1200,1200 }
				fade { point 0.15 }
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


