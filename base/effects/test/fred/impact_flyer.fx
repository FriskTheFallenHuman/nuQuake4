effect effects/test/fred/impact_flyer
{
	size	3236

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 256,256 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	spawner "dirt"
	{
		count		3,3

		line
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { point 200 }
				tint { line 0.313726,0.27451,0.184314,0.266667,0.258824,0.227451 }
				fade { point 0 }
				length { box 600,0,0,800,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 400,0,0,500,0,0 }
			}
		}
	}
	spawner "debris"
	{
		start		0.1,0.1
		count		4,4

		sprite
		{
			duration	1.5,2.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		1,1

			start
			{
				position { line 0,0,0,200,0,0 }
				velocity { box 200,-50,-50,1000,50,50 }
				size { line 200,200,250,250 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 500,500,650,650 }
				tint { point 0.0823529,0.0666667,0.0392157 }
				fade { point 1 }
			}
		}
	}
	spawner "column_smoke"
	{
		start		0.2,0.2
		count		3,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		1,1

			start
			{
				position { line 0,-30,0,250,30,0 linearSpacing }
				velocity { box 400,30,0,600,40,0 }
				size { box 80,80,100,100 }
				tint { point 0.419608,0.392157,0.313726 }
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
				size { box 340,340,360,360 }
				tint { point 0.164706,0.164706,0.137255 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "residual_smoke"
	{
		start		0.6,0.6
		count		3,3

		sprite
		{
			duration	3,3
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line -20,-30,-30,200,30,30 }
				velocity { box -5,20,-20,25,40,20 }
				size { line 180,180,240,240 }
				tint { line 0.294118,0.266667,0.172549,0.301961,0.258824,0.176471 }
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
				fade { point 0.6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blank"
	{
		count		7,7

		sprite
		{
			duration	0.2,0.3
			material	"gfx/effects/particles_shapes/blank"
			gravity		5,5
			generatedOriginNormal
			trailType	blank_trail

			start
			{
				position { cylinder 0.1,-0.3,-0.3,0.1,0.3,0.3 }
				velocity { box 3000,0,0,4000,0,0 }
				size { point 20,20 }
			}
		}
	}
	trail "blank_trail"
	{
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.2,0.2

			start
			{
				velocity { box -30,-30,-30,30,30,30 }
				size { box 80,80,120,120 }
				tint { line 0.317647,0.286275,0.223529,0.286275,0.254902,0.188235 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "decalfade" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 200,200,300,300 }
				fade { point 0.7 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "chunks"
	{
		count		5,7

		sprite
		{
			duration	2,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		1,1

			start
			{
				position { sphere -60,-60,-60,60,60,60 }
				velocity { box 800,-600,-600,1200,600,600 }
				size { line 12,12,20,20 }
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
				tint { point 1,0.976471,0.721569 }
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
	spawner "column_fire"
	{
		count		2,2

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { line 0,0,0,100,0,0 linearSpacing }
				velocity { box 1000,0,0,1500,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 250,250,280,280 }
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
				size { box 160,160,180,180 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "column_fire2"
	{
		count		2,2

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { line 0,0,0,100,0,0 linearSpacing }
				velocity { box 300,0,0,600,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 250,250,280,280 }
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
				size { box 160,160,180,180 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/weapons/shotgun_mflash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 350,350,400,400 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,9
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
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 20,30 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 50,0,0 }
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

			impact
			{
				bounce	0.2
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
		duration	0,0
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
