effect effects/vehicles/jet_thrusters
{
	size	99

	emitter "fire"
	{
		duration	10,10
		count		100,100

		line
		{
			duration	0.05,0.05
			blend	add
			material	"gfx/effects/fire/fireline1.tga"
			flipNormal

			start
			{
				position { point 10,0,0 }
				size { point 24 }
				length { box 50,0,0,70,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
			}

			end
			{
				size { point 4 }
			}
		}
	}
}

