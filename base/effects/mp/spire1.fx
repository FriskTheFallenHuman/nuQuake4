effect effects/mp/spire1
{
	size	1450

	emitter "spot"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				size { box 40,40,80,80 }
				tint { point 0.592157,0.980392,1 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "circle"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/energy_sparks/energy2"
			flipNormal

			start
			{
				position { point 1000,0,0 }
				velocity { point 2000,0,0 }
				size { point 300,300 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 20,20 }
				fade { point 0.3 }
				rotate { box -1,1 relative }
			}
		}
	}
}

