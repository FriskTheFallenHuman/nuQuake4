effect effects/monsters/slimy_transfer/vomit_fly
{
	size	26

	emitter "side_streaks"
	{
		duration	1,1
		count		35,35
		locked

		line
		{
			duration	0.3,0.3
			material	"gfx/effects/monsters/slimy_transfer/puke_trail3"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.05,-0.05,-0.1,0.05,0.05 surface }
				size { point 0.5 }
				tint { line 0,1,0,1,1,1 }
				fade { point 0 }
				offset { point 1,0,0 }
				length { box 2,0,0,3,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 }
				length { box 5,0,0,10,0,0 }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/monsters/slimy_transfer/puke_trail3_ADD"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { point 0.5 }
				tint { line 0.72549,0.87451,0.709804,1,1,1 }
				fade { point 0 }
				offset { point 1,0,0 }
				length { box 2,0,0,3,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				fade { point 0.75 }
				length { box 5,0,0,10,0,0 }
			}
		}
	}
	emitter "trail"
	{
		duration	1,1
		count		40,40

		line
		{
			duration	0.15,0.15
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"

			start
			{
				size { box 0,3 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				length { point -10,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fire_smokefade count 1.5,1.5,1.5 }
				fade { envelope linear }
			}

			end
			{
				size { box 5,8 }
				tint { point 0.203922,0.439216,0.207843 }
			}
		}
	}
	emitter "trail2"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	0.25,0.25
			blend	add
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_group_add"

			start
			{
				velocity { box 0,-20,-20,0,20,20 }
				size { box 0,5 }
				tint { line 0.301961,0.341176,0.235294,0.584314,0.482353,0.411765 }
				length { point -10,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fire_smokefade count 1.5,1.5,1.5 }
				fade { envelope linear }
			}

			end
			{
				size { box 8,12 }
				tint { line 0.203922,0.439216,0.207843,0.501961,0.501961,0 }
			}
		}
	}
}





