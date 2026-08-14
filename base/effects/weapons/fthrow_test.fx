effect effects/weapons/fthrow_test
{
	size	499

	emitter "smoke"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 0,0,0,100,0,0 }
				size { point 2,2 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 50,50,60,60 }
			}
		}
	}
	emitter "blue_fire"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.3,0.4
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 100,-10,-10,250,10,10 }
				size { box 2,2,4,4 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 25,25,50,50 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "main4"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.25,-0.125

			start
			{
				position { point 40,0,0 }
				velocity { box 100,-50,-50,400,50,50 }
				size { point 5,5 }
				tint { line 0.4,0.54902,0.839216,1,1,1 }
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
				size { point 200,200 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "main3"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"

			start
			{
				position { point 40,0,0 }
				velocity { box 400,-20,-20,500,20,20 }
				friction { point -2000,0,0 }
				size { point 5,5 }
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
				size { point 200,200 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.02,0

			start
			{
				position { line 15,-1,-1,15,1,1 }
				velocity { box 200,-10,-10,200,10,10 }
				friction { point -200,0,0 }
				size { box 5,5,10,10 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,100,100 }
				fade { line 0.5,0.25 }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2a_blue"

			start
			{
				position { point 15,0,0 }
				velocity { box 150,-5,-5,250,5,5 }
				friction { box -200,0,0,-500,0,0 }
				size { box 5,5,10,10 }
				tint { line 0.501961,0.501961,1,1,1,1 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,200,200 }
				fade { line 0.5,0.75 }
				rotate { box -0.5,0.5 }
			}
		}
	}
	emitter "heathaze"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { point 300,0,0 }
				size { point 50,50 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
}
