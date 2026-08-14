effect effects/vehicles/walker/footfall
{
	size	183

	spawner "steam1"
	{
		count		10,10

		sprite
		{
			duration	0.5,2
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.025,-0.025
			generatedNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 0,0,0,70,0,0 }
				size { line 5,5,10,10 }
				fade { point 0 }
				offset { point 0,0,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				fade { line 0.25,0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
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
				size { point 100,100 }
			}
		}
	}
	spawner "steam2"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				acceleration { box 200,0,0,800,0,0 }
				size { line 5,5,10,10 }
				fade { point 0 }
				offset { point 0,0,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				fade { line 0.25,0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
