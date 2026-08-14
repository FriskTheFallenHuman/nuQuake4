effect effects/monsters/teleport_draw
{
	size	355

	emitter "fuzz2"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			generatedNormal

			start
			{
				position { sphere 0,-2,-2,0,2,2 surface }
				angle { box 0,0,-1,0,0,1 }
				size { point 0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 250,250,150,150 }
			}
		}
	}
	emitter "spinny2"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			trailType	motion
			trailTime	1,1
			trailCount	6,6

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				angle { box 0,0,-1,0,0,1 }
				size { line 3,3,10,10 }
				tint { line 0.901961,1,0.803922,0.721569,0.858824,0.737255 }
				offset { box 20,-50,-50,150,50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				offset { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,20,20 }
				offset { box 0,-1,-1,0,1,1 }
			}
		}
	}
	emitter "unnamed5"
	{
		duration	1,1
		count		4,4

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				size { point 250,250 }
				rotate { point 0,0,-0.0833333 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}
		}
	}
}
