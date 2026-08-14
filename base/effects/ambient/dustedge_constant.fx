effect effects/ambient/dustedge_constant
{
	size	526

	emitter "dust"
	{
		duration	3,3
		count		10,10
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.1,0.1

			start
			{
				position { cylinder 0,-256,-10,0,256,10 }
				velocity { box 200,0,0,400,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 80,80,120,120 }
				tint { point 0.490196,0.4,0.317647 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
			}

			end
			{
				size { line 120,120,160,160 }
				fade { point 0.8 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	emitter "dust2"
	{
		start		3,3
		duration	3,3
		count		8,8
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.1,0.2

			start
			{
				position { cylinder 0,-256,-10,0,256,10 }
				velocity { box 60,0,0,200,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 80,80,120,120 }
				tint { point 0.490196,0.4,0.317647 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
			}

			end
			{
				size { line 120,120,160,160 }
				fade { point 0.8 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	delay "delay"
	{
		duration	8,10
	}
}

