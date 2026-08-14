effect effects/levels/process/laser_pulse
{
	size	467

	emitter "pulse"
	{
		start		0.25,0.25
		duration	0.5,0.5
		count		1,1

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 85,0,0 }
				velocity { point 300,0,0 }
				size { line 10,10,30,30 }
			}

			motion
			{
				size { envelope random }
				fade { envelope linear_flicker }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	emitter "pulse2"
	{
		start		0.3,0.3
		duration	0.5,0.5
		count		4,4

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 85,0,0 }
				velocity { point 400,0,0 }
				size { box 40,40,60,60 }
			}

			motion
			{
				size { envelope linear_flicker }
			}
		}
	}
	emitter "arcs"
	{
		start		0.6,0.6
		duration	0.5,0.5
		count		15,15

		electricity
		{
			duration	0.5,0.5
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder 1,-0.2,-0.2,1,0.2,0.2 surface }
				size { point 8 }
				offset { point 160,0,0 }
				length { point 110,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "burst"
	{
		start		1.25,1.25
		count		1,1

		oriented
		{
			duration	0.3,0.3
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 85,0,0 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "pulse 3"
	{
		start		0.5,0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 85,0,0 }
				velocity { point 400,0,0 }
				size { line 80,80,100,100 }
			}
		}
	}
	sound "unnamed5"
	{
		start		0.5,0.5
		soundShader	"effects_sparks03"
	}
	sound "unnamed6"
	{
		start		0.3,0.3
		soundShader	"effects_sparks02"
	}
	sound "unnamed7"
	{
		start		1.2,1.2
		soundShader	"effects_energy_burst"
	}
	sound "unnamed8"
	{
		soundShader	"process_core_power_up"
	}
}





