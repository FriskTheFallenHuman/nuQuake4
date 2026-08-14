effect effects/levels/hub/botswarm_med_right
{
	size	650

	emitter "bot swarm"
	{
		duration	1,1
		count		2.5,2.5

		sprite
		{
			duration	5,10
			material	"gfx/effects/particles_shapes/repairbot_sm"

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 0,0,0,100,0,0 }
				angle { box 0,0,0,0.861111,0.861111,0.861111 }
				size { point 6,6 }
				offset { box 0,-60,-60,0,60,60 }
				rotate { box 0.305556,0.444444 }
			}

			motion
			{
				fade { envelope maincontroltable }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box -0.222222,-0.222222,-0.222222,0.222222,0.222222,0.222222 }
				rotate { point 0.375 }
			}
		}
	}
}
