effect effects/debris/debris3_small
{
	size	1928

	emitter "debrisfast"
	{
		duration	5,5
		count		1,1
		attenuation	1000,1500

		sprite
		{
			duration	2,4
			material	"gfx/test/debris"
			gravity		0.1,0.2

			start
			{
				velocity { box 250,-5,-5,500,5,5 }
				size { box 200,200,400,400 }
				tint { line 0.74902,0.419608,0.266667,0.803922,0.454902,0.286275 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 500,500,700,700 }
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
			duration	1,2
			material	"gfx/test/debris"
			gravity		0.05,0.15

			start
			{
				velocity { box 100,-5,-5,250,5,5 }
				size { box 200,200,400,400 }
				tint { line 0.74902,0.419608,0.266667,0.803922,0.454902,0.286275 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 500,500,700,700 }
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
