effect effects/explosions/surface/hangar_exp
{
	size	3370

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
				size { line 4,4,5,5 }
				tint { point 0.701961,0.784314,0.803922 }
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
				size { box 800,800,1200,1200 }
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
				velocity { box 200,0,0,800,0,0 }
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
				size { line 500,500,1000,1000 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke"
	{
		count		20,60

		sprite
		{
			duration	0.75,2
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 200,-200,-200,800,200,200 }
				friction { box -2000,-200,0,0,0,0 }
				tint { line 0.286275,0.27451,0.239216,0.137255,0.129412,0.109804 }
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
	spawner "flash_streaks2"
	{
		count		4,10
		locked

		line
		{
			duration	0.06,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 200,300 }
				tint { line 0.337255,0.337255,0.337255,1,0.501961,0.247059 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 500,0,0,800,0,0 }
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
		count		15,15

		sprite
		{
			duration	0.25,2
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { box 0,-300,-300,500,300,300 }
				size { point 500,500 }
				offset { point 50,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope cosine offset 0.5,0.5 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 1,1,200,200 }
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
	spawner "fill2"
	{
		count		5,8

		sprite
		{
			duration	0.5,0.75
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				velocity { box 100,-200,-200,1000,200,200 }
				size { point 10,10 }
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
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "unnamed12"
	{
		count		4,4

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_wing2"
			gravity		1,1

			start
			{
				position { point 20,0,0 }
				velocity { box 500,-200,-200,800,200,200 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		4,10

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_bit"
			gravity		1,1

			start
			{
				position { point 13.5,0,0 }
				velocity { box 700,-200,-200,800,200,200 }
				rotate { box 0,0,-0.5,0,0,0.5 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0,0,-1,0,0,1 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 700,700,1000,1000 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "fragments"
	{
		count		9,12

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spark_line3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.25,-0.1,-0.1,0.25,0.1,0.1 }
				velocity { box 350,0,0,600,0,0 }
				size { box 8,12 }
				tint { line 1,0.937255,0.584314,1,0.709804,0.415686 }
				length { box 500,0,0,800,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
}

