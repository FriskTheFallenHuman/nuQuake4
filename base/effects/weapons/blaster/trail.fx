effect effects/weapons/blaster/trail
{
	size	3

	spawner "beam core"
	{
		count		1,1

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/rail_trail3"

			start
			{
				size { point 3 }
				tint { point 0.478431,0.478431,0.478431 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope exp_x2 }
				tint { envelope linear_flicker }
			}
		}
	}
}

