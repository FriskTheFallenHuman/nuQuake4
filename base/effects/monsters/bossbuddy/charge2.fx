effect effects/monsters/bossbuddy/charge2
{
	size	309

	emitter "burst fill"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.15,0.2
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { box 0,-5,-5,-10,5,5 }
				size { point 80,80 }
				tint { line 0.454902,0.815686,0.894118,1,1,1 }
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
		duration	1,1
		count		10,10

		electricity
		{
			duration	0.2,0.3
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
				length { box 80,0,0,150,0,0 }
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
	emitter "burst fill2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.15,0.2
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { box 0,-10,-10,-20,10,10 }
				size { point 100,100 }
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
	light "unnamed4"
	{

		light
		{
			duration	1,1
			shadows
			specular
			material	"lights/defaultPointLight"

			start
			{
				position { box -20,-20,-20,20,20,20 }
				size { point 150,200,150 }
			}

			motion
			{
				tint { envelope ren_stream_flicker3 count 6,6,6 }
			}

			end
			{
				tint { point 0.427451,0.854902,0.996078 }
			}
		}
	}
	emitter "oriented2"
	{
		duration	1,1
		count		50,50

		oriented
		{
			duration	0.15,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { line 0,-5,-5,-15,5,5 }
				size { point 100,100 }
				tint { line 0.647059,0.956863,0.937255,1,1,1 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope arch }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
}


