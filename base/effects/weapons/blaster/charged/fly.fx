effect effects/weapons/blaster/charged/fly
{
	size	54

	spawner "line"
	{
		detail		0.5
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly"

			start
			{
				size { point 4 }
				offset { point 12,0,0 }
				length { point -25,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 2 }
				length { point -20,0,0 }
			}
		}
	}
	spawner "line2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly"

			start
			{
				position { point -4,0,0 }
				size { point 4 }
				length { point 16,0,0 }
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
			material	"gfx/effects/weapons/blaster_fly"
			generatedOriginNormal

			start
			{
				position { cylinder -0.15,-0.05,-0.05,-0.15,0.05,0.05 surface }
				size { box 4,6 }
				tint { point 0.337255,0.337255,0.337255 }
				fade { point 0.8 }
				offset { point 12,0,0 }
				length { box 25,0,0,35,0,0 }
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
			material	"gfx/effects/weapons/blaster_fly2"

			start
			{
				position { point -4,0,0 }
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
	emitter "sparks4"
	{
		duration	1,1
		count		100,100

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/particles_shapes/add_sphere"

			start
			{
				angle { box 0,0,0,0.444444,0.444444,0.444444 }
				size { line 8,8,10,10 }
				tint { point 0.552941,0.768628,0.921569 }
				fade { point 0.3 }
				offset { box 0,-8,-4,0,8,4 }
			}

			motion
			{
				fade { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box -0.444444,-0.444444,-0.444444,0.444444,0.444444,0.444444 relative }
			}
		}
	}
}





