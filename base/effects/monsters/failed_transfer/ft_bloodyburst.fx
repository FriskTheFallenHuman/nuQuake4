effect effects/monsters/failed_transfer/ft_bloodyburst
{
	size	165

	spawner "bloody burst2"
	{
		detail		0.5
		count		3,3
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/gore_spray/FT_bloodburst_add"

			start
			{
				position { sphere 0,-3,-3,0,3,3 }
				size { line 8,8,10,10 }
				tint { line 1,1,1,1,0,0 }
				rotate { box -0.138889,0.138889 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 30,30 }
				rotate { box -0.138889,0.138889 }
			}
		}
	}
	spawner "blood mist"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/bloodspray2"

			start
			{
				position { sphere -1,-1,-1,1,1,1 surface }
				velocity { box 20,-30,-20,50,30,20 }
				friction { point 2000,0,0 }
				size { line 5,5,8,8 }
				tint { line 1,0.592157,0.592157,0.501961,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
			}
		}
	}
	spawner "bloody burst"
	{
		count		3,3
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/FT_bloodburst"

			start
			{
				position { sphere 0,-3,-3,0,3,3 }
				size { line 8,8,10,10 }
				tint { line 1,1,1,1,0,0 }
				rotate { box -0.138889,0.138889 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,50,50 }
				rotate { box -0.138889,0.138889 }
			}
		}
	}
	spawner "spray"
	{
		detail		0.5
		count		20,20

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fluids_drips/bubble_red_half"
			gravity		0.5,0.5
			generatedNormal
			flipNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { point 100,100,100 }
				size { point 2,2 }
				rotate { box 0,0.138889 }
			}

			impact
			{
				remove	1
				effect	"effects/damage/blooddrip3"
			}
		}
	}
	emitter "spout"
	{
		detail		0.5
		duration	5,5
		count		20,30
		locked

		line
		{
			duration	0.5,1
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		0.5,0.5
			generatedNormal
			flipNormal

			start
			{
				size { box 1,0.25 }
				fade { point 0 }
				length { box 20,25,20,20,12,20 useEndOrigin }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				size { box 15,5 }
				fade { line 0.25,0.12 }
				length { box 20,200,20,20,50,20 useEndOrigin }
			}
		}
	}
	spawner "bloodspray_enter"
	{
		detail		0.5
		count		3,4

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 1,-6,-6,20,6,6 }
				size { box 0.05,0.05,0.2,0.2 }
				tint { point 0.364706,0.32549,0.27451 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope "linear" count 3,3 }
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { box 4,4,8,8 }
			}
		}
	}
	spawner "bloodspray_exit"
	{
		detail		0.5
		count		3,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"

			start
			{
				position { point -10,0,0 }
				velocity { box 5,-6,-6,60,6,6 }
				size { point 10,10 }
				tint { point 0.603922,0.584314,0.501961 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope "linear" count 0.65,0.65 }
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		7,9
		locked

		line
		{
			duration	0.24,0.24
			generatedLine
			material	"gfx/effects/gore_spray/bloodspray4"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 1,2 }
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 0.364706,0.321569,0.27451 }
				length { box 15,0,0,50,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "spray2"
	{
		detail		0.5
		duration	5,5
		count		20,20
		locked

		sprite
		{
			duration	0.24,0.24
			material	"gfx/effects/fluids_drips/bubble_red_half"
			gravity		0.5,0.5
			generatedNormal
			flipNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { point 1,0,0 }
				size { point 2,2 }
				rotate { box 0,0.138889 }
			}

			impact
			{
				remove	1
				effect	"effects/wounds/blood_splat"
			}
		}
	}
}









