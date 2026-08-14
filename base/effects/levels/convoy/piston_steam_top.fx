effect effects/levels/convoy/piston_steam_top
{
	size	1436

	spawner "steam_release"
	{
		start		0.5,0.5
		count		12,15

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.03
			generatedNormal

			start
			{
				position { line 0,-0.5,30,0,0.5,30 }
				velocity { box -150,-150,0,150,150,0 }
				friction { box -1000,0,0,-300,0,0 }
				size { point 10,10 }
				tint { line 1,1,1,0.572549,0.909804,0.937255 }
				fade { point 0 }
				rotate { point 1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				fade { line 0.5,1 }
			}
		}
	}
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
		start		5.5,5.5
		duration	2,3
		count		20,25

		sprite
		{
			duration	4,7
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.05
			generatedNormal

			start
			{
				position { line 0,-0.5,0,0,0.5,100 }
				velocity { box 0,-12,0,0,12,0 }
				friction { point -12,-25,0 }
				size { point 12,12 }
				tint { line 1,1,1,0.572549,0.909804,0.937255 }
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
				size { point 55,55 }
				fade { line 0.12,0.06 }
			}
		}
	}
	emitter "steam_bottm"
	{
		start		1.25,1.25
		duration	1.25,1.25
		count		8,12

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.05
			generatedNormal

			start
			{
				position { line 0,-0.5,12,0,0.5,75 }
				velocity { box -2,-2,0,2,2,0 }
				size { line 1,1,2,2 }
				tint { line 1,1,1,0.572549,0.909804,0.937255 }
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
				size { line 55,55,66,66 }
				fade { line 0.12,0.25 }
			}
		}
	}
}


