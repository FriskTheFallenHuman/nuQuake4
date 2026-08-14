effect effects/levels/putra/acid_drip
{
	size	33

	emitter "String"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/brown_slime_line_additive"

			start
			{
				position { line 0,1,0,0,-1,0 }
				fade { point 0.5 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope sintable count 0.5 }
				fade { envelope sintable count 0.5 }
				length { envelope sintable count 0.5,0.5,0.5 }
			}

			end
			{
				size { box 2,3 }
				length { point 20,0,0 }
			}
		}
	}
	emitter "drop"
	{
		start		0.5,0.5
		duration	1,1
		count		1,1

		line
		{
			duration	3,3
			material	"gfx/effects/fluids_drips/drop_additive_sideways"
			gravity		0.08,0.08

			start
			{
				position { point 10,0,0 }
				velocity { point -10,0,0 }
				size { point 2 }
				tint { point 0.337255,0.415686,0.0588235 }
				length { point 8,0,0 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope cosine offset 0.5 }
				length { envelope fastinslowout count 0.7,1,1 }
			}

			end
			{
				size { point 4 }
				length { point 20,0,0 }
			}

			impact
			{
				remove	1
				effect	"effects/levels/putra/acid_splash"
			}
		}
	}
	emitter "Timer"
	{
		duration	3,8
		count		0.002,0.002

		sprite
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/drop_additive_sideways"

			start
			{
				tint { point 0,0,0 }
			}
		}
	}
}



