effect effects/ambient/red_beam_right
{
	size	69

	spawner "unnamed0"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/red_beam"

			start
			{
				size { point 0.25 }
				fade { point 0.75 }
				offset { point 3.5,13.5,2 }
				length { point 54,0,0 }
			}
		}
	}
}
