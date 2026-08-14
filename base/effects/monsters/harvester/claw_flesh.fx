effect effects/monsters/harvester/claw_flesh
{
	size	574

	sound "sound"
	{
		soundShader	"harvester_claw_flesh"
		volume	4,4
	}
	spawner "blood"
	{
		count		10,20

		sprite
		{
			duration	0.6,0.8
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.25,0.25

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 200,-100,-100,800,100,100 }
				size { line 10,30,20,40 }
				tint { line 0.509804,0.168627,0.0666667,0.384314,0.12549,0.0509804 }
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
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "blood2"
	{
		count		8,15

		sprite
		{
			duration	0.6,0.8
			persist
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.25,0.25

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 100,-150,-150,500,150,150 }
				size { line 10,30,20,40 }
				tint { line 0.584314,0.168627,0.168627,0.509804,0.164706,0.0666667 }
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
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		20,30

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
				velocity { point 10,0,0 }
				size { box 24,32 }
				tint { point 0.509804,0.164706,0.0666667 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 200,0,0,250,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}



