effect effects/weapons/hyperblaster/impact_default_mp
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
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				position { point 2,0,0 }
				size { point 15,15 }
				tint { point 0.65098,1,1 }
			}

			motion
			{
				fade { envelope "exp_x2" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 3 }
				tint { point 0.792157,1,1 }
				length { box 16,0,0,20,0,0 }
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
		count		10,10

		sprite
		{
			duration	0.5,0.6
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 0,-8,-8,20,8,8 }
				size { line 6,6,8,8 }
				tint { line 0.447059,0.8,0.568627,0.486275,0.654902,0.905882 }
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
				size { line 18,18,24,24 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "single_line"
	{
		detail		0.5
		count		1,1

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				size { box 4,7 }
				tint { point 0.717647,1,1 }
				length { box 20,0,0,30,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { point 15,0,0 }
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
}


