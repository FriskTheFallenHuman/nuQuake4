effect effects/debris/slowskydebris1
{
	size	7474

	emitter "debris2"
	{
		duration	1,1
		count		1,1
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	5,6
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 500,-5,-5,1500,5,5 }
				size { point 2500,2500 }
				tint { line 0.67451,0.396078,0.27451,0.737255,0.462745,0.329412 }
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






