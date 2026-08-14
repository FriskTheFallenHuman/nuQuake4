effect effects/monsters/harvester/can_explosion
{
	size	912

	spawner "flash"
	{
		count		4,4
		locked

		sprite
		{
			duration	0.25,0.5
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
				size { point 300,300 }
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
			entityDef	"debris_roller_joint2"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder -15,-15,-15,15,15,15 }
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
				size { line 300,300,400,400 }
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
			entityDef	"debris_roller_joint2"
			gravity		-0.25,0
			generatedOriginNormal

			start
			{
				position { sphere -100,-100,-100,100,100,100 surface }
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
				size { line 100,100,200,200 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
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
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -700,-700,-700,700,700,700 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
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
				size { point 300,300 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "flash_streaks2"
	{
		count		20,20
		locked

		line
		{
			duration	0.06,0.25
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			entityDef	"debris_roller_joint2"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,1,0.3,0.3 surface }
				velocity { box -50,0,0,50,0,0 }
				size { box 10,20 }
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
			duration	0.5,0.75
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -300,-300,-300,300,300,300 }
				friction { box -2000,-200,0,0,0,0 }
				size { point 100,100 }
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
				size { point 300,300 }
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
	spawner "unnamed14"
	{
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_harvester_cap_side2"
			gravity		1,1

			start
			{
				position { point 30,0,0 }
				velocity { box 500,-1000,-1000,1000,1000,1000 }
			}
		}
	}
	spawner "unnamed15"
	{
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_harvester_cap_side1"
			gravity		1,1

			start
			{
				position { cylinder 30,-50,-50,30,50,50 }
				velocity { box -500,-1000,-1000,-1000,1000,1000 }
			}
		}
	}
	spawner "unnamed16"
	{
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_harvester_captop"
			gravity		1,1

			start
			{
				position { cylinder 30,-60,-60,30,60,60 }
				velocity { box -500,-1000,-1000,-1000,1000,1000 }
			}
		}
	}
	spawner "chunks"
	{
		count		10,20

		model
		{
			duration	2,2
			material	"gfx/test/rocket_chunks"
			entityDef	"debris_harvester_captop"
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
				effect	"effects/fire/spot_32_nobase_walk"
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
			entityDef	"debris_harvester_captop"

			start
			{
				size { point 10,10 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.5 }
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
	spawner "chunks2"
	{
		start		0.12,0.12
		count		15,15

		sprite
		{
			duration	1,1
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		1,1

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 450,-500,-500,750,500,500 }
				size { line 6,6,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	sound "unnamed13"
	{
		soundShader	"effects_explosion_fiery"
		freqshift	1.5,1.5
	}
}

