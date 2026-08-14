effect effects/mapobjects/pistonb_guide
{
	size	81

	emitter "lines"
	{
		duration	2.6,2.6
		count		80,80
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal

			start
			{
				position { cylinder -20,0,-20,20,0,20 surface }
				size { box 4,6 }
				tint { line 1,0.956863,0.576471,0.843137,0.960784,1 }
				offset { point 50,-6,0 }
				length { point -10,0,0 }
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
				size { box 0.5,2 }
				tint { line 0.756863,1,0.992157,0.756863,0.921569,1 }
				length { point -30,0,0 }
			}
		}
	}
}


