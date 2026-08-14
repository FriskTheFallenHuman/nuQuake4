effect effects/monsters/failed_transfer/smear
{
	size	4

	emitter "spray2"
	{
		duration	5,5
		count		10,10
		locked

		sprite
		{
			duration	0.24,0.24
			material	"gfx/effects/fluids_drips/bubble_red_half"
			gravity		0.5,0.5
			generatedNormal
			flipNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { point 1,0,0 }
				size { point 2,2 }
				rotate { box 0,0.138889 }
			}

			impact
			{
				remove	1
				effect	"effects/wounds/blood_splat"
			}
		}
	}
}

