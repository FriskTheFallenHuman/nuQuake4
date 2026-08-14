effect effects/cinematics/intro/biggun_proj3
{
	size	224

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
				size { point 5 }
				fade { point 0.5 }
				length { point 100,0,0 }
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
	emitter "orbit3"
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
				fade { point 0.25 }
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
	spawner "flash2"
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
	emitter "orbit4"
	{
		duration	30,30
		count		50,50
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				size { line 5,5,10,10 }
				fade { point 0.1 }
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
	emitter "flash3"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { point -4,0,0 }
				velocity { box 0,-5,-5,0,5,5 }
				fade { point 0.5 }
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
				size { point 90,90 }
			}
		}
	}
}



