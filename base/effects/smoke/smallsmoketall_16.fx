effect effects/smoke/smallsmoketall_16
{
	size	29

	emitter "steam1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	5,6
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.01,-0.01

			start
			{
				position { point 5,0,0 }
				angle { box 0,0,0,0.222222,0.222222,0.222222 }
				size { box 3,3,6,6 }
				tint { line 0.854902,0.807843,0.654902,0.713726,0.658824,0.537255 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 10,10,15,15 }
				fade { point 0.15 }
				angle { box -0.222222,-0.222222,-0.222222,0.222222,0.222222,0.222222 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
