effect effects/materials/armor
{
	size	93

	sound "sound"
	{
		soundShader	"player_sounds_hitarmor"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bulleth02a"

			start
			{
				size { line 0.5,0.5,2,2 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				fade { point 0.6 }
				offset { point 0.5,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	spawner "streaks_flat"
	{
		count		5,5
		locked

		line
		{
			duration	0.05,0.05
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { line -0.01,-0.02,-0.02,-0.01,-0.02,0.02 cone }
				size { box 0.5,1 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 0,-2,-2,0,2,2 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 0,-5,-5,0,5,5 }
			}
		}
	}
	spawner "dust"
	{
		start		0.12,0.12
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 5,0,0 }
				velocity { box 10,-20,-20,20,20,20 }
				friction { box -200,0,0,-300,0,0 }
				size { point 10,10 }
				fade { point 0.5 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		2,2

		line
		{
			duration	0.25,0.25
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.25,0.5
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.4,-0.3,-0.3,-0.4,0.3,0.3 surface }
				velocity { box 25,0,0,75,0,0 }
				size { point 0.5 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				length { box 1,0,0,3,0,0 }
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
}



