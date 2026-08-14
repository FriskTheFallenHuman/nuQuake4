effect effects/mapobjects/big_guncharge
{
	size	353

	emitter "unnamed5"
	{
		start		0.75,0.75
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	2,2
			blend	add
			fork	1
			jitterRate	0.02
			jitterSize	3,8,8
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { cylinder 0.5,-24,-24,0.5,24,24 surface }
				velocity { point 50,0,0 }
				size { box 4,5 }
				length { box 2,0,0,10,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 200,0,0,300,0,0 }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"airdefense_cannon_charge"
	}
}





