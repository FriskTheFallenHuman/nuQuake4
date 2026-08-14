effect effects/levels/waste/wastesplash
{
	size	121

	emitter "unnamed3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	3,3
			material	"textures/decals/bloodspread2"

			start
			{
				position { point 1,0,0 }
				tint { point 0.752941,0.752941,0.752941 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope rollingfade count 0.55,0.55 }
				tint { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
			}

			end
			{
				size { point 60,60 }
				tint { point 0.501961,0.501961,0.501961 }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		3,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line 0,0,0,20,0,0 }
				size { point 10,10 }
				tint { line 0.541176,0.0666667,0.0431373,0.337255,0.027451,0.0196078 }
				fade { line 0.5,0.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,60,60 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	0.5,0.5
		count		16,16

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.3,0.4

			start
			{
				position { line 0,0,0,20,0,0 }
				velocity { box 150,-50,-50,200,50,50 }
				size { line 8,8,13,13 }
				tint { line 0.65098,0.0509804,0.0352941,0.482353,0.0156863,0.0156863 }
				fade { point 100 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.333333,0.333333 relative }
			}

			impact
			{
				remove	1
			}
		}
	}
}


