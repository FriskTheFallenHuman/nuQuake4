effect effects/vehicles/walker/machinegun/impact_default
{
	size	184

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { box 15,15,25,25 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "smoke"
	{
		start		0.1,0.1
		count		2,2

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.05,0.05

			start
			{
				velocity { box 30,-5,-5,120,5,5 }
				acceleration { point -20,0,0 }
				size { line 6,6,10,10 }
				tint { point 0.403922,0.411765,0.384314 }
				fade { point 0.4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 60,60,80,80 }
				tint { point 0.176471,0.176471,0.168627 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		3,3

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box 200,-150,-150,300,150,150 }
				size { box 6,6,10,10 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 3,3 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		3,3

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.25,0.5
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.4,-0.3,-0.3,-0.4,0.3,0.3 surface }
				velocity { box 250,0,0,350,0,0 }
				size { box 2,4 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 16,0,0,22,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 0 }
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
				size { box 4,8 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 60,0,0,80,0,0 }
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
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { box 30,30,40,40 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
}








