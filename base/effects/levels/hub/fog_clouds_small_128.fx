effect effects/levels/hub/fog_clouds_small_128
{
	size	559

	emitter "steam1"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	7,8
			blend	add
			material	"gfx/effects/smoke/cloud_add"
			gravity		-0.01,-0.01

			start
			{
				position { cylinder 0,-128,-128,0,128,128 }
				size { line 150,150,250,250 }
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
				fade { point 0.8 }
				rotate { box -0.208333,0.208333 relative }
			}
		}
	}
}
