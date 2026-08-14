effect effects/mp/regen_player
{
	size	54

	emitter "sparks"
	{
		duration	1,1
		count		10,10

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
				tint { point 0.913726,0.521569,0.521569 }
				fade { point 0 }
				offset { box -20,-20,-20,20,20,20 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				offset { envelope "linear" }
			}

			end
			{
				fade { line 1,0.25 }
			}
		}
	}
	emitter "haze"
	{
		duration	1,1
		count		5,10
		locked

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				size { point 20,20 }
				tint { line 0.658824,0,0,1,0.109804,0.109804 }
				fade { point 0 }
				offset { box -12,-12,-12,12,12,12 }
			}

			motion
			{
				fade { envelope "cosine" }
				offset { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 0.25 }
			}
		}
	}
}


