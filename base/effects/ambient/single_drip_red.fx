effect effects/ambient/single_drip_red
{
	size	765

	emitter "dropss_physics"
	{
		duration	1,1
		count		1,2

		line
		{
			duration	2,3
			material	"gfx/effects/fluids_drips/drop_red2"
			gravity		0.2,0.4

			start
			{
				size { point 3 }
				fade { point 0.5 }
				length { point 25,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 5 }
				length { point 10,0,0 }
			}
		}
	}
	emitter "snot_line2"
	{
		start		0,0.5
		duration	1,1
		count		2,2

		line
		{
			duration	0.35,2
			material	"gfx/effects/fluids_drips/drop_red2"

			start
			{
				position { cylinder -1,-1,0,1,1,0 }
				size { point 2 }
				fade { point 0.5 }
				length { box 10,0,0,25,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 2,3 }
				length { box 50,0,0,100,0,0 }
			}
		}
	}
}




