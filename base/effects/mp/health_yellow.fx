effect effects/mp/health_yellow
{
	size	95

	emitter "ring2"
	{
		duration	1,1
		count		5,5
		locked

		sprite
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { line 50,50,60,60 }
				tint { point 1,0.92549,0 }
				fade { point 0 }
				offset { point 0,0,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 1,1,2,2 }
				fade { point 0.5 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}

