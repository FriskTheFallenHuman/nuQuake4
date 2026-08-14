effect effects/test/mvainio/cylinder
{
	size	163

	emitter "unnamed1"
	{
		duration	1,1
		count		100,100
		locked

		oriented
		{
			duration	2,2
			blend	add
			material	"gfx/effects/particles_shapes/ripple"
			generatedNormal

			start
			{
				position { cylinder 0,-50,-50,200,50,50 surface }
				size { point 20,20 }
				tint { point 0.615686,0.807843,1 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope convexfade }
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 40,40 }
				fade { point 1 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
	spawner "ring"
	{
		count		150,150

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/blob"

			start
			{
				position { cylinder 0,-50,-50,0,50,50 surface }
				velocity { box 700,0,0,900,0,0 }
				size { point 5,5 }
				fade { point 0.2 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
}

