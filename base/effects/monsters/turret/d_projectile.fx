effect effects/monsters/turret/d_projectile
{
	size	54

	emitter "line_inner"
	{
		duration	1,1
		count		15,15
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -2,0,0 }
				size { point 1.5 }
				length { box -35,0,0,-15,0,0 }
			}
		}
	}
	emitter "side_streaks"
	{
		detail		0.5
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
				size { box 3,4 }
				tint { point 0.486275,0.682353,1 }
				fade { point 0 }
				offset { point -8,0,0 }
				length { box 2,0,0,4,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { line 0.75,1 }
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
				position { point -10,0,0 }
				size { point 8,8 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
	emitter "trail"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.5,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 8,8,10,10 }
				tint { line 0.584314,0.54902,0.482353,0.380392,0.376471,0.337255 }
				fade { line 0.1,0.2 }
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
	emitter "line_inner2"
	{
		detail		0.5
		duration	1,1
		count		40,40

		line
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { point -2,0,0 }
				size { box 2,3 }
				fade { point 0.1 }
				length { point -50,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}





