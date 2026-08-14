effect effects/weapons/grenadelauncher/trail_mp
{
	size	78

	emitter "trail4"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 18,18,23,23 }
				tint { line 0.678431,0.654902,0.603922,0.533333,0.533333,0.482353 }
				fade { point 0.35 }
				offset { point -5,0,0 }
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
				size { line 45,45,50,50 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}

