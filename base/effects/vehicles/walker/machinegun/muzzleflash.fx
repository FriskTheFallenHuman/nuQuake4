effect effects/vehicles/walker/machinegun/muzzleflash
{
	size	186

	spawner "smoke"
	{
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.4,-0.4

			start
			{
				position { point 0,-20,0 }
				velocity { box 50,-20,-20,100,20,20 }
				size { point 15,15 }
				tint { line 0.52549,0.533333,0.482353,0.537255,0.517647,0.478431 }
				fade { point 0 }
				rotate { box -0.416667,0.416667 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 60,60 }
				fade { point 0.25 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { box 20,20,24,24 }
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
				size { box 30,10,35,12 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box -0.138889,0.138889 }
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
	spawner "single_streak2"
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
				length { box 40,0,0,60,0,0 }
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
	spawner "heat_mark"
	{
		count		1,1
		locked

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { point 0.1,0,0 }
				velocity { box -150,0,0,-250,0,0 }
				size { line 30,30,50,50 }
				tint { line 0.776471,1,1,0.639216,0.847059,0.862745 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { box 40,40,60,60 }
				fade { point 0.15 }
			}
		}
	}
}







