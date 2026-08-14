effect effects/vehicles/flatbed/shellsmoke
{
	size	6

	emitter "shellsmoke2"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 4,4 }
				tint { point 0.603922,0.584314,0.505882 }
				fade { point 0.3 }
			}

			motion
			{
				size { envelope "lightningflicker" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
}
