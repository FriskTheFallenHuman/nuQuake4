effect effects/mp/guard_player
{
	size	79

	emitter "roll3"
	{
		duration	1,1
		count		5,5
		locked

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/energy_sparks/energy1_grey"
			trailType	motion
			trailTime	5,5
			trailCount	10,10
			trailMaterial	"gfx/effects/particles_shapes/motionblur"

			start
			{
				position { line 0,0,-10,0,0,10 }
				size { box 2,2,6,6 }
				tint { point 0.258824,0.462745,1 }
				offset { box 0,-28,10,0,28,10 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				angle { envelope "linear" }
			}

			end
			{
				angle { point 0,1,0 }
			}
		}
	}
	emitter "ground3"
	{
		duration	1,1
		count		3,3
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1_grey"

			start
			{
				position { point 1,0,0 }
				size { point 55,55 }
				tint { point 0.258824,0.462745,1 }
				fade { point 0 }
				rotate { box -0.25,0,0,-0.25,0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
}





