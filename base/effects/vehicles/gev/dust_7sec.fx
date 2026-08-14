effect effects/vehicles/gev/dust_7sec
{
	size	501

	emitter "chunks"
	{
		duration	14,14
		count		15,30
		attenuateEmitter

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
				fade { envelope pop_hold_fadefast }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.4 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box 0.5,1 relative }
			}
		}
	}
	emitter "dust"
	{
		duration	14,14
		count		8,8

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.03,-0.02
			generatedNormal

			start
			{
				position { cylinder -1,-1,1,1,1,1 }
				velocity { box -100,-100,-100,100,100,100 }
				acceleration { point -100,0,0 }
				size { box 75,75,125,125 }
				tint { line 0.47451,0.466667,0.356863,0.392157,0.368627,0.286275 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,200,200 }
				fade { line 0.15,0.25 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
}

