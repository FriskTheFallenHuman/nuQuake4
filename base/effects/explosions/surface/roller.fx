effect effects/explosions/surface/roller
{
	size	4096

	spawner "unnamed0"
	{
		count		1,1

		debris
		{
			duration	1,3
			entityDef	"debris_roller_top"

			start
			{
				position { point 100,0,0 }
				velocity { box 3000,-500,-500,3000,500,500 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -13.8889,-13.8889,-13.8889,13.8889,13.8889,13.8889 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"debris_roller_joint1"

			start
			{
				position { point 20,0,0 }
				velocity { box 2000,-500,-500,2000,500,500 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -8.33333,-8.33333,-8.33333,8.33333,8.33333,8.33333 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"debris_roller_joint2"

			start
			{
				position { point 20,0,0 }
				velocity { box 2000,-800,-800,2000,800,800 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -13.8889,-13.8889,-13.8889,13.8889,13.8889,13.8889 }
			}
		}
	}
	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.5
			persist
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 600,600 }
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
			persist
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,0,0,50,0,0 }
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
				size { line 500,500,600,600 }
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
			duration	1,3
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_roller_joint2"
			gravity		-0.025,0
			generatedOriginNormal

			start
			{
				position { sphere -150,-150,-150,150,150,150 surface }
				size { line 50,50,80,80 }
				tint { line 0.501961,0.501961,0.501961,0.752941,0.752941,0.752941 }
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
				size { line 200,200,300,300 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke"
	{
		count		5,20

		sprite
		{
			duration	0.5,1
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 500,-400,-400,800,400,400 }
				friction { box -2000,-200,0,0,0,0 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				offset { point 50,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "fill"
	{
		count		8,15

		sprite
		{
			duration	0.25,0.5
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -700,-700,-700,700,700,700 }
				angle { box 0,0,-1,0,0,1 }
				size { point 300,300 }
				tint { point 1,0.501961,0.25098 }
				offset { box 10,-50,-50,10,50,50 }
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
				size { point 500,500 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.5
			blend	add
			persist
			material	"gfx/effects/weapons/flash_half3"
			entityDef	"debris_roller_joint2"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 50,80 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 150,0,0,300,0,0 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		sprite
		{
			duration	0.25,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 600,-500,-500,600,500,500 }
				friction { box -2000,-200,0,0,0,0 }
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
				size { point 500,500 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
}





