effect effects/fire/wall_128
{
	size	561

	emitter "smoke"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	2.5,3.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.05,-0.05

			start
			{
				position { line 20,-30,-10,60,30,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 80,80,90,90 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,90,90 }
				fade { point 1 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.286275,0.286275,0.286275 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
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
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
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
			material	"gfx/effects/fire/fire2a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { line 0.501961,0.501961,0.501961,0.219608,0.219608,0.219608 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
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
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.227451,0.227451,0.227451 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
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
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1.25
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.282353,0.282353,0.282353 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
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
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.301961,0.301961,0.301961 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
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
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "embers"
	{
		detail		0.4
		duration	1,1
		count		9,12

		sprite
		{
			duration	3,5
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.1,0

			start
			{
				position { line 20,-60,-10,60,60,10 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.5,0.5,3,3 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"effects_fire"
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		3,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { point 220,150 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}
		}
	}
	emitter "fire6"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-50,0,0,50,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 60,60,80,80 }
				tint { line 0.752941,0.752941,0.752941,0.286275,0.286275,0.286275 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 80,100,80,120 }
				fade { point 1 }
				angle { point 0,0,0 relative }
			}
		}
	}
	spawner "strip"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame1"

			start
			{
				size { point 100,80 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 20,0,0 }
				rotate { point 0.375 }
			}
		}
	}
	spawner "heathaze"
	{
		detail		0.4
		count		1,1

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 80,0,0,100,0,0 }
				size { point 220,220 }
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







