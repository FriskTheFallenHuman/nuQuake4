effect effects/weapons/blaster/charged/impact_default
{
	size	181

	sound "sound"
	{
		soundShader	"effects_blaster_hit01"
	}
	decal "wall_mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/blaster_wall_mark3"

			start
			{
				size { point 25,25 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash"
	{
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			generatedNormal

			start
			{
				position { point 2,0,0 }
				size { point 40,40 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		4,6
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_impact3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 8 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		7,9
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 50,0,0,300,0,0 }
				size { box 0.5,2.5 }
				tint { point 0.956863,0.882353,0.741176 }
				length { box 15,0,0,25,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { point 0.776471,0.921569,1 }
			}
		}
	}
	spawner "smoke_ring"
	{
		detail		0.5
		count		30,30

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.01,-0.01
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-8,-8,0.1,8,8 surface }
				velocity { box 150,0,0,300,0,0 }
				size { point 6,6 }
				tint { point 0.505882,0.580392,0.654902 }
				fade { point 0.3 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 50,50 }
				tint { point 0.811765,0.776471,0.721569 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	emitter "sparks_stay"
	{
		duration	0.5,0.5
		count		15,25

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		0.1,0.2

			start
			{
				velocity { box 20,-10,-10,100,10,10 }
				size { line 4,4,6,6 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear_flicker" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { point 0.870588,0.8,0.588235 }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		start		0.06,0.06
		count		7,9

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		0.05,0.05

			start
			{
				velocity { box 50,-5,-5,100,5,5 }
				acceleration { box -50,0,0,-100,0,0 }
				size { line 10,10,20,20 }
				tint { point 0.768628,0.941177,1 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 3,3,6,6 }
				tint { point 0.4,1,0.909804 }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		count		10,12

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		0.1,0.2

			start
			{
				velocity { box 0,-20,-20,150,20,20 }
				size { line 1,1,2,2 }
				tint { line 1,1,1,1,0.909804,0.690196 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
}



