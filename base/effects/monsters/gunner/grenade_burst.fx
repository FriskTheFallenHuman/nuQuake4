effect effects/monsters/gunner/grenade_burst
{
	size	850

	sound "sound2"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	shake "camerashake2"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	decal "scorch2"
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
	spawner "ring_mark2"
	{
		detail		0.5
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
	spawner "chunks2"
	{
		detail		0.5
		count		3,5

		model
		{
			duration	2,2
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.75,0.75
			generatedOriginNormal
			trailType	chunks_trail2

			start
			{
				position { sphere 0.14,-0.2,-0.2,0.14,0.2,0.2 }
				velocity { box 300,0,0,500,0,0 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	trail "chunks_trail2"
	{
		detail		0.5
		count		30,30

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { point 5,5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.2 }
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
				size { point 30,30 }
			}
		}
	}
	spawner "column_smoke"
	{
		detail		0.5
		count		6,6

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,-10,0,180,10,0 linearSpacing }
				velocity { box 200,30,0,200,40,0 }
				size { box 120,120,160,160 }
				tint { point 0.482353,0.466667,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				tint { point 0.101961,0.101961,0.0823529 }
				fade { point 0.75 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "smoke2"
	{
		start		0.6,0.6
		count		3,3

		sprite
		{
			duration	2,2
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 10,-30,-30,10,30,30 }
				velocity { box 0,0,0,20,0,0 }
				size { line 120,120,180,180 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "sparks2"
	{
		detail		0.5
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
		count		8,8

		sprite
		{
			duration	0.16,0.5
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 50,0,0,1000,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 150,150,180,180 }
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
				size { box 150,150,180,180 }
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
				size { line 300,300,400,400 }
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
		detail		0.5
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
				length { box 80,0,0,200,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	emitter "deform"
	{
		detail		0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				size { point 0,0 }
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
	emitter "deform2"
	{
		detail		0.5
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.35,0.35
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				position { point 1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	sound "unnamed15"
	{
		soundShader	"player_grenadelauncher_explode"
	}
}





