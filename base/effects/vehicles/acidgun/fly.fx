effect effects/vehicles/acidgun/fly
{
	size	69

	spawner "unnamed0"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	5,5
			blend	add
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 1,0,0 }
				size { line 7,7,9,9 }
				tint { point 0.501961,0.501961,0 }
				fade { point 0.75 }
				rotate { box -3,4 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	5,5
			blend	add
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				size { line 6,6,8,8 }
				tint { point 0.501961,0.501961,0 }
				fade { point 0.75 }
				rotate { box -1,0 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	emitter "source1"
	{
		duration	0.25,0.25
		count		12,12

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.05,0.1

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 25,-3,-3,75,3,3 }
				size { line 2,2,5,5 }
				tint { point 0.501961,0.501961,0 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 35,35,25,25 }
				fade { line 0.15,0.3 }
			}
		}
	}
}


