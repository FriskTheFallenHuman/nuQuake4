effect effects/explosions/surface/large_explosion_walker
{
	size	3927

	spawner "unnamed16"
	{
		count		20,20

		sprite
		{
			duration	0.75,5
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_walker_upperleg"
			gravity		-0.25,0

			start
			{
				position { line 0,-300,0,0,300,0 }
				velocity { box 0,-100,0,0,100,0 }
				size { box 100,100,200,200 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { box 400,400,600,600 }
				fade { line 0.25,0.5 }
			}
		}
	}
	spawner "chunks2"
	{
		count		100,100

		sprite
		{
			duration	0.5,3
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		1,1

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box -1000,-1000,-1000,1000,1000,1000 }
				size { line 6,6,80,80 }
				rotate { box -10,10 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}
		}
	}
	sound "unnamed17"
	{
		soundShader	"effects_explosion_metal"
		volume	5,5
		freqshift	0.8,0.8
	}
	sound "unnamed18"
	{
		soundShader	"effects_explosion_fiery"
		volume	5,5
	}
	spawner "smoke5"
	{
		count		8,10

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,-50,-50,250,50,50 }
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
				size { line 400,400,500,500 }
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
				velocity { box 0,-250,-250,500,250,250 }
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
				size { line 400,400,750,750 }
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
				size { line 500,500,800,800 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke6"
	{
		count		8,10

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"
			gravity		-0.05,-0.025
			generatedOriginNormal

			start
			{
				position { sphere -300,-300,-300,300,300,300 surface }
				velocity { box 0,-50,-50,0,50,50 }
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
				size { line 600,600,750,750 }
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
				velocity { box 50,-150,-150,350,150,150 }
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
				size { line 400,400,450,450 }
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
			duration	0.5,0.5
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
				size { point 1500,1500 }
			}
		}
	}
	spawner "fire up4"
	{
		count		15,15

		sprite
		{
			duration	1,2
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
				size { line 450,450,600,600 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "unnamed14"
	{
		count		50,50

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-300,0,0,300,0 }
				velocity { box 0,-500,0,0,500,0 }
				size { box 100,100,200,200 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 400,400,600,600 }
			}
		}
	}
	spawner "flash4"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"
			entityDef	"debris_gib_brain1"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 600,600,800,800 }
				tint { point 1,0.713726,0.713726 }
				offset { point 0,100,200 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	spawner "unnamed13"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_walker_pipe"

			start
			{
				velocity { box -3000,-3000,-3000,3000,3000,3000 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -8.33333,-8.33333,-8.33333,8.33333,8.33333,8.33333 }
			}
		}
	}
}




