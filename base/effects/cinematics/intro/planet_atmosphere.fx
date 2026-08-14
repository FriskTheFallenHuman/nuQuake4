effect effects/cinematics/intro/planet_atmosphere
{
	size	8062

	spawner "unnamed2"
	{
		count		1,1
		constant

		oriented
		{
			duration	1,1
			material	"gfx/test/planetAtmosphere"

			start
			{
				position { point 1,0,0 }
				size { point 4500,4500 }
				tint { point 0.403922,0.592157,0.576471 }
				fade { point 0.6 }
				rotate { point 0,0.116667,0 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		constant

		oriented
		{
			duration	1,1
			material	"gfx/test/planetAtmosphere"

			start
			{
				position { point 1,0,0 }
				size { point 5700,5700 }
				tint { point 0.666667,0.486275,0.329412 }
				fade { point 0.6 }
				rotate { point 0,0.116667,0 }
			}
		}
	}
}

