effect effects/vehicles/gev/machinegun/muzzleflash
{
	size	48

	emitter "smoke"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.1,-0.1

			start
			{
				position { line 0,0,0,-15,0,0 }
				velocity { box 0,0,-10,0,0,0 }
				size { point 6,6 }
				tint { line 0.356863,0.360784,0.329412,0.368627,0.352941,0.32549 }
				fade { point 0 }
				rotate { box -0.416667,0.416667 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 12,12 }
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
				size { box 10,10,12,12 }
				tint { point 0.705882,0.788235,0.803922 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
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
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 10,10,12,12 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0 }
				rotate { box -0.138889,0.138889 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
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
				position { point -3,0,0 }
				size { box 4,5 }
				length { box 20,0,0,30,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 2,3 }
			}
		}
	}
	spawner "heat_mark"
	{
		count		1,1
		locked

		oriented
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { line 8,-0.4,-0.4,8,0.4,0.4 }
				velocity { point -60,0,0 }
				size { line 4,4,6,6 }
				tint { line 0.776471,1,1,0.639216,0.847059,0.862745 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 15,15,25,25 }
				fade { point 0.2 }
			}
		}
	}
}





