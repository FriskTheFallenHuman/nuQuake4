effect effects/monsters/strogg_flyer/explosion
{
	size	1314

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.5
			persist
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
			persist
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
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder 0,-50,-50,100,50,50 }
				velocity { point 100,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
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
				size { line 200,200,500,500 }
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

			start
			{
				velocity { box 300,-400,-400,400,400,400 }
				tint { line 0.286275,0.27451,0.239216,0.137255,0.129412,0.109804 }
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
			persist
			material	"gfx/effects/weapons/plasma1"
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
			persist
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 50,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 200,0,0,400,0,0 }
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
			persist
			material	"gfx/effects/fire/fire1a"

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
	emitter "chunks_trail"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 10,10 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.2 }
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
				position { sphere 200,-200,-200,300,200,200 }
				velocity { box 450,0,0,750,0,0 }
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

			impact
			{
				bounce	0.4
			}
		}
	}
	spawner "unnamed11"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_wing1"
			gravity		1,1

			start
			{
				position { cylinder 30,-100,-100,30,100,100 surface }
				velocity { box 1000,-1000,-1000,2000,1000,1000 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -13.8889,-13.8889,-13.8889,13.8889,13.8889,13.8889 relative }
			}
		}
	}
	spawner "unnamed12"
	{
		count		4,4

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_wing2"
			gravity		1,1

			start
			{
				position { point 20,0,0 }
				velocity { box 500,-800,-800,800,800,800 }
			}

			motion
			{
				rotate { envelope acceleratorfade }
			}

			end
			{
				rotate { box -16.6667,-16.6667,-16.6667,16.6667,16.6667,16.6667 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		4,4

		debris
		{
			duration	1,1
			entityDef	"moveable_gib_stroggflyer_bit"
			gravity		1,1

			start
			{
				position { point 13.5,0,0 }
				velocity { box 700,-700,-700,800,700,700 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -5.55556,-5.55556,-5.55556,5.55556,5.55556,5.55556 }
			}
		}
	}
	sound "unnamed14"
	{
		soundShader	"strogg_flyer_explosion"
	}
	sound "unnamed15"
	{
		soundShader	"strogg_flyer_explosion2"
	}
}




