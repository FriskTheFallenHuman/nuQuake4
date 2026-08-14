effect effects/ambient/pipedrip_small
{
	size	269

	emitter "drop"
	{
		duration	1,1
		count		2,2

		line
		{
			duration	1.5,1.5
			generatedLine
			material	"gfx/effects/fluids_drips/blooddrip1"
			gravity		0.5,0.5

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				size { box 2,4 }
				tint { point 0.843137,1,0.980392 }
				fade { point 0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.3 }
				length { box 25,0,0,30,0,0 }
			}
		}
	}
	delay "delay"
	{
		duration	0.5,5
	}
}

