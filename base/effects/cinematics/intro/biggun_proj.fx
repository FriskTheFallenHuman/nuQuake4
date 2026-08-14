effect effects/cinematics/intro/biggun_proj
{
	size	315

	spawner "line2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			blend	add
			material	"gfx/effects/weapons/blaster_fly"

			start
			{
				position { point -4,0,0 }
				size { point 5 }
				fade { point 0.5 }
				length { point 100,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
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
				size { box 5,7 }
				tint { line 0.466667,0.466667,0.466667,0,0.501961,0.25098 }
				offset { point 90,0,0 }
				length { box 40,0,0,50,0,0 }
			}

			motion
			{
				fade { envelope random }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
	spawner "line3"
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
				size { point 30 }
				length { point 110,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 10 }
				length { point 100,0,0 }
			}
		}
	}
	emitter "orbit"
	{
		duration	30,30
		count		15,15
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { box -100,-30,-30,-100,30,30 }
				angle { box 0,0,-1,0,0,1 }
				size { line 10,10,30,30 }
				fade { point 0.1 }
				offset { box 90,-5,-5,90,5,5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
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
				size { point 25,25 }
				offset { point 90,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	emitter "orbit2"
	{
		duration	30,30
		count		10,10
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				size { line 5,5,10,10 }
				fade { point 0.25 }
				offset { point 90,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	emitter "trail"
	{
		duration	20,20
		count		20,20

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				size { box 20,25 }
				fade { point 0.1 }
				offset { point -50,0,0 }
				length { box 150,0,0,200,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 65 }
			}
		}
	}
}




