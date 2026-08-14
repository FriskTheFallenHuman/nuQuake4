effect effects/monsters/strogg_flyer/muzzleflash_blast
{
	size	260

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
				size { point 100,100 }
				offset { point 10,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
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
				size { point 10 }
				length { box 150,0,0,250,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}
		}
	}
}
