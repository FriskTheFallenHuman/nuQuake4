effect effects/vehicles/explosion_flatbed
{
	size	1502

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_flatbed_back_hover"

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
				size { point 1000,1000 }
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
			entityDef	"debris_flatbed_back_hover"
			gravity		-0.15,-0.15

			start
			{
				position { sphere 0,-200,-200,0,200,200 }
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
		count		10,20

		sprite
		{
			duration	1,6
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_flatbed_back_hover"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				velocity { box 0,0,0,100,0,0 }
				size { line 20,20,50,50 }
				tint { line 1,0.913726,0.65098,0.752941,0.752941,0.752941 }
				fade { point 0 }
				offset { point -50,0,0 }
				rotate { box -1,1 }
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
				fade { line 0.5,1 }
				rotate { point 0 relative }
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
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_flatbed_back_hover"

			start
			{
				position { cylinder 0,-50,-50,0,50,50 surface }
				velocity { box 300,-400,-400,400,400,400 }
				tint { line 1,0.835294,0.74902,0.752941,0.752941,0.752941 }
				rotate { box -1,1 }
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
	spawner "smoke3"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.75
			persist
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_flatbed_back_hover"
			gravity		-0.8,-0.8
			generatedNormal

			start
			{
				position { cylinder 0,-50,-50,0,50,50 surface }
				velocity { box 300,0,0,500,0,0 }
				size { line 100,100,200,200 }
				tint { line 1,0.913726,0.65098,1,0.709804,0.568627 }
				fade { point 0 }
				offset { point -50,0,0 }
				rotate { box -1,1 }
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
				size { line 250,250,300,300 }
				fade { point 1 }
				rotate { point 0 relative }
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
			entityDef	"debris_flatbed_back_hover"
			generatedOriginNormal

			start
			{
				position { sphere 0,-200,-200,0,200,200 surface }
				velocity { box -200,-200,-200,200,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { point 200,200 }
				tint { point 1,0.501961,0.247059 }
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
				size { point 800,800 }
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
			entityDef	"debris_flatbed_back_hover"

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
			entityDef	"debris_flatbed_back_hover"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 80,120 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 300,0,0,500,0,0 }
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
	spawner "unnamed9"
	{
		count		5,10

		sprite
		{
			duration	0.25,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_flatbed_back_hover"

			start
			{
				velocity { box 300,-300,-300,800,300,300 }
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
	spawner "fire2"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_flatbed_back"
			gravity		-0.15,-0.15
			generatedNormal

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,0,0,300,0,0 }
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
	delay "unnamed14"
	{
		duration	5,5
	}
	spawner "fins"
	{
		start		0.15,0.15
		count		10,10
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_flatbed_fin"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-1000,-1000,1000,1000,1000 }
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
	spawner "front hover"
	{
		start		0.15,0.15
		count		2,2
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_flatbed_front_hover"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-1000,-1000,1000,1000,1000 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -8.33333,-8.33333,-8.33333,8.33333,8.33333,8.33333 }
			}
		}
	}
	spawner "MAIN BODY DB2"
	{
		start		0.15,0.15
		count		1,1
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_flatbed_back"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 1000,-1000,-1000,3000,1000,1000 }
				rotate { box -1,-1,-1,1,1,1 }
			}
		}
	}
	spawner "back hover2"
	{
		start		0.15,0.15
		count		2,2
		locked

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_flatbed_back_hover"

			start
			{
				position { sphere 100,-10,-10,100,10,10 surface }
				velocity { box 500,-1000,-1000,1000,1000,1000 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -27.7778,-27.7778,-27.7778,27.7778,27.7778,27.7778 }
			}
		}
	}
}




