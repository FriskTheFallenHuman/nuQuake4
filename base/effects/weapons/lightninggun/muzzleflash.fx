effect effects/weapons/lightninggun/muzzleflash
{
	size	15

	emitter "unnamed1"
	{
		duration	1,1
		count		50,50
		locked

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	0.3,0.6,0.6
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electricity"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -3,-0.5,-0.5,0,0.5,0.5 surface }
				size { box 0.1,0.4 }
				fade { point 0 }
				offset { box -2,0,0,2,0,0 }
				length { box 4,0,0,9,0,0 }
			}

			motion
			{
				fade { envelope fastinslowout }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "end sprite3"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { line -2,0,0,-2,0,0 useEndOrigin }
				size { line 6,6,8,8 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "fwd_sprite"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	0.05,0.05
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { line -2,0,0,-2,0,0 useEndOrigin }
				velocity { box 100,0,0,200,0,0 }
				size { line 6,6,8,8 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 4,4 }
				fade { point 1 }
			}
		}
	}
}







