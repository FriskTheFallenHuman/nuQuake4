effect effects/levels/scan_light_sm
{
	size	220

	emitter "beeam"
	{
		duration	3,3
		count		30,30
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/scan_light"

			start
			{
				size { box 2,20 }
				fade { point 0.5 }
				length { box 120,0,0,200,0,0 }
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
		count		5,5
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/scan_light"

			start
			{
				size { point 8 }
				fade { point 0.5 }
				length { point 210,0,0 }
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
		freqshift	2,2
	}
}



