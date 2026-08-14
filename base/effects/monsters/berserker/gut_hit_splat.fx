effect effects/monsters/berserker/gut_hit_splat
{
	size	142

	emitter "spread"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	10,10
			persist
			material	"textures/decals/bloodspread2"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	emitter "blood_streaks2"
	{
		duration	1,1
		count		4,20
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.29,-0.3,-0.3,-0.29,0.3,0.3 }
				velocity { point 1,0,0 }
				size { box 6,8 }
				tint { point 0.713726,0.0941177,0.0941177 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 20,0,0,50,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "splat"
	{
		count		5,5

		sprite
		{
			duration	1,1
			material	"textures/decals/dsplat2"
			entityDef	"debris_gib_rup_leg"
			gravity		0.5,0.5
			generatedOriginNormal

			start
			{
				position { point 10,0,0 }
				velocity { box 100,-100,-100,100,100,100 }
				rotate { line 0,1 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/gib_splat_sm"
			}
		}
	}
	spawner "unnamed3"
	{
		count		10,10

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/gore_spray/bloodhit4"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 50,-50,-50,80,50,50 }
				size { point 30,30 }
				tint { line 0.388235,0.0784314,0.0784314,0.262745,0.054902,0.054902 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}
		}
	}
}



