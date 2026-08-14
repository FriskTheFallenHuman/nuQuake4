effect effects/explosions/surface/hangar_exp2
{
	size	3216

	spawner "unnamed16"
	{
		start		0.025,0.025
		count		15,20

		debris
		{
			duration	1,1
			entityDef	"debris_fx_bit_bgtrail"
			gravity		0.25,0.5

			start
			{
				velocity { box 1500,-1000,-1000,1500,1000,1000 }
			}
		}
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"
			entityDef	"debris_fx_bit_bgtrail"

			start
			{
				size { point 500,500 }
				rotate { box 0,1 }
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
	spawner "smoke4"
	{
		count		10,15

		sprite
		{
			duration	5,15
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_walker_upperleg"
			gravity		-0.00125,-0.00125
			generatedOriginNormal

			start
			{
				position { sphere 0,-50,-50,500,50,50 surface }
				velocity { box 20,-5,-5,100,5,5 }
				size { line 20,20,50,50 }
				tint { point 0.733333,0.745098,0.486275 }
				fade { point 0 }
				rotate { box -1,1 }
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
				tint { point 0.439216,0.501961,0.560784 }
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
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,-50,-50,500,50,50 }
				friction { point 20,0,0 }
				size { line 20,20,50,50 }
				tint { point 0.768628,0.709804,0.482353 }
				fade { point 0 }
				rotate { box -0.5,0.5 }
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
	spawner "smoke"
	{
		count		8,10

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_walker_upperleg"
			generatedOriginNormal

			start
			{
				position { sphere -300,-300,-300,300,300,300 surface }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
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
	spawner "smoke6"
	{
		count		3,5

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_walker_upperleg"
			gravity		-0.05,-0.025
			generatedOriginNormal

			start
			{
				position { sphere -300,-300,-300,300,300,300 surface }
				velocity { box 0,-100,-100,0,100,100 }
				size { line 20,20,50,50 }
				tint { point 0.737255,0.733333,0.521569 }
				fade { point 0 }
				rotate { box -0.5,0.5 }
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
				tint { point 0.439216,0.501961,0.560784 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire up3"
	{
		count		10,10

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				acceleration { box 300,-300,-300,800,300,300 }
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
		count		10,10

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
	sound "unnamed15"
	{
		soundShader	"convoy_cannon_explosion"
	}
	sound "unnamed16"
	{
		soundShader	"convoy_cannon_explosion2"
		freqshift	0.8,0.8
	}
	delay "unnamed17"
	{
		duration	15,15
	}
	spawner "fragments"
	{
		count		9,12

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spark_line3"
			entityDef	"debris_walker_upperleg"
			generatedOriginNormal

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 350,0,0,600,0,0 }
				size { box 20,50 }
				tint { line 1,0.937255,0.584314,1,0.709804,0.415686 }
				length { box 400,0,0,800,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	spawner "chunks3"
	{
		count		100,100

		sprite
		{
			duration	1,5
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		0.25,0.25

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 800,-100,-100,1200,100,100 }
				size { line 6,6,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
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
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"
			entityDef	"debris_walker_upperleg"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 1000,1000,1200,1200 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
}
