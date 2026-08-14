effect effects/ambient/dustedge_mp
{
	size	604

	emitter "dust"
	{
		duration	2,2
		count		1,1
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	7,8
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.02,0.02

			start
			{
				position { cylinder 0,-64,-10,0,64,10 }
				velocity { box 20,0,0,30,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 60,60,80,80 }
				tint { point 0.792157,0.572549,0.466667 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 150,150,180,180 }
				fade { point 0.4 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.0833333,0.0555556 relative }
			}
		}
	}
	emitter "chunks"
	{
		duration	2,2
		count		0.4,0.4

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.4,0.4

			start
			{
				position { line 0,-64,0,0,64,0 }
				velocity { box 10,-30,-30,30,30,30 }
				size { line 3,3,5,5 }
				tint { line 0.517647,0.435294,0.282353,0.309804,0.266667,0.168627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "adc_charge2" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	delay "unnamed2"
	{
		duration	1,5
	}
}
