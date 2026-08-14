effect effects/weapons/shotgun/muzzleflash_world
{
	size	28

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.09,0.09
			blend	add
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				size { point 15,15 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "single_streak"
	{
		count		3,3
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				size { point 2 }
				length { box 20,0,0,26,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 4,0,0,10,0,0 }
			}
		}
	}
	emitter "delayed_smoke"
	{
		detail		0.5
		start		0.2,0.2
		duration	0.4,0.4
		count		20,20

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.5,0.5,1,1 }
				tint { point 0.580392,0.556863,0.521569 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 6,6,9,9 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


