effect effects/smoke/slowsmoke_32_solid
{
	size	89

	emitter "smoke"
	{
		duration	1,1
		count		10,15

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.025,-0.015

			start
			{
				velocity { box 0,-10,-10,0,10,10 }
				size { box 5,5,10,10 }
				tint { line 0.129412,0.0941177,0.0784314,0.0470588,0.0470588,0.0470588 }
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
				size { box 20,20,45,45 }
				tint { point 0.203922,0.176471,0.14902 }
				fade { point 0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}
