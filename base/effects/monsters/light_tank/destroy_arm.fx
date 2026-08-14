effect effects/monsters/light_tank/destroy_arm
{
	size	257

	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 50,50 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	spawner "smoke"
	{
		start		0.1,0.1
		count		3,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha_depth"
			gravity		-0.005,-0.005

			start
			{
				position { point 30,0,0 }
				velocity { box 0,0,0,50,0,0 }
				size { line 100,100,140,140 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,120,120 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "chunks"
	{
		detail		0.5
		count		3,5

		model
		{
			duration	0.5,0.5
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.75,0.75
			generatedOriginNormal
			trailType	chunks_trail

			start
			{
				position { sphere 0.1,-0.2,-0.2,0.1,0.2,0.2 }
				velocity { box 200,0,0,400,0,0 }
				size { point 1.4,1.4,1.4 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	trail "chunks_trail"
	{
		detail		0.5
		count		30,30

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/impact_smoke3"

			start
			{
				size { point 5,5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.7
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box 30,-60,-60,100,60,60 }
				size { line 60,60,90,90 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 90,90,120,120 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 30,30,40,40 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		9,12
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 200,0,0,400,0,0 }
				size { box 2,10 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 10,0,0,60,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		count		5,7

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				velocity { box 100,-150,-150,500,150,150 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				acceleration { point -500,0,0 }
				size { line 2,2,6,6 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				fade { point 0.4 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
}




