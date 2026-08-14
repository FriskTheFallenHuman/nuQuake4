effect effects/weapons/lightninggun/tube
{
	size	8

	emitter "unnamed1"
	{
		duration	1,1
		count		2,2
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	0.1,0.2,0.2
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"

			start
			{
				size { point 0.2 }
				offset { point 0.3,0,0 }
				length { point 1,0,0 }
			}
		}
	}
	emitter "end sprite2"
	{
		detail		0.5
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { line 0,0,0,0,0,0 useEndOrigin }
				size { line 0.6,0.6,1.2,1.2 }
				tint { point 0.282353,0.643137,1 }
				offset { point 0.4,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"weapon_lightninggun_tubeloop"
	}
}











