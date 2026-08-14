effect effects/test/mvainio/steam_slow2
{
	size	149

	emitter "steam1"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	3,4
			material	"gfx/test/coloredsmoke"
			gravity		-0.01,-0.004

			start
			{
				velocity { point 15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 10,10,15,15 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,80,80 }
				fade { point 0.3 }
				angle { box -0.25,-0.25,-0.25,0.25,0.25,0.25 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


