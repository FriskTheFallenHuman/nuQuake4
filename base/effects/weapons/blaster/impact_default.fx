effect effects/weapons/blaster/impact_default
{
	size	71

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
				size { point 12,12 }
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
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				position { point 2,0,0 }
				size { point 10,10 }
			}

			motion
			{
				fade { envelope "exp_x2" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		7,9
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
				size { point 3 }
				length { box 12,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		duration	0.2,0.2
		count		35,35

		sprite
		{
			duration	0.8,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 0,-4,-4,20,4,4 }
				size { line 3,3,5,5 }
				tint { line 0.45098,0.8,0.572549,0.713726,0.803922,0.905882 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 10,10,14,14 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		5,7
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.3,-0.1,-0.1,-0.3,0.1,0.1 surface }
				velocity { box 20,0,0,300,0,0 }
				size { box 0.5,2.5 }
				tint { point 1,0.894118,0.701961 }
				length { box 8,0,0,12,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { point 0.807843,0.878431,1 }
			}
		}
	}
	spawner "heat_mark"
	{
		detail		0.75
		count		2,2

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 0.1,0,0 }
				tint { point 0.941177,0.435294,0.0588235 }
				rotate { box 0,0,0,0,0,1 }
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
				tint { point 1,1,1 }
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
}




