effect effects/ambient/single_drip_no_splash
{
	size	475

	emitter "snot_line"
	{
		start		0,0.5
		duration	25,25
		count		4,4

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/drop_green"

			start
			{
				size { point 0.25 }
				length { box 0,0,0,35,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				length { envelope "linear" }
			}

			end
			{
				size { box 3,4 }
				length { point 100,0,0 }
			}
		}
	}
	emitter "drops"
	{
		duration	25,25
		count		1,1

		line
		{
			duration	2,3
			material	"gfx/effects/fluids_drips/drop_green"
			gravity		0.01,0.2

			start
			{
				size { point 5 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				length { envelope "linear" }
			}

			end
			{
				size { point 7 }
			}
		}
	}
}



