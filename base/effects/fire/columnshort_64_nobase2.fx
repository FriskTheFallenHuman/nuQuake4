effect effects/fire/columnshort_64_nobase2
{
	size	315

	emitter "embers"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1.5,2.5
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.2,0

			start
			{
				position { cylinder 40,-40,-40,80,40,40 }
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
		soundShader	"effects_fire_small"
	}
	emitter "smoke2"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	2,2.5
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-25,-25,0,25,25 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 5,5,10,10 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,120,120 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "fire6"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.85,0.95
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.125

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 20,20,40,40 }
				fade { point 0 }
				offset { box 0,-5,-5,0,5,5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 40,80,50,100 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "fire7"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.019,0

			start
			{
				position { cylinder 5,-8,-8,5,8,8 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { line 30,30,40,40 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
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
				size { box 50,50,60,60 }
				fade { point 1 }
				angle { box 0,0,-1,0,0,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire8"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.22,0

			start
			{
				position { cylinder 10,-10,-10,10,10,10 }
				velocity { box 0,-15,-15,30,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				fade { point 0 }
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
				size { box 30,30,40,40 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	spawner "strip"
	{
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame1"

			start
			{
				size { point 45,45 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 28,0,0 }
				rotate { point 0.375 }
			}
		}
	}
	spawner "heathaze"
	{
		count		1,1

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 50,0,0,80,0,0 }
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
