effect effects/monsters/strogg_flyer/blaster_fly
{
	size	140

	spawner "segment02"
	{
		count		1,2
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				position { point 5,0,0 }
				size { point 10 }
				tint { line 0.486275,0.403922,0.313726,0.631373,0.419608,0.286275 }
				fade { point 0.5 }
				length { point 100,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope flicker }
				length { envelope linear }
			}

			end
			{
				length { point 70,0,0 }
			}
		}
	}
	spawner "segment022"
	{
		count		2,2
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				position { point -65,0,0 }
				size { point 7 }
				tint { line 0.65098,0.615686,0.517647,0.568627,0.447059,0.356863 }
				fade { point 0.5 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope rovinglightning rate 5 }
				tint { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 5 }
				length { point 50,0,0 }
			}
		}
	}
	spawner "segment02222"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				position { point -40,0,0 }
				size { point 2 }
				fade { point 0.5 }
				length { point 100,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { point 30,0,0 }
			}
		}
	}
}



