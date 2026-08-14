effect effects/levels/waste/scannersmoke
{
	size	104

	emitter "smoke"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.025,-0.015

			start
			{
				position { box -35,-5,-5,25,15,5 }
				velocity { box -2,-2,-2,2,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 4,4,8,8 }
				tint { line 0.129412,0.0941177,0.0784314,0.337255,0.247059,0.211765 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
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
				size { box 20,20,45,45 }
				tint { point 0.203922,0.176471,0.14902 }
				fade { line 0.13,0.32 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}

