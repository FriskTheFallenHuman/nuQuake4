effect effects/levels/hub/elec_crawler
{
	size	269

	emitter "arcs"
	{
		duration	1,1
		count		4,8

		electricity
		{
			duration	0.5,0.5
			blend	add
			fork	0
			jitterRate	1
			jitterSize	0.1,25,25
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal
			flipNormal

			start
			{
				position { line 1,-1.2,0,1,1.2,0 }
				size { point 8 }
				offset { point 120,0,0 }
				length { point 140,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}
