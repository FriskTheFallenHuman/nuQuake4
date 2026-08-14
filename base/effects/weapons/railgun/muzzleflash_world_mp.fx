effect effects/weapons/railgun/muzzleflash_world_mp
{
	size	66

	spawner "side_streaks"
	{
		count		3,5
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/rail_flash_mp"

			start
			{
				position { cylinder 0,-1.5,-1.5,0,1.5,1.5 surface }
				size { point 4 }
				tint { point 0.717647,0.717647,0.717647 }
				offset { point -10,0,0 }
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
				size { point 4 }
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
			material	"gfx/effects/weapons/flash_white"

			start
			{
				size { point 12,12 }
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
		count		1,1
		locked

		line
		{
			duration	0.08,0.08
			blend	add
			material	"gfx/effects/weapons/rail_flash_mp"

			start
			{
				position { point -2,0,0 }
				size { point 2.5 }
				offset { point -5,0,0 }
				length { box 30,0,0,40,0,0 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		locked

		oriented
		{
			duration	0.08,0.08
			material	"gfx/effects/weapons/flash_white"

			start
			{
				position { point 1,0,0 }
				size { point 20,20 }
			}

			motion
			{
				size { envelope "linear" }
			}
		}
	}
}
