effect effects/debris/debris3
{
	size	4911

	emitter "debrisfast"
	{
		duration	5,5
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	1.5,2.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.7,0.8

			start
			{
				velocity { box 1500,-5,-5,2000,5,5 }
				size { box 1000,1000,1200,1200 }
				tint { line 0.803922,0.454902,0.286275,0.74902,0.423529,0.266667 }
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
				size { box 1500,1500,1800,1800 }
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris"
	{
		start		3,3
		duration	10,10
		count		1,1
		attenuation	1000,1500

		sprite
		{
			duration	4,5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.1,0.25

			start
			{
				velocity { box 500,-5,-5,1000,5,5 }
				size { box 1000,1000,1200,1200 }
				tint { line 0.85098,0.560784,0.443137,0.788235,0.454902,0.313726 }
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
				size { box 1500,1500,1800,1800 }
				fade { point 0.3 }
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


