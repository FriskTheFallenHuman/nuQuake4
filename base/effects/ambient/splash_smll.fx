effect effects/ambient/splash_smll
{
	size	199

	sound "sound"
	{
		soundShader	"ambient_water_splash_small"
	}
	spawner "streaks"
	{
		count		5,5

		line
		{
			duration	0.18,0.25
			material	"gfx/effects/fluids_drips/splash_line_alpha"

			start
			{
				position { cylinder -10,-0.05,-0.05,-10,0.05,0.05 }
				size { point 4 }
				fade { point 0 }
				length { box 3,-1,-1,3,1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { point 12 }
				fade { line 0.25,0.12 }
				length { box 65,-8,-8,75,8,8 }
			}
		}
	}
	spawner "drops_motion_outer"
	{
		count		8,12

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 25,-0.05,-0.05,12,0.05,0.05 }
				velocity { box 200,-75,-75,250,75,75 }
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
				fade { line 0.25,0.75 }
			}
		}
	}
	spawner "drops_motion_inner"
	{
		count		12,15

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.35,1
			generatedOriginNormal

			start
			{
				position { cylinder 5,-0.75,-0.75,20,0.75,0.75 }
				velocity { box 250,-3,-3,200,3,3 }
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
				fade { line 0.25,0.12 }
			}
		}
	}
	spawner "mist_lines"
	{
		start		0.12,0.12
		count		5,5

		line
		{
			duration	1,1.12
			material	"gfx/effects/fluids_drips/foam"
			gravity		0.03,0.1

			start
			{
				position { cylinder 0,-0.05,-0.05,-20,0.05,0.05 }
				velocity { point 25,0,0 }
				size { point 0.5 }
				fade { point 0 }
				length { box 12,1,1,50,-1,-1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				size { point 20 }
				fade { line 0.25,0.35 }
				length { box 1,-30,-30,1,30,30 }
			}
		}
	}
	emitter "half_bubbles_foam"
	{
		start		0.75,1
		duration	0.12,0.25
		count		20,30

		sprite
		{
			duration	0.65,0.65
			material	"gfx/effects/fluids_drips/bubble_half"

			start
			{
				position { cylinder 0,-30,-30,0,30,30 }
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
				size { point 3,3 }
				fade { point 1 }
			}
		}
	}
	spawner "impact_mist"
	{
		count		12,15
		locked

		line
		{
			duration	0.12,0.12
			material	"gfx/effects/fluids_drips/foam"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				fade { point 0 }
				length { box 1,5,5,1,-5,-5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				size { point 3 }
				fade { line 0.12,0.25 }
				length { box 12,-10,-10,12,10,10 }
			}
		}
	}
	spawner "center"
	{
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/particles_shapes/shockwave_alpha"

			start
			{
				position { point 0.05,0,0 }
				size { point 6,6 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 8,8 }
				fade { line 0.25,0.45 }
			}
		}
	}
	spawner "drops_motion_physics"
	{
		count		3,4

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 25,-0.05,-0.05,12,0.05,0.05 }
				velocity { box 200,-90,-90,250,90,90 }
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


