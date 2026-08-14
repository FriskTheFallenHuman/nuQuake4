effect effects/weapons/gauntlet/impact_monstermetal
{
	size	93

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	emitter "smoke2"
	{
		duration	0.25,0.25
		count		7,9

		sprite
		{
			duration	1,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.05,0.05

			start
			{
				velocity { box 10,-5,-5,60,5,5 }
				acceleration { point -20,0,0 }
				size { line 1,3,2,4 }
				tint { point 0.403922,0.411765,0.384314 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 15,15,25,25 }
				tint { point 0.176471,0.176471,0.168627 }
			}
		}
	}
	emitter "sparks_trails2"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.35,0.5
			persist
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 50,-150,-150,300,150,150 }
				size { box 1,1,2,2 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	emitter "side_streaks3"
	{
		duration	1,1
		count		40,40
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2_flipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.1,-0.2,0.3,0.1 surface }
				velocity { point 1,0,0 }
				size { box 1,3 }
				tint { line 1,0.65098,0.501961,0.74902,0.521569,0.203922 }
				length { box 6,0,0,8,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.921569,0.654902,0.388235,0.956863,0.639216,0.529412 }
				length { box 16,0,0,18,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "flash3"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { box 15,7,20,7 }
				tint { point 1,0.792157,0.666667 }
				rotate { point 0.0416667 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { box 10,5,15,5 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		locked
		constant

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 10,5,14,5 }
				rotate { point 0,0,0.0416667 }
			}
		}
	}
	emitter "blood2"
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
	emitter "blood3"
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
	emitter "blood_streaks2"
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
				fade { envelope "linear" }
				length { envelope "linear" }
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
	emitter "blood_rear2"
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
}


