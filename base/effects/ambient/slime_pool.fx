effect effects/ambient/slime_pool
{
	size	46

	emitter "slime_pool"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	5,10
			material	"gfx/effects/fluids_drips/slime_pool"

			start
			{
				position { point 0.05,0,0 }
				size { box 30,30,28,28 }
				tint { line 0.501961,0.501961,0,0.784314,0.733333,0.643137 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 35,35,32,32 }
				fade { line 0.25,0.12 }
			}
		}
	}
}


