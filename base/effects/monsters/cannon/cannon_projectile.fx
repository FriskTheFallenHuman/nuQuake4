effect effects/monsters/cannon/cannon_projectile
{
	size	78

	emitter "trail2"
	{
		duration	1,1
		count		40,40

		line
		{
			duration	0.35,0.35
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { point 10,0,0 }
				acceleration { box 0,-8,0,0,-25,0 }
				size { point 2 }
				tint { line 0.317647,0.356863,0.368627,0.352941,0.384314,0.427451 }
				fade { line 0.6,1 }
				length { point 70,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 3 }
			}
		}
	}
}









