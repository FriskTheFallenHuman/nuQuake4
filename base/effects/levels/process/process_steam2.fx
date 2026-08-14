effect effects/levels/process/process_steam2
{
	size	308

	emitter "STEAM"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.8,0.8
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.01,0.01

			start
			{
				position { sphere -50,-50,0,50,50,0 }
				velocity { box -20,-20,80,20,20,80 }
				size { point 120,120 }
				tint { point 1,0.752941,0.509804 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_1minusx/x2 }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,180,180 }
				tint { point 1,0.933333,0.866667 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}




