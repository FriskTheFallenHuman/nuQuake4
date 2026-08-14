effect effects/levels/tube_shatter
{
	size	301

	spawner "chunks4"
	{
		count		80,100

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 60,-50,-50,250,50,50 }
				size { box 1,1,4,4 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.2 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "chunks3"
	{
		count		80,100

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 0,-100,-100,300,100,100 }
				size { line 3,3,5,5 }
				tint { line 0.556863,0.866667,0.847059,1,1,1 }
				fade { point 0.25 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "chunks"
	{
		count		80,100

		sprite
		{
			duration	1,1
			material	"gfx/effects/particels_shapes/glass_chunks2"
			gravity		0.5,1

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 0,-100,-100,200,100,100 }
				size { line 5,5,15,15 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "chunks2"
	{
		count		80,100

		sprite
		{
			duration	1,1
			material	"gfx/effects/particels_shapes/glass_chunks2"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 60,-50,-50,60,50,50 }
				size { box 1,1,4,4 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "unnamed4"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				size { point 2,2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
}







