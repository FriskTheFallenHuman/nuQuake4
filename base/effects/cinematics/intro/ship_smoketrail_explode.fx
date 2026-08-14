effect effects/cinematics/intro/ship_smoketrail_explode
{
	size	696

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	sound "explosion"
	{
		soundShader	"effects_energy_burst"
		freqshift	1.3,1.3
	}
	emitter "smoke"
	{
		duration	20,20
		count		120,120

		line
		{
			duration	2,3
			material	"gfx/effects/smoke/soft_alpha_trail.tga"

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				size { box 2,5 }
				tint { line 0.568627,0.564706,0.486275,0.254902,0.247059,0.203922 }
				fade { point 0 }
				offset { point -20,0,0 }
				length { point 30,0,0 }
			}

			motion
			{
				size { envelope cosine count 0.8 offset 0.2 }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 6,8 }
				fade { point 0.4 }
			}
		}
	}
	emitter "smoke2"
	{
		duration	20,20
		count		60,60

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { sphere -10,-2,-2,0,2,2 }
				size { line 4,4,6,6 }
				tint { line 0.380392,0.380392,0.337255,0.333333,0.329412,0.258824 }
				fade { point 0 }
				offset { point 0.65,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 2,2,4,4 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "bright trail"
	{
		duration	20,20
		count		200,200

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/fire/fire3a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { point 1,0,0 }
				size { line 4,4,6,6 }
				fade { point 0.2 }
				offset { point -2,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 2,2,3,3 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			entityDef	"debris_roller_joint2"

			start
			{
				size { point 120,120 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	spawner "fire1"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/fire/fire3a"
			entityDef	"debris_roller_joint2"

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				velocity { box 0,-10,-10,10,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { point 30,30 }
				tint { point 0.984314,0.505882,0.45098 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "fire2"
	{
		count		5,5
		locked

		sprite
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/fire/fire4a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 0,-10,-10,10,10,10 }
				size { point 15,15 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { point 5,5 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "spark"
	{
		count		20,20
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -20,-20,-20,20,20,20 }
				size { line 0.5,0.5,1,1 }
				tint { line 1,1,1,1,0.501961,0.25098 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "ring"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/energy2"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.25098 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.1,0.1
			material	"lights/defaultPointLight"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { point 5,0,0 }
				size { point 400,400,400 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope arch }
			}

			end
			{
				tint { point 1,1,1 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		10,15
		locked

		line
		{
			duration	0.2,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			entityDef	"debris_walker_upperleg"
			generatedOriginNormal
			flipNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 surface cone }
				velocity { box 50,0,0,100,0,0 }
				size { box 1,1.5 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "bright trail2"
	{
		duration	0.5,0.5
		count		20,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { point 1,0,0 }
				size { line 8,8,12,12 }
				offset { point -2,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 2,2,3,3 }
				rotate { box -0.0555556,0.0555556 relative }
			}
		}
	}
}

