effect effects/vehicles/walker/rocket/impact_rock
{
	size	2062

	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	sound "unnamed15"
	{
		soundShader	"player_grenadelauncher_explode"
	}
	shake "camerashake2"
	{
		duration	0.7,0.7
		scale		1
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
				size { point 100,0 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "dirt"
	{
		count		2,2

		line
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { box 120,150 }
				tint { line 0.313726,0.27451,0.184314,0.266667,0.258824,0.227451 }
				fade { point 0 }
				length { box 400,0,0,500,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 200,0,0,300,0,0 }
			}
		}
	}
	spawner "debris"
	{
		start		0.1,0.1
		count		2,2

		sprite
		{
			duration	1,2
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.6,0.6

			start
			{
				velocity { box 400,-50,-50,600,50,50 }
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
				size { line 300,300,450,450 }
				tint { point 0.0862745,0.0705882,0.0392157 }
				fade { point 1 }
			}
		}
	}
	spawner "chunks"
	{
		start		0.04,0.04
		count		5,7

		sprite
		{
			duration	2,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				position { sphere -20,-20,-20,20,20,20 }
				velocity { box 400,-250,-250,800,250,250 }
				size { line 7,7,12,12 }
				tint { line 0.470588,0.419608,0.329412,0.258824,0.243137,0.184314 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "column_debris"
	{
		count		4,4

		sprite
		{
			duration	2,3
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.06,0.06

			start
			{
				position { line 0,-10,0,180,10,0 linearSpacing }
				velocity { box 0,30,0,0,40,0 }
				size { box 120,120,160,160 }
				tint { point 0.152941,0.141176,0.105882 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "decalfade" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.4 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "sparks_lines3"
	{
		count		9,12
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 12,20 }
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
				length { box 300,0,0,350,0,0 }
			}
		}
	}
	spawner "fire3"
	{
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fire/fire1a"
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
	spawner "fire4"
	{
		count		4,4

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire3a"

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
				size { point 140,140 }
			}
		}
	}
	emitter "deform"
	{
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
}









