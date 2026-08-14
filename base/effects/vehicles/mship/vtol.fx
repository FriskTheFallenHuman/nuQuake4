effect effects/vehicles/mship/vtol
{
	size	381

	emitter "smoke"
	{
		duration	1,1
		count		16,16

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 400,-50,-50,600,50,50 }
				size { point 45,45 }
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
				size { point 100,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.35 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
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
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder 28,-30,-30,28,30,30 surface }
				size { box 10,20 attenuate }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0 attenuate }
				offset { point -25,0,0 }
				length { box 10,0,0,20,0,0 attenuate }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 attenuate }
				length { box 100,0,0,200,0,0 attenuate }
			}
		}
	}
	emitter "line_inner"
	{
		duration	1,1
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { cylinder -2,-25,-25,-2,25,25 surface }
				velocity { box 10,0,0,50,0,0 }
				size { box 10,20 }
				tint { line 0.501961,0.501961,0.501961,0.74902,0.74902,0.74902 }
				fade { point 0.5 }
				offset { point -20,0,0 }
				length { box 100,0,0,150,0,0 }
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
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -2,0,0 }
				size { point 50 }
				offset { point -30,0,0 }
				length { box 250,0,0,300,0,0 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	1,1
		count		1,1
		locked

		oriented
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				size { point 200,200 }
				tint { point 0.752941,0.752941,0.752941 }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"mcc_landing_vtol"
	}
}

