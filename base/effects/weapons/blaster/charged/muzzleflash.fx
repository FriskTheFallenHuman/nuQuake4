effect effects/weapons/blaster/charged/muzzleflash
{
	size	32

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 0.5,0,0 }
				size { point 5,5 }
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
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash_half_blue3"

			start
			{
				size { point 2 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0.25 }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		count		5,8
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.05,-0.05

			start
			{
				velocity { box 50,-20,-20,100,20,20 }
				size { point 3,3 }
				tint { point 0.658824,0.584314,0.356863 }
				fade { point 0.2 }
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
				size { point 6,6 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
}




