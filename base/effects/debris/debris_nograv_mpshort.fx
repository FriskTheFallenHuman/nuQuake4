effect effects/debris/debris_nograv_mpshort
{
	size	2190

	emitter "debris"
	{
		duration	10,10
		count		1,1
		attenuation	1000,1500

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 50,-5,-5,500,5,5 }
				size { box 460,460,500,500 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
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
				size { box 580,580,620,620 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "debris2"
	{
		duration	10,10
		count		1,1
		attenuation	1000,1500

		sprite
		{
			duration	4,6
			material	"gfx/effects/particles_shapes/debris_cloud"

			start
			{
				velocity { box 50,-5,-5,500,5,5 }
				size { box 460,460,500,500 }
				tint { line 0.941177,0.521569,0.313726,0.839216,0.576471,0.411765 }
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
				size { box 580,580,620,620 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
