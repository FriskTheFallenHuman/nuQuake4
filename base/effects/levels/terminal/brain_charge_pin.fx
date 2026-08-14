effect effects/levels/terminal/brain_charge_pin
{
	size	83

	emitter "small bolts2"
	{
		duration	0.5,0.5
		count		10,10

		electricity
		{
			duration	0.15,0.15
			fork	0
			jitterRate	0
			jitterSize	0,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { point 0.5,0,0 cone }
				size { box 1,2 }
				length { box 30,0,0,80,0,0 }
			}
		}
	}
}

