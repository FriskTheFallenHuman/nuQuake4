effect effects/mp/haste_player
{
	size	108

	emitter "roadrunner"
	{
		duration	2,2
		count		20,30
		attenuateEmitter

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.021,-0.021

			start
			{
				size { point 20,20 }
				tint { line 0.576471,0.556863,0.494118,0.501961,0.501961,0.25098 }
				offset { box 0,0,0,0,0,10 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 40,40,60,60 }
			}
		}
	}
	emitter "spirals2"
	{
		duration	2,2
		count		25,25

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { sphere -15,-15,-15,15,5,15 }
				velocity { point 0,0,20 }
				size { line 2,2,5,5 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 10,10,15,15 }
				fade { point 0.8 }
			}
		}
	}
}



