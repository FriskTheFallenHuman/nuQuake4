effect effects/steam/medorange_32
{
	size	117

	emitter "steam1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1.2,1.2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.14,-0.1

			start
			{
				velocity { box 0,-5,-5,0,5,5 }
				size { box 10,10,15,15 }
				tint { line 0.768628,0.729412,0.615686,0.854902,0.835294,0.713726 }
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
				size { box 50,50,80,80 }
				tint { point 0.666667,0.576471,0.258824 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


