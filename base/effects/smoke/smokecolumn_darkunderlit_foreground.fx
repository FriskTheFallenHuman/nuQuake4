effect effects/smoke/smokecolumn_darkunderlit_foreground
{
	size	7042

	emitter "smoke"
	{
		duration	3,3
		count		10,10

		sprite
		{
			duration	20,20
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.06,-0.06

			start
			{
				velocity { box 0.001,50,50,0.001,100,100 }
				angle { box 0,0,0,1,1,1 }
				size { box 512,512,768,768 }
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
				size { box 2048,2048,4092,4092 }
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
			duration	10,10
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.06,-0.06

			start
			{
				velocity { box 0.001,50,50,0.001,100,100 }
				size { line 512,512,768,768 }
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
				size { line 2048,2048,4096,4096 }
				fade { point 0.2 }
			}
		}
	}
}

