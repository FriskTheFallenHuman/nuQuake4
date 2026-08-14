effect effects/mp/regen
{
	size	164

	emitter "sparks"
	{
		duration	1,1
		count		50,50
		locked

		sprite
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				velocity { box -50,-50,-50,50,50,50 }
				size { line 4,4,40,40 }
				tint { point 1,0,0 }
				fade { point 0 }
				offset { point 0,0,22 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 4,4,40,40 }
				fade { point 0.5 }
			}
		}
	}
	emitter "haze"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere -15,-15,-15,15,15,15 }
				velocity { box -20,-20,-20,20,20,20 }
				size { point 40,40 }
				tint { point 1,0,0 }
				fade { point 0 }
				offset { point 0,0,30 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 80,80 }
				fade { point 0.4 }
			}
		}
	}
}


