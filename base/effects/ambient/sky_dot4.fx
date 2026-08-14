effect effects/ambient/sky_dot4
{
	size	8

	emitter "flash"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 2,2 }
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
	delay "unnamed1"
	{
		duration	4,6
	}
}


