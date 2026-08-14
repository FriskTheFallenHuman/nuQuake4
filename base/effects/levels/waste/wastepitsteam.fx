effect effects/levels/waste/wastepitsteam
{
	size	354

	emitter "steam1"
	{
		duration	8,8
		count		8,12

		sprite
		{
			duration	3,4.5
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder -100,-120,0,100,120,0 }
				velocity { point 0,0,100 }
				size { line 40,40,100,100 }
				tint { line 0.501961,0.501961,0.501961,0.647059,0.380392,0.313726 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				tint { point 1,1,1 }
				fade { line 0.05,0.1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
