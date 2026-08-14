effect effects/monsters/berserker/charge_fly
{
	size	85

	emitter "burst fill"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 60,60 }
				tint { line 0.454902,0.815686,0.894118,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear_flicker }
			}

			end
			{
				rotate { box -1,1 }
			}
		}
	}
	emitter "oriented"
	{
		duration	0.15,0.3
		count		1,1

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 40,40 }
				tint { point 0.65098,0.956863,0.941177 }
			}
		}
	}
	spawner "elect2"
	{
		count		10,10

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { sphere 0,-5,-5,0,5,5 }
				size { box 1,2 }
				length { box 10,0,0,50,0,0 }
			}
		}
	}
}



