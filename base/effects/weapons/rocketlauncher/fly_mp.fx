effect effects/weapons/rocketlauncher/fly_mp
{
	size	99

	emitter "smoke trail"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 25,25,30,30 }
				tint { line 0.678431,0.654902,0.603922,0.533333,0.533333,0.482353 }
				fade { point 0.4 }
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
				size { line 55,55,65,65 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	spawner "fire line"
	{
		detail		0.5
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/fire/fireline1"

			start
			{
				position { point -2,0,0 }
				size { point 6 }
				tint { point 0.74902,0.74902,0.74902 }
				length { point -30,0,0 }
			}

			motion
			{
				tint { envelope "random" }
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
			material	"gfx/effects/fire/fireline1"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				length { box -30,0,0,-20,0,0 }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	1,1
		count		50,50
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { box 7,9 }
				tint { point 1,0.501961,0.501961 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.15 }
				length { box 25,0,0,30,0,0 }
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -4,0,0 }
				size { point 15,15 }
				tint { point 1,0.501961,0.501961 }
				fade { point 0.5 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -4,0,0 }
				size { point 6,6 }
			}
		}
	}
	emitter "sparks_lines"
	{
		detail		0.5
		duration	1,1
		count		50,50

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 }
				velocity { box 50,0,0,200,0,0 }
				size { box 0.5,1 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 2,0,0,4,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"effects_rocket_loop"
		volume	0.7,0.7
	}
	sound "unnamed10"
	{
		soundShader	"player_rocketlauncher_fly"
	}
}





