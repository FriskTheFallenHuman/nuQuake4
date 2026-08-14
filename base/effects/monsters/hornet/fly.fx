effect effects/monsters/hornet/fly
{
	size	170

	emitter "line_inner"
	{
		duration	1,1
		count		25,25

		line
		{
			duration	0.3,0.5
			blend	add
			material	"gfx/effects/fire/fireline1"

			start
			{
				position { point 20,0,0 }
				size { point 60 }
				fade { point 0.6 }
				length { point -100,0,0 }
			}

			motion
			{
				size { envelope "randomflick" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 10 }
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
				position { cylinder -0.05,-0.1,-0.1,-0.05,0.1,0.1 surface }
				size { box 6,8 }
				tint { point 0.486275,0.682353,1 }
				fade { point 0 }
				offset { point -15,0,0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				length { box 40,0,0,45,0,0 }
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
				position { point -15,0,0 }
				size { point 35,35 }
			}
		}
	}
}
