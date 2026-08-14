effect effects/monsters/fatty/stroy_spray
{
	size	683

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
				tint { line 0.501961,1,0.501961,0,0.835294,0 }
				offset { point 130,0,0 }
				length { box 150,150,150,300,300,300 }
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
	emitter "start"
	{
		duration	3,3
		count		8,8

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha_depth"

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-3,-3,20,3,3 }
				size { box 1,1,2,2 }
				tint { line 0.756863,0.74902,0.701961,0.682353,0.74902,0.631373 }
				fade { point 0 }
				offset { point 130,0,0 }
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
				size { box 12,12,20,20 }
				fade { point 0.4 }
			}
		}
	}
	emitter "steam"
	{
		duration	3,3
		count		7,9

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.02,0.06

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-10,-10,200,10,10 }
				size { box 2,2,10,10 }
				tint { point 0.501961,1,0.501961 }
				fade { point 0 }
				offset { point 130,0,0 }
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

