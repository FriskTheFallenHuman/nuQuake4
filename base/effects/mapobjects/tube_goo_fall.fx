effect effects/mapobjects/tube_goo_fall
{
	size	336

	emitter "steam"
	{
		duration	1,1
		count		8,20

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.125,1

			start
			{
				position { line 0,0,0,20,0,0 }
				size { point 50,50 }
				tint { line 0.54902,1,1,0,0.909804,0.658824 }
				fade { line 0.5,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear offset 0.5,0.5 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
				rotate { box -0.222222,0.222222 relative }
			}

			impact
			{
				remove	1
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		3,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.025,1

			start
			{
				position { line 0,0,0,20,0,0 }
				size { point 20,20 }
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
	spawner "unnamed4"
	{
		count		50,50

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal

			start
			{
				position { cylinder 45.5,-15,-15,45.5,15,15 surface }
				size { box 1,5 }
				tint { line 0.109804,1,0.419608,0.501961,1,1 }
				offset { point -55,0,0 }
				length { point 20,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 20 }
				length { box 100,0,0,120,0,0 }
			}
		}
	}
}

