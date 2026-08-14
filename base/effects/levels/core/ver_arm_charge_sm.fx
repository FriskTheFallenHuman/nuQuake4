effect effects/levels/core/ver_arm_charge_sm
{
	size	78

	emitter "electric"
	{
		start		0,1
		duration	2.5,2.5
		count		5,5
		locked

		electricity
		{
			duration	0.01,0.125
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { point -1,0,0 }
				tint { point 0.501961,0.501961,1 }
				length { box 5,0,0,10,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "sparks_lines"
	{
		start		2.35,2.45
		count		8,10

		line
		{
			duration	0.3,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.15,0.25
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 100,0,0,200,0,0 }
				acceleration { point -100,0,0 }
				size { box 0.45,0.75 }
				tint { line 0.501961,0.501961,1,0.501961,0,1 }
				length { box 3,0,0,8,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.368627,0.368627,1,1,1,1 }
			}
		}
	}
	spawner "sparks2"
	{
		start		2,2.45
		count		2,7

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.1,0.2

			start
			{
				velocity { box 20,-20,-20,80,20,20 }
				size { line 1,1,2,2 }
				tint { line 0.831373,0.831373,1,0.501961,0.501961,1 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	emitter "electric2"
	{
		start		0.45,0.45
		duration	2.5,2.5
		count		2,2
		locked

		electricity
		{
			duration	0.01,0.125
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { point -1,0,0 }
				size { point 3 }
				tint { point 0.501961,0.501961,1 }
				length { point 20,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	sound "unnamed4"
	{
		start		2,2
		soundShader	"effects_sparks02"
	}
}




