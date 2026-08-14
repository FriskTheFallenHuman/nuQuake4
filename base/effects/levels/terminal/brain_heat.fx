effect effects/levels/terminal/brain_heat
{
	size	728

	emitter "HEAT WAVE"
	{
		duration	1,1
		count		200,200

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/teleport_warp"

			start
			{
				position { cylinder 0,-350,-350,0,350,350 surface }
				velocity { box 300,0,0,400,0,0 }
				size { point 300,300 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope exp_x2 }
			}

			end
			{
				size { point 0,0 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		100,100

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.04,-0.01

			start
			{
				position { cylinder 0,-360,-360,0,360,360 surface }
				velocity { box 10,-10,-10,30,10,10 }
				size { box 25,25,100,25 }
				tint { line 0.67451,0.654902,0.576471,0.67451,0.647059,0.564706 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,200,200 }
				fade { point 0.15 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}




