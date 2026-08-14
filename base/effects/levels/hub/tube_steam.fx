effect effects/levels/hub/tube_steam
{
	size	382

	emitter "unnamed1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	3,3
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.025,-0.025

			start
			{
				position { cylinder 0,-60,-60,0,60,60 surface }
				size { point 30,30 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { point 150,150 }
				fade { line 0.2,0.5 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/smoke/cloud_add"
			gravity		-0.035,-0.025

			start
			{
				position { cylinder 0,-60,-60,0,60,60 surface }
				size { point 30,30 }
				tint { point 0.0666667,0.470588,0.87451 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
				fade { line 0.3,0.65 }
			}
		}
	}
}
