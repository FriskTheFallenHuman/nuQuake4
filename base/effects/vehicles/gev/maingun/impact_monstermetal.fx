effect effects/vehicles/gev/maingun/impact_monstermetal
{
	size	288

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
				size { line 100,100,200,200 }
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
				size { line 100,100,200,200 }
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
				length { box 180,0,0,220,0,0 }
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
	spawner "sparks_trails"
	{
		count		6,6

		sprite
		{
			duration	0.3,0.6
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		1,1
			trailType	motion
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box -500,-500,-500,500,500,500 }
				size { box 6,6,10,10 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 3,3 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
}
