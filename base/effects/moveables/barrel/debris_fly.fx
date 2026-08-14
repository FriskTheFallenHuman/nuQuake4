effect effects/moveables/barrel/debris_fly
{
	size	37

	emitter "trail"
	{
		duration	10,10
		count		60,60
		attenuateEmitter

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.003,-0.001

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 8,8,14,14 attenuate }
				tint { line 0.584314,0.54902,0.482353,0.376471,0.376471,0.337255 }
				fade { point 0.6 }
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
				size { line 14,14,18,18 attenuate }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	0.5,4
		count		2,4
		locked

		sprite
		{
			duration	0.75,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { box -5,-5,-5,5,5,5 surface }
				velocity { box 0,0,0,-1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 10,10,20,20 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 7,7,9,9 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	0.5,4
		count		2,4
		locked

		sprite
		{
			duration	0.25,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"

			start
			{
				position { box -5,-5,-5,5,5,5 surface }
				velocity { box 0,0,0,-1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 10,10,20,20 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 7,7,9,9 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}







