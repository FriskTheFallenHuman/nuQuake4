effect effects/debris/debris5
{
	size	2508

	emitter "debrisfast"
	{
		duration	5,5
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	1.5,2.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0,0.02

			start
			{
				velocity { box 500,-5,-5,1000,5,5 }
				size { box 500,500,800,800 }
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
				size { box 800,800,1000,1000 }
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris"
	{
		start		1,3
		duration	5,5
		count		3,3
		attenuation	1000,1500

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.1,0.25

			start
			{
				position { cylinder 0,-150,-1,0,150,1 surface }
				velocity { box 200,-5,-5,250,5,5 }
				size { box 100,100,150,150 }
				tint { line 0.847059,0.556863,0.439216,0.784314,0.454902,0.313726 }
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
				size { box 300,300,350,350 }
				fade { line 0.2,0.3 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	delay "delay"
	{
		duration	2,5
	}
}

