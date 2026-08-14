effect effects/steam/steam_floor_small_blast
{
	size	227

	emitter "steam1"
	{
		duration	1,1
		count		12,14

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.01,0.01

			start
			{
				position { point -5,0,0 }
				velocity { box 150,-8,-8,200,8,8 }
				size { box 25,25,40,40 }
				tint { point 0.313726,0.494118,0.513726 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope brassscale count 0.12,0.12,0.12 }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 75,75,100,100 }
				tint { point 0.796079,0.729412,0.627451 }
				fade { line 0.15,0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_steam_blast"
	}
	delay "unnamed2"
	{
		duration	0.1,3
	}
}





