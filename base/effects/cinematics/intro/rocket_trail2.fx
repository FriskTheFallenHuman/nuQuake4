effect effects/cinematics/intro/rocket_trail2
{
	size	119

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "bright trail"
	{
		duration	20,20
		count		600,600

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point 1,0,0 }
				size { line 1,1,2,2 }
				fade { point 0.2 }
				offset { point 0.65,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 0.5,0.5,1,1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "ghostly"
	{
		duration	20,20
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { line 10,10,20,20 }
				tint { line 0.0705882,0.101961,0.152941,0.0941177,0.117647,0.129412 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,80,80 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "orientglow"
	{
		count		1,1
		locked
		constant

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				position { point 1,0,0 }
				offset { point -0.85,0,0 }
			}
		}
	}
}


