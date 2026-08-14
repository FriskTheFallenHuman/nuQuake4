effect effects/monsters/scientist/needle_drip
{
	size	156

	sound "segment02"
	{
		soundShader	"gunner_grenade_launch"
	}
	spawner "segment022"
	{
		count		30,30
		locked

		line
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/particles_shapes/specs"

			start
			{
				size { box 3,4 }
				tint { point 0,0.501961,1 }
				fade { point 0.5 }
				length { box 25,-25,-25,50,25,25 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 6 }
				length { box 0,-100,-100,0,100,100 }
			}
		}
	}
	light "segment052"
	{
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
				size { envelope linear }
			}

			end
			{
				size { point 20,100 }
			}
		}
	}
	spawner "segment0122"
	{
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
				rotate { point 1 }
			}

			motion
			{
				size { envelope random }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	emitter "segment01222"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	0.5,0.8
			blend	add
			material	"gfx/effects/smoke/blacksmokepuff"

			start
			{
				velocity { box 10,-20,-20,80,20,20 }
				size { point 10,10 }
				rotate { point 0.2 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
}



