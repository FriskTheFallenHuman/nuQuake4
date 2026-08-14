effect effects/cinematics/intro/vtol
{
	size	24

	emitter "smoke"
	{
		duration	0.75,0.75
		count		16,16

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 20,-5,-5,40,5,5 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 10,10 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.35 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	0.75,0.75
		count		10,20
		locked
		attenuateEmitter

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder 0.25,-0.5,-0.5,0.25,0.5,0.5 surface }
				size { point 0.5 attenuate }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0 attenuate }
				length { box 1,0,0,2,0,0 attenuate }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 attenuate }
				length { box 3,0,0,5,0,0 attenuate }
			}
		}
	}
	emitter "line_inner2"
	{
		duration	0.75,0.75
		count		8,8
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -1,0,0 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				length { point 5,0,0 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	0.75,0.75
		count		5,5
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				velocity { box 0.5,0,0,2,0,0 }
				size { point 3,3 }
				tint { point 0.752941,0.752941,0.752941 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}

