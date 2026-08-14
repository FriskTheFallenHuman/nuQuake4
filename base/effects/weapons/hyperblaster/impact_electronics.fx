effect effects/weapons/hyperblaster/impact_electronics
{
	size	81

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
	spawner "heat_mark"
	{
		detail		0.5
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
	emitter "delayed_smoke"
	{
		detail		0.5
		start		0.6,0.6
		duration	1.5,1.5
		count		15,20

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.05,-0.05

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.4,0.4,0.8,0.8 }
				tint { point 0.67451,0.639216,0.556863 }
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
				size { line 7,7,9,9 }
				tint { point 0.356863,0.34902,0.266667 }
				rotate { box 0.111111,0.222222 relative }
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
	spawner "single_line"
	{
		detail		0.5
		count		1,1

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				size { box 4,7 }
				length { box 20,0,0,30,0,0 }
			}

			motion
			{
				length { envelope "linear" }
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
				position { line 0,0,0,5,0,0 }
				velocity { box 0,-5,-5,12,5,5 }
				size { line 3,3,5,5 }
				tint { line 0.45098,0.8,0.572549,0.713726,0.803922,0.905882 }
				fade { point 0.35 }
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
				size { line 7,7,9,9 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "sparks_trails"
	{
		detail		0.5
		count		6,9

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.15,0.15
			trailType	motion
			trailTime	0.08,0.08
			trailCount	2,2

			start
			{
				velocity { box 20,-25,-25,150,25,25 }
				size { box 0.5,0.5,1.5,1.5 }
				tint { point 0.941177,0.921569,0.819608 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" count 2,2,2 }
				fade { envelope "linear_flicker" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { point 0.882353,0.956863,0.992157 }
			}
		}
	}
	spawner "electricity"
	{
		start		0.2,0.2
		count		5,5

		electricity
		{
			duration	0.15,0.75
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electricity"
			generatedNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 }
				size { box 0.3,0.8 }
				length { box 2,0,0,8,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
}



