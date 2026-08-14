effect effects/cinematics/intro/biggun_impact
{
	size	898

	spawner "flash2"
	{
		count		20,20

		sprite
		{
			duration	0.25,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { point 1,0,0 }
				velocity { box 20,-100,-100,80,100,100 }
				size { point 60,60 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 300,300 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	spawner "blue_fire"
	{
		count		5,5

		sprite
		{
			duration	1,5
			blend	add
			material	"gfx/effects/fire/fire2b"

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 50,-50,-50,20,50,50 }
				size { box 2,2,4,4 }
				tint { line 0.501961,0.501961,1,1,1,1 }
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
				size { box 250,250,500,500 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	spawner "blue_fire2"
	{
		count		5,5

		sprite
		{
			duration	3,5
			blend	add
			material	"gfx/effects/fire/fire5b"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-20,-20,0,20,20 }
				size { box 1,1,2,2 }
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
				size { line 150,150,300,300 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	spawner "side_streaks2"
	{
		count		7,7

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.045,-0.05,-0.05,-0.048,0.05,0.05 surface }
				size { box 5,7 }
				tint { line 0.466667,0.466667,0.466667,0,1,1 }
				length { box 100,0,0,250,0,0 }
			}

			motion
			{
				fade { envelope random }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
	spawner "flash5"
	{
		count		10,10

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { point -4,0,0 }
				offset { point 15,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 90,90 }
			}
		}
	}
	spawner "flash6"
	{
		count		20,20

		sprite
		{
			duration	5,6
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { box -50,-50,-50,50,50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 90,90 }
			}
		}
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 40,40 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 20,40 }
				tint { point 0.501961,0.501961,1 }
				fade { point 0 }
				length { box 50,0,0,300,0,0 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"effects_explosion_muffled"
		freqshift	0.8,0.8
	}
	sound "unnamed10"
	{
		soundShader	"effects_energy_burst"
		volume	1,1
		freqshift	1.4,1.4
	}
}


