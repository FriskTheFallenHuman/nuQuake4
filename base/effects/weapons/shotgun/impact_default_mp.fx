effect effects/weapons/shotgun/impact_default_mp
{
	size	166

	sound "sound"
	{
		soundShader	"bullet_impact_metal_shotgun"
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
	spawner "smoke"
	{
		detail		0.5
		start		0.1,0.1
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 3,0,0,5,0,0 }
				size { line 3,3,4,4 }
				tint { line 0.403922,0.411765,0.384314,0.443137,0.439216,0.356863 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 12,12,15,15 }
				tint { line 0.176471,0.176471,0.164706,0.180392,0.184314,0.156863 }
				fade { point 0.75 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		3,3

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.6,0.8
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 50,-150,-150,300,150,150 }
				size { box 2,2,3,3 }
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
	spawner "sparks_lines"
	{
		detail		0.5
		count		3,3

		line
		{
			duration	0.5,0.75
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.25,0.5
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.4,-0.3,-0.3,-0.4,0.3,0.3 surface }
				velocity { box 50,0,0,200,0,0 }
				size { box 2,3 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 4,0,0,6,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		5,7
		locked

		line
		{
			duration	0.6,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2_flipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 2,4 }
				tint { line 1,0.65098,0.501961,0.74902,0.521569,0.203922 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.921569,0.654902,0.388235,0.956863,0.639216,0.529412 }
				length { box 10,0,0,15,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 16,16 }
				tint { point 1,0.792157,0.666667 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 12,12 }
			}
		}
	}
}



