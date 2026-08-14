effect effects/test/mvainio/ceilingsmoke2
{
	size	255

	emitter "oriented fog"
	{
		duration	30,30
		count		2,2

		oriented
		{
			duration	4,6
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.003,0.003

			start
			{
				position { cylinder 0,-80,-80,0,80,80 }
				size { line 120,120,140,140 }
				tint { line 0.501961,0.501961,0.501961,0.552941,0.521569,0.447059 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
}
