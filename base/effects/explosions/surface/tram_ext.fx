effect effects/explosions/surface/tram_ext
{
	size	505

	spawner "flash"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.25,0.25
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
				size { line 250,250,350,350 }
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
				size { line 100,100,150,150 }
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
			material	"gfx/effects/smoke/cloud_alpha_depth"
			generatedOriginNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 surface }
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
				size { line 50,50,100,100 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "oriented flash"
	{
		count		2,2

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				offset { point 10,0,0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 100,100,300,300 }
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
				velocity { box 150,-150,-150,150,150,150 }
				angle { box 0,0,-1,0,0,1 }
				size { point 50,50 }
				tint { point 0.996078,0.713726,0.505882 }
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
				size { point 100,100 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	emitter "trail"
	{
		start		0.25,0.25
		duration	1,1
		count		80,80

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 20,20,25,25 }
				tint { line 0.309804,0.258824,0.2,0.286275,0.27451,0.239216 }
				fade { point 0.1 }
				offset { point -5,0,0 }
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
				size { line 90,90,100,100 }
				rotate { box -0.25,0.25 relative }
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
				size { point 80,80 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 20,30 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 30,0,0,150,0,0 }
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
	sound "unnamed10"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
}
