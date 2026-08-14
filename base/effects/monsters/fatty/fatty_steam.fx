effect effects/monsters/fatty/fatty_steam
{
	size	856

	emitter "steam2"
	{
		duration	4.75,4.75
		count		10,20

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.05,-0.025
			generatedNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				velocity { box 200,-100,-100,300,100,100 }
				size { line 80,80,100,100 }
				tint { line 0.752941,0.752941,0.752941,0.458824,0.556863,0.321569 }
				fade { point 0 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,400,400 }
				fade { line 0.5,1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam"
	{
		duration	4.75,4.75
		count		10,20

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				velocity { box 100,-20,-20,300,20,20 }
				angle { box 0,0,0,0,0,0.222222 }
				size { line 80,80,100,100 }
				tint { line 0.752941,0.752941,0.752941,0.458824,0.556863,0.321569 }
				fade { point 0 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,300,300 }
				fade { line 0.25,1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam3"
	{
		duration	6.5,6.5
		count		20,30

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { sphere 0,-50,-50,0,50,50 }
				velocity { box 20,-50,-50,20,50,50 }
				angle { box 0,0,0,0,0,0.166667 }
				size { line 150,150,300,300 }
				tint { line 0.752941,0.752941,0.752941,0.458824,0.556863,0.321569 }
				fade { point 0 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { line 0.25,1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}




