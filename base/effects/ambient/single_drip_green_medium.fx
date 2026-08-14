effect effects/ambient/single_drip_green_medium
{
	size	294

	emitter "snot_line2"
	{
		start		0,0.5
		duration	25,25
		count		1.5,1.5

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/drop_green"

			start
			{
				position { line 0,1,1,0,-1,-1 }
				size { point 3 }
				length { box 12,0,0,8,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 5,8 }
				length { box 55,0,0,85,0,0 }
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
			gravity		0.01,0.1

			start
			{
				size { point 5 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
			}
		}
	}
}



