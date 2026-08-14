effect effects/ambient/single_drip_blue
{
	size	420

	emitter "blue_line"
	{
		start		0,0.5
		duration	25,25
		count		4,4

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/drop_blue"

			start
			{
				size { point 0.25 }
				tint { point 0,1,1 }
				length { box 55,0,0,35,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				length { envelope "linear" }
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
			material	"gfx/effects/fluids_drips/drop_blue"
			gravity		0.01,0.2
			generatedOriginNormal

			start
			{
				position { line 5,0,0,12,0,0 }
				size { point 5 }
				tint { point 0.501961,1,1 }
				length { box 30,0,0,45,0,0 }
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



