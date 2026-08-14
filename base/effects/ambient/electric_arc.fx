effect effects/ambient/electric_arc
{
	size	158

	emitter "electricty"
	{
		duration	1,1
		count		1,1
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	2
			jitterRate	0.2
			jitterSize	3,5,5
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				size { point 5 }
				length { box 1,-1,-1,2,1,1 useEndOrigin }
			}

			motion
			{
				fade { envelope random count 0.5 }
				length { envelope exp_1minusx/x2 }
			}

			end
			{
				length { box 100,-25,-25,160,25,25 }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_sparks02_large"
		freqshift	1.4,1.4
	}
	sound "unnamed2"
	{
		soundShader	"effects_sparks03_large"
		freqshift	0.8,0.8
	}
}




