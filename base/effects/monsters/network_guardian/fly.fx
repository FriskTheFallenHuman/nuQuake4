effect effects/monsters/network_guardian/fly
{
	size	45

	emitter "line_inner"
	{
		duration	1,1
		count		75,75

		line
		{
			duration	0.1,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -2,0,0 }
				size { point 4 }
				fade { point 0.5 }
				length { box -20,0,0,-10,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2 }
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
			material	"gfx/effects/weapons/flash_half"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { box 3,4 }
				tint { point 0.486275,0.682353,1 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 2,0,0,4,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				length { box 15,0,0,20,0,0 }
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
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -4,0,0 }
				size { point 10,10 }
			}
		}
	}
	emitter "trail"
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
				size { line 12,12,14,14 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "line_outer2"
	{
		duration	1,1
		count		30,30

		line
		{
			duration	1.5,2
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { point -2,0,0 }
				size { box 6,7.5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { line 0.1,0.15 }
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
				size { box 2,3 }
				tint { point 0.501961,0.501961,0.501961 }
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
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -4,0,0 }
				size { point 30,30 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}
		}
	}
}
