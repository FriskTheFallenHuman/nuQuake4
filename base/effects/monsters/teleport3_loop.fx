effect effects/monsters/teleport3_loop
{
	size	79

	emitter "spinny"
	{
		duration	1,1
		count		5,5

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
				angle { box 0,0,-1,0,0,1 }
				size { line 0,0,3,3 }
				tint { line 0.596078,0.796079,0.619608,0.662745,1,0.32549 }
				offset { box -10,-10,-10,10,10,10 }
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
	emitter "fuzz2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.0025,-0.0025
			generatedNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { point 5,0,0 }
				angle { box -1,-1,-1,1,1,1 }
				size { line 30,30,50,50 }
				tint { line 0.556863,0.803922,0.380392,0.172549,0.847059,0.188235 }
				fade { point 0.5 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "random" offset 0.5 }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.0125,-0.0125

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				size { line 5,5,10,10 }
				fade { line 0.5,1 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box -0.166667,0.166667 }
			}

			motion
			{
				fade { envelope "random" offset 0.5 }
				angle { envelope "linear" }
				rotate { envelope "exp_x2" }
			}

			end
			{
				rotate { box -0.5,0.5 }
			}
		}
	}
	delay "unnamed3"
	{
		duration	0.5,3
	}
	sound "unnamed4"
	{
		soundShader	"effects_teleport_rift"
		volume	0.3,0.3
	}
	sound "unnamed5"
	{
		soundShader	"effects_sparks01"
		volume	0.6,0.6
		freqshift	1.2,1.2
	}
}



