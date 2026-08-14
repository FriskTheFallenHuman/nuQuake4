effect effects/test/flyer_strafe
{
	size	11246

	emitter "tracer"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/tracerblue"

			start
			{
				velocity { point 5000,0,0 }
				size { point 8 }
				tint { point 0.266667,0.305882,0.490196 }
				length { box 220,0,0,300,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/strogg_tracerburst"
			}
		}
	}
	delay "delay"
	{
		duration	0.5,1.5
	}
}
