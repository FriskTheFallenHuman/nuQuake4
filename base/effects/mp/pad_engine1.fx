effect effects/mp/pad_engine1
{
	size	480

	emitter "core"
	{
		duration	1,1
		count		6,6
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 150,0,0,200,0,0 }
				size { point 140,140 attenuate }
				fade { point 0 attenuate }
				offset { point 0,0,7 }
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
				size { point 40,40 attenuate }
				fade { point 1 attenuate }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "line cylinder"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				position { point -20,0,0 }
				angle { box 0,0,-0.5,0,0,0.5 }
				size { box 20,30 }
				fade { point 0.2 }
				offset { point 0,40,0 }
				length { box 340,0,0,400,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				size { point 0 }
				angle { box 0,0,-0.5,0,0,0.5 relative }
			}
		}
	}
	emitter "rings"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1.3,1.8
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				velocity { box 150,0,0,200,0,0 }
				size { point 200,200 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
			}

			end
			{
				size { point 100,100 }
				fade { point 0.65 }
			}
		}
	}
}

