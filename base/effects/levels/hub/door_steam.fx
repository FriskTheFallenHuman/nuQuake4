effect effects/levels/hub/door_steam
{
	size	608

	emitter "unnamed2"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/smoke/cloud_add"

			start
			{
				velocity { box 100,-80,-80,120,80,80 }
				friction { point -600,0,0 }
				size { point 30,30 }
				tint { point 0.505882,0.65098,0.737255 }
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
				fade { line 0.3,1 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 50,-50,-50,80,50,50 }
				size { point 30,30 }
				tint { point 0.501961,0.596078,0.741176 }
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
				size { line 120,120,300,300 }
				fade { line 0.3,0.65 }
			}
		}
	}
}
