effect effects/weapons/rocketlauncher/muzzleflash
{
	size	42

	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				size { line 8,8,12,12 }
				fade { point 0.7 }
				offset { point 2,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 2,2,3,3 }
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 8,8,12,12 }
				tint { point 0.701961,0.784314,0.803922 }
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
				size { line 2,2,3,3 }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 2.5 }
				length { box 32,0,0,38,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 1.5 }
				length { box 14,0,0,20,0,0 }
			}
		}
	}
}






