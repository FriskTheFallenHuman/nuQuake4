effect effects/monsters/teleport3
{
	size	60

	spawner "spinny"
	{
		count		1,1

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			trailType	motion
			trailTime	1,1
			trailCount	6,6

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				angle { box 0,0,-1,0,0,1 }
				size { line 0,0,3,3 }
				tint { line 0.596078,0.796079,0.619608,0.662745,1,0.32549 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	spawner "fuzz2"
	{
		count		1,1

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.0025,-0.0025
			generatedNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { point 5,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { box 10,10,30,30 }
				tint { line 0.556863,0.803922,0.380392,0.172549,0.847059,0.188235 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		2,2

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.0125,-0.0125

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				size { point 5,5 }
				fade { line 0.5,1 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box -0.166667,0.166667 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
				rotate { envelope exp_x2 }
			}

			end
			{
				rotate { box -0.5,0.5 }
			}
		}
	}
}



