effect effects/monsters/teleport_malfunction
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
				size { box 80,80,120,120 }
			}
		}
	}
	emitter "black hole"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { point 300,300 }
				rotate { box 0,-1 }
			}

			motion
			{
				size { envelope "raven_flicker1" }
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
	emitter "distortion"
	{
		detail		0.3
		duration	1,1
		count		3,3

		sprite
		{
			duration	1,3
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
	emitter "electricity2"
	{
		detail		0.3
		duration	1,1
		count		3,3

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { cylinder 0.35,-1,-1,0.35,1,1 }
				velocity { point 10,0,0 }
				size { box 0.25,2 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				length { box 100,0,0,120,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 0,0,-150,0,0,150 }
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
				velocity { box 0,0,0,300,0,0 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope "random" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 100,100,200,200 }
			}
		}
	}
	emitter "energy spike2"
	{
		start		1.5,1.5
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				velocity { box 0,0,0,200,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { point 70,70 }
				fade { line 0.5,1 }
				offset { box 0,-30,-30,100,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "random" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	sound "unnamed10"
	{
		soundShader	"effects_teleport_out"
		volume	0.6,0.6
	}
	sound "unnamed9"
	{
		soundShader	"effects_sparks03"
		freqshift	0.8,0.8
	}
}



