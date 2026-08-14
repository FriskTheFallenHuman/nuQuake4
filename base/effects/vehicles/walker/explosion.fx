effect effects/vehicles/walker/explosion
{
	size	1314

	spawner "flash"
	{
		count		2,3
		locked

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				offset { box 10,0,0,150,0,0 }
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
				size { point 500,500 }
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
				velocity { box 100,0,0,400,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				fade { point 0 }
				offset { box 0,-5,-5,50,5,5 }
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
				size { line 400,400,600,600 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke2"
	{
		count		20,20

		sprite
		{
			duration	1,6
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				velocity { point 100,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				offset { point -50,0,0 }
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
				size { line 200,200,500,500 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke2"
	{
		count		8,8

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box 300,-400,-400,400,400,400 }
				tint { line 0.286275,0.27451,0.239216,0.137255,0.129412,0.109804 }
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
		count		6,6

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box 200,0,0,400,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
				tint { point 1,0.501961,0.247059 }
				offset { box 10,-5,-5,100,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
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
				size { box 50,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 150,0,0,200,0,0 }
			}

			motion
			{
				fade { envelope decalfade }
				length { envelope arch count 0.6,0.6,0.6 }
			}

			end
			{
				fade { point 1 }
				length { point 400,0,0 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		sprite
		{
			duration	0.25,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { box 200,-300,-300,500,300,300 }
				friction { box -2000,-200,0,0,0,0 }
				size { point 20,20 }
				offset { point 50,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope halfsintable }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,200,200 }
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
		count		8,8

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
				velocity { box 400,-600,-600,700,600,600 }
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
		}
	}
	trail "chunks_trail"
	{
		count		40,40

		sprite
		{
			duration	0.5,0.5
			persist
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
	spawner "joint debris"
	{
		count		1,1
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_walker_joint"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 900,-400,-400,1100,400,400 }
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
	spawner "MAIN BODY DB"
	{
		count		1,1
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_walker_main_body"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-500,-500,1000,500,500 }
			}

			motion
			{
				rotate { envelope laserfencewave }
			}

			end
			{
				rotate { box -8.33333,-8.33333,-8.33333,8.33333,8.33333,8.33333 }
			}
		}
	}
	spawner "rocket launcher"
	{
		count		1,1
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_walker_rocket_launcher"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-500,-500,1100,500,500 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -12.5,-12.5,-12.5,12.5,12.5,12.5 }
			}
		}
	}
	spawner "upperleg"
	{
		count		1,1
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_walker_upperleg"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-500,-500,1100,500,500 }
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
	spawner "chunks2"
	{
		start		0.12,0.12
		count		10,10

		sprite
		{
			duration	1,2
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		1,1
			generatedNormal

			start
			{
				position { sphere 200,-200,-200,300,200,200 }
				velocity { box 450,0,0,750,0,0 }
				size { line 6,6,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear count 4 offset -3 }
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
	sound "unnamed17"
	{
		soundShader	"effects_explosion_metal"
		volume	1,1
		freqshift	0.9,0.9
	}
	sound "unnamed18"
	{
		soundShader	"effects_explosion_fiery"
		volume	1,1
	}
	sound "unnamed19"
	{
		soundShader	"player_rocketlauncher_explode2"
		volume	0.5,0.5
	}
}








