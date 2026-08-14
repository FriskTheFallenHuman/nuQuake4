effect effects/ambient/heart_blood
{
	size	324

	emitter "drips_physics"
	{
		start		0,0.5
		duration	3,3
		count		1,4

		line
		{
			duration	4,4
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.12,0.12

			start
			{
				position { line 100,-50,-50,100,50,50 }
				size { box 6,12 }
				fade { point 0 }
				length { box 12,0,0,6,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 1 }
				length { box 200,0,0,250,0,0 }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/slime_splash_red"
			}
		}
	}
	emitter "drips_center"
	{
		start		0,0.5
		duration	3,3
		count		1,2

		line
		{
			duration	1,2
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.12,0.25

			start
			{
				position { line 0,-75,-75,0,75,75 }
				size { box 6,12 }
				fade { point 0 }
				length { box 100,0,0,25,0,0 }
			}

			motion
			{
				fade { envelope pop_hold_fade }
				length { envelope linear }
			}

			end
			{
				fade { point 1 }
				length { box 200,0,0,250,0,0 }
			}
		}
	}
	emitter "blood_left"
	{
		start		0,0.5
		duration	3,3
		count		1,3

		line
		{
			duration	2,4
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.01,0.12

			start
			{
				position { line -100,0,-75,-125,0,-100 }
				size { box 5,12 }
				fade { point 0 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope popoverextreme_hold_fade }
			}

			end
			{
				fade { point 1 }
				length { box 0,0,0,25,0,0 }
			}
		}
	}
	emitter "blood_right"
	{
		start		0,0.5
		duration	3,3
		count		1,3

		line
		{
			duration	2,4
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		0.01,0.12

			start
			{
				position { line -100,0,145,-125,0,100 }
				size { box 5,12 }
				fade { point 0 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope popoverextreme_hold_fade }
			}

			end
			{
				fade { point 1 }
				length { box 0,0,0,25,0,0 }
			}
		}
	}
}


