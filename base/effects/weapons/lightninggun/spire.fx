effect effects/weapons/lightninggun/spire
{
	size	5

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
			jitterSize	0.3,0.6,0.6
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"
			flipNormal

			start
			{
				size { box 0.3,0.5 }
				offset { point 0.3,0,0 }
				length { point 3.7,0,0 }
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
				tint { point 0.54902,0.776471,1 }
				offset { box -0.2,-0.25,0,-0.2,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	emitter "end sprite3"
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
				tint { point 0.54902,0.776471,1 }
				offset { box -1.1,-0.25,0,-1.1,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	emitter "end sprite4"
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
				tint { point 0.54902,0.776471,1 }
				offset { box -2.1,-0.25,0,-2.1,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	emitter "end sprite5"
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
				tint { point 0.54902,0.776471,1 }
				offset { box -3.1,-0.25,0,-3.1,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}






