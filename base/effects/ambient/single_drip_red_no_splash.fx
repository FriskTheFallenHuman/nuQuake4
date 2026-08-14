effect effects/ambient/single_drip_red_no_splash
{
	size	58

	emitter "snot_line2"
	{
		start		0,0.5
		duration	25,25
		count		4,4

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/drop_red"

			start
			{
				size { point 0.25 }
				length { box 55,0,0,35,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 8,2 }
			}
		}
	}
	emitter "drops2"
	{
		duration	25,25
		count		1,1

		line
		{
			duration	2,3
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.01,0.2
			generatedOriginNormal

			start
			{
				position { line 5,0,0,12,0,0 }
				size { point 5 }
				length { box 30,0,0,45,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 7 }
			}
		}
	}
}


