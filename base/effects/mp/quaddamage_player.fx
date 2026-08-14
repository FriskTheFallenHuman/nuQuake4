effect effects/mp/quaddamage_player
{
	size	43

	emitter "sparks"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				size { line 4,4,10,10 }
			}

			motion
			{
				fade { envelope "linear" }
				offset { envelope "linear" }
			}

			end
			{
				offset { box -10,-10,-10,10,10,10 }
			}
		}
	}
	emitter "haze"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				size { box 10,10,15,15 }
				tint { point 0.419608,0.521569,1 }
				fade { point 0.5 }
			}

			motion
			{
				fade { envelope "linear" }
				offset { envelope "linear" }
			}

			end
			{
				offset { box -10,-10,-10,10,10,10 }
			}
		}
	}
}



