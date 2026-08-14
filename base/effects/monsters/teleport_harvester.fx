effect effects/monsters/teleport_harvester
{
	size	165

	spawner "fuzz4"
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
				size { box 80,80,100,100 }
			}
		}
	}
	emitter "energy spike3"
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
				position { sphere 0,-150,-150,0,150,150 }
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




