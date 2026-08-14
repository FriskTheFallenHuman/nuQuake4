effect effects/cinematics/intro/ship_warp
{
	size	849

	spawner "deform"
	{
		count		1,1

		oriented
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/energy_sparks/explosion_deform"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	emitter "teleportring4"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/teleport_base"

			start
			{
				position { point 1,0,0 }
				size { point 15,30 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 50,100 }
			}
		}
	}
	spawner "unnamed7"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/energy_sparks/explosion_deform"

			start
			{
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	spawner "unnamed4"
	{
		count		3,3

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/teleport_base3"

			start
			{
				size { point 100,100 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
}




