effect effects/monsters/turret/d_death
{
	size	340

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
	emitter "smoke"
	{
		detail		0.5
		duration	0.4,0.4
		count		10,10

		sprite
		{
			duration	1,8
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.001,-0.001

			start
			{
				position { line 30,-20,-20,30,20,20 }
				velocity { box -10,-10,-10,10,10,10 }
				acceleration { box -1,-1,-1,1,1,1 }
				size { point 20,20 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" count 3,3 }
				fade { envelope "arch" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 40,40,60,60 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.7
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { line 1,-30,-30,1,30,30 }
				velocity { box -30,-30,-30,30,30,30 }
				size { line 30,30,50,50 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "arch" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,110,110 }
				rotate { box -0.472222,0.472222 relative }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "arch" count -1.5,-1.5 offset 1,1 }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 230,230,240,240 }
			}
		}
	}
	emitter "sparks_lines"
	{
		detail		0.5
		duration	0.1,0.1
		count		80,80

		line
		{
			duration	0.15,0.5
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 10,0,0,150,0,0 }
				size { box 2,4 }
				tint { line 0.921569,0.713726,0.0784314,0.74902,0.521569,0.203922 }
				length { box 100,0,0,250,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" count 2 offset -1 }
				length { envelope "exp_xoverx2" count 0.4,0,0 }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 1,0,0,2,0,0 }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		count		20,25

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.01,0.05

			start
			{
				position { cylinder 0,-50,-50,0,50,50 }
				velocity { box 10,-30,-30,60,30,30 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				acceleration { box -2,-2,-2,2,2,2 }
				size { line 0.5,0.5,3,3 }
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
	spawner "underlit"
	{
		detail		0.5
		count		8,8

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/underlit_alpha2"

			start
			{
				position { box -25,-25,-15,25,25,15 }
				velocity { box -15,-15,-5,15,15,5 }
				size { line 5,5,10,10 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" count 3,3 }
				tint { envelope "linear" count 1.2,1.2,1.2 }
				fade { envelope "fastinslowout" count 0.9 offset 0.1 }
				rotate { envelope "exp_xoverx2" count 0.5 }
			}

			end
			{
				size { line 30,30,50,50 }
				fade { line 0.3,0.5 }
				rotate { box 0.833333,-0.833333 relative }
			}
		}
	}
}







