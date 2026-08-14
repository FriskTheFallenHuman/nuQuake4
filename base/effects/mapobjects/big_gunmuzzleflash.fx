effect effects/mapobjects/big_gunmuzzleflash
{
	size	970

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 0.5,0,0 }
				size { point 500,500 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "single_streak"
	{
		count		2,2
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				size { point 100 }
				length { box 200,0,0,500,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 20 }
			}
		}
	}
	spawner "sparks"
	{
		count		10,12
		locked

		sprite
		{
			duration	0.15,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				velocity { box 100,-300,-300,1000,300,300 }
				size { line 20,20,50,50 }
				fade { line 0.5,1 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	spawner "orbit"
	{
		count		5,10

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { point 500,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,200,200 }
				fade { line 0.25,0.5 }
				offset { box 0,-50,-50,0,50,50 }
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
				size { point 500,500 }
			}
		}
	}
	spawner "unnamed4"
	{
		count		5,10

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { box 200,0,0,600,0,0 }
				size { point 20,20 }
				fade { point 0.5 }
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
				size { line 100,100,500,500 }
			}
		}
	}
}
