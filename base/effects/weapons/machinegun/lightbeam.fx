effect effects/weapons/machinegun/lightbeam
{
	size	137

	emitter "beam_inner"
	{
		duration	1,1
		count		3,3
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"

			start
			{
				size { box 0.5,2 }
				fade { line 0.7,0.25 }
				offset { point -5,-2.5,0 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope "randomflick" count 5 }
				fade { envelope "randomflick" count 12 }
			}

			end
			{
				size { box 0.5,2 }
				fade { line 0.25,0.1 }
			}
		}
	}
	emitter "beam"
	{
		duration	1,1
		count		15,15
		locked

		line
		{
			duration	3,5
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.3,-0.3,1,0.3,0.3 cone }
				size { box 1.5,4 }
				fade { line 0.05,0.09 }
				offset { point -10,-2.5,0 }
				length { box 80,0,0,120,0,0 }
			}

			motion
			{
				size { envelope "linear_flicker" }
				fade { envelope "randomflick" }
			}

			end
			{
				size { box 0.5,6 }
			}
		}
	}
	emitter "dust"
	{
		duration	1,1
		count		15,15
		locked

		sprite
		{
			duration	0.35,4
			material	"gfx/effects/particles_shapes/dust"

			start
			{
				position { cylinder 15,-35,-30,100,25,30 cone }
				velocity { box 0,-0.2,-0.2,1,0.2,0.2 }
				angle { box 0,0,0,1,1,1 }
				size { point 0.125,0.125 }
				tint { line 1,0.992157,0.917647,0.776471,0.745098,0.733333 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				fade { line 0.3,0.6 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}


