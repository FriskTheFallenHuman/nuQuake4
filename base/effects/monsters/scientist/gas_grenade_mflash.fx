effect effects/monsters/scientist/gas_grenade_mflash
{
	size	142

	sound "segment02"
	{
		soundShader	"gunner_grenade_launch"
	}
	light "segment052"
	{
		detail		0.5
		locked

		light
		{
			duration	0.06,0.06
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 80,80,80 }
				tint { line 0,0.501961,1,1,1,1 }
			}
		}
	}
	emitter "segment0622"
	{
		duration	0.1,0.1
		count		10,10

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point -5,0,0 }
				velocity { point 200,0,0 }
				size { point 30,30 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 20,100 }
			}
		}
	}
	spawner "sparkles"
	{
		detail		0.5
		count		12,12

		sprite
		{
			duration	0.5,0.8
			blend	add
			material	"gfx/effects/fire/embers"

			start
			{
				velocity { box 50,-20,-20,125,20,20 }
				size { point 10,10 }
				tint { point 0.403922,0.886275,0.427451 }
				rotate { point 1 }
			}

			motion
			{
				size { envelope "random" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	0.5,0.8
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				velocity { box 10,-20,-20,80,20,20 }
				size { point 5,5 }
				tint { point 0.403922,0.886275,0.427451 }
				rotate { point 0.2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
}




