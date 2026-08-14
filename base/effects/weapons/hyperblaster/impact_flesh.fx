effect effects/weapons/hyperblaster/impact_flesh
{
	size	69

	emitter "smoke"
	{
		detail		0.5
		duration	0.2,0.2
		count		35,35

		sprite
		{
			duration	0.8,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,5,0,0 }
				velocity { box 0,-4,-4,20,4,4 }
				size { line 1,1,3,3 }
				tint { line 0.45098,0.8,0.572549,0.713726,0.803922,0.905882 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 4,4,6,6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood"
	{
		detail		0.5
		count		4,4

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,80,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.25098,0.0352941,0.0352941,0.156863,0,0 }
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
				fade { line 1,0.5 }
			}
		}
	}
	spawner "blood2"
	{
		count		3,3

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,30,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.25098,0.0352941,0.0352941,0.156863,0,0 }
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
				size { line 20,20,25,25 }
				fade { line 1,0.5 }
			}
		}
	}
	spawner "blood_streaks"
	{
		detail		0.5
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
				tint { point 0.278431,0.0392157,0.0392157 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 30,0,0,35,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "blood_rear"
	{
		count		3,3

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05
			flipNormal

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.25098,0.0352941,0.0352941,0.156863,0,0 }
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
				fade { line 1,0.5 }
			}
		}
	}
	spawner "impact_flash"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 3,3 }
			}

			motion
			{
				fade { envelope "exp_x2" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 1.5 }
				length { box 4,0,0,6,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}



