effect effects/vehicles/gev/dust_concrete
{
	size	382

	emitter "dust"
	{
		duration	1,1
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
	emitter "lines"
	{
		duration	1,1
		count		400,400
		locked
		attenuateEmitter

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
				size { box 4,6 }
				tint { line 0.588235,0.552941,0.478431,0.513726,0.47451,0.360784 }
				fade { point 0.35 }
				offset { point 10,0,0 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 12,15 }
				length { box 200,0,0,250,0,0 }
			}
		}
	}
}









