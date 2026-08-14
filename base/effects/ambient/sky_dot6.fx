effect effects/ambient/sky_dot6
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
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	delay "unnamed1"
	{
		duration	4,6
	}
}

