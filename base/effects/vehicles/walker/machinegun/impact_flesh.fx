effect effects/vehicles/walker/machinegun/impact_flesh
{
	size	151

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "blood"
	{
		count		6,6

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
				tint { line 0.243137,0.0784314,0.0352941,0.176471,0.054902,0.0235294 }
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
				size { line 40,40,60,60 }
				fade { point 1 }
			}
		}
	}
	spawner "blood2"
	{
		count		2,2

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,50,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.360784,0.105882,0.105882,0.25098,0.0823529,0.0352941 }
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
				size { line 30,30,40,40 }
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
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 20,30 }
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
				length { box 90,0,0,120,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}


