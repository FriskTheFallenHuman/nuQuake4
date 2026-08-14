effect effects/ambient/single_drip
{
	size	105

	emitter "snot_line"
	{
		start		0,0.5
		duration	1,1
		count		4,4

		line
		{
			duration	3,4
			material	"gfx/effects/fluids_drips/brown_drop"

			start
			{
				position { line 0,1,0,0,-1,0 }
				size { point 0.25 }
				length { box 10,0,0,25,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 3,4 }
				length { box 50,0,0,100,0,0 }
			}
		}
	}
	emitter "drops_physics"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	2,3
			material	"gfx/effects/fluids_drips/brown_drop"
			gravity		0.1,0.2

			start
			{
				position { line -0.05,-0.05,0,0.05,-0.05,0 }
				size { point 5 }
				length { point 25,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 7 }
				length { point 10,0,0 }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/drip_splash"
			}
		}
	}
	emitter "drops"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1.5,2
			material	"gfx/effects/fluids_drips/brown_drop"
			gravity		0.02,0.35

			start
			{
				position { line -0.05,-0.05,0,0.05,-0.05,-1 }
				size { point 5 }
				length { point 25,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 7 }
				length { point 20,0,0 }
			}
		}
	}
}



