effect effects/cinematics/intro/dropship_explosion
{
	size	251

	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.7,0.8
			blend	add
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				size { point 32,32 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
				rotate { point -0.111111 relative }
			}
		}
	}
	emitter "flash"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.15,0.15
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 75,75 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0.4 }
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
	sound "sound"
	{
		soundShader	"player_rocketlauncher_explode"
		volume	2,2
	}
	sound "unnamed10"
	{
		start		0.1,0.1
		soundShader	"player_rocketlauncher_explode2"
	}
	spawner "flash3"
	{
		count		12,12

		sprite
		{
			duration	0.7,1
			blend	add
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { sphere -20,-20,-20,20,20,20 }
				velocity { box -5,-5,-5,5,5,5 }
				size { point 4,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
			}

			end
			{
				size { point 16,16 }
			}
		}
	}
	emitter "flash4"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 2,2 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0.1 }
			}

			motion
			{
				size { envelope linear count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 120,120 }
			}
		}
	}
	spawner "flash5"
	{
		count		30,30

		sprite
		{
			duration	0.7,1
			blend	add
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { sphere -8,-8,-8,8,8,8 }
				velocity { box -15,-15,-15,15,15,15 }
				size { point 2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
			}

			end
			{
				size { point 8,8 }
			}
		}
	}
	light "unnamed7"
	{

		light
		{
			duration	0.5,0.5
			material	"lights/defaultPointLight"

			start
			{
				size { point 100,100,100 }
				tint { point 0.87451,0.854902,0.768628 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope random }
			}
		}
	}
	emitter "flash6"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.2,0.2
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 200,10 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0.05 }
			}

			motion
			{
				size { envelope linear count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 2,1 }
			}
		}
	}
	emitter "flash7"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 5,150 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0.05 }
				rotate { point 0.125 }
			}

			motion
			{
				size { envelope linear count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 2,1 }
			}
		}
	}
	emitter "flash8"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.15,0.15
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1,2 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0.05 }
				rotate { point -0.166667 }
			}

			motion
			{
				size { envelope arch }
			}

			end
			{
				size { point 5,250 }
			}
		}
	}
}

