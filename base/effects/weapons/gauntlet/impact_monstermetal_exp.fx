effect effects/weapons/gauntlet/impact_monstermetal_exp
{
	size	76

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	emitter "flash"
	{
		duration	0.25,0.25
		count		6,6

		sprite
		{
			duration	0.1,0.1
			blend	add
			persist
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 6,6 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	0.25,0.25
		count		5,7
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 0.5,1 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 1,0,0 }
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
				length { box 4,0,0,8,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "sparks_trails"
	{
		duration	0.25,0.25
		count		3,5

		sprite
		{
			duration	0.2,0.4
			persist
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
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
