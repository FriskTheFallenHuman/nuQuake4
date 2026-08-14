effect effects/monsters/teleport_big
{
	size	705

	emitter "black hole"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { point 300,300 }
				rotate { box 0,-1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}
		}
	}
	emitter "unnamed5"
	{
		duration	1,1
		count		3,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				velocity { point 30,0,0 }
				size { point 300,300 }
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
	emitter "electricity2"
	{
		detail		0.3
		duration	1,1
		count		10,20

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { cylinder 0.35,-1,-1,0.35,1,1 }
				size { box 0.25,2 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				fade { line 0.5,1 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 10,0,0,120,0,0 }
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
			duration	1,5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box -20,0,0,-50,0,0 }
				angle { box -0.1,-0.1,-0.1,0.1,0.1,0.1 }
				size { line 0,0,3,3 }
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
	emitter "unnamed8"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	5,5
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				velocity { point -70,0,0 }
				size { point 350,350 }
				rotate { point 0,0,0.5 }
			}

			motion
			{
				size { envelope "linear" offset 0.5,0.5 }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 390,390 }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	3,3
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
				size { point 390,390 }
			}
		}
	}
	emitter "unnamed13"
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
				size { point 100,100 }
				offset { point 0,0,-60 }
				rotate { box -0.25,0,-1,-0.25,0,1 }
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
				offset { point 0,0,75 }
				rotate { point -0.25,0,0 }
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
		detail		0.3
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
		soundShader	"effects_teleporter_big"
		volume	0.6,0.6
	}
	spawner "unnamed6"
	{
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_core"

			start
			{
				position { point 1,0,0 }
				size { point 150,150 }
				rotate { point 0,0,0.375 }
			}
		}
	}
}






