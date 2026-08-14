effect effects/levels/dispersal/lift_off_dust
{
	size	784

	emitter "dust"
	{
		duration	15.5,15.5
		count		8,8

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.35,-0.2
			generatedOriginNormal

			start
			{
				position { cylinder 10,-50,-50,10,50,50 surface }
				velocity { box 80,0,0,160,0,0 }
				size { point 400,400 }
				tint { line 0.713726,0.658824,0.537255,0.705882,0.737255,0.513726 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
				rotate { box 0.5,1 relative }
			}
		}
	}
	emitter "dust2"
	{
		duration	15.5,15.5
		count		6,6

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.3,-0.2
			generatedOriginNormal

			start
			{
				position { cylinder 10,-50,-50,10,50,50 surface }
				velocity { box 60,0,0,120,0,0 }
				size { point 200,200 }
				tint { line 0.713726,0.658824,0.537255,0.827451,0.623529,0.419608 }
				fade { point 0.2 }
				rotate { box 0,0.166667 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				rotate { box 0.166667,0.333333 relative }
			}
		}
	}
}




