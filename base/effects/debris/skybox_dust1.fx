effect effects/debris/skybox_dust1
{
	size	366

	emitter "debris2"
	{
		duration	5,5
		count		0.5,0.5
		attenuation	1000,1500

		sprite
		{
			duration	6,7
			material	"gfx/test/debris"

			start
			{
				velocity { point 50,0,0 }
				size { point 150,150 }
				tint { line 0.678431,0.466667,0.270588,0.737255,0.505882,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
