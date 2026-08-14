effect effects/levels/hub/electric_slide
{
	size	408

	spawner "unnamed0"
	{
		count		3,3

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,19,7
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				velocity { box 0,0,10,0,0,280 }
				size { box 3,5 }
				length { point 280,0,0 }
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


