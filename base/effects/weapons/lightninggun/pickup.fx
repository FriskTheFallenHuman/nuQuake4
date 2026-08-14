effect effects/weapons/lightninggun/pickup
{
	size	15

	emitter "beam"
	{
		duration	1,1
		count		2,2

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0.1
			jitterSize	3.1,0.6,0.6
			material	"gfx/effects/electricity/electricity"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 surface }
				size { point 0.5 }
				offset { point 0,0,3 }
				length { point 0,0,10 }
			}
		}
	}
	emitter "glow"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 6,6 }
				offset { point 0,0,4.5 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 1,0,0 }
				size { point 7,7 }
				offset { point 0,0,3.8 }
				rotate { point 0.25,0,0 }
			}
		}
	}
}


