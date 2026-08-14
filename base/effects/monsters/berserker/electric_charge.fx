effect effects/monsters/berserker/electric_charge
{
	size	47

	emitter "end electricity2"
	{
		duration	0.25,0.25
		count		3,3
		locked

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { box 0.5,1 }
				offset { box 5,-5,-5,5,5,5 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				length { envelope "linear" }
			}

			end
			{
				length { box 20,0,0,30,0,0 }
			}
		}
	}
	emitter "end sprite"
	{
		duration	0.25,0.25
		count		8,8
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { line 0,0,0,15,0,0 }
				velocity { box 20,0,0,30,0,0 }
				size { line 15,15,25,25 }
			}

			motion
			{
				size { envelope "linear_flicker" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { point 0 relative }
			}
		}
	}
	delay "unnamed3"
	{
		duration	0.5,3
	}
}


