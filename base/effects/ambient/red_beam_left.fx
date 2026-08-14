effect effects/ambient/red_beam_left
{
	size	65

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
				size { point 0.15 }
				fade { point 0.75 }
				offset { point 0,-1,-13.765 }
				length { point 50.75,0,0 }
			}
		}
	}
}
