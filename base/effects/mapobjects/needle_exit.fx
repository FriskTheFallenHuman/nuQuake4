effect effects/mapobjects/needle_exit
{
	size	48

	spawner "blood2"
	{
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,30,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.686275,0.0627451,0.0627451,0.52549,0.0509804,0.0509804 }
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
				size { line 8,8,10,10 }
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
				size { box 6,8 }
				tint { point 0.572549,0.00392157,0.00392157 }
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
	spawner "steam1"
	{
		count		5,5

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0125,-0.0125

			start
			{
				position { point 0,0,0 cone }
				velocity { box 1,-1,-1,1,1,1 }
				angle { box 0,0,0,1,0,1 }
				size { box 5,5,10,10 }
				tint { point 0.435294,0.0588235,0.0588235 }
				fade { point 0.35 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,20,20 }
				angle { box -0.5,0,-0.5,0.5,0,0.5 relative }
				rotate { point 0 relative }
			}
		}
	}
	spawner "blood_streaks2"
	{
		count		1,1
		locked

		line
		{
			duration	0.75,0.75
			generatedLine
			material	"gfx/effects/fluids_drips/blood_spit_alpha"

			start
			{
				velocity { point 1,0,0 }
				size { point 3 }
				tint { point 0.572549,0.00392157,0.00392157 }
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
	spawner "blood"
	{
		count		5,5

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,40,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.541176,0.0352941,0.0352941,0.411765,0.0196078,0.0196078 }
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
	sound "unnamed5"
	{
		soundShader	"bullet_impact_flesh"
		freqshift	1.5,1.5
	}
}


