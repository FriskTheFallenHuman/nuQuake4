effect effects/test/mvainio/bbfire1
{
	size	154

	emitter "smoke"
	{
		duration	10,10
		count		4,4

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder 20,-60,-10,60,60,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 40,40,70,70 }
				tint { line 0.576471,0.513726,0.368627,0.262745,0.247059,0.211765 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				tint { envelope fast_in_slow_out }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	10,10
		count		14,14

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	10,10
		count		14,14

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	10,10
		count		14,14

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "orient_glow"
	{
		count		1,1
		constant

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				position { point 1,0,0 }
				size { point 120,60 }
			}

			motion
			{
				fade { envelope randomflick }
			}

			end
			{
				fade { point 0.6 }
			}
		}
	}
	emitter "embers"
	{
		duration	10,10
		count		10,10

		sprite
		{
			duration	1.5,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.1,0

			start
			{
				position { cylinder 20,-60,-10,40,60,10 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.5,0.5,3,3 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}



