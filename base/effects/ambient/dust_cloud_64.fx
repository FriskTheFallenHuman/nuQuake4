effect effects/ambient/dust_cloud_64
{
	size	357

	emitter "steam1"
	{
		duration	10,10
		count		0.2,0.2

		sprite
		{
			duration	10,10
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0,-64,-64,0,64,64 }
				size { line 180,180,220,220 }
				tint { point 0.690196,0.505882,0.415686 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.5 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
}

