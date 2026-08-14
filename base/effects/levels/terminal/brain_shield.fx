effect effects/levels/terminal/brain_shield
{
	size	1468

	emitter "unnamed2"
	{
		duration	1,1
		count		300,300
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 0,-400,-400,1000,400,400 surface }
				size { line 80,80,100,100 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
				offset { point -500,0,0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope convexfade }
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 1 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		200,200
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash_hot"
			generatedNormal

			start
			{
				position { sphere 0,-400,-400,1000,400,400 surface }
				fade { point 0 }
				offset { point -500,0,0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope convexfade }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 20,20 }
				fade { point 1 }
			}
		}
	}
}

