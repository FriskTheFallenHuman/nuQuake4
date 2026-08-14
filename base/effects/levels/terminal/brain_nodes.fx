effect effects/levels/terminal/brain_nodes
{
	size	81

	emitter "small bolts"
	{
		duration	0.5,0.5
		count		25,25

		electricity
		{
			duration	0.15,0.15
			fork	0
			jitterRate	0
			jitterSize	0,7,7
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder 0.5,-12,-12,0.5,12,12 surface cone }
				size { box 1,2 }
				offset { point 10,0,0 }
				length { box 10,0,0,60,0,0 }
			}
		}
	}
	emitter "small bolts2"
	{
		duration	0.5,0.5
		count		25,25

		electricity
		{
			duration	0.15,0.15
			fork	0
			jitterRate	0
			jitterSize	0,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { cylinder 0.5,-12,-12,0.5,12,12 surface cone }
				size { box 1,2 }
				offset { point 12,0,0 }
				length { box 10,0,0,30,0,0 }
			}
		}
	}
}



