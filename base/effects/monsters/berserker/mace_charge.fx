effect effects/monsters/berserker/mace_charge
{
	size	20

	emitter "unnamed0"
	{
		duration	1,1
		count		8,8
		locked

		electricity
		{
			duration	0.2,0.2
			fork	0
			jitterRate	0
			jitterSize	0,8,8
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				offset { box -5,-5,-5,5,5,5 }
				length { point 0,0,10 }
			}
		}
	}
}

