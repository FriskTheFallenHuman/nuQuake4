effect effects/vehicles/thrust2
{
	size	134

	emitter "smoke"
	{
		duration	1,1
		count		16,16

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				size { point 45,45 }
				tint { point 0.721569,0.803922,0.803922 }
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
				fade { point 0.25 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "line_inner"
	{
		duration	1,1
		count		15,15
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { line -2,-5,-5,-2,5,5 }
				size { box 10,30 }
				tint { line 0.501961,0.501961,0.501961,0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				length { box 50,0,0,100,0,0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"convoy_large_ship_loop1"
	}
	sound "unnamed5"
	{
		soundShader	"convoy_jetfire2"
	}
	emitter "side_streaks2"
	{
		duration	1,1
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
				size { box 5,10 attenuate }
				tint { line 0.752941,0.752941,0.752941,0.34902,0.34902,0.776471 }
				fade { point 0 attenuate }
				offset { point -3,0,0 }
				length { box 10,0,0,20,0,0 attenuate }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 attenuate }
				length { box 50,0,0,80,0,0 attenuate }
			}
		}
	}
	emitter "line_inner2"
	{
		duration	1,1
		count		10,10
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { point -2,0,0 }
				size { point 5 }
				fade { point 0.5 }
				length { box 80,0,0,120,0,0 }
			}
		}
	}
}
