effect effects/monsters/bossbuddy/lightning_impact
{
	size	44

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 5,5 }
				rotate { box 0,1 }
			}
		}
	}
	emitter "smoke"
	{
		duration	0.2,0.2
		count		30,30

		sprite
		{
			duration	1,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
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
				size { envelope linear }
				tint { envelope fire_smokefade }
				fade { envelope linear }
			}

			end
			{
				size { line 18,18,25,25 }
			}
		}
	}
	emitter "end electricity2"
	{
		duration	0.2,0.2
		count		30,30
		locked

		electricity
		{
			duration	0.05,0.05
			blend	add
			fork	1
			jitterRate	0
			jitterSize	3,7,7
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
				fade { envelope linear_flicker }
			}
		}
	}
	emitter "end sprite2"
	{
		duration	0.2,0.2
		count		10,10
		locked

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { line 2,0,0,2,0,0 useEndOrigin }
				size { line 20,20,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "end sprite oriented"
	{
		duration	0.2,0.2
		count		10,10
		locked

		oriented
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 1,0,0 }
				size { line 20,20,30,30 }
				rotate { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "side_impact_streaks"
	{
		duration	0.2,0.2
		count		40,60
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
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 2,3 }
				length { box 4,0,0,7,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}
