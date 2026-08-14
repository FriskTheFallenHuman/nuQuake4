effect effects/vehicles/gev/impact
{
	size	1220

	spawner "unnamed16"
	{
		count		2,4

		debris
		{
			duration	1,1
			entityDef	"debris_fx_bit"

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box 400,-400,-400,800,400,400 }
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
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_fx_bit"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
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
			entityDef	"debris_fx_bit"
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
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 200,200,300,300 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke2"
	{
		count		5,10

		sprite
		{
			duration	1,6
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_fx_bit"
			gravity		-0.0125,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				size { line 20,20,50,50 }
				tint { line 0.74902,0.74902,0.74902,0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point -50,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,250,250 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke2"
	{
		count		5,10

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_fx_bit"

			start
			{
				velocity { box 150,-150,-150,200,150,150 }
				tint { line 0.74902,0.74902,0.74902,0.501961,0.501961,0.501961 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "fill"
	{
		count		5,8

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_fx_bit"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -200,-200,-200,200,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
				tint { point 1,0.501961,0.25098 }
				offset { box 10,-5,-5,10,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
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
			entityDef	"debris_fx_bit"

			start
			{
				size { point 200,0 }
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
			entityDef	"debris_fx_bit"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 25,75 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 150,0,0,250,0,0 }
			}

			motion
			{
				fade { envelope "decalfade" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,10

		sprite
		{
			duration	0.25,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_fx_bit"

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
				size { envelope "halfsintable" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 75,75,100,100 }
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
		count		5,10

		model
		{
			duration	2,2
			material	"gfx/test/rocket_chunks"
			entityDef	"debris_fx_bit"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.25,1
			generatedOriginNormal
			trailType	chunks_trail

			start
			{
				position { sphere 0.14,-0.2,-0.2,0.14,0.2,0.2 }
				velocity { box 300,-400,-400,400,400,400 }
				tint { line 0.501961,0.501961,0.501961,0.109804,0.054902,0 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}

			impact
			{
				remove	1
				effect	"effects/fire/spot_32_nobase_3sec"
			}
		}
	}
	trail "chunks_trail"
	{
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_fx_bit"

			start
			{
				size { point 10,10 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
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
			generatedNormal

			start
			{
				position { sphere 0,-100,-100,150,100,100 }
				velocity { box 450,0,0,750,0,0 }
				size { line 6,6,15,15 }
				rotate { box -8.33333,8.33333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
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
		volume	0.5,0.5
	}
	sound "unnamed18"
	{
		soundShader	"effects_explosion_fiery"
		volume	0.5,0.5
	}
	sound "unnamed19"
	{
		soundShader	"player_rocketlauncher_explode2"
		volume	0.5,0.5
	}
	sound "unnamed20"
	{
		soundShader	"player_grenadelauncher_explode"
		volume	0.5,0.5
		freqshift	0.6,0.6
	}
}







