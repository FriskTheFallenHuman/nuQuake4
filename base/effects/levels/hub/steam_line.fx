effect effects/levels/hub/steam_line
{
	size	306

	emitter "unnamed2"
	{
		duration	1,1
		count		5,8

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/smoke/cloud_add"
			gravity		-0.025,-0.0125

			start
			{
				position { line 0,0,-180,0,0,180 }
				size { point 30,30 }
				tint { point 0.0666667,0.470588,0.87451 }
				fade { point 0 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 80,80,120,120 }
				fade { line 0.3,0.65 }
			}
		}
	}
}
