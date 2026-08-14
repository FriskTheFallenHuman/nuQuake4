effect effects/levels/scan_light_med1
{
	size	160

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
				size { box 3,8 }
				tint { point 1,0,0 }
				fade { point 0.5 }
				offset { point 1,3,0 }
				length { box 90,0,0,70,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
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
			material	"gfx/effects/energy_sparks/scan_light2"

			start
			{
				size { point 2 }
				tint { point 0.890196,0.356863,0.356863 }
				fade { point 0.5 }
				offset { point 0,3,0 }
				length { point 60,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"process_node_large"
		freqshift	2.5,2.5
	}
	emitter "unnamed3"
	{
		duration	3,3
		count		5,5
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				velocity { box 50,0,0,100,0,0 }
				size { point 2,2 }
				tint { line 1,0,0,1,0.501961,0 }
				offset { point 0,3,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 50,50,80,80 }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	3,3
		count		5,5
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				tint { line 1,0,0,0.941177,0.305882,0 }
				fade { point 0 }
				offset { point 0,3,0 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { point 50,50 }
				fade { point 1 }
			}
		}
	}
}


