effect effects/player/blood_cough1
{
	size	23

	spawner "unnamed0"
	{
		count		2,2

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/gore_spray/bloodhit4"

			start
			{
				velocity { point 0,-20,0 }
				size { point 0,0 }
				tint { point 0.501961,0,0 }
				offset { point 0,-5,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		4,6
		locked

		line
		{
			duration	0.15,0.25
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.25,-0.25,-0.2,0.25,0.25 surface }
				velocity { point 0,-1,0 }
				size { box 0.5,1 }
				tint { point 0.545098,0.0784314,0.0784314 }
				offset { point 0,-5,0 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 5,0,0,10,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}

