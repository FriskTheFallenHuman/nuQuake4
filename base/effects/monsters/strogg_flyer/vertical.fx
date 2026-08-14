effect effects/monsters/strogg_flyer/vertical
{
	size	371

	emitter "smoke"
	{
		duration	1,1
		count		5,10

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 200,-50,-50,300,50,50 }
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
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 1 }
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
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -2,0,0 }
				size { point 25 }
				tint { point 0.439216,0.439216,0.439216 }
				fade { point 0.5 }
				offset { point -20,0,0 }
				length { box 100,-5,-5,150,5,5 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"convoy_large_ship_loop1"
		freqshift	0.5,0.5
	}
	sound "unnamed5"
	{
		soundShader	"convoy_jetfire2"
	}
	emitter "side_streaks2"
	{
		duration	1,1
		count		10,10
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 surface }
				size { box 10,20 }
				tint { line 1,1,1,1,0.501961,0.25098 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 }
				length { box 100,0,0,150,0,0 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 1,0,0 }
				size { point 30,30 }
				tint { line 1,1,0.501961,1,0.501961,0.25098 }
				fade { point 0.25 }
			}
		}
	}
	emitter "unnamed7"
	{
		duration	1,1
		count		1,100

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 1,0,0 }
				velocity { box 0,0,0,200,0,0 }
				size { point 50,50 }
				tint { line 1,1,0.501961,1,0.501961,0.25098 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
}

