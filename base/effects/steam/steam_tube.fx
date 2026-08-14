effect effects/steam/steam_tube
{
	size	262

	emitter "steam1"
	{
		duration	0.8,0.8
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,0.01

			start
			{
				velocity { box 430,-55,-55,445,55,55 }
				acceleration { point -300,0,0 }
				size { box 40,40,45,45 }
				tint { point 0.72549,0.776471,0.784314 }
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
				size { box 80,80,85,85 }
				fade { point 0.15 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam2"
	{
		start		0.6,0.6
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 300,-15,-15,305,15,15 }
				acceleration { point -250,0,0 }
				size { box 40,40,45,45 }
				tint { point 0.729412,0.780392,0.729412 }
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
				size { box 80,80,85,85 }
				fade { point 0.15 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam3"
	{
		start		1,1
		duration	1,1
		count		5,5

		sprite
		{
			duration	2.2,2.2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 50,-15,-15,55,15,15 }
				size { box 40,40,45,45 }
				tint { point 0.72549,0.780392,0.784314 }
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
				size { box 60,60,65,65 }
				fade { point 0.15 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_steam_blast"
	}
}



