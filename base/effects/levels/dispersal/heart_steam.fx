effect effects/levels/dispersal/heart_steam
{
	size	312

	emitter "steam"
	{
		duration	1,1
		count		1,3

		sprite
		{
			duration	3,5
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.01,0.01

			start
			{
				velocity { box 0,-5,-5,45,5,5 }
				size { box 20,20,40,40 }
				tint { line 0.533333,0.560784,0.321569,0.458824,0.560784,0.321569 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 125,125,150,150 }
				fade { point 0.25 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "drops"
	{
		duration	1,1
		count		2,7

		line
		{
			duration	1.5,1.5
			blend	add
			generatedLine
			material	"gfx/effects/fluids_drips/splash_line_alpha_green"
			gravity		0.5,0.5

			start
			{
				position { cylinder 0,-40,-40,0,40,40 }
				velocity { box 0,0,0,20,0,0 }
				size { box 1,2 }
				fade { line 0.5,0.75 }
				length { box 5,0,0,25,0,0 }
			}
		}
	}
}





