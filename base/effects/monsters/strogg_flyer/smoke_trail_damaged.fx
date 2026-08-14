effect effects/monsters/strogg_flyer/smoke_trail_damaged
{
	size	255

	emitter "smoke"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				size { point 70,70 }
				tint { point 0.364706,0.32549,0.27451 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 180,180 }
				fade { point 0.75 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
}



