effect effects/monsters/network_guardian/thruster
{
	size	447

	emitter "smoke"
	{
		duration	1,1
		count		17,17

		sprite
		{
			duration	0.7,1
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 500,0,0,600,0,0 }
				acceleration { box -200,-250,-250,-200,250,250 }
				size { point 40,40 }
				tint { point 0.521569,0.517647,0.439216 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
				tint { point 0.309804,0.270588,0.2 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "line_inner"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -2,0,0 }
				size { point 25 }
				length { point 50,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.5 }
				length { box 300,0,0,350,0,0 }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	1,1
		count		40,40
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { sphere -0.4,-0.13,-0.13,-0.4,0.13,0.13 surface }
				velocity { point 200,0,0 }
				size { point 30 }
				tint { point 0,0,1 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { point 20,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 1,0.501961,0 }
				fade { point 1 }
				length { box 150,0,0,200,0,0 }
			}
		}
	}
	emitter "line_inner2"
	{
		duration	1,1
		count		5,5
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -25,0,0 }
				size { point 50 }
				tint { point 1,0.501961,0 }
				fade { point 0.2 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 70 }
				length { point 350,0,0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"network_guardian_fly_loop"
	}
	sound "unnamed5"
	{
		soundShader	"network_guardian_jetfire1"
		volume	0.6,0.6
		freqshift	2,2
	}
}




