effect effects/monsters/gib2
{
	size	299

	spawner "drops"
	{
		count		17,17

		line
		{
			duration	0.7,1
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.25,0.35

			start
			{
				position { line -10,-10,-10,10,10,10 }
				velocity { box -50,-90,0,-400,90,250 }
				size { box 10,20 }
				tint { line 0.392157,0,0,0.243137,0,0 }
				length { point 30,0,0 }
			}

			motion
			{
				fade { envelope linear count 3 offset -2 }
				length { envelope linear }
			}

			end
			{
				length { box 40,0,0,80,0,0 }
			}
		}
	}
	spawner "big_squirt"
	{
		start		0,0.2
		count		3,3

		line
		{
			duration	0.2,0.3
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodspray"
			gravity		0.3,0.3

			start
			{
				position { line -5,-5,-5,5,5,5 }
				velocity { box -550,-120,-50,-600,120,200 }
				size { point 3 }
				tint { line 1,1,1,0.827451,0.0470588,0.0470588 }
				fade { line 0.5,0.6 }
				length { point 10,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				length { envelope exp_1minusx/x2 count 0.5,1,1 }
			}

			end
			{
				size { box 5,7 }
				length { box 100,0,0,150,0,0 }
			}
		}
	}
	spawner "small_squirt"
	{
		start		0,0.2
		count		5,5

		line
		{
			duration	0.4,0.4
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodspray"
			gravity		0.04,0.1

			start
			{
				position { line -5,-5,-5,5,5,5 }
				velocity { box -300,-100,-50,-550,100,100 }
				size { box 3,5 }
				tint { line 1,1,1,0.831373,0.0313726,0.0313726 }
				fade { line 0.5,0.7 }
				length { box 5,0,0,10,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				length { envelope exp_1minusx/x2 count 0.5,1,1 }
			}

			end
			{
				size { box 5,10 }
				length { box 30,0,0,80,0,0 }
			}
		}
	}
	spawner "fast_squirt"
	{
		start		0,0.2
		count		2,2

		line
		{
			duration	0.3,0.5
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodspray"
			gravity		0.15,0.24

			start
			{
				position { line -5,-5,-5,5,5,5 }
				velocity { box -400,-100,-50,-500,100,150 }
				size { box 4,5 }
				tint { line 1,1,1,0.921569,0.054902,0.054902 }
				fade { line 0.6,0.7 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 3 offset -2 }
				length { envelope exp_1minusx/x2 count 0.5,1,1 }
			}

			end
			{
				size { point 8 }
				length { box 50,0,0,100,0,0 }
			}
		}
	}
	spawner "rev_drops"
	{
		count		8,8

		sprite
		{
			duration	0.3,0.6
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.1,0.3

			start
			{
				velocity { box 20,-50,-50,100,50,150 }
				size { line 20,20,25,25 }
				tint { line 0.243137,0,0,0.392157,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "mist"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.9
			persist
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		0.2,0.4

			start
			{
				velocity { box 50,-50,0,-350,50,100 }
				size { line 30,30,40,40 }
				tint { line 0.313726,0,0,0.576471,0.0901961,0.0901961 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 70,70,90,90 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "splat"
	{
		duration	0.1,0.1
		count		100,100

		sprite
		{
			duration	0.15,0.15
			persist
			material	"textures/decals/dsplat2"
			generatedOriginNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { point 4000,0,0 }
				size { point 25,25 }
				rotate { line 0,1 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/gib_splat"
			}
		}
	}
}


