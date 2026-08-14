effect effects/levels/core/hexfx3
{
	size	273

	spawner "BURST"
	{
		count		16,16
		locked

		oriented
		{
			duration	4,4
			blend	add
			material	"textures/core/core_hexfx"

			start
			{
				position { sphere 0,-16,-16,8,16,16 }
				velocity { box 0,-32,-32,4,32,32 }
				size { line 32,32,128,128 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				tint { envelope exp_x2 }
				fade { envelope exp_x2 }
				angle { envelope linear }
			}
		}
	}
}


