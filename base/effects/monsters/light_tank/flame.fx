effect effects/monsters/light_tank/flame
{
	size	198

	emitter "smoke"
	{
		duration	10,10
		count		10,10

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/smoke/smoke"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,30,30 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,120,120 }
				fade { point 0.25 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	spawner "fire1"
	{
		count		2,2
		locked

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0.6 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
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
				size { box 35,35,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
	spawner "fire2"
	{
		count		2,2
		locked

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0.6 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
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
				size { box 35,35,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"lt_tank_flame_loop"
	}
	emitter "fire_trail"
	{
		duration	1.5,1.5
		count		10,10

		sprite
		{
			duration	0.75,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 0,-2,-2,0,2,2 }
				size { box 20,20,30,30 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	spawner "fire3"
	{
		count		2,2
		locked

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0.6 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
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
				size { box 35,35,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_gas"
		volume	0.2,0.2
	}
}



