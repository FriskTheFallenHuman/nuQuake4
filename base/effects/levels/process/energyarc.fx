effect effects/levels/process/energyarc
{
	size	320

	emitter "Arc"
	{
		duration	0.25,0.25
		count		2,2

		electricity
		{
			duration	0.25,0.25
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				position { line 0,0,-40,0,0,30 }
				size { box 15,20 }
				tint { point 0.752941,0.945098,0.854902 }
				length { line 0,0,0,0,0,0 useEndOrigin }
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
				position { point 120,0,0 }
				size { point 150,150,150 }
				tint { point 0.8,1,1 }
			}
		}
	}
	sound "ZapSound"
	{
		soundShader	"effects_sparks03"
	}
	sound "unnamed3"
	{
		start		0.1,0.1
		soundShader	"effects_sparks02"
	}
}



