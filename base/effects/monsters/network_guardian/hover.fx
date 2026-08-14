effect effects/monsters/network_guardian/hover
{
	size	203

	emitter "ENGINE"
	{
		duration	1,2
		count		15,15
		locked

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 10,-20,-20,85,20,20 }
				velocity { box 0,-20,-20,80,20,20 }
				size { box 30,30,40,40 }
				tint { point 0,0.501961,0.501961 }
				fade { line 0.5,1 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 60,60,80,80 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "spots3"
	{
		duration	1,3
		count		30,30
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { cylinder 10,-20,-20,85,20,20 surface }
				velocity { box 0,0,0,20,0,0 }
				size { box 0.5,0.5,1,1 }
				tint { line 1,1,1,0,1,1 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}



