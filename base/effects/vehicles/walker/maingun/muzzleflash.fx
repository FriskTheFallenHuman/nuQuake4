effect effects/vehicles/walker/maingun/muzzleflash
{
	size	115

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
				size { box 40,40,50,50 }
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
				size { box 8,12 }
				fade { point 0.8 }
				length { box 65,0,0,100,0,0 }
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
				size { line 35,35,45,45 }
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
				size { line 15,15,25,25 }
			}
		}
	}
	spawner "smoke"
	{
		count		4,7
		locked

		sprite
		{
			duration	0.24,0.24
			material	"gfx/effects/smoke/impact_smoke"

			start
			{
				velocity { box 20,-40,-40,50,40,40 }
				size { box 5,5,7,7 }
				tint { point 0.603922,0.576471,0.411765 }
				fade { point 0.8 }
				rotate { box -0.416667,0.416667 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,70,70 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
}


