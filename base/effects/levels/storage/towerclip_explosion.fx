effect effects/levels/storage/towerclip_explosion
{
	size	2051

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				velocity { point 100,0,0 }
				size { line 4,4,5,5 }
				tint { point 0.854902,0.729412,0.654902 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 1.2,1.2 }
				tint { envelope linear count 2,2,2 offset -1,-1,-1 }
				fade { envelope linear }
			}

			end
			{
				size { point 800,800 }
			}
		}
	}
	spawner "fire1"
	{
		count		2,2

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 50,0,0,100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
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
				size { line 800,800,1000,1000 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke"
	{
		count		20,30

		sprite
		{
			duration	1,5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.25,0

			start
			{
				position { sphere -400,-200,-200,400,200,200 surface }
				velocity { box 50,-50,-50,300,50,50 }
				acceleration { box 0,0,0,50,50,0 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				rotate { box 0,1 }
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
				size { line 400,400,600,600 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "flash_streaks2"
	{
		duration	0.1,0.1
		count		80,80
		locked

		line
		{
			duration	0.1,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { line -1,0.6,0.6,-1,-0.6,-0.6 }
				velocity { box 100,0,0,1500,0,0 }
				size { box 150,300 }
				tint { line 0.752941,0.752941,0.752941,1,0.501961,0.25098 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { point 1,0,0 }
			}

			motion
			{
				size { envelope exp_xoverx2 count 0.7 }
				tint { envelope linear count 2,2,2 offset -1,-1,-1 }
				fade { envelope decalfade }
				length { envelope exp_1minusx/x2 count 0.5,0.5,0.5 }
			}

			end
			{
				fade { point 1 }
				length { box 700,0,0,1000,0,0 }
			}
		}
	}
	emitter "unnamed9"
	{
		duration	0.1,0.1
		count		150,150

		sprite
		{
			duration	0.5,1.4
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { box 100,-200,-200,500,200,200 }
				friction { box -2000,-200,0,0,0,0 }
				size { point 50,50 }
				offset { point 50,0,0 }
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
				size { point 200,200 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.4,0.4
		scale		0.5
		attenuateEmitter
		attenuation	200,1000
	}
	spawner "fill2"
	{
		count		8,8

		sprite
		{
			duration	0.5,0.75
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				velocity { box 100,-100,100,500,100,100 }
				size { box 50,50,200,200 }
				tint { line 1,1,1,1,0.501961,0.25098 }
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
				size { point 500,500 }
				rotate { box -0.416667,0.416667 relative }
			}
		}
	}
	emitter "unnamed8"
	{
		duration	0.15,0.15
		count		400,400

		line
		{
			duration	0.25,1
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half3"
			gravity		3,3

			start
			{
				velocity { box 1000,-1500,-1500,2000,1500,1500 }
				friction { point -20,-20,-20 }
				size { box 5,10 }
				tint { point 0.886275,0.807843,0.752941 }
				length { box 20,0,0,100,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 3 offset -2 }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
				length { box 100,0,0,300,0,0 }
			}
		}
	}
}
