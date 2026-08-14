effect effects/mp/carryflag_strogg
{
	size	140

	emitter "flagtrail"
	{
		duration	1,1
		count		20,20
		attenuateEmitter

		line
		{
			duration	1.5,2.5
			blend	add
			persist
			material	"gfx/effects/particles_shapes/add_sphere"
			flipNormal

			start
			{
				position { point 60,-20,0 }
				acceleration { box 0,-8,0,0,-25,0 }
				size { point 20 }
				tint { point 1,0.501961,0 }
				fade { point 0.8 }
				length { box 70,0,0,80,0,0 }
			}

			motion
			{
				fade { envelope "exp_1minusx/x2" }
				length { envelope "linear" }
			}

			end
			{
				length { box 20,0,0,30,0,0 }
			}
		}
	}
}


