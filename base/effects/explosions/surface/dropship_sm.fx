effect effects/explosions/surface/dropship_sm
{
	size	991

	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 100,100 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "ring_mark"
	{
		count		1,1

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { point 0.1,0,0 }
				tint { point 1,0.980392,0.72549 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	spawner "sparks"
	{
		count		15,15

		sprite
		{
			duration	0.4,0.6
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				velocity { box 100,-150,-150,500,150,150 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				acceleration { point -500,0,0 }
				size { line 0.5,0.5,4,4 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	spawner "column_fire"
	{
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 50,-100,-100,500,100,100 }
				angle { box 0,0,0,1,1,1 }
				size { box 350,350,380,380 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 60,60,80,80 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "column_fire2"
	{
		count		4,4

		sprite
		{
			duration	0.16,0.16
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 50,0,0,500,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 350,350,380,380 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 60,60,80,80 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
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
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 600,600,700,700 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	spawner "fragments"
	{
		count		9,12

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spark_line3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 350,0,0,600,0,0 }
				size { box 8,12 }
				tint { line 1,0.937255,0.584314,1,0.709804,0.415686 }
				length { box 120,0,0,300,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	sound "unnamed15"
	{
		soundShader	"player_grenadelauncher_explode"
	}
	spawner "unnamed13"
	{
		count		10,20

		sprite
		{
			duration	1,8
			material	"gfx/effects/smoke/smoke_dark"

			start
			{
				position { cylinder 0,-100,-100,100,100,100 surface }
				velocity { box 0,-25,-25,50,25,25 }
				size { point 80,80 }
				fade { point 0 }
				rotate { box -0.166667,0.166667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
				fade { line 0.5,1 }
			}
		}
	}
	spawner "unnamed14"
	{
		count		2,2

		debris
		{
			duration	1,1
			entityDef	"debris_fx_bit"

			start
			{
				velocity { box 600,-600,-600,600,600,600 }
			}
		}
	}
	emitter "unnamed16"
	{
		duration	10,10
		count		10,20

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/smoke_dark"
			entityDef	"debris_fx_bit"

			start
			{
				size { point 50,50 }
				fade { point 0 }
				rotate { box -0.166667,0.166667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 250,250 }
				fade { line 0.5,0.75 }
			}
		}
	}
}

