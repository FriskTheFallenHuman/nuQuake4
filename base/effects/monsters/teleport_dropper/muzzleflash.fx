effect effects/monsters/teleport_dropper/muzzleflash
{
	size	154

	spawner "flash3"
	{
		count		4,8
		locked

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 6,0,0 }
				size { point 35,35 }
				tint { line 1,1,1,1,0.501961,0.247059 }
				fade { point 0.6 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}
		}
	}
	spawner "single_streak2"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				length { box 30,0,0,50,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 10,0,0,16,0,0 }
			}
		}
	}
	spawner "line_gritty"
	{
		count		1,1

		line
		{
			duration	0.13,0.13
			blend	add
			material	"gfx/effects/fire/embers"

			start
			{
				position { point 1,0,0 }
				velocity { box 50,0,0,150,0,0 }
				size { point 2 }
				length { box 30,0,0,45,0,0 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope linear count 1.5 offset -0.5 }
			}

			end
			{
				size { point 6 }
			}
		}
	}
	spawner "line_gritty2"
	{
		count		5,5
		locked

		line
		{
			duration	0.18,0.18
			blend	add
			material	"gfx/effects/fire/embers"
			generatedOriginNormal

			start
			{
				position { cylinder 0.5,-0.25,-0.25,0.5,0.25,0.25 }
				size { box 3,5 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 0 }
				length { point 30,0,0 }
			}
		}
	}
	spawner "smoke"
	{
		count		8,8
		locked

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box 5,-30,-60,20,30,60 }
				size { box 1,1,4,4 }
				fade { point 0.8 }
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
				size { line 5,5,25,25 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,1

		line
		{
			duration	0.14,0.14
			material	"gfx/effects/smoke/steam_source"

			start
			{
				velocity { point 55,0,0 }
				size { point 5 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 50,0,0 }
			}
		}
	}
	trail "chunks_trail"
	{
		count		20,20

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 5,5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		1,1

		model
		{
			duration	1,1
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.5,0.5
			trailType	chunks_trail

			start
			{
				position { point -20,0,0 }
				velocity { box 0,-100,50,0,-130,30 }
				size { point 0.5,0.5,0.5 }
				rotate { box 0,0,0,1,1,1 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	spawner "unnamed10"
	{
		count		1,2

		model
		{
			duration	1,1
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.5,0.5
			trailType	chunks_trail

			start
			{
				position { point -20,0,0 }
				velocity { box 0,-100,-40,0,-150,-80 }
				size { point 0.5,0.5,0.5 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"weapon_nailgun_fire"
		freqshift	0.7,1.4
	}
}





