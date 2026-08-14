effect effects/monsters/fatty/acid_spray_inv
{
	size	308

	emitter "steamcore"
	{
		duration	5.5,5.5
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal
			flipNormal

			start
			{
				tint { line 0.411765,0.478431,0.0196078,0.572549,0.556863,0.486275 }
				length { point 155,125,155 }
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
		duration	5.5,5.5
		count		1,3

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		-0.01,0.01
			generatedOriginNormal
			flipNormal

			start
			{
				position { line -25,0,0,-45,0,0 }
				velocity { box -100,-15,-15,-150,15,15 }
				size { box 70,70,90,90 }
				tint { point 0.607843,0.635294,0.168627 }
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
		duration	5.5,5.5
		count		8,8

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha_depth"
			flipNormal

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-3,-3,20,3,3 }
				size { box 1,1,2,2 }
				tint { line 0.756863,0.74902,0.701961,0.682353,0.74902,0.631373 }
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
				size { box 12,12,20,20 }
				fade { point 0.4 }
			}
		}
	}
	emitter "steam"
	{
		duration	5.5,5.5
		count		7,9

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.02,0.06
			flipNormal

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-10,-10,200,10,10 }
				size { box 2,2,10,10 }
				tint { line 0.803922,0.8,0.756863,0.803922,0.796079,0.611765 }
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
