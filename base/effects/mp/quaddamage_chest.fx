effect effects/mp/quaddamage_chest
{
	size	93

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
				size { line 5,5,10,10 }
			}

			motion
			{
				fade { envelope "linear" }
				offset { envelope "linear" }
			}

			end
			{
				offset { box -20,-20,-20,20,20,20 }
			}
		}
	}
	emitter "haze"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				angle { box -0.0833333,-0.0833333,-0.0833333,0.0833333,0.0833333,0.0833333 }
				size { point 20,30 }
				tint { point 0.419608,0.521569,1 }
				fade { point 0.5 }
			}

			motion
			{
				fade { envelope "linear" }
				offset { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				offset { box -30,-30,-30,30,30,30 }
			}
		}
	}
	emitter "haze2"
	{
		duration	1,1
		count		15,15
		locked

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				size { line 20,20,30,30 }
				tint { point 0.419608,0.521569,1 }
				fade { point 0.5 attenuate }
				offset { box -20,-10,-10,20,10,10 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 }
			}
		}
	}
}



