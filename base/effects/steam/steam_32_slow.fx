effect effects/steam/steam_32_slow
{
	size	162

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "steam"
	{
		duration	1,1
		count		3,5

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.04,-0.01

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 10,-10,-10,30,10,10 }
				size { box 30,30,40,40 }
				tint { line 0.713726,0.74902,0.658824,0.592157,0.658824,0.576471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,70,70 }
				fade { point 0.3 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}


