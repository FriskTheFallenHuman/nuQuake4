effect effects/weapons/machinegun/muzzleflash
{
	size	32

	spawner "smoke"
	{
		detail		0.5
		count		3,3
		locked

		sprite
		{
			duration	0.24,0.24
			material	"gfx/effects/smoke/impact_smoke"

			start
			{
				velocity { box 10,-20,-20,20,20,20 }
				size { point 1.5,1.5 }
				tint { point 0.603922,0.576471,0.411765 }
				rotate { box -0.416667,0.416667 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 8,8 }
				rotate { box -0.555556,0.555556 relative }
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
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 2.5 }
				length { box 22,0,0,28,0,0 }
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
				size { box 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
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
				size { box 2,2,3,3 }
			}
		}
	}
	spawner "flash2"
	{
		detail		0.5
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 4,4 }
				tint { point 0.752941,0.752941,0.752941 }
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
				size { point 2.5,2.5 }
			}
		}
	}
}




