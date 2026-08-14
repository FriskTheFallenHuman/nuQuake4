effect effects/smoke/hangar_line
{
	size	1952

	emitter "smoke"
	{
		duration	10,10
		count		2,2

		sprite
		{
			duration	5,10
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.05,-0.025

			start
			{
				position { line 50,-150,-30,180,150,30 }
				velocity { box 10,-5,-5,100,5,5 }
				size { line 100,100,200,200 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 800,800,1000,1000 }
				fade { point 1 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
}


