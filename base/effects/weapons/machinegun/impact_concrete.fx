effect effects/weapons/machinegun/impact_concrete
{
	size	1541

	sound "sound"
	{
		soundShader	"effects_bulletimpact_concrete"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { box 4,4,6,6 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "dirt"
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
				size { box 4,6 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 45,0,0,70,0,0 }
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
			gravity		0.3,0.3

			start
			{
				velocity { box 100,-30,-30,150,30,30 }
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
				size { point 75,75 }
				fade { point 0.6 }
			}
		}
	}
	spawner "smoke"
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
				position { line 0,0,0,20,0,0 }
				velocity { box 0,-5,-5,50,5,5 }
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
	spawner "chunks"
	{
		detail		0.75
		start		0.04,0.04
		count		7,12

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				velocity { box 200,-80,-80,300,80,80 }
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
	spawner "chunks_physics"
	{
		detail		0.75
		start		0.04,0.04
		count		1,1

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				position { point 1,0,0 }
				velocity { box 200,-80,-80,300,80,80 }
				size { line 0.5,0.5,2,2 }
				tint { line 0.458824,0.411765,0.337255,0.235294,0.254902,0.172549 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	spawner "single_streak"
	{
		detail		0.5
		count		1,1

		line
		{
			duration	0.06,0.06
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point 2,0,0 }
				velocity { point 1,0,0 }
				size { point 5 }
				length { box 10,0,0,14,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 4,0,0,6,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 2,4 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 10,0,0,20,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		3,3

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 8,8 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
	}
	spawner "sparks_trails"
	{
		detail		0.5
		count		4,6

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.06,0.06
			trailCount	3,3

			start
			{
				velocity { box 50,-150,-150,300,150,150 }
				size { box 1,1,2,2 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
}








