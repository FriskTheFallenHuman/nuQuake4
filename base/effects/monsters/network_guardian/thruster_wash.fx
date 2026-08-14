effect effects/monsters/network_guardian/thruster_wash
{
	size	490

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
				acceleration { box -200,-200,-200,-200,200,200 }
				size { point 40,40 }
				tint { point 0.717647,0.658824,0.52549 }
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
				tint { point 0.266667,0.262745,0.243137 }
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
				size { point 35 }
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
				velocity { point 250,0,0 }
				size { point 35 }
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
				size { point 65 }
				tint { point 1,0.501961,0 }
				fade { point 0.2 }
				length { point 250,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 80 }
				length { point 400,0,0 }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		17,17

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { sphere 300,-5,-5,300,5,5 }
				velocity { box 200,-50,-50,200,50,50 }
				acceleration { box -200,-350,-350,-200,350,350 }
				size { point 50,50 }
				tint { line 1,1,1,1,0.501961,0.247059 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "arch" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
				fade { point 1 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"network_guardian_jetfire2"
		volume	0.8,0.8
		freqshift	2,2
	}
	sound "unnamed6"
	{
		soundShader	"network_guardian_fly_loop"
	}
}



