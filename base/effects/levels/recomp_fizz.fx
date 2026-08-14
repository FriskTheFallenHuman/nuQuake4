effect effects/levels/recomp_fizz
{
	size	182

	emitter "unnamed0"
	{
		duration	10,10
		count		15,15

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.035,-0.035

			start
			{
				position { cylinder -30,-30,-30,30,30,30 surface }
				angle { box 0,0,-0.194444,0,0,0.194444 }
				size { line 20,20,30,30 }
				tint { line 0.458824,0.458824,0.458824,0.317647,0.352941,0.4 }
				fade { line 0.1,0.25 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_hold_fade }
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
			}

			end
			{
				size { line 80,80,100,100 }
				tint { point 0.537255,0.517647,0.388235 }
				angle { box 0,0,0,0,0,0.194444 relative }
			}
		}
	}
	emitter "bubbles"
	{
		duration	1,1
		count		100,100

		oriented
		{
			duration	0.25,0.5
			material	"gfx/effects/fluids_drips/bubble_green_half"

			start
			{
				position { cylinder 1,-30,-30,1,30,30 surface }
				size { point 0,0 }
				rotate { point 0,-0.0916667,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
	emitter "bubbles2"
	{
		duration	1,1
		count		100,100

		oriented
		{
			duration	0.25,0.5
			material	"gfx/effects/fluids_drips/bubble_additive"

			start
			{
				position { sphere 1,-50,-50,1,50,50 surface }
				size { point 0,0 }
				tint { line 0.164706,0.337255,0.156863,0.301961,0.309804,0.14902 }
				rotate { point 0,-0.0916667,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 2,2,6,6 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		2,2

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/soundwave"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				fade { point 0.25 }
				rotate { point 0,-0.0916667,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 80,50 }
			}
		}
	}
}





