effect effects/ambient/dustedge
{
	size	140

	emitter "dust"
	{
		start		4,4
		duration	2,2
		count		8,8
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	3,4
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.02,0.02

			start
			{
				position { cylinder 0,-64,-10,0,64,10 }
				velocity { box 20,0,0,30,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 20,20,30,30 }
				tint { point 0.258824,0.235294,0.184314 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
				fade { point 0.85 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.0833333,0.0555556 relative }
			}
		}
	}
	emitter "chunks_physics"
	{
		start		4,6
		duration	2,2
		count		2,2

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.4,0.4

			start
			{
				position { line 0,-64,0,0,64,0 }
				velocity { box 10,-30,-30,30,30,30 }
				size { line 1,1,3,3 }
				tint { line 0.458824,0.411765,0.337255,0.231373,0.254902,0.168627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope adc_charge2 }
			}

			end
			{
				fade { point 1 }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
}

