effect effects/explosions/surface/large_explosion
{
	size	2030

	spawner "chunks2"
	{
		count		30,30

		sprite
		{
			duration	1,3
			material	"gfx/effects/rock_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		0.5,0.5

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 1000,-500,-500,1200,500,500 }
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
	spawner "smoke3"
	{
		count		20,20

		sprite
		{
			duration	1,10
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"
			gravity		-0.02,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				velocity { box 10,0,0,30,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				offset { point -25,0,0 }
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
				size { line 100,100,250,250 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke4"
	{
		count		5,5

		sprite
		{
			duration	10,10
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"
			gravity		-0.01,-0.00125
			generatedOriginNormal

			start
			{
				position { sphere 0,-50,-50,1000,50,50 surface }
				velocity { box 0,0,0,50,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.486275,0.486275,0.486275,0.501961,0.501961,0.501961 }
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
				size { line 400,400,500,500 }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
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
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 400,400,500,500 }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 400,400,600,600 }
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
				velocity { box 400,-400,-400,400,400,400 }
				size { point 50,50 }
				tint { point 0.992157,0.713726,0.501961 }
				offset { box 10,-5,-5,10,5,5 }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
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
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 1000,1000 }
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
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 450,450,600,600 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
}
