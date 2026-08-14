effect effects/smoke/smokecolumn_darkunderlit_slow_64
{
	size	473

	emitter "smoke"
	{
		duration	3,3
		count		10,10

		sprite
		{
			duration	15,15
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.00625,-0.00625

			start
			{
				velocity { box 0.001,5,5,0.001,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 16,16,32,32 }
				tint { line 0,0,0,0.203922,0.184314,0.156863 }
				fade { point 0 }
				offset { box 10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 128,128,256,256 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "underlit"
	{
		duration	3,3
		count		1.5,1.5

		sprite
		{
			duration	15,15
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.00625,-0.00625

			start
			{
				velocity { box 0.001,5,5,0.001,10,10 }
				size { line 16,16,32,32 }
				tint { point 1,0.811765,0.458824 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0.277778,0.444444 }
			}

			motion
			{
				size { envelope concavefade }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 128,128,256,256 }
				fade { point 0.2 }
			}
		}
	}
}
