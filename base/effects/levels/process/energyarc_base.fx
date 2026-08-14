effect effects/levels/process/energyarc_base
{
	size	228

	emitter "Arcs"
	{
		duration	0.25,0.25
		count		2,2

		electricity
		{
			duration	0.3,0.3
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				position { line 0,0,-10,0,0,10 }
				size { box 10,15 }
				tint { point 0.768628,0.890196,0.839216 }
				length { point 75,0,0 }
			}
		}
	}
	light "FlashyLite"
	{

		light
		{
			duration	0.25,0.25
			material	"lights/rav_spot"

			start
			{
				position { point 40,0,0 }
				size { point 120,120,120 }
				tint { point 0.8,1,1 }
			}
		}
	}
	sound "ZapSound"
	{
		soundShader	"effects_sparks02"
	}
	sound "unnamed3"
	{
		start		0.1,0.1
		soundShader	"effects_weld"
	}
}



