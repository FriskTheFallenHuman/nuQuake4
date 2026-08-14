effect effects/mp/motion_haze1
{
	size	289

	spawner "main pulse"
	{
		count		10,10

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy3"

			start
			{
				velocity { box 10,0,0,400,0,0 }
				size { line 50,50,80,80 }
				fade { point 0 }
				rotate { box 0.75,0,0.319444,0.75,0,0.430556 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
			}

			end
			{
				fade { point 0.6 }
			}
		}
	}
	emitter "origin"
	{
		duration	1,1
		count		2,2

		oriented
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/energy_sparks/energy3"

			start
			{
				velocity { point 50,0,0 }
				size { point 80,80 }
				fade { point 0 }
				rotate { box 0.75,0,0.319444,0.75,0,0.430556 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	delay "delay"
	{
		duration	1,1
	}
}
