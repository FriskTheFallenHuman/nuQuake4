effect effects/levels/scan_light2
{
	size	264

	emitter "beeam"
	{
		duration	3,3
		count		15,15
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/scan_light2"

			start
			{
				size { box 20,64 }
				tint { point 1,0,0 }
				fade { point 0.5 }
				length { box 160,0,0,200,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "beeam2"
	{
		duration	3,3
		count		1,1
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/scan_light2"

			start
			{
				size { point 20 }
				tint { point 1,0,0 }
				fade { point 0.5 }
				length { point 170,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"process_node_large"
		freqshift	2.5,2.5
	}
}



