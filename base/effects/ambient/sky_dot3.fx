effect effects/ambient/sky_dot3
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
				size { point 4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	delay "unnamed1"
	{
		duration	3,6
	}
}

