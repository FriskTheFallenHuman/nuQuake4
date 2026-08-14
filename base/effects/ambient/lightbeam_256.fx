effect effects/ambient/lightbeam_256
{
	size	661

	spawner "beam_inner"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { point 1,0,0 }
				size { box 60,80 }
				fade { line 0.1,0.2 }
				length { box 300,0,0,500,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 65,75 }
				fade { line 0.13,0.15 }
			}
		}
	}
	spawner "beam"
	{
		count		4,4
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.2,-0.2,1,0.2,0.2 }
				size { box 120,160 }
				fade { line 0.08,0.16 }
				length { box 250,0,0,500,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 135,145 }
				fade { line 0.12,0.14 }
			}
		}
	}
	emitter "dust"
	{
		duration	30,30
		count		200,200

		sprite
		{
			duration	1,3
			material	"gfx/effects/particles_shapes/dust"
			gravity		-0.005,0

			start
			{
				position { cylinder 0,-80,-80,500,80,80 }
				velocity { box 0,-0.2,-0.2,1,0.2,0.2 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.2,0.2,0.4,0.4 }
				tint { line 1,0.972549,0.721569,0.866667,0.768628,0.639216 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 0.8 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}





