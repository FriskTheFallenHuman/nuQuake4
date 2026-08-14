effect effects/monsters/iron_maiden/laser
{
	size	21

	spawner "unnamed1"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/ctf_grey_light"

			start
			{
				size { point 0.25 }
				tint { point 1,0.176471,0.176471 }
				length { point 20,0,0 }
			}
		}
	}
}
