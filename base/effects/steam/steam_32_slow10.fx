effect effects/steam/steam_32_slow10
{
	size	120

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "steam"
	{
		duration	5,5
		count		3,5

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.04,-0.01

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 10,-10,-10,30,10,10 }
				size { box 10,10,20,20 }
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
				size { box 30,30,50,50 }
				fade { point 0.3 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}
