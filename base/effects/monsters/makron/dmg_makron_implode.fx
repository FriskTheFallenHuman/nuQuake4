effect effects/monsters/makron/dmg_makron_implode
{
	size	859

	spawner "center_out"
	{
		start		0.5,0.5
		count		1,1
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				size { point 10,10 }
				rotate { box -0.0138889,0.0138889 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "center_in"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 10,10 }
				rotate { box -0.0138889,0.0138889 }
			}

			motion
			{
				size { envelope pop_fade count 4,4 }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "electricity"
	{
		count		5,5
		locked

		electricity
		{
			duration	0.2,0.2
			blend	add
			fork	1
			jitterRate	0.1
			jitterSize	2,7,7
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 surface }
				size { point 7 }
				tint { point 0.639216,0.572549,0.745098 }
				fade { point 0 }
				length { box 50,0,0,240,0,0 }
			}

			motion
			{
				size { envelope quartersintable }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { point 4 }
				fade { point 1 }
			}
		}
	}
	sound "sound foom"
	{
		soundShader	"makron_dmg_hit"
	}
	decal "decal2"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 100,100 }
				rotate { line 0,1 }
			}
		}
	}
	spawner "center4"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	spawner "smoke_ring2"
	{
		start		0.5,0.5
		count		30,30

		sprite
		{
			duration	0.2,0.25
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.01,-0.01
			generatedOriginNormal

			start
			{
				position { cylinder 5,-15,-15,5,15,15 surface }
				velocity { box 1000,0,0,1500,0,0 }
				size { point 6,6 }
				tint { point 0.576471,0.466667,0.686275 }
				fade { point 0.5 }
				rotate { box 0,0.111111 }
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
				size { line 80,80,120,120 }
				tint { point 0.803922,0.721569,0.811765 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "ring_out2"
	{
		start		0.5,0.5
		count		2,2

		sprite
		{
			duration	0.2,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 20,0,0 }
				size { point 0,0 }
				tint { point 0.858824,0.694118,0.87451 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 500,500,600,600 }
			}
		}
	}
	spawner "ring_in2"
	{
		count		2,2

		sprite
		{
			duration	0.2,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 10,0,0 }
				size { line 200,200,300,300 }
				tint { point 0.858824,0.694118,0.87451 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "residual2"
	{
		start		0.4,0.4
		count		30,30

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.005,-0.005
			generatedOriginNormal

			start
			{
				position { sphere -60,-60,-60,60,60,60 surface }
				velocity { box 0,0,0,50,0,0 }
				size { line 60,60,80,80 }
				tint { point 0.643137,0.415686,0.690196 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 110,110,140,140 }
				fade { point 0.15 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "base oriented3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.15,0.15
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	spawner "unnamed21"
	{
		count		10,30

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				size { box 100,100,200,200 }
				tint { point 0.713726,0.8,0.870588 }
				fade { line 0.25,0.5 }
				offset { box 0,-350,-350,0,350,350 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				offset { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "electricity_out"
	{
		start		0.5,0.5
		count		10,10
		locked

		electricity
		{
			duration	0.3,0.3
			blend	add
			fork	1
			jitterRate	0.1
			jitterSize	2,7,7
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere -30,-30,-30,30,30,30 surface }
				velocity { point 300,0,0 }
				size { point 14 }
				tint { point 0.639216,0.568627,0.741176 }
				fade { point 0 }
			}

			motion
			{
				size { envelope quartersintable }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { point 7 }
				fade { point 1 }
				length { box 250,0,0,300,0,0 }
			}
		}
	}
	spawner "unnamed14"
	{
		start		0.5,0.5
		count		5,5

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 400,400 }
			}
		}
	}
	sound "unnamed14"
	{
		soundShader	"stream_hub_emp_blast1"
		freqshift	1.5,1.5
	}
	sound "unnamed15"
	{
		start		0.5,0.5
		soundShader	"stream_hub_emp_blast2"
		freqshift	0.8,0.8
	}
}







