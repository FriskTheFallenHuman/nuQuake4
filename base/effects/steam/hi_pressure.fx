effect effects/steam/hi_pressure
{
	size	290

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "steamcore"
	{
		duration	1,1
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 33 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "end"
	{
		duration	1,1
		count		1,3

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 100,-15,-15,150,15,15 }
				size { box 70,70,90,90 }
				tint { point 0.815686,0.803922,0.74902 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,130,130 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "start"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-3,-3,8,3,3 }
				size { box 1,1,2,2 }
				tint { line 0.760784,0.74902,0.705882,0.682353,0.74902,0.635294 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 9,9,12,12 }
				fade { point 0.4 }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		7,9

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.02,0.06

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-10,-10,110,10,10 }
				size { box 2,2,10,10 }
				tint { line 0.803922,0.8,0.756863,0.729412,0.776471,0.639216 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 70,70,90,90 }
				fade { point 0.3 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}





