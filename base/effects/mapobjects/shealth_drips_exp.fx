effect effects/mapobjects/shealth_drips_exp
{
	size	243

	emitter "drop"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	1.5,1.5
			generatedLine
			persist
			material	"gfx/effects/fluids_drips/blooddrip1"
			gravity		0.5,0.5

			start
			{
				position { sphere -2,-2,-2,2,2,2 }
				size { box 1,2 }
				tint { line 0.501961,1,0.501961,0,0.25098,0 }
				fade { point 0 }
				length { box 1,0,0,2,0,0 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.3 }
				length { box 5,0,0,10,0,0 }
			}

			impact
			{
				remove	1
				effect	"effects/mapobjects/shealth_splat"
			}
		}
	}
}
