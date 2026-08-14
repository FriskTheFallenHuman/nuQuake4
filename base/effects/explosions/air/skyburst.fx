effect effects/explosions/air/skyburst
{
	size	11315

	emitter "unnamed2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/add_sphere2"

			start
			{
				position { point 1,0,0 }
				size { point 8000,8000 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5000,5000 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/particles_shapes/add_sphere2"

			start
			{
				position { point 1,0,0 }
				size { point 3000,3000 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 1500,1500 }
			}
		}
	}
	delay "unnamed4"
	{
		duration	1,6
	}
}




