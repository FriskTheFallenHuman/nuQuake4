effect effects/levels/dispersal/heart_rain
{
	size	130

	emitter "drops"
	{
		duration	1,1
		count		2,7

		line
		{
			duration	4,4
			generatedLine
			material	"gfx/effects/fluids_drips/splash_line_alpha_green"
			gravity		0.04,0.04

			start
			{
				position { cylinder 0,-80,-80,0,80,80 }
				velocity { box 0,0,0,50,0,0 }
				size { point 0.5 }
				fade { line 0.75,1 }
				length { box 5,0,0,25,0,0 }
			}
		}
	}
}


