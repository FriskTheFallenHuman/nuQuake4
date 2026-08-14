effect effects/vehicles/walker/rocket/muzzleflash
{
	size	115

	spawner "flash_close"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				tint { point 0,0,0 }
				rotate { box 1,2 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope fastinslowout }
				rotate { envelope random }
			}

			end
			{
				size { box 40,40,50,50 }
				tint { point 0.74902,0.74902,0.74902 }
			}
		}
	}
	spawner "streaks_straight"
	{
		count		1,1
		locked

		line
		{
			duration	0.18,0.18
			blend	add
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -5,0,0 }
				size { box 8,12 }
				fade { point 0.8 }
				length { box 65,0,0,100,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 35,35,45,45 }
				fade { point 0.9 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 15,15,25,25 }
			}
		}
	}
	spawner "smoke"
	{
		count		8,8
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/impact_smoke"

			start
			{
				position { box -5,-5,-5,5,5,5 }
				velocity { box 10,-5,-5,15,5,5 }
				size { line 10,10,15,15 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				rotate { box -0.416667,0.416667 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fire_smokefade count 2,2,2 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				tint { line 0.301961,0.301961,0.301961,0.372549,0.372549,0.372549 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		4,8
		locked

		line
		{
			duration	0.3,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.05,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 50,0,0,200,0,0 }
				size { box 0.5,1 }
				tint { line 1,0.941177,0.8,0.94902,0.941177,0.839216 }
				length { box 3,0,0,9,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.568627,0.313726 }
			}
		}
	}
}


