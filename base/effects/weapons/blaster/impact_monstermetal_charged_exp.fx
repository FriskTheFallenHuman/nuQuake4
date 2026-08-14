effect effects/weapons/blaster/impact_monstermetal_charged_exp
{
	size	66

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bulleth02a"

			start
			{
				size { line 1,1,2,2 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		1,3

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 50,-50,-50,100,50,50 }
				size { box 1,1,2,2 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.984314,0.945098,0.823529,0.972549,0.835294,0.788235 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		5,7
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
				size { box 1,2 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 3,0,0 }
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
				length { box 5,0,0,15,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
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
	spawner "smoke_ring"
	{
		count		20,20

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.01,-0.01
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-8,-8,0.1,8,8 surface }
				velocity { box 80,0,0,150,0,0 }
				size { point 6,6 }
				tint { point 0.521569,0.576471,0.627451 }
				fade { point 0.25 }
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
				size { point 12,12 }
				tint { point 0.811765,0.776471,0.721569 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		5,7
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
				velocity { box 20,0,0,100,0,0 }
				size { box 0.5,2.5 }
				tint { point 1,0.894118,0.701961 }
				length { box 5,0,0,10,0,0 }
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
}
