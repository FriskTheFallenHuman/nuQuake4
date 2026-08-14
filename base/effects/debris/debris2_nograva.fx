effect effects/debris/debris2_nograva
{
	size	3182

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
				velocity { box 50,-5,-5,80,5,5 }
				size { box 200,200,300,300 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
				fade { point 0 }
				rotate { box 0,0.166667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 1000,1000,1500,1500 }
				fade { point 0.3 }
				rotate { box -0.0555556,0.0555556 relative }
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
				velocity { box 50,-5,-5,80,5,5 }
				size { box 600,600,800,800 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
				fade { point 0 }
				rotate { box 0,0.166667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 1800,1800,2000,2000 }
				fade { point 0.2 }
				rotate { box -0.0555556,0.0555556 relative }
			}
		}
	}
}


