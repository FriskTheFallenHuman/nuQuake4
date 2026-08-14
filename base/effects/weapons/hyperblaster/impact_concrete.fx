effect effects/weapons/hyperblaster/impact_concrete
{
	size	144

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
	spawner "dirt"
	{
		start		0.04,0.04
		count		6,8

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.02,0.02

			start
			{
				velocity { box 10,-5,-5,60,5,5 }
				acceleration { point -20,0,0 }
				size { box 0.5,3,1,4 }
				tint { point 0.411765,0.376471,0.313726 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 20,20,30,30 }
			}
		}
	}
	spawner "dirt2"
	{
		detail		0.5
		count		3,3

		line
		{
			duration	0.25,0.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { box 3,5 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.8 }
			}
		}
	}
	spawner "debris"
	{
		detail		0.5
		start		0.1,0.1
		count		1,1

		sprite
		{
			duration	0.35,0.7
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.26,0.26

			start
			{
				velocity { box 100,-20,-20,150,20,20 }
				size { line 10,10,15,15 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 50,50 }
				fade { point 0.6 }
			}
		}
	}
	spawner "chunks"
	{
		detail		0.5
		start		0.04,0.04
		count		3,3

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				velocity { box 80,-40,-40,300,40,40 }
				size { line 0.25,0.25,2,2 }
				tint { line 0.458824,0.411765,0.337255,0.254902,0.254902,0.188235 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
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
				velocity { box 0,-5,-5,20,5,5 }
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
				size { line 12,12,15,15 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}



