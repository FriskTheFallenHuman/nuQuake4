effect effects/levels/storage/largefire1
{
	size	697

	sound "sound"
	{
		soundShader	"effects_fire_deep2"
	}
	emitter "smoke2"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	2.5,3.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 20,-25,-25,140,25,25 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 50,50,70,70 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,180,180 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1.3,2
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-90,0,0,90,0 }
				velocity { box 30,0,0,70,0,0 }
				size { box 120,120,140,140 }
				tint { line 1,1,1,0.403922,0.27451,0.00784314 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 70,70,90,250 }
				fade { point 0.6 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "fire6"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-90,0,0,90,0 }
				velocity { box 30,0,0,70,0,0 }
				size { point 60,60 }
				tint { line 1,1,1,0.501961,0.501961,0 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 70,70,90,250 }
				fade { point 0.6 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.75,1.45
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { line 0,-70,0,0,70,0 }
				velocity { box 50,-10,-10,100,10,10 }
				size { box 75,75,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,90,90 }
				fade { point 1 }
				rotate { box -0.194444,0.194444 relative }
			}
		}
	}
	emitter "Bottom Flame"
	{
		duration	1,1
		count		9,15

		sprite
		{
			duration	0.5,1.6
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line 0,-100,0,0,100,0 }
				size { box 30,30,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 150,150,250,250 }
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
				size { point 150,150 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 100,0,0 }
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
				velocity { box 80,0,0,100,0,0 }
				size { point 400,400 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		2,6

		oriented
		{
			duration	0.75,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { box 400,230,380,250 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fullflicker }
			}

			end
			{
				size { box 1,1,30,30 }
			}
		}
	}
}








