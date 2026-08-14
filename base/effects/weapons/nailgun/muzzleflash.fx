effect effects/weapons/nailgun/muzzleflash
{
	size	30

	spawner "flash"
	{
		count		2,3
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 2,0,0 }
				size { point 4.5,4.5 }
				fade { point 0.6 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
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
				size { box 1,3 }
				length { box 20,0,0,26,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0.5 }
				length { box 10,0,0,16,0,0 }
			}
		}
	}
	spawner "line_gritty"
	{
		detail		0.5
		count		1,1
		locked

		line
		{
			duration	0.08,0.08
			blend	add
			material	"gfx/effects/fire/embers"

			start
			{
				position { point 1,0,0 }
				velocity { box 50,0,0,150,0,0 }
				size { box 0.5,1 }
				length { box 15,0,0,18,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
}




