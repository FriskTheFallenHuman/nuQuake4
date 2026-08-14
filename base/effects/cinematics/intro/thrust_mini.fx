effect effects/cinematics/intro/thrust_mini
{
	size	23

	emitter "smoke"
	{
		duration	7.5,7.5
		count		50,50

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				size { point 5,5 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0.1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				tint { point 0.521569,0.47451,0.301961 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	7.5,7.5
		count		10,20
		locked
		attenuateEmitter

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 surface }
				size { box 1,3 attenuate }
				fade { point 0 attenuate }
				offset { point -3,0,0 }
				length { box 5,0,0,8,0,0 attenuate }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 attenuate }
				length { box 10,0,0,15,0,0 attenuate }
			}
		}
	}
	emitter "line_inner2"
	{
		duration	7.5,7.5
		count		10,10
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { point -2,0,0 }
				size { point 2 }
				fade { point 0.5 }
				length { box 15,0,0,20,0,0 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	7.5,7.5
		count		5,5
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/blaster_fly2"

			start
			{
				velocity { point 10,0,0 }
				size { point 3,3 }
				rotate { box -1,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
}






