effect effects/levels/hub/fog_clouds_small
{
	size	908

	emitter "steam1"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	5,6
			blend	add
			material	"gfx/effects/smoke/cloud_add"
			gravity		-0.01,-0.01

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				size { line 300,300,500,500 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.8 }
				rotate { box -0.208333,0.208333 relative }
			}
		}
	}
}
