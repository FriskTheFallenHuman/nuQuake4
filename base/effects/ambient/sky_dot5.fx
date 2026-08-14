effect effects/ambient/sky_dot5
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
				size { point 1.5,1.5 }
				tint { point 0.501961,1,1 }
				offset { point 0,1,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	delay "unnamed2"
	{
		start		5,5
		duration	6,6
	}
}
