effect effects/cinematics/intro/ship_gastrail
{
	size	440

	emitter "ghostly"
	{
		duration	20,20
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point -20,0,0 }
				size { line 60,60,80,80 }
				tint { line 0.0705882,0.101961,0.152941,0.0941177,0.117647,0.129412 }
				fade { point 0.15 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,300,300 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


