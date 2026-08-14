effect effects/vehicles/gev/machinegun/tracer
{
	size	52

	spawner "tracer"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/tracerflipped"

			start
			{
				position { line 20,0,0,100,0,0 }
				size { point 1.5 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope linear count 2 offset -1 }
				length { envelope linear }
			}
		}
	}
	spawner "tracer2"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/tracerflipped"

			start
			{
				size { point 0.5 }
				fade { line 0.1,0.6 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				length { envelope linear }
			}
		}
	}
}











