effect effects/ambient/hydrolic_drip
{
	size	519

	emitter "drip_left"
	{
		start		0,0.5
		duration	3,3
		count		1,3

		line
		{
			duration	2,4
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.01,0.12

			start
			{
				position { line 0,0,0,0,0,-30 }
				size { box 5,12 }
				fade { point 0 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "popoverextreme_hold_fade" }
			}

			end
			{
				fade { point 1 }
				length { box 0,0,0,25,0,0 }
			}
		}
	}
	emitter "drip_right"
	{
		start		0,0.5
		duration	3,3
		count		1,3

		line
		{
			duration	2,4
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.01,0.12

			start
			{
				position { line 0,0,-50,0,0,-30 }
				size { box 5,12 }
				fade { point 0 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "popoverextreme_hold_fade" }
			}

			end
			{
				fade { point 1 }
				length { box 0,0,0,25,0,0 }
			}
		}
	}
}


