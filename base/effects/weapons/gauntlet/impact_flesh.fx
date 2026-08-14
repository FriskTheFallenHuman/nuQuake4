effect effects/weapons/gauntlet/impact_flesh
{
	size	64

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	emitter "blood"
	{
		duration	0.25,0.25
		count		16,16

		sprite
		{
			duration	0.6,0.8
			persist
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.509804,0.168627,0.0666667,0.384314,0.12549,0.0509804 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 10,10,20,20 }
				fade { point 1 }
			}
		}
	}
	emitter "blood2"
	{
		duration	0.25,0.25
		count		8,8

		sprite
		{
			duration	0.6,0.8
			persist
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.05,0.05

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 10,0,0,50,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.588235,0.172549,0.172549,0.509804,0.168627,0.0666667 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 10,10,20,20 }
				fade { point 1 }
			}
		}
	}
	emitter "blood_streaks"
	{
		duration	0.25,0.25
		count		8,12

		line
		{
			duration	0.15,0.25
			generatedLine
			persist
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.6,-0.6,-0.2,0.6,0.6 surface }
				velocity { point 1,0,0 }
				size { box 6,8 }
				tint { point 0.509804,0.168627,0.0666667 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 20,0,0,25,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "blood_rear"
	{
		duration	0.25,0.25
		count		12,12

		sprite
		{
			duration	0.6,0.8
			persist
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05
			flipNormal

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.509804,0.168627,0.0666667,0.384314,0.12549,0.0509804 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 10,10,20,20 }
				fade { point 1 }
			}
		}
	}
}

