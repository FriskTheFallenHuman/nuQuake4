effect effects/monsters/harvester/rocket_explosion
{
	size	1610

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 250,0 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_explosion_metal"
		volume	5,5
		freqshift	0.8,0.8
	}
	sound "sound2"
	{
		soundShader	"effects_explosion_fiery"
		volume	5,5
	}
	spawner "smoke"
	{
		count		8,8

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,-50,-50,250,50,50 }
				friction { point 20,0,0 }
				size { line 120,120,150,150 }
				tint { line 0.486275,0.486275,0.486275,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 600,600,800,800 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire up"
	{
		count		9,9

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/fire/fire4a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,50,50,50 }
				velocity { box 50,-150,-150,350,150,150 }
				size { point 150,150 }
				tint { line 0.901961,0.858824,0.709804,0.709804,0.513726,0.290196 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 400,400,450,450 }
				fade { point 1 }
				rotate { box -0.416667,0.416667 relative }
			}
		}
	}
	spawner "ring"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.25098 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 1000,1000 }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		9,9
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
				velocity { point 1,0,0 }
				size { box 20,25 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
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
				length { box 320,0,0,340,0,0 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 440,440,460,460 }
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
				size { point 40,40 }
			}
		}
	}
}


