effect effects/monsters/strogg_flyer/rocket_trail1
{
	size	175

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "lines"
	{
		duration	20,20
		count		40,40

		line
		{
			duration	2,3
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				size { box 1,5 }
				tint { line 0.333333,0.301961,0.384314,0.2,0.258824,0.207843 }
				fade { point 0.7 }
				length { point 60,0,0 }
			}

			motion
			{
				size { envelope cosine count 0.8 offset 0.2 }
				fade { envelope exp_x2 }
			}

			end
			{
				size { box 3,7 }
			}
		}
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
				size { line 4,4,6,6 }
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
				size { line 80,80,120,120 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	20,20
		count		100,100
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/flash_half"
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 surface }
				size { box 8,12 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0.1 }
				length { box 4,0,0,8,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				length { box 50,0,0,60,0,0 }
			}
		}
	}
	spawner "glow"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	20,20
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				size { point 40,40 }
				tint { point 0.4,0.54902,0.839216 }
				rotate { point -4 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { point 4 relative }
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
				size { point 15,15 }
				tint { point 0.501961,0.501961,1 }
				offset { point -0.85,0,0 }
			}
		}
	}
	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	20,20
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				size { point 3 }
				offset { point -1.5,0,0 }
				length { point 50,0,0 }
			}
		}
	}
}
