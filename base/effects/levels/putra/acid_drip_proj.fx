effect effects/levels/putra/acid_drip_proj
{
	size	29

	emitter "drop"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	3,3
			persist
			material	"gfx/effects/fluids_drips/drop_additive_sideways"

			start
			{
				position { point 10,0,0 }
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
		}
	}
}

