effect effects/levels/process/process_steam
{
	size	317

	emitter "STEAM"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.01,0.01

			start
			{
				position { sphere -50,-50,0,50,50,0 }
				velocity { box -30,-30,100,30,30,100 }
				size { point 90,90 }
				tint { point 1,0.568627,0.133333 }
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
				size { box 150,150,175,175 }
				tint { point 1,0.823529,0.65098 }
				fade { point 0.3 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}




