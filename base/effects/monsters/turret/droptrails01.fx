effect effects/monsters/turret/droptrails01
{
	size	2159

	emitter "Flametrails"
	{
		duration	20,20
		count		30,30

		sprite
		{
			duration	0.4,0.4
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 0,-100,-100,0,100,100 }
				size { point 100,100 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
				fade { point 1 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	emitter "Tail"
	{
		duration	20,20
		count		2,2
		locked

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/particles_shapes/motionblur2"

			start
			{
				size { point 160 }
				tint { point 0.647059,0.576471,0.352941 }
				fade { point 0.5 }
				length { point 0,2000,0 }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "random" count 0.2,0.2,0.2 }
				fade { envelope "linear" }
			}

			end
			{
				size { point 80 }
				tint { point 0.639216,0.501961,0.356863 }
			}
		}
	}
}









