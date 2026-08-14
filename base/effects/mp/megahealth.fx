effect effects/mp/megahealth
{
	size	220

	emitter "ring2"
	{
		duration	1,1
		count		6,6
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { line 40,40,50,50 }
				tint { point 0.196078,0.392157,1 }
				fade { point 0 }
				offset { point 0,0,22 }
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
				size { line 120,120,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}


