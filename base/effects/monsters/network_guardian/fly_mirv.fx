effect effects/monsters/network_guardian/fly_mirv
{
	size	111

	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				size { point 5 }
				offset { point -10,0,0 }
				length { point -35,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 4 }
				length { point -30,0,0 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -4,0,0 }
				size { point 20,20 }
				offset { point -10,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	emitter "trail_add"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				angle { box 0,0,0,0.444444,0.444444,0.444444 }
				size { line 40,40,60,60 }
				tint { point 0.611765,0.596078,0.827451 }
				fade { point 0 }
				offset { box 0,-5,-2,0,5,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 35,35 }
				fade { point 0.6 }
				angle { box -0.444444,-0.444444,-0.444444,0.444444,0.444444,0.444444 relative }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	1,1
		count		30,30
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/flash_half"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { box 8,10 }
				tint { point 0.560784,0.482353,1 }
				fade { point 0 }
				offset { point -10,0,0 }
				length { box 32,0,0,35,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 80,0,0,90,0,0 }
			}
		}
	}
	sound "sound1"
	{
		soundShader	"player_rocketlauncher_fly"
	}
	sound "sound2"
	{
		soundShader	"effects_rocket_loop"
		freqshift	0.5,0.5
	}
	emitter "flash2"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -4,0,0 }
				angle { box -1,-1,-1,1,1,1 }
				size { point 10,10 }
				fade { point 0 }
				offset { box 20,-20,-20,20,20,20 }
			}

			motion
			{
				fade { envelope "cosine" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "trail2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 8,8,10,10 }
				tint { line 0.584314,0.54902,0.482353,0.380392,0.376471,0.337255 }
				fade { point 0.1 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
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
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "line_outer3"
	{
		duration	1,1
		count		30,30

		line
		{
			duration	1.5,5
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { point -2,0,0 }
				size { box 20,30 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { line 0.75,0.5 }
				length { point -35,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 11,15 }
				tint { point 0.501961,0.501961,0.501961 }
			}
		}
	}
	emitter "spots2"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.8,0.8
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { line -5,0,0,5,0,0 }
				velocity { box 0,-80,-80,0,80,80 }
				size { box 0.5,0.5,1,1 }
				tint { line 1,0.501961,0,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}



