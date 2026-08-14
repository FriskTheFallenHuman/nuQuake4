effect effects/debris/debris1_nograv
{
	size	4323

	emitter "debris"
	{
		duration	1,1
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 500,-5,-5,1500,5,5 }
				size { box 600,600,1000,1000 }
				tint { line 0.941177,0.521569,0.317647,0.843137,0.576471,0.415686 }
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
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris2"
	{
		duration	1,1
		count		2,2
		attenuation	1000,1500

		sprite
		{
			duration	3,4
			material	"gfx/test/debris"

			start
			{
				velocity { box 500,-5,-5,1500,5,5 }
				size { box 600,600,1000,1000 }
				tint { line 0.941177,0.521569,0.317647,0.843137,0.576471,0.415686 }
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
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
