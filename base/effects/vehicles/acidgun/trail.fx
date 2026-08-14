effect effects/vehicles/acidgun/trail
{
	size	58

	emitter "spray"
	{
		duration	1,1
		count		100,100

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.12,0.25

			start
			{
				position { point 1,0,0 }
				velocity { box 75,-25,-100,125,25,100 }
				size { line 1,1,3,3 }
				tint { line 0.403922,0.572549,0.054902,0.501961,0.501961,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fade }
			}

			end
			{
				size { line 0.25,0.25,0.5,0.5 }
				fade { point 1 }
			}
		}
	}
	emitter "unnamed0"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 1,0,0 }
				size { box 15,15,25,25 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -3,4 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
}


