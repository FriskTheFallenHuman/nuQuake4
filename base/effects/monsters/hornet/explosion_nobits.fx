effect effects/monsters/hornet/explosion_nobits
{
	size	859

	sound "unnamed18"
	{
		soundShader	"effects_hornet_explosion"
		volume	3,3
		freqshift	1.5,1.5
	}
	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
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
				size { point 600,600 }
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
			entityDef	"debris_roller_joint2"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box -50,-50,-50,50,50,50 }
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
				size { line 300,300,350,350 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke"
	{
		count		20,30

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha_depth"
			entityDef	"debris_roller_joint2"
			gravity		-0.25,0
			generatedOriginNormal

			start
			{
				position { sphere -150,-150,-150,150,150,150 surface }
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
				size { line 200,200,300,300 }
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
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -500,-500,-500,500,500,500 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
				tint { point 1,0.501961,0.25098 }
				offset { box 10,-5,-5,10,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		sprite
		{
			duration	0.25,0.75
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -200,-200,-200,200,200,200 }
				friction { box -2000,-200,0,0,0,0 }
				offset { point 50,0,0 }
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
				size { point 300,300 }
				fade { point 0.25 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
}



