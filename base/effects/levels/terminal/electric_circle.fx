effect effects/levels/terminal/electric_circle
{
	size	518

	emitter "unnamed0"
	{
		duration	1,1
		count		3,3
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,19,7
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				size { box 3,5 }
				length { point 512,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_sparks02_large"
		freqshift	1.3,1.3
	}
	sound "unnamed2"
	{
		soundShader	"effects_sparks03_large"
		freqshift	1.5,1.5
	}
}
