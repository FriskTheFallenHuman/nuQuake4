effect effects/monsters/teleport_makron
{
	size	788

	emitter "unnamed5"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				velocity { point 100,0,0 }
				size { point 500,500 }
				rotate { box 0,0,-0.0833333,0,0,0.0833333 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}
		}
	}
	emitter "spinny"
	{
		detail		0.3
		duration	1,1
		count		10,100

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 50,0,0,200,0,0 }
				angle { box -0.1,-0.1,-0.1,0.1,0.1,0.1 }
				size { line 1,1,5,5 }
				tint { line 0.721569,0.862745,0.737255,0.905882,1,0.807843 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		2,2

		oriented
		{
			duration	2,2
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				size { point 350,350 }
				rotate { point 0,0,0.0277778 }
			}

			motion
			{
				size { envelope "linear" offset 0.5,0.5 }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 550,550 }
			}
		}
	}
	emitter "deform"
	{
		detail		0.3
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_warp"

			start
			{
				size { point 10,10 }
				offset { point -80,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "cosine" }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	emitter "unnamed13"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				velocity { box 60,0,0,120,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
			}

			end
			{
				size { point 400,400 }
			}
		}
	}
	emitter "unnamed14"
	{
		duration	1,1
		count		3,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				size { point 180,180 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	emitter "electricity3"
	{
		duration	1,1
		count		10,20

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	2
			jitterRate	0
			jitterSize	3,12,7
			jitterTable	"halfsintable"
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				size { box 1,5 }
				fade { line 0.5,1 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}
		}
	}
	sound "unnamed11"
	{
		soundShader	"effects_teleport"
		freqshift	0.8,0.8
	}
	spawner "fuzz"
	{
		count		30,30

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box 200,0,0,300,0,0 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,1,0.501961 }
				fade { point 0.5 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 150,150,300,300 }
			}
		}
	}
	emitter "THELIGHT"
	{
		duration	1,1
		count		2,2

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				size { box 50,80 }
				length { box 400,0,0,500,0,0 }
			}

			motion
			{
				fade { envelope "fadeouttable" }
			}
		}
	}
	spawner "unnamed13"
	{
		detail		0.5
		count		20,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.125,0

			start
			{
				position { sphere 0,-80,-80,200,80,80 surface }
				velocity { box 30,-80,-80,100,80,80 }
				angle { box 0,0,-1,0,0,1 }
				size { line 50,50,100,100 }
				fade { line 0.5,1 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}
		}
	}
}



