effect effects/monsters/harvester/whip_electricity
{
	size	96

	emitter "end electricity2"
	{
		duration	0.25,0.25
		count		3,3
		locked

		electricity
		{
			duration	0.25,0.75
			blend	add
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electricity"
			generatedOriginNormal

			start
			{
				position { cylinder -10,0.35,0.35,-20,-0.35,-0.35 }
				size { box 0.5,1 }
				offset { box 5,-5,-5,5,5,5 }
				length { box 20,0,0,30,0,0 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	emitter "end sprite"
	{
		duration	0.25,0.25
		count		8,8
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { line -15,0,0,15,0,0 }
				velocity { box 20,0,0,30,0,0 }
				size { line 35,35,60,60 }
			}

			motion
			{
				size { envelope linear_flicker }
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0 relative }
			}
		}
	}
	emitter "side_impact_streaks"
	{
		duration	0.25,0.25
		count		8,20
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -15,-0.3,-0.3,15,0.3,0.3 surface }
				velocity { box 20,0,0,30,0,0 }
				size { box 4,8 }
				length { box 16,0,0,30,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_sparks02"
		volume	6,6
	}
}

