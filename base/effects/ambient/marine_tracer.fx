effect effects/ambient/marine_tracer
{
	size	11059

	spawner "tracer"
	{
		count		1,1

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/tracerflipped"

			start
			{
				velocity { point 5000,0,0 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 80,0,0,120,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/marine_tracerburst"
			}
		}
	}
	delay "delay"
	{
		duration	1,2
	}
}



