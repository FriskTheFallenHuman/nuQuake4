effect effects/ambient/sky_dot
{
	size	15

	emitter "flash2"
	{
		start		0.125,0.125
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	delay "unnamed1"
	{
		start		0,5
		duration	1,1
	}
}
