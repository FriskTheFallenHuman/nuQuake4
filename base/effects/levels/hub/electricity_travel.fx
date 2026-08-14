effect effects/levels/hub/electricity_travel
{
	size	765

	emitter "electricity"
	{
		duration	1,1
		count		2,2

		electricity
		{
			duration	0.2,0.3
			blend	add
			fork	2
			jitterRate	0
			jitterSize	30,30,30
			material	"gfx/effects/electricity/electricity"

			start
			{
				position { cylinder -0.5,-0.35,-0.35,-0.5,0.35,0.35 }
				velocity { box 3000,0,0,4000,0,0 }
				size { box 8,10 }
				fade { point 0 }
				offset { box 10,0,0,30,0,0 }
				length { box 100,0,0,200,0,0 }
			}

			motion
			{
				fade { envelope fastinslowout }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	delay "delay"
	{
		duration	1,4
	}
	sound "unnamed2"
	{
		soundShader	"effects_sparks02_large"
	}
	sound "unnamed3"
	{
		soundShader	"effects_sparks03_large"
	}
}

