effect effects/monsters/fatty/shieldhit
{
	size	191

	spawner "unnamed4"
	{
		count		3,8

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"

			start
			{
				position { sphere 0,-10,-10,0,10,10 }
				size { line 10,10,15,15 }
				tint { line 1,1,1,1,0.831373,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 60,60,70,70 }
			}
		}
	}
	spawner "sparks2"
	{
		count		10,12

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/weapons/flash_hot"
			gravity		0.1,0.2

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,-20,-20,100,20,20 }
				size { point 0.5,0.5 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	spawner "unnamed5"
	{
		count		1,1
		locked

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/flash_hot"

			start
			{
				size { line 1,1,5,5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,25,25 }
			}
		}
	}
}
