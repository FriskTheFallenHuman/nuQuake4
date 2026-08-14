effect effects/cinematics/intro/dropship_pre_liftoff
{
	size	302

	emitter "dust2"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.5,0.8
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.5,-0.1

			start
			{
				position { line -10,-80,-20,10,-120,100 }
				velocity { box -300,-40,-300,300,-20,300 }
				size { point 20,20 }
				tint { line 0.74902,0.74902,0.74902,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 80,80,100,100 }
				fade { point 0.1 }
				rotate { box -5,5 relative }
			}
		}
	}
}
