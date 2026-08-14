effect effects/vehicles/gev/maingun/impact_flesh
{
	size	500

	sound "sound"
	{
		soundShader	"effects_walker_squish"
	}
	spawner "blood"
	{
		count		6,6

		sprite
		{
			duration	0.3,0.5
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				tint { line 0.211765,0.0705882,0.027451,0.156863,0.0509804,0.0156863 }
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
				size { line 250,250,350,350 }
				fade { point 1 }
			}
		}
	}
	spawner "blood2"
	{
		count		2,2

		sprite
		{
			duration	0.3,0.5
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				tint { line 0.219608,0.0627451,0.0627451,0.184314,0.0627451,0.0235294 }
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
				size { line 250,250,350,350 }
				fade { point 1 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		15,15
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
				position { cylinder -0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 20,30 }
				tint { point 0.25098,0.0823529,0.0352941 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 250,0,0,350,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	sound "sound2"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
}
