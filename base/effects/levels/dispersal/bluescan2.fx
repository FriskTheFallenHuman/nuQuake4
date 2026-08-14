effect effects/levels/dispersal/bluescan2
{
	size	163

	emitter "spin"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spin_line1"
			flipNormal

			start
			{
				size { line 70,70,90,90 }
				tint { point 0.207843,0.819608,1 }
				fade { point 0.15 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}
