effect effects/monsters/teleport2
{
	size	708

	spawner "fuzz"
	{
		count		20,20

		sprite
		{
			duration	0.5,0.5
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
				size { box 50,50,80,80 }
			}
		}
	}
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
	spawner "energy spike"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				size { point 2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "distortion"
	{
		detail		0.3
		count		1,1

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				size { point 5,5 }
			}

			motion
			{
				size { envelope "linear" count 0.5,0.5 }
				fade { envelope "cosine" count 0.5 }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	emitter "unnamed5"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				size { point 150,150 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}
		}
	}
	spawner "unnamed6"
	{
		count		2,2

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
	spawner "electricity2"
	{
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
				fade { line 0.5,0.75 }
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
	spawner "unnamed7"
	{
		count		5,10

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				velocity { box 50,0,0,800,0,0 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 150,150,300,300 }
			}
		}
	}
	emitter "energy spike2"
	{
		duration	0.25,0.5
		count		10,10

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				velocity { box 150,0,0,450,0,0 }
				size { point 100,100 }
				fade { line 0.5,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 10,10,50,50 }
			}
		}
	}
	spawner "spinny"
	{
		detail		0.5
		count		10,30

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			trailType	motion
			trailTime	1,1
			trailCount	6,6

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 0,0,0,200,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { line 0,0,3,3 }
				tint { line 0.721569,0.862745,0.737255,0.905882,1,0.807843 }
				offset { box 0,-20,-20,0,20,20 }
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
	sound "unnamed10"
	{
		soundShader	"effects_teleport_out"
	}
}




