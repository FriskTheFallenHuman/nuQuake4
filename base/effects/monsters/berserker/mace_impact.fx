effect effects/monsters/berserker/mace_impact
{
	size	43

	spawner "end electricity2"
	{
		count		3,3

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electricity"
			generatedOriginNormal

			start
			{
				position { cylinder -0.01,0.35,0.35,-0.01,-0.35,-0.35 }
				size { box 0.5,1 }
				offset { box 5,-5,-5,5,5,5 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	spawner "end sprite oriented"
	{
		count		1,1

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 1,0,0 }
				size { line 20,20,30,30 }
				rotate { box 0,0,0,0,0,1 }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		detail		0.5
		count		4,6

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 2,3 }
				length { box 4,0,0,7,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_sparks02"
		volume	6,6
	}
}



