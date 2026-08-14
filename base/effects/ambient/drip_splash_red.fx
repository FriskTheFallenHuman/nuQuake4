effect effects/ambient/drip_splash_red
{
	size	31

	sound "sound"
	{
		soundShader	"effects_liquiddrip_small_quiet"
	}
	spawner "drops_motion"
	{
		count		5,6

		sprite
		{
			duration	0.25,1
			material	"gfx/effects/fluids_drips/bubble_red"
			gravity		0.1,0.5

			start
			{
				position { cylinder 2,-3,-3,2,3,3 }
				velocity { box 25,-25,-25,50,25,25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "splat"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_red2"

			start
			{
				size { point 6,6 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}


