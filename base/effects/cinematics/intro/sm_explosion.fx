effect effects/cinematics/intro/sm_explosion
{
	size	213

	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.7,0.8
			blend	add
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box -20,-20,-20,20,20,20 }
				size { point 80,80 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
			}

			end
			{
				size { point 130,130 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 150,150 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
}


