effect effects/monsters/strogg_marine/blaster_mflash
{
	size	176

	light "light"
	{
		detail		0.5
		locked

		light
		{
			duration	0.06,0.06
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 100,100,100 }
				tint { line 0.584314,0.67451,0.831373,0.647059,0.619608,0.301961 }
			}
		}
	}
	spawner "single_streak"
	{
		detail		0.5
		count		2,2
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"

			start
			{
				size { point 4 }
				length { box 14,0,0,24,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0.5 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		3,5
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 10,15 }
				fade { point 0 }
				length { box 16,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 0 }
				fade { point 0.75 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				position { point 2,0,0 }
				size { point 40,40 }
				tint { point 0.74902,0.74902,0.74902 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	emitter "heat"
	{
		detail		0.75
		duration	0.25,0.25
		count		5,5
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				velocity { box -50,0,0,-150,0,0 }
				size { line 3,3,6,6 }
				tint { point 0.756863,0.941177,1 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
			}
		}
	}
}








