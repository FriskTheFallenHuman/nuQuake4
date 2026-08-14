effect effects/fire/spot_48
{
	size	179

	emitter "smoke"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,40,40 }
				tint { point 0.576471,0.513726,0.364706 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { line 0.6,0.8 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.2,-0.1

			start
			{
				position { cylinder -5,-5,-5,5,5,5 }
				velocity { box 0,0,0,40,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 20,20 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "fast_in_slow_out" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 20,40,20,50 }
				fade { line 1,0.25 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.3,0.55
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.04

			start
			{
				position { line -10,-10,0,10,10,15 }
				velocity { box 60,-5,-5,80,5,5 }
				acceleration { box -100,-100,-100,100,100,100 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.4,0.5
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.2,-0.1

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 20,0,0,70,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.3,0.5
			blend	add
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { cylinder -5,-5,-10,5,5,-10 }
				velocity { point -20,0,0 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box -150,0,0,-200,0,0 }
				size { point 20,20 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"effects_fire_small"
	}
	spawner "strip"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame3"

			start
			{
				size { point 50,50 }
				offset { point 20,0,0 }
				rotate { point 0.375 }
			}

			motion
			{
				tint { envelope "firetable" }
			}
		}
	}
	emitter "base"
	{
		duration	1,1
		count		6,6

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { point 80,80 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}
		}
	}
	emitter "heathaze"
	{
		detail		0.4
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 10,0,0,50,0,0 }
				size { point 80,80 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
}




