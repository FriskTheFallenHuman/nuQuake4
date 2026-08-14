effect effects/levels/hub/fog_clouds
{
	size	1188

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
				position { cylinder 0,-400,-400,0,400,400 }
				size { line 400,400,600,600 }
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
