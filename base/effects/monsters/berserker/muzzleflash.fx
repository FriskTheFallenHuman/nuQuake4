effect effects/monsters/berserker/muzzleflash
{
	size	72

	emitter "unnamed1"
	{
		duration	0.25,0.25
		count		25,25
		locked

		electricity
		{
			duration	0.1,0.1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	0.3,0.7,0.7
			jitterTable	"halfsintable"
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
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 50,0,0,60,0,0 }
			}
		}
	}
	emitter "end sprite2"
	{
		duration	0.25,0.25
		count		40,40
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -2,0,0 }
				size { point 5,5 }
				tint { line 0.4,0.54902,0.839216,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 30,30,50,50 }
			}
		}
	}
}
