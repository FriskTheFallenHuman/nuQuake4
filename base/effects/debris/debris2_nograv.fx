effect effects/debris/debris2_nograv
{
	size	17855

	emitter "debris"
	{
		duration	10,10
		count		0.3,0.3
		attenuation	1000,1500

		sprite
		{
			duration	14,16
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 500,-5,-5,1500,5,5 }
				size { box 3600,3600,4000,4000 }
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
				size { box 4800,4800,5200,5200 }
				fade { point 0.3 }
				rotate { box -1,1 relative }
			}
		}
	}
	emitter "debris2"
	{
		duration	10,10
		count		0.3,0.3
		attenuation	1000,1500

		sprite
		{
			duration	14,16
			material	"gfx/effects/particles_shapes/debris_cloud"

			start
			{
				velocity { box 500,-5,-5,1500,5,5 }
				size { box 3600,3600,4000,4000 }
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
				size { box 4800,4800,5200,5200 }
				fade { point 0.2 }
				rotate { box -1,1 relative }
			}
		}
	}
}


