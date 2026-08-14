effect effects/mp/quaddamage
{
	size	102

	emitter "sparks"
	{
		duration	1,1
		count		14,14

		sprite
		{
			duration	1,1.3
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		-0.1,-0.1

			start
			{
				position { sphere -25,-25,-25,25,25,50 }
				size { line 4,4,40,40 }
				fade { point 0 }
				offset { point 0,8,12 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
	emitter "haze"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1.3
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.1,-0.1

			start
			{
				position { sphere -25,-25,-25,25,25,50 }
				size { point 40,40 }
				tint { point 0.423529,0.52549,1 }
				fade { point 0 }
				offset { point 0,8,12 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
}


