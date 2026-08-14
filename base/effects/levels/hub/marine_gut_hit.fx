effect effects/levels/hub/marine_gut_hit
{
	size	474

	spawner "blood2"
	{
		count		8,10

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 0,0,20,0,0,200 }
				size { line 1,3,1,4 }
				tint { line 0.360784,0.105882,0.105882,0.513726,0.0627451,0.0627451 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 80,80,150,150 }
				fade { point 1 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		4,6
		locked

		line
		{
			duration	0.15,0.25
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.03,-0.3,-0.25,0.03,0.3,-0.25 surface }
				velocity { point 1,0,0 }
				size { box 6,8 }
				tint { line 0.8,0,0,0.509804,0.164706,0.0666667 }
				length { box 0,0,10,0,0,15 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 0,0,70,0,0,75 }
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
			generatedOriginNormal

			start
			{
				position { point -30,0,0 }
				velocity { point 0,0,-1000 }
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
