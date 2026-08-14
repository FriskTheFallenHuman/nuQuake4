effect effects/levels/core/ver_arm_scan
{
	size	78

	emitter "zappy"
	{
		duration	1,1
		count		1,1
		locked

		electricity
		{
			duration	3.25,3.25
			fork	0
			jitterRate	0
			jitterSize	10,1,1
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				size { point 2 }
				tint { line 1,1,1,0.831373,0.831373,1 }
				length { line 50,0,0,50,0,0 useEndOrigin }
			}
		}
	}
	emitter "secondary"
	{
		duration	1,1
		count		10,10
		locked

		electricity
		{
			duration	2,2
			fork	0
			jitterRate	0
			jitterSize	1,3,3
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { cylinder 1,-1,-1,1,1,1 cone }
				tint { line 1,1,1,0.501961,0.501961,1 }
				length { point 10,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "hot tip"
	{
		count		3,3
		locked

		sprite
		{
			duration	4,4
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				tint { point 0.831373,0.831373,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	spawner "sparks_lines"
	{
		start		3,3.25
		count		8,10

		line
		{
			duration	0.3,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.15,0.25
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 100,0,0,200,0,0 }
				acceleration { point -100,0,0 }
				size { box 0.45,0.75 }
				tint { line 0.501961,0.501961,1,0.501961,0,1 }
				length { box 3,0,0,8,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.368627,0.368627,1,1,1,1 }
			}
		}
	}
	spawner "sparks2"
	{
		start		3,3.25
		count		2,7

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.1,0.2

			start
			{
				velocity { box 20,-20,-20,80,20,20 }
				size { line 1,1,2,2 }
				tint { line 0.831373,0.831373,1,0.501961,0.501961,1 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	sound "unnamed5"
	{
		start		3,3
		soundShader	"effects_weld"
	}
	sound "unnamed6"
	{
		start		2,2
		soundShader	"effects_sparks03"
	}
	sound "unnamed7"
	{
		soundShader	"effects_weld_loop"
	}
}




