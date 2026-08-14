effect effects/levels/mcc_landing/strogg_tracer_long
{
	size	11240

	spawner "tracer"
	{
		count		1,1

		line
		{
			duration	5,5
			persist
			material	"gfx/effects/weapons/tracerblue"

			start
			{
				velocity { point 5000,0,0 }
				size { point 2 }
				tint { point 0.266667,0.305882,0.490196 }
				length { box 220,0,0,300,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}
		}
	}
	delay "delay"
	{
		duration	0.5,1.5
	}
	sound "unnamed2"
	{
		soundShader	"effects_bullet_tracer_large"
		volume	1,1
		freqshift	1.2,1.2
	}
}









