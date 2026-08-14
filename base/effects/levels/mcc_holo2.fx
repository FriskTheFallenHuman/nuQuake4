effect effects/levels/mcc_holo2
{
	size	51

	spawner "beam"
	{
		count		20,20
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.7,-0.7,1,0.7,0.7 }
				size { box 5,10 }
				tint { line 0.152941,0.278431,0.262745,1,1,1 }
				fade { line 0.05,0.01 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 6,8 }
				fade { line 0.06,0.07 }
			}
		}
	}
	emitter "dust"
	{
		duration	30,30
		count		10,10

		sprite
		{
			duration	3,5
			material	"gfx/effects/particles_shapes/dust"
			gravity		-0.002,0

			start
			{
				position { cylinder 0,-8,-8,20,8,8 }
				velocity { box 0,-0.2,-0.2,0.2,0.2,0.2 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.15,0.15,0.35,0.35 }
				tint { line 0.815686,0.909804,0.862745,0.666667,0.768628,0.843137 }
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
				fade { point 0.5 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}
