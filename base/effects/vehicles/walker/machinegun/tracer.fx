effect effects/vehicles/walker/machinegun/tracer
{
	size	3

	spawner "tracer"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/tracerflipped"

			start
			{
				size { box 1,3 }
				tint { point 0.615686,0.615686,0.615686 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}
		}
	}
}
