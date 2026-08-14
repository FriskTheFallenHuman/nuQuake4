effect effects/debris/debris2
{
	size	6020

	emitter "debrisfast"
	{
		duration	5,5
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	2,3
			material	"gfx/test/debris"
			gravity		0.7,0.8

			start
			{
				velocity { box 1500,-5,-5,2000,5,5 }
				size { box 1200,1200,1600,1600 }
				tint { line 0.427451,0.34902,0.239216,0.419608,0.384314,0.239216 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 1800,1800,2400,2400 }
				tint { point 0.294118,0.313726,0.368627 }
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
			duration	5,6
			material	"gfx/test/debris"
			gravity		0.1,0.25

			start
			{
				velocity { box 500,-5,-5,1000,5,5 }
				size { box 1200,1200,1600,1600 }
				tint { line 0.592157,0.403922,0.192157,0.431373,0.341176,0.219608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 1800,1800,2400,2400 }
				tint { point 0.294118,0.329412,0.34902 }
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







