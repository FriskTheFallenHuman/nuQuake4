effect effects/levels/hub/botswarm_near_left
{
	size	655

	emitter "bot swarm"
	{
		duration	1,1
		count		2.5,2.5

		sprite
		{
			duration	5,10
			material	"gfx/effects/particles_shapes/repairbot_med_flipped"

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 0,0,0,100,0,0 }
				angle { box 0,0,0,0.861111,0.861111,0.861111 }
				size { point 10,10 }
				offset { box 0,-60,-60,0,60,60 }
				rotate { box 0.305556,0.444444 }
			}

			motion
			{
				tint { envelope linear }
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
