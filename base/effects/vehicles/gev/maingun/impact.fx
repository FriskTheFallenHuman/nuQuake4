effect effects/vehicles/gev/maingun/impact
{
	size	1432

	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
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
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	spawner "column_smoke"
	{
		start		0.1,0.1
		count		4,4

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.2,0.2

			start
			{
				position { cylinder 50,-60,-60,350,60,60 linearSpacing }
				velocity { box 100,30,0,300,40,0 }
				size { box 150,150,200,200 }
				tint { point 0.419608,0.392157,0.313726 }
				fade { point 0 }
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
				size { box 320,320,350,350 }
				tint { point 0.164706,0.164706,0.137255 }
				fade { point 0.5 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "residual_smoke2"
	{
		start		0.4,0.4
		count		4,4

		sprite
		{
			duration	3,3
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line -20,-30,-30,200,30,30 }
				velocity { box -5,20,-20,25,40,20 }
				size { line 180,180,240,240 }
				tint { line 0.254902,0.247059,0.211765,0.247059,0.247059,0.227451 }
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
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.2,0.2

			start
			{
				velocity { box -30,-30,-30,30,30,30 }
				size { box 80,80,120,120 }
				tint { line 0.345098,0.329412,0.278431,0.32549,0.32549,0.301961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope decalfade }
				rotate { envelope linear }
			}

			end
			{
				size { box 200,200,300,300 }
				fade { point 0.5 }
				rotate { box -0.138889,0.138889 relative }
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
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	spawner "column_fire"
	{
		count		4,4

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 100,0,0,300,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 200,200,220,220 }
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
				size { box 480,480,500,500 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "column_fire2"
	{
		count		4,4

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 100,0,0,300,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 200,200,220,220 }
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
				size { box 480,480,500,500 }
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
				size { line 450,450,500,500 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 300,300 }
				fade { point 1 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/muzzleflash2_depth"

			start
			{
				velocity { box 300,-50,-50,400,50,50 }
				size { point 1000,1000 }
				tint { point 1,1,0.8 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 350,350 }
				fade { point 0.8 }
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
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 400,0,0,450,0,0 }
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
				velocity { point 500,0,0 }
				size { point 0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 800,800 }
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
				size { envelope linear }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		6,6

		sprite
		{
			duration	0.6,1.2
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		2,2
			trailType	motion
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box 1000,-1000,-1000,1200,1000,1000 }
				size { box 6,6,10,10 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 3,3 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	spawner "embers_out"
	{
		count		30,30

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.1,0.2

			start
			{
				position { cylinder 0,-250,-250,500,250,250 }
				velocity { point 100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { line 0.996078,0.968628,0.905882,0.94902,0.603922,0.376471 }
				offset { box -20,-20,-20,20,20,20 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear_flicker }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 0.5,0.5,1,1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}








