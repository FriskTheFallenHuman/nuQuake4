effect effects/cinematics/intro/sm_explosion_blue
{
	size	425

	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.3,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { point 1,0,0 }
				velocity { box -20,-20,-20,20,20,20 }
				size { point 60,60 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 300,300 }
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
