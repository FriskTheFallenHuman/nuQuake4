effect effects/weapons/hyperblaster/muzzleflash_world
{
	size	39

	spawner "flash"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 20,20 }
				offset { point 1,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0.25,0.25 }
			}
		}
	}
	spawner "single_streak"
	{
		count		2,2
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				size { point 2 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 0.5 }
			}
		}
	}
	emitter "heat_mark"
	{
		duration	1,1
		count		1,1
		locked

		oriented
		{
			duration	0.15,0.15
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { point 0.1,0,0 }
				velocity { box -50,0,0,-150,0,0 }
				size { line 5,5,10,10 }
				tint { line 0.776471,1,1,0.639216,0.847059,0.862745 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 15,15,20,20 }
			}
		}
	}
	spawner "sparks"
	{
		count		10,12
		locked

		sprite
		{
			duration	0.15,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		0.1,0.2

			start
			{
				velocity { box 20,-30,-30,80,30,30 }
				size { line 0.5,0.5,4,4 }
				fade { point 0.2 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear_flicker }
			}
		}
	}
}

