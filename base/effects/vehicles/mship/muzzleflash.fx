effect effects/vehicles/mship/muzzleflash
{
	size	495

	spawner "flash_close"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				tint { point 0,0,0 }
				rotate { box 1,2 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope fastinslowout }
				rotate { envelope random }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.752941,0.752941,0.752941 }
			}
		}
	}
	spawner "streaks_straight"
	{
		count		1,1
		locked

		line
		{
			duration	0.18,0.18
			blend	add
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -5,0,0 }
				size { box 50,80 }
				fade { point 0.8 }
				length { box 350,0,0,400,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 250,250,350,350 }
				fade { point 0.9 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 150,150,250,250 }
			}
		}
	}
}

