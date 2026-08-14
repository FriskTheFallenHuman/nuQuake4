effect effects/monsters/bossbuddy/impact_default
{
	size	859

	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 50,50 }
				rotate { line 0,1 }
			}
		}
	}
	emitter "center2"
	{
		duration	0.1,0.1
		count		20,20
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 150,250 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { point 10,20 }
			}
		}
	}
	spawner "smoke_ring"
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
	spawner "ring_out"
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
				tint { point 0.921569,0.827451,0.929412 }
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
	spawner "ring_in"
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
	spawner "residual"
	{
		start		0.4,0.4
		count		30,30

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.01,-0.005
			generatedOriginNormal

			start
			{
				position { sphere -60,-60,-60,60,60,60 surface }
				velocity { box 5,0,0,25,0,0 }
				size { line 60,60,80,80 }
				tint { point 0.639216,0.411765,0.686275 }
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
	emitter "base oriented"
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
	sound "unnamed7"
	{
		soundShader	"weapon_darkmatter_energy_burst"
	}
}

