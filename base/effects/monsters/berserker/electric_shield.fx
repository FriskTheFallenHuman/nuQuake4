effect effects/monsters/berserker/electric_shield
{
	size	238

	emitter "arcs"
	{
		duration	0.5,0.5
		count		30,30

		electricity
		{
			duration	3,3
			blend	add
			fork	5
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder 1,-50,-50,1,50,50 surface }
				size { point 2 }
				length { point 200,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}


