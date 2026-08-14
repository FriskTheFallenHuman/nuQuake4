effect effects/smoke/smallsmoke_16
{
	size	36

	emitter "steam1"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	2.5,3
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.01,-0.005

			start
			{
				position { point 5,0,0 }
				velocity { box 0,-5,0,0,5,0 }
				size { box 6,6,10,10 }
				tint { line 0.854902,0.807843,0.654902,0.713726,0.658824,0.537255 }
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
				size { box 15,15,20,20 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
