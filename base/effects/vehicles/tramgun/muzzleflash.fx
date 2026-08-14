effect effects/vehicles/tramgun/muzzleflash
{
	size	137

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { box 10,10,14,14 }
				tint { point 0.705882,0.788235,0.803922 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 6,6,9,9 }
				fade { point 1 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "flash_wide"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 20,4,25,6 }
				tint { point 0.752941,0.752941,0.752941 }
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
				size { box 3,3,4,4 }
				fade { point 0.2 }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				size { point 7 }
				fade { point 0.4 }
				length { box 80,0,0,130,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 3 }
			}
		}
	}
}

