effect effects/levels/convoy/piston_steam
{
	size	938

	sound "sound"
	{
		soundShader	"effects_steam_blast2"
	}
	emitter "drops4"
	{
		duration	12,12
		count		12,15

		line
		{
			duration	6,6
			material	"gfx/effects/fluids_drips/splash_line_alpha_flip_green"
			gravity		0.01,0.08

			start
			{
				position { cylinder -15,-15,500,15,15,200 }
				size { box 2,4 }
				fade { point 0 }
				length { box 0,0,-100,0,0,-75 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope fast_in_slow_out }
			}

			end
			{
				fade { line 0.25,0.5 }
				length { point 0,0,5 }
			}
		}
	}
	emitter "steam_trail"
	{
		start		5,5
		duration	3,4
		count		6,6

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.06
			generatedNormal

			start
			{
				position { line 0,-0.5,0,0,0.5,150 }
				velocity { box -5,-5,0,5,5,0 }
				size { box 5,5,1,1 }
				tint { line 0.713726,0.588235,0.447059,0.501961,0.639216,0.709804 }
				fade { point 0 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 75,75,90,90 }
				fade { line 0.12,0.25 }
			}
		}
	}
	emitter "steam_bottm"
	{
		start		0.45,0.45
		duration	3,3
		count		12,12

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.05,-0.005
			generatedNormal

			start
			{
				position { line 0,-0.5,-45,0,0.5,-45 }
				velocity { box -125,-125,0,125,125,0 }
				friction { point -12,-12,0 }
				size { point 0.25,0.25 }
				tint { line 0.784314,0.729412,0.639216,0.556863,0.666667,0.701961 }
				fade { point 0 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				fade { line 0.5,0.25 }
			}
		}
	}
	emitter "steam_release_right"
	{
		start		1,1
		duration	1,1
		count		3,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.1,-0.03
			generatedNormal

			start
			{
				position { point 0,-10,-30 }
				velocity { box -25,-200,0,25,-300,0 }
				friction { box -1000,0,0,-5000,0,0 }
				size { point 35,35 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0 }
				rotate { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,200,200 }
				fade { line 0.5,0.25 }
			}
		}
	}
	emitter "steam_release_left"
	{
		start		1,1
		duration	1,1
		count		3,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.1,-0.03
			generatedNormal

			start
			{
				position { point 0,10,-30 }
				velocity { box -25,200,0,25,300,0 }
				friction { box -1000,0,0,-5000,0,0 }
				size { line 35,35,45,45 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0 }
				rotate { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,200,200 }
				fade { line 0.5,0.25 }
			}
		}
	}
	emitter "steam_trail2"
	{
		start		5,5
		duration	3,4
		count		6,6

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.03
			generatedNormal

			start
			{
				position { line 0,-0.5,0,0,0.5,150 }
				velocity { box -12,-12,0,12,12,0 }
				friction { point -12,-12,0 }
				size { line 1,1,2,2 }
				fade { point 0 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 35,35,50,50 }
				fade { line 0.25,0.12 }
			}
		}
	}
}


