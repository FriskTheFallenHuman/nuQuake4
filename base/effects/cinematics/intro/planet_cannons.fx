effect effects/cinematics/intro/planet_cannons
{
	size	1435

	trail "trail5"
	{
		count		6,6

		sprite
		{
			duration	3,5
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				size { point 40,40 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope "exp_x2" }
				fade { envelope "linear" offset 0.5 }
				rotate { envelope "cosine" offset 0.5 }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	10,10
		count		0.75,0.75

		sprite
		{
			duration	32,32
			material	"gfx/effects/weapons/blaster_fly2"
			trailType	trail5

			start
			{
				position { box 0,-100,-100,0,100,100 }
				velocity { point 0.5,0,0 }
				friction { point -0.05,0,0 }
				size { point 15,15 }
				tint { line 0.72549,0.796079,0.92549,0.4,0.54902,0.839216 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "exp_x2" count 1.2,1.2 offset -0.2,-0.2 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 70,70 }
				rotate { point -0.5 }
			}
		}
	}
}










