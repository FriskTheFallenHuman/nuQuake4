effect effects/levels/putra/acid_drip_mflash
{
	size	24

	emitter "String"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	3,4
			persist
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
	emitter "Timer"
	{
		duration	3,8
		count		0.002,0.002

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/fluids_drips/drop_additive_sideways"

			start
			{
				tint { point 0,0,0 }
			}
		}
	}
}

