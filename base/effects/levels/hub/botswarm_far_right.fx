effect effects/levels/hub/botswarm_far_right
{
	size	897

	emitter "bot swarm"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	15,15
			material	"gfx/effects/particles_shapes/repairbot_med"

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 50,0,0,100,0,0 }
				angle { box 0,0,0,0.861111,0.861111,0.861111 }
				size { point 30,30 }
				offset { box 0,-60,-60,0,60,60 }
				rotate { box 0.305556,0.444444 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "maincontroltable" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				angle { box -0.222222,-0.222222,-0.222222,0.222222,0.222222,0.222222 }
				rotate { point 0.375 }
			}
		}
	}
}

