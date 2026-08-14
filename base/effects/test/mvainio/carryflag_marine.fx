effect effects/test/mvainio/carryflag_marine
{
	size	110

	emitter "sprites"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/energy_sparks/energy1_grey"

			start
			{
				position { line 20,-10,-7,50,-40,-7 }
				size { point 40,40 }
				tint { line 0.588235,0.752941,0.247059,0.443137,0.741176,0.258824 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "fast_in_slow_out" }
			}

			end
			{
				size { point 60,60 }
				fade { point 0.4 }
			}
		}
	}
	emitter "smoketrail2"
	{
		duration	1,1
		count		30,30

		line
		{
			duration	1.5,2.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point 30,-20,-7 }
				acceleration { box 0,-8,0,0,-25,0 }
				size { point 10 }
				tint { point 0.603922,0.760784,0.239216 }
				length { point 50,0,0 }
			}

			motion
			{
				fade { envelope "linear" count 1.5 offset -0.5 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		50,50

		linked
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				size { point 20 }
			}
		}
	}
}
