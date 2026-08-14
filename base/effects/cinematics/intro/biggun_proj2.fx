effect effects/cinematics/intro/biggun_proj2
{
	size	191

	spawner "line4"
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
				size { point 2 }
				fade { point 0.5 }
				offset { point 42,0,0 }
				length { point 50,0,0 }
			}
		}
	}
	spawner "line5"
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
				size { point 10 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 35,0,0 }
				length { point 55,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 3 }
				length { point 50,0,0 }
			}
		}
	}
	emitter "orbit3"
	{
		duration	30,30
		count		50,50
		locked

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { box -25,-10,-10,-50,10,10 }
				angle { box 0,0,-0.0833333,0,0,0.0833333 }
				size { point 5,5 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0.1 }
				offset { box 80,-2,-2,80,2,2 }
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
				size { point 30,30 }
			}
		}
	}
	spawner "flash3"
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
				offset { point 83,0,0 }
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
	emitter "orbit4"
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
				size { line 2,2,3,3 }
				tint { line 1,1,1,0.501961,0.501961,1 }
				fade { point 0.5 }
				offset { point 80,0,0 }
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
				size { point 10,10 }
			}
		}
	}
}









