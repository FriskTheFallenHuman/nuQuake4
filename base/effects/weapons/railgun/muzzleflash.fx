effect effects/weapons/railgun/muzzleflash
{
	size	54

	spawner "side_streaks"
	{
		count		3,5
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/rail_flash"

			start
			{
				position { cylinder 0,-1.5,-1.5,0,1.5,1.5 surface }
				size { point 2 }
				tint { point 0.713726,0.713726,0.713726 }
				length { box 40,0,0,50,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.08,0.08
			material	"gfx/effects/weapons/flash_green"

			start
			{
				size { point 6,6 }
				offset { point 4,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	spawner "single_streak"
	{
		detail		0.5
		count		1,1
		locked

		line
		{
			duration	0.08,0.08
			blend	add
			material	"gfx/effects/weapons/rail_flash"

			start
			{
				position { point -2,0,0 }
				size { point 2.5 }
				length { box 30,0,0,40,0,0 }
			}
		}
	}
}





