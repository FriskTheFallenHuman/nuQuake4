effect effects/mp/haste_player2
{
	size	36

	emitter "spirals"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { cylinder -25,-25,-25,25,25,25 }
				size { point 10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 5,5,10,10 }
				fade { point 1 }
			}
		}
	}
}
