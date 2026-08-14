effect effects/weapons/hyperblaster/muzzleflash
{
	size	22

	spawner "flash"
	{
		detail		0.5
		count		1,1
		locked

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 0.5,0,0 }
				size { point 4,4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
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
				size { point 0.75 }
				length { box 7,0,0,9,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5 }
			}
		}
	}
	emitter "heat_mark"
	{
		detail		0.5
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
				size { line 1,1,2,2 }
				tint { line 0.776471,1,1,0.639216,0.847059,0.862745 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 6,6,8,8 }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
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
				size { line 0.5,0.5,1,1 }
				fade { point 0.25 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear_flicker" }
			}
		}
	}
	spawner "fwd_sprite2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.05,0.05
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { line -2,0,0,-2,0,0 useEndOrigin }
				velocity { box 100,0,0,200,0,0 }
				size { line 3,3,4,4 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				fade { point 0.4 }
			}
		}
	}
	spawner "flash_wide2"
	{
		detail		0.5
		count		2,2
		locked

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 12,3,14,4 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0 }
				rotate { box -0.0555556,0.0555556 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { box 2,2,3,3 }
				fade { point 0.5 }
			}
		}
	}
}





