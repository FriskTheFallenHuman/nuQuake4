effect effects/debris/debris3_nograv
{
	size	5474

	emitter "debris"
	{
		duration	10,10
		count		0.35,0.35
		attenuation	1000,1500

		sprite
		{
			duration	7,9
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 200,-5,-5,600,5,5 }
				size { box 600,600,1000,1000 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
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
				size { box 1800,1800,2200,2200 }
				fade { point 0.3 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "debris2"
	{
		duration	10,10
		count		0.35,0.35
		attenuation	1000,1500

		sprite
		{
			duration	7,9
			material	"gfx/effects/particles_shapes/debris_cloud"

			start
			{
				velocity { box 200,-5,-5,600,5,5 }
				size { box 600,600,1000,1000 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
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
				size { box 1800,1800,2200,2200 }
				fade { point 0.2 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
}
