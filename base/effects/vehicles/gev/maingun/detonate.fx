effect effects/vehicles/gev/maingun/detonate
{
	size	1415

	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	spawner "residual_smoke"
	{
		start		0.2,0.2
		count		6,6

		sprite
		{
			duration	3,3
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.1,-0.1

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,0,0,20,0,0 }
				size { line 220,220,280,280 }
				tint { point 0.380392,0.372549,0.321569 }
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
				fade { point 0.4 }
				rotate { box -0.111111,0.111111 relative }
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
				position { sphere -100,-100,-100,100,100,100 linearSpacing }
				angle { box 0,0,0,1,1,1 }
				size { box 160,160,180,180 }
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
				size { box 300,300,350,350 }
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
				position { sphere -100,-100,-100,100,100,100 linearSpacing }
				angle { box 0,0,0,1,1,1 }
				size { box 160,160,180,180 }
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
				size { box 300,300,350,350 }
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
				position { cylinder -0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
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
				velocity { box -1000,-1000,-1000,1000,1000,1000 }
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
				position { sphere -250,-250,-250,250,250,250 }
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





