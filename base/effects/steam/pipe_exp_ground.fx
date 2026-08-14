effect effects/steam/pipe_exp_ground
{
	size	1133

	spawner "steam4"
	{
		start		0.25,0.25
		count		20,20

		sprite
		{
			duration	1,5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.125,-0.0125

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				size { line 100,100,0,0 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				offset { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 300,300,500,500 }
				fade { line 0.25,0.75 }
				offset { box 0,-300,-300,0,300,300 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
}
