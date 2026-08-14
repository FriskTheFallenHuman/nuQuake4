effect effects/monsters/harvester/explode_final
{
	size	3283

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
				position { cylinder -0.3,-0.3,-0.3,-0.3,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 50,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 400,0,0,800,0,0 }
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
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	trail "chunks_trail"
	{
		count		50,50

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 20,20 }
				tint { point 0,0,0 }
				fade { point 0.5 }
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
		count		30,30

		sprite
		{
			duration	1,3
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		0.5,0.5
			trailType	chunks_trail

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 1000,-500,-500,1200,500,500 }
				size { line 6,6,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	sound "unnamed17"
	{
		soundShader	"harvester_explosion_death_a"
	}
	sound "unnamed18"
	{
		soundShader	"harvester_explosion_death_b"
	}
	sound "unnamed19"
	{
		soundShader	"harvester_explosion_death_c"
	}
	sound "unnamed20"
	{
		soundShader	"harvester_explosion_death_d"
	}
	spawner "smoke3"
	{
		count		20,30

		sprite
		{
			duration	1,10
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder -50,-50,-50,50,50,50 }
				velocity { point 100,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 200,200,500,500 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke4"
	{
		count		10,15

		sprite
		{
			duration	10,10
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"
			gravity		-0.00125,-0.00125
			generatedOriginNormal

			start
			{
				position { sphere -500,-50,-50,500,50,50 surface }
				velocity { box 0,0,0,100,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.486275,0.486275,0.486275,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 800,800,1000,1000 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke5"
	{
		count		8,10

		sprite
		{
			duration	5,5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,-50,-50,500,50,50 }
				friction { point 20,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.486275,0.486275,0.486275,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 800,800,1000,1000 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire up2"
	{
		count		10,15

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/impact_fire"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 0,-500,-500,1000,500,500 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 800,800,1500,1500 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire2"
	{
		count		2,2

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_walker_upperleg"
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
				size { line 800,800,1000,1000 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke"
	{
		count		8,10

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"
			generatedOriginNormal

			start
			{
				position { sphere -300,-300,-300,300,300,300 surface }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 500,500,1000,1000 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fill2"
	{
		count		5,8

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_walker_upperleg"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box 850,-850,-850,850,850,850 }
				size { point 50,50 }
				tint { point 0.992157,0.713726,0.501961 }
				offset { box 10,-5,-5,10,5,5 }
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
				size { point 1000,1000 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "smoke6"
	{
		count		8,10

		sprite
		{
			duration	5,5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"
			gravity		-0.05,-0.025
			generatedOriginNormal

			start
			{
				position { sphere -300,-300,-300,300,300,300 surface }
				velocity { box 0,-100,-100,0,100,100 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 1000,1000,1500,1500 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire up3"
	{
		count		25,25

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 100,-300,-300,800,300,300 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 800,800,850,850 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "ring"
	{
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.25098 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2000,2000 }
			}
		}
	}
	spawner "fire up4"
	{
		count		25,25

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/fire/impact_fire"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 100,-300,-300,800,300,300 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 800,800,850,850 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
}


