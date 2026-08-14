effect effects/cinematics/intro/thrust_mini2
{
	size	44

	emitter "line_inner2"
	{
		duration	0.75,0.75
		count		8,8
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { point -2,0,0 }
				size { box 5,8 }
				fade { point 0.5 }
				length { box 30,0,0,35,0,0 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	0.75,0.75
		count		5,5

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				velocity { point 30,0,0 }
				size { point 10,10 }
				rotate { box -0.972222,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}



