effect effects/monsters/makron/impact
{
	size	214

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 50,50 }
				rotate { box 0,1 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	1,5
			persist
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.02,-0.01

			start
			{
				position { point 5,0,0 }
				velocity { box 0,-5,-5,5,5,5 }
				size { line 5,5,8,8 }
				tint { line 0.752941,0.752941,0.752941,0.8,0.784314,0.709804 }
				fade { line 0.2,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "fire_smokefade" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 60,60,80,60 }
			}
		}
	}
	emitter "end electricity2"
	{
		duration	1,1
		count		30,30
		locked

		electricity
		{
			duration	0.05,0.05
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
				size { box 2,5 }
				tint { line 1,1,1,0.501961,0,0.25098 }
				offset { box 5,-5,-5,5,5,5 }
				length { box 50,0,0,80,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	emitter "end sprite oriented"
	{
		duration	1,1
		count		10,10
		locked

		oriented
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 1,0,0 }
				size { line 80,80,90,90 }
				tint { line 0.921569,0.639216,0.929412,0.615686,0.141176,0.545098 }
				rotate { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "side_impact_streaks"
	{
		duration	1,1
		count		20,50
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -4,-20,-20,-4,20,20 surface }
				size { box 20,30 }
				tint { line 0.713726,0.286275,0.713726,1,1,1 }
				offset { point 5,0,0 }
				length { box 50,0,0,60,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}

