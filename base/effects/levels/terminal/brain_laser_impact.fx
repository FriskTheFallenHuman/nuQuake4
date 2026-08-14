effect effects/levels/terminal/brain_laser_impact
{
	size	22

	spawner "unnamed2"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				size { point 15,15 }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				tint { point 1,0.717647,0.717647 }
			}
		}
	}
}


