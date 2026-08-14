effect effects/monsters/teleport_pull
{
	size	292

	emitter "fuzz2"
	{
		duration	1,1
		count		10,10

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
				tint { line 1,1,1,0.501961,1,0.501961 }
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
				size { box 80,80,150,150 }
			}
		}
	}
	emitter "energy spike"
	{
		duration	1,1
		count		5,10

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere 0,-25,-25,0,25,25 }
				velocity { box 20,0,0,200,0,0 }
				size { box 15,15,20,20 }
				fade { line 0.5,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "spinny2"
	{
		duration	1,1
		count		20,20

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
				acceleration { box 500,0,0,1000,0,0 }
				size { line 3,3,10,10 }
				tint { line 0.901961,1,0.803922,0.721569,0.858824,0.737255 }
				offset { box 0,-50,-50,0,50,50 }
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
	emitter "THELIGHT"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				size { box 5,10 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope fadeouttable }
			}
		}
	}
	emitter "unnamed4"
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
				size { point 150,150 }
				rotate { point 0,0,-1 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}
		}
	}
}

