effect effects/explosions/surface/tram_pipe_exp
{
	size	1761

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
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha_depth"
			gravity		-0.25,0
			generatedOriginNormal

			start
			{
				position { sphere -400,-400,-400,400,400,400 surface }
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
		count		5,20

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				velocity { box 500,-400,-400,800,400,400 }
				friction { box -2000,-200,0,0,0,0 }
				tint { line 0.286275,0.27451,0.239216,0.137255,0.133333,0.113725 }
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
		count		5,8

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -700,-700,-700,700,700,700 }
				angle { box 0,0,-1,0,0,1 }
				size { point 500,500 }
				tint { point 1,0.501961,0.25098 }
				offset { box 10,-5,-5,10,5,5 }
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
				size { point 1000,1000 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 500,500 }
				rotate { box 0,1 }
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
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 200,300 }
				tint { point 0.501961,0.501961,0.501961 }
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
		count		5,5

		sprite
		{
			duration	0.25,0.75
			blend	add
			material	"gfx/effects/fire/fire1a"

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
	spawner "chunks"
	{
		count		10,20

		model
		{
			duration	2,2
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.25,0.5
			generatedOriginNormal
			trailType	chunks_trail

			start
			{
				position { sphere 0.14,-0.2,-0.2,0.14,0.2,0.2 }
				velocity { box 300,-600,-600,600,600,600 }
				tint { line 0.501961,0.501961,0.501961,0.109804,0.054902,0 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}

			impact
			{
				remove	1
				effect	"effects/fire/spot_32_nobase"
				effect	"effects/fire/column_128_nobase"
			}
		}
	}
	trail "chunks_trail"
	{
		count		30,30

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 10,10 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.2 }
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
				size { point 50,50 }
			}
		}
	}
	spawner "unnamed11"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_wing1"
			gravity		1,1

			start
			{
				position { point 30,0,0 }
				velocity { box 1000,-1000,-1000,1200,1000,1000 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -10,-10,-10,10,10,10 relative }
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
				velocity { box 500,-800,-800,800,800,800 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -22.2222,-22.2222,-22.2222,22.2222,22.2222,22.2222 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		4,4

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_bit"
			gravity		1,1

			start
			{
				position { point 13.5,0,0 }
				velocity { box 700,-700,-700,800,700,700 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -19.4444,-19.4444,-19.4444,19.4444,19.4444,19.4444 relative }
			}
		}
	}
}















