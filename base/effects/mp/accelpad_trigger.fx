effect effects/mp/accelpad_trigger
{
	size	445

	spawner "unnamed1"
	{
		count		4,4

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
				tint { point 1,0.501961,0.25098 }
				offset { point -90,0,0 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 200,200,250,250 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		30,30

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		0.25,0.25

			start
			{
				position { cylinder 0,-10,-10,20,10,10 }
				velocity { box 0,-20,-20,800,20,20 }
				angle { box 0,0,-1,0,0,1 }
				size { box 8,8,10,10 }
				tint { point 1,0.501961,0.25098 }
				offset { box 0,-10,-10,0,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope exp_x2 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		5,5

		sprite
		{
			duration	0.125,0.125
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { cylinder 0,-30,-30,0,30,30 surface }
				velocity { point 1000,0,-150 }
				size { line 50,50,80,80 }
				tint { point 1,0.501961,0.247059 }
				offset { point -70,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
}
