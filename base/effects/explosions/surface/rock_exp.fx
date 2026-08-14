effect effects/explosions/surface/rock_exp
{
	size	2305

	spawner "unnamed15"
	{
		count		15,15

		debris
		{
			duration	3,3
			entityDef	"debris_small_rock1a"

			start
			{
				position { point 100,0,0 }
				velocity { box 0,-1000,-1000,1000,1000,1000 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -22.2222,-22.2222,-22.2222,22.2222,22.2222,22.2222 }
			}
		}
	}
	spawner "chunks3"
	{
		start		0.12,0.12
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris3"
			entityDef	"debris_walker_upperleg"
			gravity		0.5,1
			generatedNormal

			start
			{
				position { sphere 0,-200,-200,300,200,200 }
				velocity { box 450,0,0,750,0,0 }
				size { line 6,6,20,20 }
				rotate { box -1,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 }
			}

			impact
			{
				bounce	0.4
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
			entityDef	"debris_walker_upperleg"

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
				size { line 400,400,600,600 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke2"
	{
		count		20,30

		sprite
		{
			duration	1,6
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				velocity { box 100,-200,-200,200,200,200 }
				size { line 20,20,50,50 }
				tint { line 0.513726,0.470588,0.329412,0.592157,0.490196,0.384314 }
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
				size { line 400,400,600,600 }
				tint { point 0.521569,0.505882,0.403922 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke2"
	{
		count		5,20

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"

			start
			{
				velocity { box 300,-400,-400,400,400,400 }
				tint { line 0.584314,0.560784,0.501961,0.752941,0.752941,0.752941 }
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
				tint { point 0.341176,0.309804,0.184314 }
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
			entityDef	"debris_walker_upperleg"
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
				size { envelope linear }
				fade { envelope linear }
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
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 250,250 }
				rotate { box 0,1 }
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
			entityDef	"debris_walker_upperleg"

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
	sound "unnamed17"
	{
		soundShader	"effects_explosion_metal"
	}
	sound "unnamed18"
	{
		soundShader	"effects_explosion_fiery"
	}
	sound "unnamed19"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	sound "unnamed20"
	{
		soundShader	"player_grenadelauncher_explode"
	}
	spawner "trails"
	{
		start		0.5,0.5
		count		2,4

		line
		{
			duration	5,7
			material	"gfx/effects/particles_shapes/duststreak_alpha"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { cylinder -100,-100,-100,100,100,100 }
				size { box 10,30 }
				tint { line 0.4,0.34902,0.243137,0.384314,0.407843,0.235294 }
				fade { point 0.4 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 1000,0,0 }
			}
		}
	}
	spawner "particles"
	{
		start		0.5,0.5
		count		8,14

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		0.01,0.01

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				velocity { box -2,-2,-20,2,2,0 }
				size { line 200,200,300,300 }
				tint { line 0.992157,0.854902,0.6,0.866667,0.984314,0.603922 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "particles_big"
	{
		count		8,10

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			entityDef	"debris_walker_upperleg"
			gravity		0.01,0.01

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				velocity { box 0,0,-15,0,0,0 }
				size { point 200,200 }
				tint { line 0.886275,0.839216,0.682353,0.772549,0.792157,0.717647 }
				fade { point 0.6 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 800,800 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
}





