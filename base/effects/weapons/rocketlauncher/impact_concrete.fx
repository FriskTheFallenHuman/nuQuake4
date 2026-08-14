effect effects/weapons/rocketlauncher/impact_concrete
{
	size	711

	sound "sound3"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	sound "sound2"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	shake "camerashake3"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	decal "scorch3"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 50,50 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "dirt"
	{
		detail		0.5
		start		0.2,0.2
		count		3,3

		line
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { box 40,60 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 200,0,0,300,0,0 }
			}

			motion
			{
				fade { envelope "decalfade" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	spawner "ring_mark3"
	{
		detail		0.5
		count		1,1

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

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
				size { point 500,500 }
			}
		}
	}
	spawner "lightsmoke2"
	{
		start		0.6,0.6
		count		8,8

		sprite
		{
			duration	0.8,1.2
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.02,-0.02

			start
			{
				position { sphere 0,-120,-120,140,120,120 linearSpacing }
				velocity { box 0,50,50,0,-50,-50 }
				size { line 100,100,140,140 }
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
				tint { point 0.164706,0.164706,0.137255 }
				fade { point 0.4 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "debris"
	{
		start		0.1,0.1
		count		3,3

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				velocity { box 200,-50,-50,400,50,50 }
				size { line 100,100,150,150 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "decalfade" }
			}

			end
			{
				size { line 200,200,350,350 }
				tint { point 0.0862745,0.0705882,0.0392157 }
				fade { point 1 }
			}
		}
	}
	spawner "dustsphere3"
	{
		detail		0.5
		count		40,40
		locked

		oriented
		{
			duration	0.75,0.75
			material	"gfx/effects/particles_shapes/debris_cloud"
			generatedNormal

			start
			{
				position { sphere -20,-20,-20,20,20,20 surface }
				velocity { box 50,0,0,150,0,0 }
				size { point 20,20 }
				tint { point 0.490196,0.462745,0.356863 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 80,80 }
				tint { point 0.352941,0.317647,0.239216 }
				fade { point 1 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
	spawner "sparks_lines2"
	{
		detail		0.5
		count		9,12
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 6,16 }
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
				length { box 120,0,0,140,0,0 }
			}
		}
	}
	spawner "sparks2"
	{
		detail		0.5
		start		0.2,0.2
		count		15,15

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { sphere -20,-100,-100,100,100,100 }
				velocity { box 0,-50,-50,50,50,50 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				size { line 0.5,0.5,3,3 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -6,-6,-6,6,6,6 }
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
	spawner "fire3"
	{
		count		4,4

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line 0,0,0,50,0,0 linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
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
				size { box 120,120,150,150 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash3"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 140,140,160,160 }
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
	emitter "deform3"
	{
		detail		0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				size { point 200,200 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "deform_oriented3"
	{
		detail		0.5
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.35,0.35
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				position { point 1,0,0 }
				size { point 200,200 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
}






