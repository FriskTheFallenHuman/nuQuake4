effect effects/levels/recomp_bubble
{
	size	319

	emitter "bubbles"
	{
		duration	1,1
		count		30,30

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_green_half"

			start
			{
				position { sphere 1,-200,-200,1,200,200 }
				size { point 0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "bubbles2"
	{
		duration	1,1
		count		25,25

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_additive"

			start
			{
				position { sphere 1,-200,-200,1,200,200 }
				size { point 0,0 }
				tint { line 0.164706,0.337255,0.156863,0.305882,0.309804,0.14902 }
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
		count		20,20

		oriented
		{
			duration	3,5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.01,-0.01

			start
			{
				position { sphere 1,-150,-150,1,150,150 }
				size { point 10,10 }
				tint { line 0.32549,0.32549,0.32549,0.266667,0.270588,0.160784 }
				fade { line 0.25,0.5 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine offset 0.54 }
			}

			end
			{
				size { box 100,100,150,150 }
				tint { point 0.152941,0.14902,0.129412 }
			}
		}
	}
}

