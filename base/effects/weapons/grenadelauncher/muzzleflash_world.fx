effect effects/weapons/grenadelauncher/muzzleflash_world
{
	size	29

	emitter "delayed_smoke"
	{
		start		0.2,0.2
		duration	0.4,0.4
		count		30,30

		sprite
		{
			duration	0.6,0.6
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.5,0.5,1,1 }
				tint { point 0.541176,0.521569,0.47451 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 3,3,8,8 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.16,0.16
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				velocity { point 1,0,0 }
				size { point 10,10 }
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
				size { point 1.5,1.5 }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				length { box 20,0,0,25,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 0.5 }
				length { box 6,0,0,10,0,0 }
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
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.1,0.2

			start
			{
				velocity { box 20,-30,-30,80,30,30 }
				size { line 0.25,0.25,3,3 }
				tint { line 1,1,1,1,0.529412,0.32549 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear_flicker }
			}
		}
	}
}
