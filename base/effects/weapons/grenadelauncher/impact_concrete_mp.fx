effect effects/weapons/grenadelauncher/impact_concrete_mp
{
	size	711

	shake "camerashake4"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	sound "sound4"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	sound "sound3"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	spawner "debris3"
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
				tint { line 0.462745,0.427451,0.262745,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope decalfade }
			}

			end
			{
				size { line 200,200,350,350 }
				tint { point 0.0823529,0.0666667,0.0392157 }
				fade { point 1 }
			}
		}
	}
	spawner "darksmoke2"
	{
		start		0.4,0.4
		count		6,6

		sprite
		{
			duration	1.25,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.2,0.2

			start
			{
				position { line 0,-10,0,180,10,0 linearSpacing }
				velocity { box 0,30,0,50,40,0 }
				size { box 160,160,200,200 }
				tint { point 0.372549,0.321569,0.219608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.5 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	decal "scorch4"
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
	spawner "ring_mark4"
	{
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
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "sparks_lines3"
	{
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
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 180,0,0,220,0,0 }
			}
		}
	}
	spawner "sparks3"
	{
		start		0.2,0.2
		count		25,25

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { sphere -20,-100,-100,300,100,100 }
				velocity { box 0,-50,-50,50,50,50 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				size { line 0.5,0.5,3,3 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -6,-6,-6,6,6,6 }
			}

			motion
			{
				fade { envelope linear_flicker }
				angle { envelope linear }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	spawner "dustsphere2"
	{
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
				size { envelope convexfade }
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
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
	spawner "column_fire2"
	{
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line -30,0,0,100,0,0 linearSpacing }
				velocity { box 200,0,0,300,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 120,120,140,140 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,80,80 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "column_fire3"
	{
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { line -30,0,0,100,0,0 linearSpacing }
				velocity { box 200,0,0,300,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 120,120,140,140 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,80,80 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "flash2"
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
				size { line 180,180,220,220 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "firesphere3"
	{
		count		20,20
		locked

		oriented
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/fire/fire4a"
			generatedNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 surface }
				velocity { box 50,0,0,150,0,0 }
				size { point 10,10 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope convexfade }
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				fade { point 0.6 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
}

