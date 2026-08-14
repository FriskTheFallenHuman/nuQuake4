effect effects/test/bdube/timeout
{
	size	92

	emitter "segment00"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"_default"
			gravity		0.5,0.5

			start
			{
				velocity { box 300,-50,-50,400,50,50 }
				size { point 2,2 }
			}
			timeout
			{
				effect	"effects/test/bdube/electricity"
				effect	"effects/test/bdube/tunnelvision"
			}
		}
	}
	emitter "segment01"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"_default"

			start
			{
				velocity { point 100,0,0 }
				size { point 10,10 }
			}
			timeout
			{
				effect	"effects/monsters/gladiator/blaster_burst"
			}
		}
	}
}


