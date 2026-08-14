effect effects/vehicles/gev/dust_rock
{
	size	384

	emitter "chunks2"
	{
		duration	1,1
		count		15,15
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		-0.1,-0.1
			generatedNormal

			start
			{
				position { cylinder 1,-1,-1,1,1,1 }
				velocity { box 50,0,0,100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 1,1,3,3 }
				tint { line 0.447059,0.466667,0.329412,0.368627,0.34902,0.239216 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,0.5 }
			}

			motion
			{
				fade { envelope "pop_hold_fadefast" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.4 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box 0.5,1 relative }
			}
		}
	}
	emitter "dust2"
	{
		duration	1,1
		count		3,3
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.03,-0.02
			generatedNormal

			start
			{
				position { cylinder 1,-1,-1,1,1,1 }
				velocity { box 100,0,0,200,0,0 }
				acceleration { point -100,0,0 }
				size { box 75,75,125,125 }
				tint { line 0.478431,0.470588,0.360784,0.392157,0.372549,0.290196 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 150,150,200,200 }
				fade { line 0.35,0.5 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "lines2"
	{
		duration	1,1
		count		50,50
		locked
		attenuateEmitter
		attenuation	0,256

		line
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-20,-20,0,20,20 surface }
				velocity { box 150,0,0,200,0,0 }
				size { box 8,12 }
				tint { line 0.588235,0.552941,0.478431,0.513726,0.47451,0.360784 }
				fade { point 0.5 }
				offset { point 10,0,0 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 16,20 }
				length { box 200,0,0,250,0,0 }
			}
		}
	}
}









