effect effects/explosions/surface/dropship_exp
{
	size	4243

	spawner "black hole"
	{
		count		2,2

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				size { point 0,0 }
				rotate { box 0,-1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 3000,3000 }
			}
		}
	}
	spawner "smoke3"
	{
		count		10,15

		sprite
		{
			duration	3,3
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.00125,-0.00125
			generatedOriginNormal

			start
			{
				position { sphere 0,-50,-50,1000,50,50 surface }
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
	spawner "smoke4"
	{
		count		8,10

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"

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
				size { line 1000,1000,1500,1500 }
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
				size { box 200,300 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 300,0,0,1000,0,0 }
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
	spawner "smoke2"
	{
		count		8,10

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"
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
	spawner "fire2"
	{
		count		30,30

		sprite
		{
			duration	0.75,1
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { sphere 0,-50,-50,0,50,50 }
				velocity { box 100,0,0,900,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,50,50 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 300,300,500,500 }
				fade { point 1 }
				offset { box 0,-600,-600,0,600,600 }
			}
		}
	}
	sound "unnamed10"
	{
		soundShader	"medlabs_dropship_explosion"
		volume	0.6,0.6
		freqshift	1.1,1.1
	}
	sound "unnamed11"
	{
		start		0.3,0.3
		soundShader	"medlabs_dropship_explosion2"
		volume	0.5,0.5
		freqshift	0.8,0.8
	}
	spawner "fire up3"
	{
		count		10,15

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 500,-500,-500,1000,500,500 }
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








