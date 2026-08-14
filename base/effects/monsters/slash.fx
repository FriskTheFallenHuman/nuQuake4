effect effects/monsters/slash
{
	size	527

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
				velocity { box 20,-50,-50,50,50,50 }
				size { line 5,5,10,10 }
				tint { line 0.239216,0,0,0.392157,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" count 2 offset -1 }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,50,50 }
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
				velocity { box 50,-50,-50,100,50,50 }
				size { line 10,10,20,20 }
				tint { line 0.313726,0,0,0.576471,0.0901961,0.0901961 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 25,25,30,30 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "splat"
	{
		count		100,100

		sprite
		{
			duration	0.15,0.15
			persist
			material	"textures/decals/dsplat2"

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { box 4000,-500,-500,4000,500,500 }
				size { point 50,50 }
				rotate { box 0,1 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/gib_splat_sm"
			}
		}
	}
}

