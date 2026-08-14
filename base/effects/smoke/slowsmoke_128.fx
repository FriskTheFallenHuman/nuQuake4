effect effects/smoke/slowsmoke_128
{
	size	409

	emitter "smoke"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.06,-0.03

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 5,-2,-2,10,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,120,120 }
				tint { line 0.152941,0.137255,0.121569,0.176471,0.152941,0.133333 }
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
				size { box 200,200,250,250 }
				tint { point 0.156863,0.137255,0.113725 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.06,-0.03

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 5,-2,-2,10,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,120,120 }
				tint { line 0.458824,0.4,0.34902,0.423529,0.372549,0.32549 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0.305556,0.416667 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				size { box 200,200,250,250 }
				tint { point 0.156863,0.137255,0.113725 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}





