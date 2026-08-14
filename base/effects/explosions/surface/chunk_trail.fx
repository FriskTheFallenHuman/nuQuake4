effect effects/explosions/surface/chunk_trail
{
	size	43

	emitter "chunks_trail"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 5,5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.15 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
}
