effect effects/wounds/burn
{
	size	6

	spawner "unnamed0"
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
				position { point 0.1,0,0 }
				velocity { point 0.1,0,0 }
				size { line 3,3,3.5,3.5 }
				tint { point 0.501961,0,0 }
				fade { line 0.5,0.7 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 1,1,1.2,1.2 }
			}
		}
	}
	spawner "unnamed1"
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
				position { point 0.1,0,0 }
				velocity { point 0.1,0,0 }
				size { line 2,2,2.5,2.5 }
				tint { point 1,1,0 }
				fade { line 0.5,0.7 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 0.5,0.5,0.7,0.7 }
			}
		}
	}
}


