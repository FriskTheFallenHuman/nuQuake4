effect effects/explosions/air/airburst_03
{
	size	2829

	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
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
				size { point 2000,2000 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		20,20
		locked

		line
		{
			duration	0.2,0.5
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 surface cone }
				velocity { box 50,0,0,1000,0,0 }
				size { box 5,20 }
				tint { line 1,0.847059,0.435294,1,0.501961,0 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope exp_1minusx/x2 }
			}

			end
			{
				length { box 200,0,0,350,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "dust2"
	{
		start		0.2,0.2
		count		5,5

		sprite
		{
			duration	2,4
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { box -200,-200,0,200,200,0 }
				velocity { box -100,-100,0,100,100,0 }
				size { point 100,100 }
				tint { line 0,0,0,0.113725,0.109804,0.101961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 300,300,600,600 }
				fade { line 0.3,0.8 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "underlit"
	{
		count		4,4

		sprite
		{
			duration	1.2,2.4
			material	"gfx/effects/smoke/underlit_alpha2"

			start
			{
				position { box -100,-100,0,100,100,0 }
				velocity { box -100,-100,-50,100,100,50 }
				size { box 50,50,100,100 }
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
				size { line 350,350,500,500 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "flame"
	{
		count		4,4

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { box -100,-100,0,100,100,0 }
				velocity { box -30,-30,-30,30,30,30 }
				size { box 10,10,30,30 }
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
				size { line 100,100,200,200 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	trail "chunks_trail"
	{
		count		3,3

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				size { point 25,25 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 250,250 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fallers"
	{
		count		3,5

		sprite
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/blank"
			gravity		1,1
			generatedOriginNormal
			trailType	chunks_trail

			start
			{
				position { cylinder 100,-100,-100,100,100,100 surface }
				velocity { point 500,0,0 }
				size { point 10,10 }
			}
		}
	}
}
