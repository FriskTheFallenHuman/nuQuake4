effect effects/wounds/energy
{
	size	13

	spawner "blue glow"
	{
		count		1,1
		locked

		oriented
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 0.2,0,0 }
				velocity { point 0.1,0,0 }
				size { box 8.1,8,9,9 }
				tint { point 1,0.501961,0 }
			}

			motion
			{
				fade { envelope linear }
			}

			end
			{
				fade { point 0.01 }
			}
		}
	}
	spawner "core"
	{
		count		1,1
		locked

		oriented
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 0.2,0,0 }
				velocity { point 0.1,0,0 }
				size { box 5,5,6,6 }
				fade { point 0.5 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}


