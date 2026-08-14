effect effects/weapons/shotgun/muzzleflash
{
	size	15

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.16,0.16
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 4,0,0 }
				velocity { point 1,0,0 }
				size { point 6,6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
	emitter "delayed_smoke"
	{
		detail		0.5
		start		0.2,0.2
		duration	0.4,0.4
		count		20,20

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.5,0.5,1,1 }
				tint { point 0.580392,0.556863,0.521569 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 6,6,9,9 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}




