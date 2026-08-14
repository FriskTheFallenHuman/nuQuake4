effect effects/smoke/firesmoke_64
{
	size	187

	emitter "smoke"
	{
		duration	10,10
		count		5,5

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { point 50,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.290196,0.278431,0.243137,0.309804,0.258824,0.2 }
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
				size { line 50,50,100,100 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}






