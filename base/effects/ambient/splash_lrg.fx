effect effects/ambient/splash_lrg
{
	size	555

	sound "sound"
	{
		soundShader	"ambient_water_splash_big"
	}
	spawner "streaks"
	{
		count		4,4

		line
		{
			duration	0.5,0.75
			material	"gfx/effects/fluids_drips/splash_line_alpha"

			start
			{
				position { cylinder -12,-2,-2,-25,2,2 }
				size { point 12 }
				fade { point 0 }
				length { box 85,-3,-3,65,3,3 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope fast_in_slow_out }
				length { envelope popover_hold_grow }
			}

			end
			{
				size { point 35 }
				fade { line 0.25,0.12 }
				length { box 125,-6,-6,200,6,6 }
			}
		}
	}
	spawner "mist_lines"
	{
		start		0.12,0.12
		count		6,12

		line
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/foam"
			gravity		0.12,0.35

			start
			{
				position { cylinder -10,-0.05,-0.05,-20,0.05,0.05 surface }
				velocity { point 50,0,0 }
				fade { point 0 }
				length { box 50,-25,-25,100,25,25 }
			}

			motion
			{
				size { envelope fast_in_slow_out }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { point 25 }
				fade { line 0.25,0.12 }
				length { box 45,-100,-100,35,100,100 }
			}
		}
	}
	spawner "drops_motion_outer"
	{
		count		12,20

		sprite
		{
			duration	1,2
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 100,-1,-1,80,1,1 }
				velocity { box 300,-150,-150,350,150,150 }
				size { box 3,3,1,1 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 0.25,0.25,0.5,0.5 }
				fade { line 1,0.75 }
			}
		}
	}
	spawner "drops_motion_inner"
	{
		count		12,20

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.35,1
			generatedOriginNormal

			start
			{
				position { cylinder 50,-0.75,-0.75,35,0.75,0.75 }
				velocity { box 600,-12,-12,500,12,12 }
				size { box 2,2,1,1 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 4,4,3,3 }
				fade { line 0.25,0.5 }
			}
		}
	}
	spawner "foam"
	{
		start		0.08,0.08
		count		5,8

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/fluids_drips/foam"
			gravity		0.65,1.25

			start
			{
				position { line 85,-1,-1,50,1,1 }
				velocity { box 425,-1,-1,450,1,1 }
				size { point 0.5,50 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
			}

			end
			{
				size { box 100,500,100,100 }
				fade { line 0.25,0.12 }
			}
		}
	}
	emitter "half_bubbles_foam"
	{
		start		0.75,1
		duration	0.12,1
		count		40,50

		sprite
		{
			duration	0.65,0.65
			material	"gfx/effects/fluids_drips/bubble_half"

			start
			{
				position { cylinder 0,-75,75,0,75,-75 }
				velocity { box 0,-1,-1,0,1,1 }
				fade { point 0 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope pop_drop_grow }
			}

			end
			{
				size { point 6,6 }
				fade { point 1 }
			}
		}
	}
	spawner "splash_foam"
	{
		count		5,6

		line
		{
			duration	0.5,1
			material	"gfx/effects/fluids_drips/splash_line_alpha"

			start
			{
				position { cylinder -10,-0.05,-0.05,-10,0.05,0.05 surface }
				size { point 10 }
				fade { point 0 }
				length { box 25,-12,-12,25,12,12 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { point 25 }
				fade { line 0.25,0.12 }
				length { box 100,-25,-25,150,25,25 }
			}
		}
	}
	spawner "shockwave_inner"
	{
		count		2,2

		oriented
		{
			duration	0.65,0.65
			material	"gfx/effects/particles_shapes/shockwave_alpha"

			start
			{
				position { point 0.05,0,0 }
				size { point 10,10 }
				fade { line 0.5,0.12 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	spawner "drops_motion_physics"
	{
		count		10,12

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		1,1.5
			generatedOriginNormal

			start
			{
				position { cylinder 25,-0.05,-0.05,12,0.05,0.05 }
				velocity { box 300,-200,-200,350,200,200 }
				size { point 2,2 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { point 0.25,0.25 }
				fade { line 1,0.75 }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/drip_ring"
			}
		}
	}
}


