effect effects/weapons/railgun/impact_concrete
{
	size	1584

	sound "sound"
	{
		soundShader	"weapon_railgun_impact"
	}
	decal "wall mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_decal"

			start
			{
				size { point 6,6 }
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
				size { box 6,8 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 70,0,0,90,0,0 }
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
	spawner "side_impact_streaks"
	{
		count		7,9
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
				size { box 3,5 }
				length { box 12,0,0,18,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		3,5
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
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 50,0,0,300,0,0 }
				size { box 1,3 }
				tint { point 0.658824,0.921569,0.627451 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { point 0.247059,0.627451,0.294118 }
			}
		}
	}
	emitter "heat_mark"
	{
		detail		0.5
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 0.1,0,0 }
				tint { line 0.501961,1,0.501961,0.74902,1,0.858824 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "smoke"
	{
		start		0.04,0.04
		count		9,9

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,30,0,0 }
				velocity { box 0,-5,-5,100,5,5 }
				size { box 5,7,6,9 }
				tint { point 0.411765,0.376471,0.313726 }
				fade { point 0.8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 60,60,80,80 }
			}
		}
	}
	spawner "dirt_streaks"
	{
		detail		0.5
		count		4,6
		locked

		line
		{
			duration	0.15,0.25
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 12,15 }
				tint { point 0.427451,0.352941,0.239216 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 60,0,0,80,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "chunks"
	{
		detail		0.5
		start		0.04,0.04
		count		7,12

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				velocity { box 80,-80,-80,400,80,80 }
				size { line 1,1,5,5 }
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
		detail		0.5
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
				velocity { box 80,-80,-80,400,80,80 }
				size { line 1,1,5,5 }
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
}




