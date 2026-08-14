effect effects/weapons/lightninggun/impact
{
	size	57

	emitter "smoke"
	{
		detail		0.5
		duration	1,1
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
				tint { line 0.694118,0.776471,0.803922,0.682353,0.745098,0.823529 }
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
				size { line 23,23,30,30 }
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
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,0.35,0.35,-0.1,-0.35,-0.35 }
				size { box 7,8 }
				offset { box 5,-5,-5,5,5,5 }
				length { box 10,0,0,40,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	emitter "end sprite oriented"
	{
		detail		0.5
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
				size { line 20,20,30,30 }
				tint { point 0.54902,0.776471,1 }
				rotate { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "side_impact_streaks2"
	{
		detail		0.5
		duration	1,1
		count		50,50
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 5,6 }
				tint { point 0.54902,0.776471,1 }
				length { box 16,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}

















