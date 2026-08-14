effect effects/monsters/turret/dropturret_death
{
	size	1526

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"
			entityDef	"debris_FT_gun"

			start
			{
				size { point 256,0 }
				rotate { box 0,1 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
	}
	spawner "smoke2"
	{
		start		0.3,0.3
		count		10,10

		sprite
		{
			duration	2,4
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_FT_gun"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder 50,-50,-50,100,50,50 }
				velocity { point 100,0,0 }
				size { line 30,30,50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				offset { point -50,0,0 }
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
				size { line 300,300,400,400 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fire1"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_FT_gun"
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
				fade { envelope "decalfade" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
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
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			entityDef	"debris_FT_gun"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 50,100 }
				tint { point 0.713726,0.447059,0.286275 }
				fade { point 0 }
				offset { point 5,0,0 }
				length { box 400,0,0,500,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { point 150,0,0 }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		9,9
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			entityDef	"debris_FT_gun"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 12,25 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 320,0,0,340,0,0 }
			}
		}
	}
	spawner "fire2"
	{
		count		4,4

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_FT_gun"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 surface linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 140,140,150,150 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 220,220,250,250 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "fire3"
	{
		count		4,4

		sprite
		{
			duration	0.6,0.6
			material	"gfx/effects/fire/fire3a"
			entityDef	"debris_FT_gun"

			start
			{
				position { line 0,0,0,150,0,0 linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 140,140,150,150 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 220,220,250,250 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash4"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash"
			entityDef	"debris_FT_gun"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 340,340,360,360 }
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
				size { point 40,40 }
			}
		}
	}
	spawner "unnamed8"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_FT_door"

			start
			{
				position { point 30,0,0 }
				velocity { box 500,-2000,-2000,2000,2000,2000 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -13.8889,-13.8889,-13.8889,13.8889,13.8889,13.8889 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_FT_pin"

			start
			{
				position { point 100,0,0 }
				velocity { box 1000,0,0,3000,0,0 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -22.2222,-22.2222,-22.2222,22.2222,22.2222,22.2222 }
			}
		}
	}
	spawner "unnamed10"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"debris_FT_gun"

			start
			{
				position { point 20,0,0 }
				velocity { box 500,-500,-500,1000,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -19.4444,-19.4444,-19.4444,0.277778,19.4444,19.4444 }
			}
		}
	}
	effect "unnamed14"
	{
		start		0.3,0.3
		effect	"effects/fire/column_128_nb_5sec"
	}
	sound "unnamed14"
	{
		soundShader	"player_grenadelauncher_explode"
	}
}














