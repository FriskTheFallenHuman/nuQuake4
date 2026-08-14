effect effects/mapobjects/tube_goo_splash
{
	size	284

	emitter "unnamed3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	8,8
			material	"textures/decals/goospread"

			start
			{
				position { point 1,0,0 }
				size { point 50,50 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "steam2"
	{
		count		3,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.025,1

			start
			{
				position { line 0,0,0,20,0,0 }
				velocity { box 100,-50,-50,200,50,50 }
				size { line 20,20,30,30 }
				tint { line 0.54902,1,1,0,0.909804,0.658824 }
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
	spawner "unnamed4"
	{
		count		10,50

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal

			start
			{
				position { cylinder 45.5,-20,-20,45.5,20,20 surface }
				size { box 5,10 }
				tint { line 0.109804,1,0.419608,0.501961,1,1 }
				offset { point -50,0,0 }
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
				size { box 20,30 }
				length { box 10,0,0,120,0,0 }
			}
		}
	}
	spawner "steam"
	{
		count		1,3
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line 0,0,0,20,0,0 }
				velocity { box 0,-100,-100,0,100,100 }
				tint { line 0.54902,1,1,0,0.909804,0.658824 }
				fade { point 0.25 }
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
				size { point 10,10 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}



