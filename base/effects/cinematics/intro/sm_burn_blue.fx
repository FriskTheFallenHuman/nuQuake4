effect effects/cinematics/intro/sm_burn_blue
{
	size	192

	emitter "flash2"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { box -10,-10,-10,10,10,10 }
				velocity { box -60,-60,-60,60,60,60 }
				acceleration { box -120,-120,-120,120,120,120 }
				size { box 10,20,30,20 }
				tint { line 0.501961,0,1,1,0.25098,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,100,100,100 }
				tint { line 0,1,1,0,0,1 }
				rotate { box -0.972222,1.25 relative }
			}
		}
	}
}
