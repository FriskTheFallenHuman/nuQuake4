effect effects/monsters/strogg_marine/blaster_fly
{
	size	37

	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				size { point 4.5 }
				offset { point 12,0,0 }
				length { point -20,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 2.5 }
				length { point -15,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		7,7
		locked
		constant

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder -0.12,-0.05,-0.05,-0.12,0.05,0.05 surface }
				size { box 2.5,4 }
				tint { point 0.466667,0.466667,0.466667 }
				fade { point 0.8 }
				offset { point 12,0,0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "random" }
			}

			end
			{
				fade { point 0.2 }
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
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				size { point 8,8 }
				offset { point 8,0,0 }
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
}






