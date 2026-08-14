effect effects/monsters/teleport2_air
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
				velocity { box -200,-200,-200,200,200,200 }
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
	spawner "electricity2"
	{
		count		10,20

		electricity
		{
			duration	0.25,0.5
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
				length { box -180,-180,-180,180,180,180 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 10,-10,-10,120,10,10 }
			}
		}
	}
	spawner "spinny"
	{
		detail		0.5
		count		10,30

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box -200,-200,-200,200,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { line 0,0,3,3 }
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
	sound "unnamed6"
	{
		soundShader	"effects_teleport"
		freqshift	1.3,1.3
	}
}


