effect effects/monsters/berserker/gut_hit
{
	size	478

	spawner "blood"
	{
		detail		0.5
		count		8,8

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.509804,0.164706,0.0666667,0.384314,0.121569,0.0509804 }
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
				size { line 10,10,20,20 }
				fade { point 1 }
			}
		}
	}
	spawner "blood2"
	{
		count		4,10

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,200,0,0 }
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
				size { line 50,50,100,100 }
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
				position { cylinder -0.25,-0.3,-0.3,-0.25,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 6,8 }
				tint { line 0.8,0,0,0.509804,0.164706,0.0666667 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 70,0,0,75,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "blood_rear"
	{
		count		6,6

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05
			flipNormal

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.639216,0.0470588,0.0470588,0.384314,0.121569,0.0509804 }
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
				size { line 30,30,50,50 }
				fade { point 1 }
			}
		}
	}
	emitter "blood_streaks2"
	{
		detail		0.5
		duration	1,1
		count		4,6
		locked

		line
		{
			duration	0.15,0.25
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 6,8 }
				tint { point 0.509804,0.168627,0.0666667 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 40,0,0,50,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "unnamed13"
	{
		detail		0.5
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_gib_rup_leg"

			start
			{
				velocity { box 100,-20,-20,600,20,20 }
				fade { point 1 attenuate }
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
				position { point 10,0,0 }
				velocity { point 1000,0,0 }
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



