effect effects/smoke/smolder1
{
	size	105

	emitter "steam"
	{
		duration	1,1
		count		2,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.04,-0.01

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 10,-10,-10,30,10,10 }
				size { box 20,20,30,20 }
				tint { line 0.67451,0.654902,0.576471,0.67451,0.65098,0.568627 }
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
				size { box 40,40,50,50 }
				fade { point 0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}


