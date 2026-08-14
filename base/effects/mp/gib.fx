effect effects/mp/gib
{
	size	762

	sound "sound"
	{
		soundShader	"effects_walker_squish"
	}
	spawner "splat"
	{
		count		4,4

		sprite
		{
			duration	0.12,0.12
			material	"textures/decals/dsplat2"
			generatedOriginNormal

			start
			{
				position { cylinder -1,-1,-1,1,1,1 }
				velocity { point 5000,0,0 }
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
	spawner "blood"
	{
		count		3,3

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,80,0,80 }
				size { line 50,50,60,60 }
				tint { line 0.0745098,0.00784314,0.00784314,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood2"
	{
		count		3,3

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,40,0,80 }
				size { line 50,50,60,60 }
				tint { line 0.117647,0.0156863,0.0156863,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood_rear"
	{
		count		3,3

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05
			flipNormal

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,80,0,80 }
				size { line 50,50,60,60 }
				tint { line 0.0666667,0,0,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		25,25
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 15,20 }
				tint { point 0.309804,0.101961,0.0431373 }
				length { box 40,0,0,45,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 0.14902,0.0509804,0.0156863 }
				length { box 150,0,0,200,0,0 }
			}
		}
	}
	spawner "blood3"
	{
		count		24,24

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05
			trailType	motion
			trailTime	0.8,0.8
			trailCount	50,50
			trailMaterial	"gfx/effects/gore_spray/bloodhit3"

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box -900,-900,-900,900,900,900 }
				size { line 20,20,30,30 }
				tint { line 0.0705882,0.00784314,0.00784314,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 40,40,50,50 }
				fade { point 1 }
				rotate { box -1,1 relative }
			}
		}
	}
}
