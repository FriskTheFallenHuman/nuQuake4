effect effects/weapons/hyperblaster/fly
{
	size	81

	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				size { point 10 }
				offset { point 15,0,0 }
				length { point -60,0,0 }
			}

			motion
			{
				size { envelope "random" }
				fade { envelope "decalfade" offset 0.8 }
				length { envelope "random" }
			}

			end
			{
				size { point 6 }
				length { point -45,0,0 }
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
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal

			start
			{
				position { cylinder -0.12,-0.05,-0.05,-0.12,0.05,0.05 surface }
				size { box 3,5 }
				tint { point 0.470588,0.470588,0.470588 }
				fade { point 0.8 }
				offset { point 12,0,0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "random" }
				length { envelope "linear" }
			}

			end
			{
				size { box 7,9 }
				fade { point 0.2 }
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
			duration	0.5,0.5
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -4,0,0 }
				size { point 6,6 }
				offset { point 8,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 50,50 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
}












