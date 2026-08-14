effect effects/weapons/machinegun/impact_flesh
{
	size	380

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "blood2"
	{
		detail		0.5
		count		4,4

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,80,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.247059,0.0313726,0.0313726,0.156863,0,0 }
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
				size { line 20,20,40,40 }
				fade { line 1,0.5 }
			}
		}
	}
	spawner "blood3"
	{
		count		3,3

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.2,0.2

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,50,30,0,50 }
				size { line 1,3,2,4 }
				tint { line 0.247059,0.0313726,0.0313726,0.156863,0,0 }
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
				size { line 40,40,80,80 }
				fade { line 1,0.5 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "blood_streaks2"
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
				tint { point 0.27451,0.0392157,0.0392157 }
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
	spawner "blood_rear2"
	{
		count		3,3

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.2,0.2
			flipNormal

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,50,100,0,50 }
				size { line 1,3,2,4 }
				tint { line 0.247059,0.0313726,0.0313726,0.156863,0,0 }
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
				size { line 40,40,80,80 }
				fade { line 1,0.5 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "guts1"
	{
		detail		0.5
		count		4,5

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/gore_spray/bloodhit5"
			gravity		0.5,0.5

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,-120,-20,100,120,160 }
				size { line 1,1,2,2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 5,5,20,20 }
				fade { line 1,0.75 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "guts3"
	{
		detail		0.5
		count		2,3

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/gore_spray/bloodhit6"
			gravity		0.5,0.5

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,-120,-20,100,120,80 }
				size { line 1,1,2,2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 5,5,20,20 }
				fade { line 1,0.75 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
}















