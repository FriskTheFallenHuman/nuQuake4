effect effects/monsters/berserker/swipe_attack
{
	size	43

	emitter "start up"
	{
		duration	1,1
		count		4,4
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/spike"
			generatedOriginNormal
			flipNormal

			start
			{
				size { point 30,30 }
				tint { point 0.419608,0.6,0.866667 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" count 0.2,0.2 }
				fade { envelope "random" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				rotate { box -0.125,0.125 relative }
			}
		}
	}
	emitter "startup"
	{
		detail		0.5
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { cylinder 0.1,-1,-1,0.1,1,1 surface }
				size { point 2 }
				length { point 20,0,0 }
			}

			motion
			{
				fade { envelope "sintable" rate 1 }
				length { envelope "random" rate 1,1,1 }
			}
		}
	}
	emitter "powerup"
	{
		duration	0.85,0.85
		count		10,10
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal
			flipNormal

			start
			{
				position { point 1,0,0 }
				size { point 2 }
				length { box 30,-5,-5,30,5,5 }
			}

			motion
			{
				fade { envelope "cosine" count 0.5 offset 0.5 }
			}
		}
	}
	emitter "orienteed pules"
	{
		detail		0.5
		duration	0.75,0.75
		count		10,10
		locked

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"
			flipNormal

			start
			{
				velocity { point 50,0,0 }
				acceleration { point 20,0,0 }
				tint { point 0.87451,0.917647,0.968628 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_sparks03_quiet"
	}
}




