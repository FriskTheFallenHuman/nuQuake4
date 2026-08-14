effect effects/weapons/lightninggun/muzzleflash_world
{
	size	58

	emitter "unnamed1"
	{
		duration	1,1
		count		25,25
		locked

		electricity
		{
			duration	0.1,0.1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	0.3,0.6,0.6
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electricity"
			generatedOriginNormal

			start
			{
				position { cylinder -0.5,-0.5,-0.5,0.5,0.5,0.5 surface }
				size { box 0.5,1.5 }
				fade { point 0 }
				offset { point -2,0,0 }
				length { box 30,0,0,35,0,0 }
			}

			motion
			{
				fade { envelope fastinslowout }
				length { envelope linear }
			}

			end
			{
				fade { point 1 }
				length { point 20,0,0 }
			}
		}
	}
	emitter "end sprite2"
	{
		duration	1,1
		count		40,40
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -2,0,0 }
				velocity { point 200,0,0 }
				size { line 15,15,20,20 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "end sprite3"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -2,0,0 }
				velocity { point 200,0,0 }
				size { line 30,30,40,40 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}

