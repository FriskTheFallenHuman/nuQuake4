effect effects/cinematics/intro/ship_entry
{
	size	31

	emitter "side_streaks"
	{
		duration	20,20
		count		100,100
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
				size { box 1,2 }
				tint { point 0.992157,0.690196,0.658824 }
				fade { point 0.1 }
				offset { point 0.8,0,0 }
				length { box 2,0,0,6,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				length { box 6,0,0,10,0,0 }
			}
		}
	}
	emitter "heathaze"
	{
		duration	20,20
		count		10,10
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { box 4,6 }
				tint { point 0.992157,0.690196,0.658824 }
				fade { point 0.1 }
				offset { point 0.8,0,0 }
				length { box 8,0,0,12,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				length { box 16,0,0,24,0,0 }
			}
		}
	}
}

