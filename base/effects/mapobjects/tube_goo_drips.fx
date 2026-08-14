effect effects/mapobjects/tube_goo_drips
{
	size	336

	emitter "steam2"
	{
		duration	1,1
		count		5,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.5,0.5

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { line 5,5,15,15 }
				tint { line 0,0.909804,0.909804,0,0.909804,0.658824 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.222222,0.222222 relative }
			}

			impact
			{
				remove	1
			}
		}
	}
	spawner "unnamed2"
	{
		count		5,5

		line
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodline1"
			gravity		0.0125,0.0125

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { box 1,10 }
				tint { line 0.509804,1,1,0.156863,1,0.580392 }
				offset { point -15,0,0 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 100,0,0,300,0,0 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		5,5

		line
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodline1"
			gravity		0.25,0.5

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { box 1,5 }
				tint { line 0.509804,1,1,0.156863,1,0.580392 }
				fade { point 0.75 }
				offset { point -15,0,0 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 100,0,0,300,0,0 }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1,3
			material	"gfx/effects/gore_spray/bloodline1"

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { box 1,5 }
				tint { line 1,1,1,0.501961,1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 8 }
				length { box 100,0,0,120,0,0 }
			}
		}
	}
}
