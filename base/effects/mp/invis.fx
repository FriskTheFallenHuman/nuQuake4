effect effects/mp/invis
{
	size	180

	emitter "ring2"
	{
		duration	1,1
		count		12,12
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy2"
			gravity		-1,-1

			start
			{
				size { line 80,80,120,120 }
				tint { point 0.792157,0.847059,1 }
				fade { point 0 }
				offset { point 0,0,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 0,0,10,10 }
				fade { point 0.4 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "sparks"
	{
		duration	1,1
		count		40,40
		locked

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			generatedNormal

			start
			{
				position { point 0,0,30 }
				velocity { point 50,0,0 }
				size { line 1,1,2,2 }
				fade { point 0 }
				offset { box -80,-80,-80,80,80,80 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				offset { envelope linear }
			}

			end
			{
				size { line 6,6,8,8 }
				fade { point 0.6 }
			}
		}
	}
}



