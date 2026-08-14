effect effects/monsters/harvester/claw_metal
{
	size	322

	spawner "flash"
	{
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
				size { point 30,30 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
	spawner "side_streaks"
	{
		count		10,20
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
				velocity { point 10,0,0 }
				size { box 2,5 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 10,0,0 }
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
				length { box 180,0,0,100,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "sparks_trails"
	{
		count		10,25

		sprite
		{
			duration	0.2,0.4
			persist
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.25,0.7
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 150,-150,-150,400,150,150 }
				size { box 5,5,20,20 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 2,2 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	sound "sound2"
	{
		soundShader	"generic_large_metal_break"
		volume	4,4
	}
	spawner "unnamed7"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_chunk"

			start
			{
				velocity { box 300,-300,-300,500,300,300 }
			}
		}
	}
	spawner "unnamed8"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_chunk_sm"

			start
			{
				velocity { box 500,-150,-150,700,150,150 }
				rotate { box -1,-1,-1,1,1,1 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		debris
		{
			duration	1,1
			entityDef	"debris_chunk_sm2"

			start
			{
				velocity { box 500,-150,-150,700,150,150 }
				rotate { box -1,-1,-1,1,1,1 }
			}
		}
	}
}



