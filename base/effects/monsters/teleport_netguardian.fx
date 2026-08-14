effect effects/monsters/teleport_netguardian
{
	size	121

	spawner "spinny2"
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
				tint { line 0.901961,1,0.803922,0.721569,0.858824,0.737255 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	spawner "fuzz3"
	{
		count		1,1

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.005,-0.005
			generatedNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { point 5,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,1,0.501961 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,0.5 }
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
				size { box 20,20,30,30 }
			}
		}
	}
	emitter "energy spike2"
	{
		duration	1,1
		count		15,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.05,-0.05

			start
			{
				position { sphere 0,-100,-100,0,100,100 }
				size { box 20,20,30,30 }
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
				size { point 2,2 }
			}
		}
	}
}


