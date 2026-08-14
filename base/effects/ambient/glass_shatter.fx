effect effects/ambient/glass_shatter
{
	size	425

	spawner "unnamed5"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 0,-100,-100,80,100,100 }
				size { point 20,20 }
				tint { line 0.439216,0.501961,0.560784,0.498039,0.498039,0.498039 }
				fade { point 0.75 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "chunks"
	{
		count		40,50

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 0,0,-100,100,300,100 }
				size { line 3,3,6,6 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
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
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box -300,-300,-300,300,300,300 }
				size { box 1,1,4,4 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "chunks3"
	{
		count		20,20

		sprite
		{
			duration	1,5
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 60,-50,-50,100,50,50 }
				size { point 5,5 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	spawner "chunks4"
	{
		count		40,50

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/glass_chunks"
			gravity		0.5,1

			start
			{
				position { cylinder 1,-30,-50,1,30,50 }
				velocity { box 0,-300,-100,100,0,100 }
				size { line 3,3,6,6 }
				tint { line 0.556863,0.866667,0.85098,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
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

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				fade { point 0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
}
