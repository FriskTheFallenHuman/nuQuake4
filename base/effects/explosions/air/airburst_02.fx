effect effects/explosions/air/airburst_02
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
			duration	0.2,0.2
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 2000,2000 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 1000,1000 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		10,10
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 surface cone }
				velocity { box 200,0,0,400,0,0 }
				size { point 50 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 400,0,0,800,0,0 }
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
	spawner "dust2"
	{
		start		0.2,0.2
		count		3,3

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder -50,-50,-50,50,50,50 }
				velocity { box -400,-400,-400,400,400,400 }
				size { box 50,50,80,80 }
				tint { line 0.560784,0.552941,0.486275,0.117647,0.113725,0.101961 }
				fade { point 0 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 500,500,800,800 }
				fade { point 0.35 }
				rotate { point 0.125 }
			}
		}
	}
	trail "chunks_trail"
	{
		count		10,10

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



