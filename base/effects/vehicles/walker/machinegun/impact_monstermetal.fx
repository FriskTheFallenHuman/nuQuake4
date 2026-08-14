effect effects/vehicles/walker/machinegun/impact_monstermetal
{
	size	151

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
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
	spawner "sparks_trails"
	{
		count		3,3

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box 200,-150,-150,300,150,150 }
				size { box 6,6,10,10 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 3,3 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 4,8 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 60,0,0,80,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { box 40,40,60,60 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
}


