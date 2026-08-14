effect effects/mapobjects/needle_graft
{
	size	121

	light "light"
	{
		locked

		light
		{
			duration	0.12,0.12
			material	"lights/defaultPointLight"
			flipNormal

			start
			{
				position { point 10,0,0 }
				size { point 50,50,50 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.819608,0.627451,0.337255 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		8,10
		locked

		line
		{
			duration	0.2,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.5,0.75
			generatedOriginNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 200,0,0,500,0,0 }
				acceleration { point -100,0,0 }
				size { box 1,2 }
				tint { line 1,0.941177,0.8,0.94902,0.941177,0.839216 }
				length { box 12,0,0,18,0,0 }
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
	spawner "sparks_lines2"
	{
		count		8,10

		line
		{
			duration	0.3,0.5
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.5,0.75
			generatedOriginNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 200,0,0,500,0,0 }
				size { box 1,2 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 7,0,0,9,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	emitter "delayed_smoke"
	{
		duration	1,1
		count		15,20

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.05,-0.05

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.4,0.4,0.8,0.8 }
				tint { point 0.647059,0.627451,0.611765 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 7,7,9,9 }
				tint { point 0.32549,0.32549,0.301961 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
}

