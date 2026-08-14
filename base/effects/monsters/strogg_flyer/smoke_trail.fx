effect effects/monsters/strogg_flyer/smoke_trail
{
	size	326

	emitter "smoke"
	{
		duration	1,1
		count		16,16

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 0,-50,-50,0,50,50 }
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
				fade { point 0.35 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.1,0.2
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 0,-50,-50,0,50,50 }
				size { point 90,90 }
				tint { point 0.411765,0.356863,0.639216 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
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
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.5 }
				length { box 200,0,0,300,0,0 }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	1,1
		count		40,40
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 surface }
				size { box 30,40 }
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
				length { box 100,0,0,200,0,0 }
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
}








