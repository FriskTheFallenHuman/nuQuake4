effect effects/levels/process/energyarc_mid
{
	size	20

	emitter "Arc"
	{
		duration	0.25,0.25
		count		2,2

		electricity
		{
			duration	0.25,0.25
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				position { line 0,0,-10,0,0,10 }
				size { box 10,15 }
				tint { point 0.741176,0.94902,0.803922 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	sound "ZapSound"
	{
		soundShader	"effects_sparks03"
		freqshift	1.1,1.1
	}
}



