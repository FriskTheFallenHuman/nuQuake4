effect effects/explosions/surface/waste_electrical
{
	size	347

	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
		volume	5,5
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	emitter "sparks_lines"
	{
		start		0.15,0.15
		duration	0.3,0.3
		count		200,200

		line
		{
			duration	0.05,0.1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedNormal

			start
			{
				position { sphere -0.1,0,-0.1,0.1,0.1,0.1 surface cone }
				velocity { box 50,0,0,200,0,0 }
				size { box 1,5 }
				tint { line 1,0.847059,0.431373,0.501961,1,1 }
				fade { line 0.5,1 }
				length { box 5,0,0,10,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope exp_1minusx/x2 }
			}

			end
			{
				length { box 100,0,0,175,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "dust2"
	{
		count		12,12

		sprite
		{
			duration	6,8
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.004,-0.001

			start
			{
				position { box -35,-35,-60,35,35,10 }
				velocity { box -5,-5,0,5,5,10 }
				size { point 10,10 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope exp_1minusx/x2 }
			}

			end
			{
				size { line 50,50,60,60 }
				fade { line 0.3,0.4 }
				rotate { box -2.22222,2.22222 relative }
			}
		}
	}
	spawner "underlit"
	{
		count		10,10

		sprite
		{
			duration	2,3.5
			material	"gfx/effects/smoke/underlit_alpha2"

			start
			{
				position { box -20,-20,-100,20,20,20 }
				velocity { box -20,-20,-15,20,20,15 }
				size { box 5,5,10,10 }
				tint { line 0.501961,0.501961,1,0,1,1 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 2,2 }
				tint { envelope linear count 1.5,1.5,1.5 offset -0.5,-0.5,-0.5 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				fade { point 0.5 }
				rotate { box -1.11111,1.11111 relative }
			}
		}
	}
	spawner "flame"
	{
		count		12,12

		sprite
		{
			duration	0.5,1.2
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { box -35,-35,-75,35,35,25 }
				velocity { box -50,-50,-20,50,50,80 }
				size { box 4,4,8,8 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 2,2 }
				tint { envelope linear count 1.5,1.5,1.5 offset -0.5,-0.5,-0.5 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 60,60,90,90 }
				fade { point 1 }
				rotate { box -1.25,1.25 relative }
			}
		}
	}
	emitter "burst fill2"
	{
		duration	0.4,0.4
		count		15,15

		sprite
		{
			duration	0.15,0.3
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { box -20,-20,-80,20,20,20 }
				velocity { box -120,-120,-90,120,120,90 }
				tint { line 0.454902,0.811765,0.894118,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope arch }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,200,200 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
	emitter "burst fill"
	{
		duration	0.5,0.5
		count		20,20

		sprite
		{
			duration	0.15,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { box -25,-25,-50,25,25,25 }
				size { point 130,130 }
				tint { line 0.454902,0.811765,0.894118,1,1,1 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 10,10 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
	emitter "elect2"
	{
		duration	0.6,0.6
		count		20,20

		electricity
		{
			duration	0.2,0.5
			blend	add
			fork	1
			jitterRate	0.1
			jitterSize	0,10,10
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { box 0,1,1,0,-1,-1 }
				size { box 1,3 }
				fade { point 0 }
				offset { box -10,-10,-80,10,10,20 }
				length { box 100,0,0,200,0,0 }
			}

			motion
			{
				fade { envelope linear count 2 }
				length { envelope linear }
			}

			end
			{
				fade { point 1 }
				length { point 1,0,0 }
			}
		}
	}
	spawner "flash2"
	{
		start		0.2,0.2
		count		1,1

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				position { point 0,0,-20 }
				size { point 30,30 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
}




